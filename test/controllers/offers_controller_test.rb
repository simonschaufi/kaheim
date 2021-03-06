require 'test_helper'

class OffersControllerTest < ActionDispatch::IntegrationTest

  test 'should get index' do
    get offers_url
    assert_response :success
    assert_select 'table.offer-specifics', 1
  end

  test 'should get index for signed in user' do
    sign_in users(:david)
    get offers_url
    assert_response :success
    assert_select 'table.offer-specifics', 1
  end

  test 'send notification if unlocked user creates offer' do
    sign_in users(:jane)
    num_subscribers = Subscription.offers.confirmed.count
    assert_difference 'ActionMailer::Base.deliveries.size', +num_subscribers do
      post offers_url, params: {offer: { title: 'New offer', description: 'An offer you cannot refuse', from_date: '01-01-2013', rent: 200, size: 19, gender: 'dontcare', street: 'Sesame', zip_code: '12949' }}
    end
    assert_equal I18n.t('helpers.creation_success', {model: Offer.model_name.human}), flash[:notice]
  end

end
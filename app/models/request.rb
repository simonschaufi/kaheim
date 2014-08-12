class Request < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :title, :until, :description, :user

  scope :current, -> { where('requests.updated_at >= ?', 31.days.ago) }
  scope :outdated, -> { where('requests.updated_at < ?', 31.days.ago) }
  scope :unlocked, -> { joins(:user).where(users: { unlocked: true }) }
end

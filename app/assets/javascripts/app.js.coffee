$ ->
  #list view details toggle
  $('.toggle-collapse').click ->
    $(this).parents('.item').find('div.short').toggle()
    $(this).parents('.item').find('div.long').toggle()

  #short description sign counter
  $('.short-description').next().html(140 - $('.short-description').val().length)
  $('.short-description').keyup ->
    if (140 - $('.short-description').val().length) >= 0
      $('.short-description').next().html(140 - $('.short-description').val().length)
    else
      $('.short-description').val($('.short-description').val().substr(0, 140))

  $('[data-behaviour~=datepicker]').datepicker
    autoclose: true,
    format: if $('#locale-selection').data('current-locale') == 'en' then "yyyy-mm-dd" else "dd.mm.yyyy",
    language: if $('#locale-selection').data('current-locale') == 'en' then 'en' else 'de'
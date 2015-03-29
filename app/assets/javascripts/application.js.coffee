# This is a manifest file that'll be compiled into application.js, which will include all the files
# listed below.
#
# Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
# or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
#
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# compiled file.
#
# Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
# about supported directives.
#
#= require jquery
#= require jquery_ujs
#= require select2
#= require prices

showPhoneModal = ->
  $('.js_modal_back').show()
  $('.js_modal_phone').show()

closeModals = ->
  $('.js_modal_back').hide()
  $('.js_modal_phone').hide()
  $('.js_modal_notice').hide()

showNotice = (msg) ->
  noticeModal = $('.js_modal_notice')
  noticeModal.find('.modal__title').html(msg)
  noticeModal.show()

$(document).on 'click', '.header__contacts', ()->
  showPhoneModal()

$(document).on 'click', '.js_modal_back', ()->
  closeModals()

$(document).on 'click', '.js_close_button', ()->
  closeModals()

submitPhoneCall = (name, time, phone)->
  $.ajax
    url: '/phone_calls'
    type: 'POST'
    dataType: "json"
    data:
      name: name
      phone: phone
      time: time
    success: (data)->
      $('.js_modal_phone').hide()
      showNotice('Ваш заказ принят в обработку')
      setTimeout(closeModals, 2000)
    error: (xhr)->
      closeModals()
      alert 'Упс! Что-то пошло не так.'

$(document).on 'click', '.js_phone_call_submit', ()->
  phone = $('.js_phone').val()
  name = $('.js_name').val()
  time = $('.js_time').val()
  if phone && name && time
    submitPhoneCall(name, time, phone)
  else
    $('.modal_error').removeClass('modal_error')
    unless time
      $('.js_time').closest(".input_set").addClass('modal_error')
    unless name
      $('.js_name').closest(".input_set").addClass('modal_error')
    unless phone
      $('.js_phone').closest(".input_set").addClass('modal_error')


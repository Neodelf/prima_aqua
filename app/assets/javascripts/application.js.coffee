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

closeModal = ->
  $('.js_modal_back').hide()
  $('.js_modal_phone').hide()

$(document).on 'click', '.header__contacts', ()->
  showPhoneModal()

$(document).on 'click', '.js_modal_back', ()->
  closeModal()

$(document).on 'click', '.js_close_button', ()->
  closeModal()

submitPhoneCall = ->
  

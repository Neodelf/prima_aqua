if window.Storage and window.JSON
  window.$storage = (key) ->
    set: (value) ->
        localStorage.setItem(key, JSON.stringify(value))
    get: ->
        item = localStorage.getItem(key)
        JSON.parse(item) if item

class Order
  constructor: ->
    localStorage.setItem('product', '')
    html = $storage("prima_state_card").get()
    if html
      $('.prima_state_card').html(html)

    @isValid = false

    $(document).on 'change', '.js-aqua-select-tag', (e)=>
      @updateVolumesSelector(e)

    $(document).on 'change', '.js-volume-select-tag', (e)=>
      @actualizePrice($(e.currentTarget).closest('.water_template'))

    $(document).on 'click', '.js_add_position', (e)=>
      @addPosition(e)

    $(document).on 'click', '.js_remove_position', (e)=>
      @removePosition(e)

    $(document).on 'click', '.js_empty_bottles', (e)->
      checkbox = $(e.currentTarget)
      checkbox.attr("checked", !checkbox.attr("checked"))

    $(document).on 'click', '.js_increment', (e)=>
      @updateAmount(e, 1)

    $(document).on 'click', '.js_decrement', (e)=>
      @updateAmount(e, -1)

    $(document).on 'click', '.js_order_change_step', ()=>
      @changeOrderStep()

    $(document).on 'click', '.js_variant', (e)=>
      elem = $(e.currentTarget)
      if  !elem.hasClass('disabled') && @isShoudProcessed(elem)
        $('.order__customer_form').toggleClass('hidden_block')



  # improve!!! make through class
  @saveHtml: ->
    $storage("prima_state_card").set($('.prima_state_card').html())

  checkAvailableTime: ()->
    $.ajax
      url: "/check_time?data=#{$('.datepicker').val()}"
      type: 'GET'
      dataType: "json"
      success: (msg)=>
        disabled = $('.disabled')
        if msg.length > 0
          disabled.addClass('active').removeClass('disabled')
          for i in msg
            if i == 1
              $('.js_morning').addClass('disabled').removeClass('active')
            else if i == 2
              $('.js_evening').addClass('disabled').removeClass('active')
        else
          disabled.removeClass('disabled')

  changeOrderStep: ->
    $('.order_step').toggleClass('hidden_block')

  isShoudProcessed: (elem)->
    elem.hasClass('first_variant') && $('.js_company').is(':visible') ||
    elem.hasClass('second_variant') && $('.js_individual').is(':visible')

  showModal: ->
    $('.js_modal_back').show()
    $('.js_modal_order').show()

  addPosition: (e)->
    $('.products').append($('.js_aqua_template').html())

  removePosition: (e)->
    elem = $(e.currentTarget)
    elem.closest('.water_template').remove()

  updateVolumesSelector: (e)->
    elem = $(e.currentTarget)
    aqua_id = parseInt(elem.val())
    $.ajax
      url: "/aquas/#{aqua_id}/volumes"
      type: 'GET'
      dataType: "json"
      success: (data)=>
        waterLine = elem.closest('.water_template')
        @refreshSelectTag(waterLine.find('.js-volume-select-tag'), data.volumes)
        @actualizePrice(waterLine)

  refreshSelectTag: (htmlTag, values)->
    html = ''
    for val in values
      html += "<option value='#{val}'>#{val.split('-')[1]}</option>"
    htmlTag.html(html)

  updateAmount: (e, num)->
    elem = $(e.currentTarget)
    input = elem.closest('.js_amount').find('input')
    val = parseInt(input.val())
    if num > 0
      input.val(val + 1)
    else
      if val > 2
        input.val(val - 1)
    @actualizePrice(elem.closest('.water_template'))

  actualizePrice: (elem)->
    elem.find('.js_price').hide()
    $.ajax
      url: "/aquas/check_price"
      type: 'GET'
      data:
        aqua_id: parseInt(elem.find('.js-aqua-select-tag').val())
        volume_id: parseInt(elem.find('.js-volume-select-tag').val())
        amount: parseInt(elem.find('.js_amount_input').val())
      dataType: "json"
      success: (data)=>
        elem.find('.js_price_value').html(data.price)
        elem.find('.js_price').show()
        if parseFloat(data.price) > 1
          elem.find('.js_currency').show()
        else
          elem.find('.js_currency').hide()

  makingOrderToSubmit: =>
    data =  {
              products: @getProducts(),
              info: @getInfo()
            }
    data

  getInfo: ->
    info = {}
    info['customer_type'] = $('.js_customer_type_selector').data('val')
    form = $(".js_#{info['customer_type']}")
    info['name'] = form.find('.js_name').val()
    info['phone'] = form.find('.js_phone').val()
    info['address'] = form.find('.js_address').val()
    info['date'] = $('.datepicker').val()
    info['time'] = $('.js_delivery_time_selector').data('val')
    info['comment'] = $('.js_comment').val()

  getProducts: ->
    products = {}
    product_lines = $('.products').find('.water_temlate')
    for line in product_lines
      products['aqua'] = line.find('.js-aqua-select-tag').val()


$(document).on 'click', '.variant', (e)->
  elem = $(e.currentTarget)
  unless  elem.hasClass('disabled') || elem.hasClass('active')
    console.log '---------should change view--------------'
    selector = elem.closest('.custome_selector')
    selector.find('.variant').toggleClass('active')
    selector.data('val', elem.data('val'))



$ ->
  order = new Order
  $('.datepicker').datepicker(
    dayNamesMin: ["Вс", "Пн", "Вт", "Ср", "Чт", "Пт", "Сб"]
    dateFormat: "dd-mm-yy"
    firstDay: 1
    nextText: ">"
    prevText: "<"
    minDate: new Date()
    monthNames: ["Январь", "Февраль", "Март", "Апрель", "Май", "Июнь", "Июль", "Август", "Сентябрь", "Октябрь", "Ноябрь", "Декабрь"]
    onSelect: (date) ->
      order.checkAvailableTime()
  )
  $(document).on 'click', '.red_button', ->
    order.showModal()

if window.Storage and window.JSON
  window.$storage = (key) ->
    set: (value) ->
        localStorage.setItem(key, JSON.stringify(value))
    get: ->
        item = localStorage.getItem(key)
        JSON.parse(item) if item

class Order
  constructor: ->
    #localStorage.setItem('product', '')
    #html = $storage("prima_state_card").get()
    #if html
    #  $('.prima_state_card').html(html)

    @isValid = false

    $(document).on 'change', '.js-aqua-select-tag', (e)=>
      @updateVolumesSelector(e)

    $(document).on 'change', '.js-volume-select-tag', (e)=>
      @actualizeWaterPrice($(e.currentTarget).closest('.water_template'))

    $(document).on 'click', '.js_add_position', (e)=>
      @addPosition(e)

    $(document).on 'click', '.js_remove_position', (e)=>
      @removePosition(e)

    $(document).on 'click', '.js_remove_accessory', (e)=>
      @removeAccessory(e)

    $(document).on 'click', '.js_empty_bottles', (e)->
      checkbox = $(e.currentTarget)
      checkbox.attr("checked", !checkbox.attr("checked"))

    $(document).on 'click', '.js_increment', (e)=>
      elem = $(e.currentTarget)
      if elem.data('product') == 'aqua'
        @updateWaterAmount(elem)
      else
        @updateProductAmount(elem)

    $(document).on 'click', '.js_order_change_step', ()=>
      @changeOrderStep()

    $(document).on 'click', '.js_variant', (e)=>
      elem = $(e.currentTarget)
      if  !elem.hasClass('disabled') && @isShoudProcessed(elem)
        $('.order__customer_form').toggleClass('hidden_block')

    $(document).on 'click', '.js_add_product', (e)=>
      elem = $(e.currentTarget)
      @insertProduct(elem)

    $(document).on 'click', '.js_all', (e)=>
      @filterProducts('all', e)

    $(document).on 'click', '.js_cooler', (e)=>
      @filterProducts('cooler', e)

    $(document).on 'click', '.js_accessory', (e)=>
      @filterProducts('accessory', e)



  # improve!!! make through class
  @saveHtml: ->
    #$storage("prima_state_card").set($('.prima_state_card').html())

  filterProducts: (type, e)->
    $('.filter_active').removeClass('filter_active')
    $(e.currentTarget).addClass('filter_active')
    carousel = $('.js_order__products')
    klass = false
    klass = if type == 'cooler'
              '.jsCooler'
            else if type == 'accessory'
              '.jsAccessory'
    if klass
      $('.js_order__products').slick('slickFilter', klass)
    else
      $('.js_order__products').slick('slickUnfilter')


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

    $('.js_order__products').slick
      infinite: true
      slidesToShow: 3
      slidesToScroll: 3
      prevArrow: '<button type="button" class="slick-prev"><</button>'
      nextArrow: '<button type="button" class="slick-next">></button>'

  addPosition: (e)->
    $('.products').append($('.js_aqua_template').html())

  removePosition: (e)->
    elem = $(e.currentTarget)
    elem.closest('.water_template').remove()

  removeAccessory: (e)->
    elem = $(e.currentTarget)
    elem.closest('.accessory_template').remove()

  updateVolumesSelector: (e)->
    elem = $(e.currentTarget)
    aqua_id = parseInt(elem.val())
    $.ajax
      url: "/aquas/#{aqua_id}/volumes"
      type: 'GET'
      dataType: "json"
      success: (data)=>
        waterLine = elem.closest('.water_template')
        @refreshWaterSelectTag(waterLine.find('.js-volume-select-tag'), data.volumes)
        @actualizeWaterPrice(waterLine)

  insertProduct: (elem)->
    attr = elem.data()
    $('.products').append(@productHtml(attr.type, attr.title, attr.amount, attr.price, attr.id))


  productHtml: (type, name, amount, price, id)->
    step = amount
    step1 = '-' + amount
    html = "<div class='accessory_template js_product_item' data-id=#{id}>
              <div class='accessory_name'>
                #{name}
              </div>
              <div class='amount js_amount'>
                <button class='js_increment' data-product='accessory' data-step=#{step1}>
                  -
                </button>
                <input value='#{amount}' disabled='disabled' class='js_accessory_amount'/>
                <button class='js_increment' data-product='accessory' data-step='#{step}'>
                  +
                </button>
              </div>
              <div class='remove_button js_remove_accessory'>
                x
              </div>
              <div class='price js_price' data-price='#{price}'>
                <span class='js_price_value'>#{price.toFixed(2)}</span>
                <span class='js_currency'>
                  Р.
                </span>
              </div>
              <div class='clearfix'></div>
            </div>"
    html

  refreshWaterSelectTag: (htmlTag, values)->
    html = ''
    for val in values
      html += "<option value='#{val}'>#{val.split('-')[1]}</option>"
    htmlTag.html(html)

  updateWaterAmount: (elem)->
    num = elem.data('step')
    input = elem.closest('.js_amount').find('input')
    val = parseInt(input.val())
    if num > 0 || val > 2
      input.val(val + num)
      @actualizeWaterPrice(elem.closest('.water_template'))

  updateProductAmount: (elem)->
    num = elem.data('step')
    input = elem.closest('.js_amount').find('input')
    val = parseInt(input.val())
    if num > 0 || (val + num) > 0
      input.val(val + num)
      @actualizeAccessoryPrice(elem.closest('.accessory_template'), num > 0)

  actualizeWaterPrice: (elem)->
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
        elem.find('.js_price_value').html(data.price.toFixed(2))
        elem.find('.js_price').show()
        if parseFloat(data.price) > 1
          elem.find('.js_currency').show()
        else
          elem.find('.js_currency').hide()

  actualizeAccessoryPrice: (elem, isPositive)->
    priceBlock = elem.find('.js_price')
    priceBlock.hide()
    price = parseFloat(priceBlock.data('price'))
    oldcost = parseFloat(elem.find('.js_price_value').html())
    newCost = if isPositive then oldcost+price else oldcost-price
    elem.find('.js_price_value').html(newCost.toFixed(2))
    priceBlock.show()

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
    info['empty_bottles'] = $('.js_empty_bottles').val()

  getProducts: =>
    products = {}
    product_lines = $('.products').find('.water_temlate')
    if product_lines.length > 0
      products['aquas'] = @getWaters(product_lines)

  getWaters: (product_lines)->
    products = []
    for line in product_lines
      product = {}
      product['aqua'] = line.find('.js-aqua-select-tag').val()
      product['volume'] = line.find('.js-volume-select-tag').val()
      product['amount'] = line.find('.js_amount_input').val()
      products.push(product)
    products



$(document).on 'click', '.variant', (e)->
  elem = $(e.currentTarget)
  unless  elem.hasClass('disabled') || elem.hasClass('active')
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

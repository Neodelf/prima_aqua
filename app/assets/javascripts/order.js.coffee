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

    $(document).on 'click', '.js_submit_card', ()->
      closeModals()


  # improve!!! make through class
  @saveHtml: ->
    $storage("prima_state_card").set($('.prima_state_card').html())

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

$ ->
  order = new Order
  $(document).on 'click', '.red_button', ->
    order.showModal()

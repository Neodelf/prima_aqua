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

    $(document).on 'change', '.js-aqua-select-tag', (e)=>
      @updateVolumesSelector(e)

    $(document).on 'click', '.js_add_position', (e)=>
      @addPosition(e)

    $(document).on 'click', '.js_remove_position', (e)=>
      @removePosition(e)

    $(document).on 'click', '.js_increment', (e)=>
      @updateAmount(e, 1)

    $(document).on 'click', '.js_decrement', (e)=>
      @updateAmount(e, -1)

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
        @refreshSelectTag(elem.closest('.water_template').find('.js-volume-select-tag'), data.volumes)

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
        volume_id: parseInt(elem.find('.js-aqua-select-tag').val())
        amount: parseInt(elem.find('.js_amount_input').val())
      dataType: "json"
      success: (data)=>
        elem.find('.js_price_value').html(data.price)
        elem.find('.js_price').show()

  # update value on select water end select volume

$ ->
  order = new Order
  $(document).on 'click', '.red_button', ->
    order.showModal()

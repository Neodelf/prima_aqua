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

  showModal: ->
    $('.js_modal_back').show()
    $('.js_modal_order').show()

  addProduct: ->

  selectWater: (water_id)->

  getVolumes: (water_id)->
    $.ajax
      url: "/aquas/#{water_id}/volumes"
      type: 'GET'
      dataType: "json"
      success: (data)->
        console.log data.volumes


$ ->
  order = new Order
  $(document).on 'click', '.red_button', ->
    order.showModal()
    order.getVolumes(1)

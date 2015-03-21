activateFilter = (filter) ->
  $('.js_prices').addClass('hidden_block')
  $(".js_#{filter}").removeClass('hidden_block')
  $(".selected_filter").removeClass('selected_filter')
  $(".filter__#{filter}").addClass('selected_filter')


$(document).on 'click', '.js_filter', (e)->
  e.preventDefault()
  size = $(e.currentTarget).data('filter')
  activateFilter(size)

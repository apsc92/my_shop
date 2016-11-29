# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  window.itemChange = (elem) ->
    row = elem.closest('tr')
    quantity = elem.value
    id = $(row).find('td.order_item_id').text()
    order_id = $(row).find('td.order_id').text()
    $.ajax
      url: '/orders/' + order_id + '/order_items/' + id + '?quantity=' + quantity,
      type: 'PUT'
      success: (result) ->
        window.location.reload()
        return
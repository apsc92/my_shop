# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready ->
  window.itemChange = (id) ->
    id = $('.order_item_id').text();
    quantity = $('#item_quantity').val();
    $.ajax
      url: '/order_items/' + id + '?quantity=' + quantity,
      type: 'PUT'
      success: (result) ->
        window.location.reload()
        return

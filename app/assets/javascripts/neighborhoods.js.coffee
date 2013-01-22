# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $('#city_id').parent().hide()
  cities = $('#city_id').html()
  $('#state_id').change -> 
    state = $('#state_id :selected').text()
    console.log(state)
    options = $(cities).filter("optgroup[label='#{state}']").html()
    console.log(options)
    if options
      $('#city_id').html(options)
      $('#city_id').parent().show()
    else
      $('#city_id').empty()
      $('#city_id').parent().hide()

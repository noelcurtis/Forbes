# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->

  # Show cities based on selected State
  $('#neighborhood_city_id').parent().hide()
  cities = $('#neighborhood_city_id').html()
  console.log(cities)
  $('#state_id').change -> 
    state = $('#state_id :selected').text()
    console.log(state)
    options = $(cities).filter("optgroup[label='#{state}']").html()
    console.log(options)
    if options
      $('#neighborhood_city_id').html(options)
      $('#neighborhood_city_id').parent().show()
      city_id = $('#neighborhood_city_id :selected').val()
      update_neighborhoods(city_id)
    else
      $('#neighborhood_city_id').empty()
      $('#neighborhood_city_id').parent().hide()
      $('#neighborhoods').hide()

  # Show neighborhoods based on selected city
  $('#neighborhood_city_id').change ->
    city_id = $('#neighborhood_city_id :selected').val()
    update_neighborhoods(city_id)  

  update_neighborhoods = (city_id) ->
    $.ajax '/neighborhoods',
      type: 'GET'
      datatype: 'html' 
      data:
        city_id: "#{city_id}"
      success: (data) -> 
        $('#neighborhoods').html("#{data}")
        $('#neighborhoods').show()

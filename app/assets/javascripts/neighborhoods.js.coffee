jQuery ->

  # Show cities based on selected State
  $('#neighborhood_city_id').parent().hide()
  $('.new_neighborhood_link').parent().hide()
  cities = $('#neighborhood_city_id').html()
  $('#state_id').change ->
    state = $('#state_id :selected').text()
    options = $(cities).filter("optgroup[label='#{state}']").html()
    if options
      blank_option = '<option value>Select a City</option>'
      $('#neighborhood_city_id').html(blank_option + options)
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
    $('.new_neighborhood_link').bind('ajax:before', ->
        $(this).data('params', { city_id: "#{city_id}" })
    ).parent().show()
    $.ajax '/neighborhoods',
      type: 'GET'
      datatype: 'html'
      data:
        city_id: "#{city_id}"
      success: (data) ->
        $('#neighborhoods').html("#{data}")
        $('#neighborhoods').show()


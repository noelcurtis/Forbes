$ ->
    $('#login').on 'click', (ev) -> $(this).toggleClass 'active'

#$ ->
#  $('header').on 'click', '#login', (e) ->
#    e.preventDefault()
#
#    login_form = $('#login_form').show()
#
#    $(this).data('html', true)
#           .data('content', login_form)
#           .data('placement', 'bottom')
#           .data('trigger', 'manual')
#           .popover('toggle')

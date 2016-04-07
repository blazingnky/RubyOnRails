# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

init = ->
  $('#ajax_form').on 'ajax:success', (e, data) ->
    $('#result').empty()
    $.each data, ->
      $('#result').append(
        $('<li></li>').append(
          $('<a></a>').attr('href', 'http://www.wings.msn.to/index.php/-/A-03/' + @isbn).append(@title)
        )
      )

  $(document).ajaxStart ->
     $('#progress').html '통신 중...'
   .ajaxComplete ->
     $('#progress').html ''

  $('#slide_search').on 'ajax:success', (e, data) ->
    $('#result').empty()
    $.each data.Slideshows.Slideshow, ->
      $('#result').append(
        $('<li></li>').append(
          $('<a></a>').attr('href', @URL).append("#{@Title}(#{@Description})")
        )
      )


$(document).ready(init)
$(document).on('page:change', init)
# This is a manifest file that'll be compiled into application.js, which will include all the files
# listed below.
#
# Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
# or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
#
# It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# compiled file.
#
# Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
# about supported directives.
#
#= require jquery
#= require tether
#= require jquery_ujs
#= require popper
#= require bootstrap
#= require Chart.bundle
#= require chartkick
#= require turbolinks
#= require_tree .

document.addEventListener 'turbolinks:load', (event) ->
  if typeof ga is 'function'
    ga('set', 'location', event.data.url)
    ga('send', 'pageview')

document.addEventListener 'turbolinks:load', (event) ->
  $('[data-toggle="popover"]').popover trigger: 'hover focus'
  return
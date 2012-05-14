#= require jquery
#= require jquery.cookie
#= require jquery_ujs
#= require twitter/bootstrap
#= require tree.jquery
#= require hamlcoffee
#= require inflection
#= require underscore
#= require faye
#= require app
#= require_tree .
#= require_self

jQuery ->
  $("a[rel=popover]").popover()
  $(".tooltip").tooltip()
  $("a[rel=tooltip]").tooltip()
  
  window.proctor = new Proctor

// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require bootstrap-sprockets
//= require_tree .

// $(document).ready(function() {
// 	$('input[name="daterange"]').daterangepicker();
// });

$(document).ready(function(){
	$(function() {
    $('input[name="daterange"]').daterangepicker({
    	startDate: new Date()
    });
	});
})

// $('input[name="daterange"]').daterangepicker(
// {
//     locale: {
//       format: 'YYYY-MM-DD'
//     },
//     startDate: '2013-01-01',
//     endDate: '2013-12-31'
// }, 
// function(start, end, label) {
//     alert("A new date range was chosen: " + start.format('YYYY-MM-DD') + ' to ' + end.format('YYYY-MM-DD'));
// });
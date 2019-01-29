// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require materialize
//= require rails-ujs
//= require activestorage

$(document).ready(function () {
    $("button").click(function () {
        $(`#${$(this).data("id")}`).toggle();
    });

    $.get('/api/notifications/count', function(result) {
        $('.notification_counter a').text(`Notifications: ${result}`)
    });

    $('.modal').modal();
});

$(function () {
    $('.content').atwho(
        {
            at: "@",
            callbacks: {
                remoteFilter: function (query, callback) {
                    $.getJSON("/api/author/", {key: query}, function (data) {
                        callback(data.map(x => x.nick))
                    });
                }
            }
        });
});

$(document).ready(function () {
    $('#autocomplete-input').keyup(debounce(function() {

        let testInput = $(this).val();

        $.get('/api/posts', {key: testInput}, function (result) {
            let autocomplete_data = {};
            for (let key in result) {
                autocomplete_data[result[key].title] = null
            }
            $('input.autocomplete').autocomplete({
                data: autocomplete_data
            }).autocomplete('open');
        })
    }, 300))


});

function debounce(func, wait, immediate) {
    var timeout;
    return function() {
        var context = this, args = arguments;
        var later = function() {
            timeout = null;
            if (!immediate) func.apply(context, args);
        };
        var callNow = immediate && !timeout;
        clearTimeout(timeout);
        timeout = setTimeout(later, wait);
        if (callNow) func.apply(context, args);
    };
};

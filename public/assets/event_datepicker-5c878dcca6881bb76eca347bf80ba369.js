$(function(){function e(){var e=function(){switch($(".event_option").hide(),$("#event_repeats").val()){case"never":break;case"weekly":$("#repeats_options").show(),$("#repeats_weekly_options").show()}};e(),$("#event_repeats").on("change",function(){e()});var n=function(){switch($("#event_repeat_ends").val()){case"never":$("#event_repeat_ends_on").hide();break;case"on":$("#event_repeat_ends_on").show()}};n(),$("#event_repeat_ends").on("change",function(){n()})}$(document).ready(e),$(document).on("page:load",e)});
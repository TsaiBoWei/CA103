$(document).ready(function(){
      var max = 150.72259521484375;
      $.each($('.progress'), function( index, value ){
        percent = $(value).data('progress');
        $(value).children($('.fill')).attr('style', 'stroke-dashoffset: ' + ((100 - percent) / 100) * max);
        $(value).children($('.display')).text(percent + '%');
      });
    });

//purchase List script

    $('.rolldown-list li').each(function () {
        var delay = ($(this).index() /3) + 's';
        $(this).css({
          webkitAnimationDelay: delay,
          mozAnimationDelay: delay,
          animationDelay: delay
        });
      });

      $('#btnReload').click(function () {
        $('#myList').removeClass('rolldown-list');
        setTimeout(function () {
          $('#myList').addClass('rolldown-list');
        }, 2);
      });

//uploadfile script

    $(document).ready(function() {
    
    'use strict';
  
    $('.input-file').each(function() {
      var $input = $(this),
          $label = $input.next('.js-labelFile'),
          labelVal = $label.html();
     
      $('.input-file').on('change', function(e) {
//    	console.log(e);
        var fileName = '';
        if (e.target.value) fileName = e.target.value.split('\\').pop();
        fileName ? $label.addClass('has-file').find('.js-fileName').html(fileName) : $label.removeClass('has-file').html(labelVal);
        
        ////////
        
        var file = e.target.files[0];                            // selected file

        
//        BLOB作法
        var blob = new Blob([file]), // 文件转化成二进制文件
        url = URL.createObjectURL(blob); //转化成url
       
        var video = $('<video id="myvideo" width="400" height="240" controls source src="' + url + '">');
        
        $('.preview2').html('').append(video);
        video[0].load(function(file) {
        	  // Handler for .load() called.
        	URL.revokeObjectURL(this.src);
        	 
        });
    
        $("#myvideo").on(
        	      "loadedmetadata", 
        	      function(event){
        	    	  var duration= this.duration;
        	    	 
        	    	  onTrackedVideo(this.duration);
        	       
        	      });

        
     });
  });
    
   
  });
    function onTrackedVideo(duration){
    	
    	var cour_length=document.getElementById("cour_length");
        cour_length.value=duration;
    

    };
    
 
    
 

$(document).ready(function () {
            $('#summernote').summernote({
//      airMode: true,
      height: 400, 
     
   
      
      //set editable area's height
//      codemirror: { // codemirror options
//        theme: 'Darkly'
//      },
//                
       popover: {
         image: [],
         link: [],
         air: []
       }
     
             });      
      
    });
//        $('.note-editor').css("background-color","red");
        var markupStr = $('.note-editable').html();
        
        function show() { 
        alert(markupStr);
            console.log(markupStr);
        };
        $("input").click(function (){
            var markupStr = $('.note-editable').html();
//             console.log(markupStr);
            $("#wtf").val(markupStr);
            var wtf=$("#wtf").val();
            console.log(wtf);
            
            
        })
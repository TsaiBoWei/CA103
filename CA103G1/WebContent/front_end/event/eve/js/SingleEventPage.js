/*navbar*/ 
    $(document).ready(function(){
        /*模擬點擊登入按鈕後 登入按鈕消失 右上顯示會員名稱*/
        $("#registerBtn").click(function(){
           $("#registerBtn").hide();
            $("#navUserBtn").show();
           $(".dropdown>a").html("David&nbsp&nbsp<i class='fa fa-caret-down dropbtn'></i>").show();
        });

          /* 點擊會員名稱 出現下拉選單 */
        $("#navUserName").click(function(){
             document.getElementById("myDropdown").classList.toggle("show-dropdown-content");
        });
  

        /* 點擊外部 下拉選單消失 */
        window.onclick = function(event) {
          if (!event.target.matches('.dropbtn')) {

            var dropdowns = document.getElementsByClassName("dropdown-content");
            var i;
            for (i = 0; i < dropdowns.length; i++) {
              var openDropdown = dropdowns[i];
              if (openDropdown.classList.contains('show-dropdown-content')) {
                openDropdown.classList.remove('show-dropdown-content');
              }
            }
          }
        }
    });





/*GoTop button*/ 
	$(document).ready(function(){
		$("#goTopBtn").click(function(){
			$('html,body').animate({scrollTop: '0px'}, 400);   
		});
	});





  $(document).ready(function(){
 
    //multi-slide-carousel 避免按左右按鈕往上移&註冊不同的carousel id
    $('#bs4-multi-slide-carousel').carousel({
      interval: 4000
    });

    $('.multnext1').click(function(){ $('[id^="bs4-multi-slide-carousel"]').carousel('next')});
    $('.multprev1').click(function(){ $('[id^="bs4-multi-slide-carousel"]').carousel('prev')});

    $('.multnext1-new').click(function(){ $('[id^="bs4-multi-slide-carousel-new"]').carousel('next')});
    $('.multprev1-new').click(function(){ $('[id^="bs4-multi-slide-carousel-new"]').carousel('prev')});

    $('.multnext1-friend').click(function(){ $('[id^="bs4-multi-slide-carousel-friend"]').carousel('next')});
    $('.multprev1-friend').click(function(){ $('[id^="bs4-multi-slide-carousel-friend"]').carousel('prev')});

    $('.adnext').click(function(){ $('[id^="myCarousel2"]').carousel('next')});
    $('.adprev').click(function(){ $('[id^="myCarousel2"]').carousel('prev')});
});
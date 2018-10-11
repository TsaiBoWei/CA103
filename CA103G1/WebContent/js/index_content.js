/**
 * 
 */

/*Cover*/
    /*換底圖 https://segmentfault.com/a/1190000003067215*/
    $(document).ready(function(){
        function fadeIn(e) {
          e.className = "cover_bgimg coverfadein section-fade-in-out"
        };

        function fadeOut(e) {
          e.className = "cover_bgimg section-fade-in-out"
        };
        //目前顯示的圖片
        cur_img = document.getElementById("coverImgs").children.length - 1;

        function turnImgs(imgs) {
            $("#coverImgad").fadeIn();
            $("#coverFirstImg").hide();
            var imgs = document.getElementById("coverImgs").children;
            if (cur_img == 0) {
              fadeOut(imgs[cur_img]);
              cur_img = imgs.length - 1;
              fadeIn(imgs[cur_img]);
            } else {
              fadeOut(imgs[cur_img]);
              fadeIn(imgs[cur_img - 1]);
              cur_img--;
            }
          }
          //設置換圖间隔
        setInterval(turnImgs, 5000);

    });

    /*Moving Letter in Cover http://tobiasahlin.com/moving-letters/#3*/
        // Wrap every letter in a span
        $(document).ready(function(){
            $(".moveLetter2").hide();
            $('.moveLetter1').each(function(){
              $(this).html($(this).text().replace(/([^\x00-\x80]|\w)/g, "<span class='letter'>$&</span>"));
            });

            anime.timeline({loop: true})
              .add({
                targets: '.moveLetter1 .letter',
                opacity: [0,1],
                easing: "easeInOutQuad",
                duration: 2000,
                delay: function(el, i) {
                  return 100 * (i+1)
                }
              }).add({
                targets: '.moveLetter1',
                opacity: 0,
                duration: 1000,
                easing: "easeOutExpo",
                delay: 4000
              });

             window.setTimeout( function(){
                $(".moveLetter2").show();
                  $('.moveLetter2').each(function(){
                  $(this).html($(this).text().replace(/([^\x00-\x80]|\w)/g, "<span class='letter'>$&</span>"));
                });

                anime.timeline({loop: true})
                  .add({
                    targets: '.moveLetter2 .letter',
                    opacity: [0,1],
                    easing: "easeInOutQuad",
                    duration: 1000,
                    delay: function(el, i) {
                      return 60 * (i+1)
                    }
                  }).add({
                    targets: '.moveLetter2',
                    opacity: 0,
                    duration: 1000,
                    easing: "easeOutExpo",
                    delay: 3000
                  });
             },1000);
        });



/*GoTop button*/ 
	$(document).ready(function(){
		$("#goTopBtn").click(function(){
			$('html,body').animate({scrollTop: '0px'}, 400);   
		});
	});

/*宣傳圖 Carousel*/
	$(document).ready(function(){
    
        // Enable Carousel Indicators
        $(".item1").click(function(){
            $("#myCarouse2").carousel(0);
        });

        $(".item2").click(function(){
            $("#myCarouse2").carousel(1);
        });

        $(".item3").click(function(){
            $("#myCarouse2").carousel(2);
        });
        
        // Enable Carousel Controls
        $(".carousel-control-prev").click(function(){
            $("#myCarouse2").carousel("prev");

        });

        $(".carousel-control-next").click(function(){
            $("#myCarouse2").carousel("next");
        });

});



/*MULTIPLE carousel */
/*JS輪播 http://www.dayexie.com/detail2322637.html*/
    $(document).ready(function(){
        var i=0;
        $(function(){
            $(".picImgPop").eq(0).show().siblings().hide();   //默認第一張圖片顯示，其他的隱藏
            console.log( ($(".picImgPop")).eq(0));

            //點擊左右按鈕
            $(".btn1Pop").click(function(){
                i--;   //往左
                if(i==-1){i=2;}
                showPic();
            });

            $(".btn2Pop").click(function(){
                i++;   //往右
                if(i==3){i=0;}
                showPic();
            });
        });

        //顯示圖片
        function showPic(){
            $(".picImgPop").eq(i).show().siblings().hide();
        }
    });

    $(document).ready(function(){
        var i=0;
        $(function(){
            $(".picImgNew").eq(0).show().siblings().hide();   //默認第一張圖片顯示，其他的隱藏
            console.log( ($(".picImgNew")).eq(0));

            //點擊左右按鈕
            $(".btn1New").click(function(){
                i--;   //往左
                if(i==-1){i=2;}
                showPic();
            });

            $(".btn2New").click(function(){
                i++;   //往右
                if(i==3){i=0;}
                showPic();
            });
        });

        //顯示圖片
        function showPic(){
            $(".picImgNew").eq(i).show().siblings().hide();
        }
    });

    $(document).ready(function(){
        var i=0;
        $(function(){
            $(".picImgFriend").eq(0).show().siblings().hide();   //默認第一張圖片顯示，其他的隱藏
            console.log( ($(".picImgFriend")).eq(0));

            //點擊左右按鈕
            $(".btn1Friend").click(function(){
                i--;   //往左
                if(i==-1){i=2;}
                showPic();
            });

            $(".btn2Friend").click(function(){
                i++;   //往右
                if(i==3){i=0;}
                showPic();
            });
        });

        //顯示圖片
        function showPic(){
            $(".picImgFriend").eq(i).show().siblings().hide();
        }
    });



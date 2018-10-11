/**
 * 
 */


/*navbar*/ 
    $(document).ready(function(){
       
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









 

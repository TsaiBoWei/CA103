<%@ page language="java" contentType="text/html; charset=utf-8"
pageEncoding="big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>UpdateMember</title>
<style type="text/css">
   body { background: #1f1f1f !important; } /* Adding !important forces the browser to overwrite the default style applied by Bootstrap */
</style>
    <link rel="stylesheet " href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css ">

</head>

<body >

    <div class="container">
        <div class="col-sm-12 formContent center text-light">
          <form action="<%=request.getContextPath() %>/mem/mem.do" method="post" enctype="multipart/form-data">
              <div class="form-group">
                <h4 class="mt-3 text-light" align="center" >修改資料</h4>
              </div>
             <div class="form-group ">
             	<div>
        			<img class="preview" style="max-width: 150px; max-height: 150px;">
        			<div class="size"></div>
    			</div>
                <label >上傳圖片:</label>
                <input type="file" class="upl" name="memPhoto">
                <input type="submit"  value="上傳">
             </div>
             <div class="form-group">
                <label >會員暱稱:</label>
                <input type="text" name="memName" class="form-control" value=${memVO.mem_name }>
             </div>
             <div class="form-group">
                <label>會員生日:</label>
                <input type="date" name="memBirth" class="form-control">
             </div>
			<div class="form-group">
                <label>會員信箱:</label>
                <input type="email" name="memEmail" class="form-control">
             </div>
             <div class="form-group">
                <label>個人簡介</label>
                <textarea class="form-control" name="memIntro" placeholder="" style="height: 300px" ></textarea>
             </div>
             
             <div class="form-group">
              <input type="hidden" name="action" value="mem_update">  <!-- 進入servlet -->
              <button type="submit" class="btn btn-primary" id="regSend">送出</button>
              <button type="button" class="btn btn-secondary " data-dismiss="modal">取消</button>
              
            </div>
        	
          </form>
        </div>
    </div>

<!-- JavaScript dependencies -->
<script src="https://code.jquery.com/jquery-3.2.1.min.js "></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
<!-- Script: Smooth scrolling between anchors in a same page -->
<script src="js/smooth-scroll.js"></script>

<script>
    $(function (){

    function format_float(num, pos)
    {
        var size = Math.pow(10, pos);
        return Math.round(num * size) / size;
    }

    function preview(input) {

        if (input.files && input.files[0]) {
            var reader = new FileReader();
            
            reader.onload = function (e) {
                $('.preview').attr('src', e.target.result);
                var KB = format_float(e.total / 1024, 2);
                $('.size').text("檔案大小：" + KB + " KB");
            }

            reader.readAsDataURL(input.files[0]);
        }
    }

    $("body").on("change", ".upl", function (){
        preview(this);
    })
    
        });
</script>

</body>
</html>

function doClick() {
	var el = document.getElementById("fileElem");

	if (el) {
		el.click();
	}
}

function handleFiles() {
	var file = document.getElementById("fileElem").files[0];
	document.getElementById('img').src = window.URL.createObjectURL(file);
}

function openFile(event) {
	var input = event.target; // 取得上傳檔案
	var reader = new FileReader(); // 建立FileReader物件

	reader.readAsDataURL(input.files[0]); // 以.readAsDataURL將上傳檔案轉換為base64字串

	reader.onload = function() { // FileReader取得上傳檔案後執行以下內容
		var dataURL = reader.result; // 設定變數dataURL為上傳圖檔的base64字串
		$('#output').attr('src', dataURL).show(); // 將img的src設定為dataURL並顯示
	};
}

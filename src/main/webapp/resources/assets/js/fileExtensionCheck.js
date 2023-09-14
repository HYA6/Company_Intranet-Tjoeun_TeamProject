$("#filename").on("change", function(){

var fileName = $("#filename").val();

fileName = fileName.slice(fileName.indexOf(".") + 1).toLowerCase();

if(fileName != "jpg" && fileName != "png" &&  fileName != "gif" &&  fileName != "bmp"){

alert("이미지 파일은 (jpg, png, gif, bmp) 형식만 등록 가능합니다.");

$("#filename").val("");

return;

}

});
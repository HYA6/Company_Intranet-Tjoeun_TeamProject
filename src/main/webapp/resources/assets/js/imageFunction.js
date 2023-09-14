$("#filename").on("change", function(){

	var fileName = $("#filename").val();

	fileExt = fileName.slice(fileName.indexOf(".") + 1).toLowerCase();

	if(fileExt != "jpg" && fileExt != "png" &&  fileExt != "gif" &&  fileExt != "bmp"){

		alert("이미지 파일은 (jpg, png, gif, bmp) 형식만 등록 가능합니다.");

		$("#filename").val("");

		return;

	}

});


let beforeImageHref = document.getElementById('imageName').href;
let beforeImage = document.getElementById('imageNameSpan').innerHTML;


function readImage(input) {
	
	var fileName = input.files[0].name;
	var fileExt = fileName.slice(fileName.indexOf(".") + 1).toLowerCase();
	
	var flag = 1;
	if(fileExt != "jpg" && fileExt != "png" &&  fileExt != "gif" &&  fileExt != "bmp") {
		flag = 0;
	}
	
	
	
	if (input.files && input.files[0] && flag ) {
		var reader = new FileReader();
	    reader.onload = function(e) {
	    	console.log(input.files[0]);
	    	document.getElementById('preImage').src = e.target.result;
	  		document.getElementById('imageName').href = e.target.result;
	  		document.getElementById('imageName').download = e.target.result;
	    };
    reader.readAsDataURL(input.files[0]);
    
  
	document.getElementById('imageNameSpan').innerHTML = fileName;
  } else {
	  
	  document.getElementById('preImage').src = beforeImageHref;
	  
  }
}

function resetDefaultImage() {
	document.getElementById('preImage').src = "images/user.png";
	document.getElementById('imageName').href = "";
	document.getElementById('imageName').download = "";
	$('#imageNameSpan').html("");
	$('#filename').val("");
}

function resetImage() {
	document.getElementById('preImage').src = beforeImageHref;
	document.getElementById('imageName').href = beforeImageHref;
	document.getElementById('imageName').download = beforeImageHref;
	document.getElementById('imageNameSpan').innerHTML = beforeImage;
	$('#filename').val("");
}


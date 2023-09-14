// 파일 포함한 form 검증
function validateFileForm() {
	
	var subject = document.getElementById("subject").value;
    var content = document.getElementById("content").value;
    var file = document.getElementById("filename").value;
    
    if (subject.trim() === '' || content.trim() === '' || file.trim() === '') {
        alert("제목과 내용, 파일을 모두 입력해주세요.");
        return false; // 폼 제출 중단
    }

    // 비어 있지 않은 경우 폼을 제출
    return true;
    
}

// 종류 포함한 form 검증
function validateTypeForm() {
	
	var subject = document.getElementById("subject").value;
    var content = document.getElementById("content").value;
    
    const typeNodeList = document.getElementsByName('gubun');
    
    let flag = 0;
    typeNodeList.forEach((node) => {
    	if (node.checked) {
    		flag = 1;
    	}
    });
    
    if ( flag != 1 ) {
    	alert("공지 종류를 선택해주세요.");
    	return false;
    }
    
    if (subject.trim() === '' || content.trim() === '') {
        alert("제목과 내용을 모두 입력해주세요.");
        return false; // 폼 제출 중단
    }
    

    
    // 비어 있지 않은 경우 폼을 제출
    return true;   
}

// 일반 form 검증
function validateForm() {
	
	var subject = document.getElementById("subject").value;
    var content = document.getElementById("content").value;
    
    if (subject.trim() === '' || content.trim() === '') {
        alert("제목과 내용을 모두 입력해주세요.");
        return false; // 폼 제출 중단
    }

    // 비어 있지 않은 경우 폼을 제출
    return true;
    
}
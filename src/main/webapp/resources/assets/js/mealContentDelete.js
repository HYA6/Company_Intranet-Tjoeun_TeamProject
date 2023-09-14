function confirmAndDelete() {
        if (confirm("해당 게시물을 삭제하시겠습니까?")) {
            // User clicked OK, submit the form
        	
            document.getElementById("delete").submit();
            alert("게시물을 삭제했습니다.");
        } else {
            // User clicked Cancel, do nothing
        }
    }
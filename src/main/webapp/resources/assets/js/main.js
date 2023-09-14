document.addEventListener("DOMContentLoaded", function () {
     var RoomValues = document.querySelectorAll('.RoomValue');

     RoomValues.forEach(function (RoomValue) {
        if (!RoomValue) {
            var noDivElement = document.createElement("div");
            noDivElement.textContent = '없음';
            RoomValue.appendChild(noDivElement);
        }
        console.log(RoomValue.innerText);
    });
});



let a = document.getElementsByTagName('a');
let img = document.getElementsByTagName('img');

let count = 1;


//'◀'에 연결한다.
function firstClick() {
//	alert('첫클릭 된다');
	// getAttribute('속성이름'): 인수로 지정된 속성의 속성값을 얻어온다.
	count = --count < 1 ? 10 : count;
	img[2].setAttribute('src', `./images/${count}.jpg`);
	count = --count < 1 ? 10 : count;
	img[1].setAttribute('src', `./images/${count}.jpg`);
	count = --count < 1 ? 10 : count;
	img[0].setAttribute('src', `./images/${count}.jpg`);
};

count = 3;
// '▶'에 연결한다.
function endClick() {
//	alert('마지막 클릭 된다');
	count = ++count > 10 ? 1 : count;
	img[0].setAttribute('src', `./images/${count}.jpg`);
	count = ++count > 10 ? 1 : count;
	img[1].setAttribute('src', `./images/${count}.jpg`);
	count = ++count > 10 ? 1 : count;
	img[2].setAttribute('src', `./images/${count}.jpg`);
};



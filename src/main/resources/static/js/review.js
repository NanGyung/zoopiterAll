// 동물 태그 셀렉트 박스 이벤트

// // 선택한 태그를 추가할 영역
// const $tagList = document.querySelector('.tag-list');
// // 동물유형 선택 셀렉트 박스
// const $select = document.querySelector('select[name="pet"]');

// const select_h = e => {
//     const target = e.target;
//     const petTagValue = target.value;
//     const $options = document.querySelectorAll('.select option');

//     if (petTagValue == 'default') {
//         e.preventDefault();
//     } else {
//         for (const ele of $options) {
//             if (ele.value == petTagValue) {
//                 // tagList 영역에 선택한 태그 추가
//                 let newTag = document.createElement("div");
//                 newTag.innerHTML = `#<p>${ele.textContent}</p>`;
//                 newTag.className = 'tag';
//                 $tagList.appendChild(newTag);
//             }
//         }
//     }
// };
// $select.addEventListener('change', select_h, false);

const $selectBox = document.querySelector('.left .selectBox');
const $check = document.querySelectorAll('input[type="checkbox"]');
let addBtn;

const  checkbox_h = e => {
    let checkedCnt = 0;

    // 동물태그 체크박스 선택했을 시 전체 선택 해제 버튼 추가
    for(const ele of $check){
        if (ele.checked == true) {
            checkedCnt++;
        }
    }
    if(checkedCnt === 1){
        addBtn = document.createElement("button");
        addBtn.innerHTML = '전체 선택 해제';
        addBtn.setAttribute("id", "allBtn");
        $selectBox.appendChild(addBtn);
    }else if(checkedCount === 0 || checkedCount === $check.length){
        $selectBox.removeChild(addBtn);
    }
}

$selectBox.addEventListener('change',checkbox_h,false);


// 좋아요 클릭 이벤트

// 클릭 전 아이콘
const $prevHeart = document.querySelectorAll('.like-icons .fa-regular');

const heart_h = e => {
    const target = e.target;
    if (target.className == "fa-regular fa-heart") {
        target.classList.remove("fa-regular");
        target.classList.remove("fa-heart");
        target.classList.add("fa-solid");
        target.classList.add("fa-heart");
    } else if (target.className == "fa-solid fa-heart") {
        target.classList.remove("fa-solid");
        target.classList.remove("fa-heart");
        target.classList.add("fa-regular");
        target.classList.add("fa-heart");
    }
};
for (const ele of $prevHeart) {
    ele.addEventListener('click', heart_h, false);
}

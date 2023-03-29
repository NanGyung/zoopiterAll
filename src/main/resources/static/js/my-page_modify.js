// 수정화면에서 수정완료 버튼 눌렀을 때 마이페이지-메인으로 감
const $modifyBtn2 = document.getElementById('btn_modify2');
const modify_h = e => {
    if(window.confirm('수정완료 하시겠습니까?')){
        location.replace('./mypage_main.html');
    }else{
        return;
    }
};

$modifyBtn2.addEventListener('click',modify_h,false);
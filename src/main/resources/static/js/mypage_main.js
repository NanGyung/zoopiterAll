function modify() {
  if (window.confirm('수정하시겠습니까?')) {
    console.log('승인');
    location.replace('./mypage_main_modify.html'); //'index.php'
  } else {
    console.log('취소');
    return;
  }
}
function withdraw() {
  if (window.confirm('탈퇴하시겠습니까?')) {
    console.log('승인');
  } else {
    console.log('취소');
  }
}

const $nickname = document.getElementById('nickname');
const $id = document.getElementById('id');
const $pw = document.getElementById('pw');
const $pwCheck = document.getElementById('pwCheck');
const $email = document.getElementById('email');
const $emailCheck = document.getElementById('emailCheck');

const $errNickname = document.querySelector('.err.nickname');
const $errId = document.querySelector('.err.id');
const $errPw = document.querySelector('.err.pw');
const $errPwCheck = document.querySelector('.err.pwCheck');
const $errEmail = document.querySelector('.err.email');
const $errEmailCheck = document.querySelector('.err.emailCheck');

// 닉네임
$nickname.addEventListener('keydown', e => {
  const input = $nickname.value;
  const lenOfInput = input.length;

  if (e.key === ' ') {
    e.preventDefault();
  }

  if (e.key != 'Enter') {
    return;
  }
  if (e.key == 'Enter') {
    if (/[^A-Za-z0-9ㄱ-힣]/.test(input)) {
      $errNickname.classList.remove('hidden');
      $errNickname.textContent = '* 영문 숫자 한글만 입력 가능합니다.';
      $nickname.focus();
      return;
    }
    if (lenOfInput == 0) {
      $errNickname.classList.remove('hidden');
      $errNickname.textContent = '* 닉네임를 입력해 주세요.';
      $nickname.focus();
      $nickname.value = '';
    } else {
      $errNickname.classList.add('hidden');
      // $nickname.value = input;
      $id.focus();
    }
    return;
  }
});

$nickname.addEventListener('blur', e => {
  const input = $nickname.value;
  const lenOfInput = input.length;

  if (/[^A-Za-z0-9ㄱ-힣]/.test(input)) {
    $errNickname.classList.remove('hidden');
    $errNickname.textContent = '* 영문 숫자 한글만 입력 가능합니다.';
    return;
  }
  if (lenOfInput == 0) {
    $errNickname.classList.remove('hidden');
    $errNickname.textContent = '* 닉네임을 입력해 주세요.';
    $nickname.value = '';
  } else {
    $errNickname.classList.add('hidden');
    // $nickname.value = input;
  }
  return;
});

//아이디
$id.addEventListener('keydown', e => {
  const input = $id.value;
  const lenOfInput = input.length;

  if (e.key === ' ') {
    e.preventDefault();
  }

  if (e.key != 'Enter') {
    return;
  }
  if (e.key == 'Enter') {
    if (/[^A-Za-z0-9]/.test(input)) {
      $errId.classList.remove('hidden');
      $errId.textContent = '* 영문 숫자만 입력 가능합니다.';
      $id.focus();
      return;
    }
    if (lenOfInput == 0) {
      $errId.classList.remove('hidden');
      $errId.textContent = '* 아이디를 입력해 주세요.';
      $id.focus();
      $id.value = '';
    } else {
      $errId.classList.add('hidden');
      // $id.value = input;
      $pw.focus();
    }
    return;
  }
});

$id.addEventListener('blur', e => {
  const input = $id.value.trim();
  const lenOfInput = input.length;

  if (/[^A-Za-z0-9]/.test(input)) {
    $errId.classList.remove('hidden');
    $errId.textContent = '* 영문 숫자만 입력 가능합니다.';
    return;
  }
  if (lenOfInput == 0) {
    $errId.classList.remove('hidden');
    $errId.textContent = '* 아이디을 입력해 주세요.';
    $id.value = '';
  } else {
    $errId.classList.add('hidden');
    // $id.value = input;
  }
  return;
});

//비밀번호
$pw.addEventListener('keydown', e => {
  const input = $pw.value;
  const lenOfInput = input.length;

  if (e.key === ' ') {
    e.preventDefault();
  }

  if (e.key != 'Enter') {
    return;
  }
  if (e.key == 'Enter') {
    if (/[^A-Za-z0-9]/.test(input)) {
      $errPw.classList.remove('hidden');
      $errPw.textContent = '* 영문 대소문자 숫자만 입력 가능합니다.';
      $pw.focus();
      return;
    }
    if (lenOfInput == 0) {
      $errPw.classList.remove('hidden');
      $errPw.textContent = '* 비밀번호를 입력해 주세요.';
      $pw.focus();
    } else if (8 > lenOfInput || lenOfInput > 20) {
      $errPw.classList.remove('hidden');
      $errPw.textContent = '* 비밀번호는 8~20자 입력 가능합니다.';
      $pw.focus();
    } else {
      $errPw.classList.add('hidden');
      $pwCheck.focus();
    }
    return;
  }
});

$pw.addEventListener('blur', e => {
  const input = $pw.value;
  const lenOfInput = input.length;

  if (/[^A-Za-z0-9]/.test(input)) {
    $errPw.classList.remove('hidden');
    $errPw.textContent = '* 영문 대소문자 숫자만 입력 가능합니다.';
    return;
  }
  if (lenOfInput == 0) {
    $errPw.classList.remove('hidden');
    $errPw.textContent = '* 비밀번호를 입력해 주세요.';
  } else if (8 > lenOfInput || lenOfInput > 20) {
    $errPw.classList.remove('hidden');
    $errPw.textContent = '* 비밀번호는 8~20자 입력 가능합니다.';
  } else {
    $errPw.classList.add('hidden');
  }
  return;
});

//비밀번호 확인
$pwCheck.addEventListener('input', e => {
  const input = $pwCheck.value;
  const inputChk = $pw.value;
  const lenOfInput = input.length;

  if (lenOfInput != 0) {
    if (input == inputChk) {
      $errPw.classList.add('hidden');
      $errPwCheck.textContent = '비밀번호가 일치합니다';
      $errPwCheck.style = 'color : green';
    } else {
      $errPwCheck.classList.remove('hidden');
      $errPwCheck.textContent = '비밀번호가 일치하지 않습니다.';
      $errPwCheck.style = 'color : red';
    }
  }
  return;
});

//비밀번호 확인
$pwCheck.addEventListener('keydown', e => {
  const input = $pwCheck.value;
  const inputChk = $pw.value;
  const lenOfInput = input.length;

  if (e.key === ' ') {
    e.preventDefault();
  }

  if (e.key != 'Enter') {
    return;
  }

  if (e.key == 'Enter') {
    if (lenOfInput != 0 && input == inputChk) {
      $email.focus();
    }
  }
  return;
});

//이메일
$email.addEventListener('keydown', e => {
  const input = $email.value;
  const lenOfInput = input.length;
  const emailRegex = /^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]$/;

  if (e.key === ' ') {
    e.preventDefault();
  }

  if (e.key != 'Enter') {
    return;
  }
  if (e.key == 'Enter') {
    if (lenOfInput == 0) {
      $errEmail.classList.remove('hidden');
      $errEmail.textContent = '* 이메일를 입력해 주세요.';
      $email.focus();
      $email.value = '';
    } else if (
      !input.includes('@') ||
      !input.includes('.') ||
      lenOfInput < 5 ||
      emailRegex.test(input)
    ) {
      $errEmail.classList.remove('hidden');
      $errEmail.textContent = '* 이메일 양식에 맞게 입력해 주세요.';
      $email.focus();
    } else {
      $errEmail.classList.add('hidden');
      $email.value = input;
      $emailCheck.focus();
    }
    return;
  }
});

$email.addEventListener('blur', e => {
  const input = $email.value;
  const lenOfInput = input.length;
  const emailRegex = /^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]$/;

  if (lenOfInput == 0) {
    $errEmail.classList.remove('hidden');
    $errEmail.textContent = '* 이메일를 입력해 주세요.';
    $email.value = '';
  } else if (
    !input.includes('@') ||
    !input.includes('.') ||
    lenOfInput < 5 ||
    emailRegex.test(input)
  ) {
    $errEmail.classList.remove('hidden');
    $errEmail.textContent = '* 이메일 양식에 맞게 입력해 주세요.';
  } else {
    $errEmail.classList.add('hidden');
    $email.value = input;
  }
  return;
});

const $loginBtn = document.getElementById('loginBtn');
const $loginPopup = document.getElementById('loginPopup');
$loginBtn.addEventListener('click', e => {
  $loginPopup.showModal();
});

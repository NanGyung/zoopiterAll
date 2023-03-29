const $id = document.getElementById('id');
const $pw = document.getElementById('pw');
const $errId = document.querySelector('.err.id');
const $errPw = document.querySelector('.err.pw');

$id.addEventListener('keydown', e => {
    const input = $id.value.trim();
    const lenOfInput = input.length;

    if (e.key != 'Enter') {
        return;
    }
    if (e.key == 'Enter') {
        if (/[^A-Za-z0-9]/.test(input)) {
            $errId.classList.remove('hidden');
            $errId.textContent = '* 영문과 숫자만 입력 가능합니다.';
            $id.focus();
            return;
        }
        if (lenOfInput == 0) {
            $errId.classList.remove('hidden');
            $errId.textContent = '* 아이디를 입력해 주세요.';
            $id.focus();
            $id.value = '';
        } else if (lenOfInput > 15) {
            $errId.classList.remove('hidden');
            $errId.textContent = '* 아이디는 15글자 이하로 입력 가능합니다.';
            $id.focus();
        } else {
            $errId.classList.add('hidden');
            $id.value = input;
            $pw.focus();
        }
        return;
    }
});

$id.addEventListener('blur', e => {
    const input = document.getElementById('id').value.trim();
    const lenOfInput = input.length;
    const $login = document.getElementById('login');

    if (/[^A-Za-z0-9]/.test(input)) {
        $errId.classList.remove('hidden');
        $errId.textContent = '* 영문과 숫자만 입력 가능합니다.';
        return;
    }
    if (lenOfInput == 0) {
        $errId.classList.remove('hidden');
        $errId.textContent = '* 아이디를 입력해 주세요.';
        $id.value = '';
    } else if (lenOfInput > 15) {
        $errId.classList.remove('hidden');
        $errId.textContent = '* 아이디는 15글자 이하로 입력 가능합니다.';
    } else {
        $errId.classList.add('hidden');
        $id.value = input;
    }
});

$pw.addEventListener('keydown', e => {
    const input = document.getElementById('pw').value;
    //password는 값을 가져와서 바로 trim이 안됨
    const lenOfInput = input.trim().length;
    const $login = document.getElementById('login');

    if (e.key != 'Enter') {
        return;
    }

    if (e.key == 'Enter') {
        if (/[^A-Za-z0-9]/.test(input)) {
            $errPw.classList.remove('hidden');
            $errPw.textContent = '* 영문과 숫자만 입력 가능합니다.';
            $pw.focus();
            return;
        }
        if (lenOfInput == 0) {
            $errPw.classList.remove('hidden');
            $errPw.textContent = '* 비밀번호를 입력해 주세요.';
            $pw.focus();
            $pw.value = '';
        } else if (lenOfInput < 8 || lenOfInput > 15) {
            $errPw.classList.remove('hidden');
            $errPw.textContent =
                '* 영문자, 숫자조합으로 8글자 이상 15글자 이하 입력 가능합니다.';
            $pw.focus();
        } else {
            $errPw.classList.add('hidden');
            $login.focus();
        }
        return;
    }
});

$pw.addEventListener('blur', e => {
    const input = document.getElementById('pw').value;
    const lenOfInput = input.trim().length;
    const $login = document.getElementById('login');

    if (/[^A-Za-z0-9]/.test(input)) {
        $errPw.classList.remove('hidden');
        $errPw.textContent = '* 영문과 숫자만 입력 가능합니다.';
        return;
    }
    if (lenOfInput == 0) {
        $errPw.classList.remove('hidden');
        $errPw.textContent = '* 비밀번호를 입력해 주세요.';
        $pw.value = '';
    } else if (lenOfInput < 8 || lenOfInput > 15) {
        $errPw.classList.remove('hidden');
        $errPw.textContent =
            '* 영문자, 숫자조합으로 8글자 이상 15글자 이하 입력 가능합니다.';
    } else {
        $errPw.classList.add('hidden');
        $pw.value = input;
    }
});

const $findId = document.getElementById('findId');
const $checkId = document.getElementById('checkId');
const $loginGo = document.getElementById('loginGo');
const $checkPw = document.getElementById('checkPw');

const $findIdPopup = document.getElementById('findIdPopup');
const $findIdPopup2 = document.getElementById('findIdPopup2');

const $findPw = document.getElementById('findPw');
const $checkPassword = document.getElementById('checkPassword');
const $loginGo2 = document.getElementById('loginGo2');

const $findPwPopup = document.getElementById('findPwPopup');
const $findPwPopup2 = document.getElementById('findPwPopup2');

$findId.addEventListener('click', e => {
    $findIdPopup.showModal();
});

$checkId.addEventListener('click', e => {
    $findIdPopup.close();
    $findIdPopup2.showModal();
});

$loginGo.addEventListener('click', e => {
    $findIdPopup2.close();
});

$checkPw.addEventListener('click', e => {
    $findIdPopup2.close();
    $findPwPopup.showModal();
});

$findPw.addEventListener('click', e => {
    $findPwPopup.showModal();
});

$checkPassword.addEventListener('click', e => {
    $findPwPopup.close();
    $findPwPopup2.showModal();
});

$loginGo2.addEventListener('click', e => {
    $findPwPopup2.close();
});
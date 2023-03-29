// 지정한 태그의 컨텐츠를 다른 컨텐츠로 바꿈  fetch('html파일 이름') 
const fetchPage = (name, className) => {
    fetch(name).then(function (response) {
        response.text().then(function (text) {
            document.querySelector(className).innerHTML = text;
        })
    }
    );
};
// const mypage_banner = fetch('my-page_main-banner').then(function (response) {
//     response.text().then(function (text) {
//         const $banner = document.querySelector('.fg-banner');
//         $banner.innerHTML = text;
//     })
// }
// );
// const mypage_article = fetch('my-page_main-article').then(function (response) {
//     response.text().then(function (text) {
//         const $main = document.querySelector('.container');
//         $main.innerHTML = text;
//     })
// }
// );
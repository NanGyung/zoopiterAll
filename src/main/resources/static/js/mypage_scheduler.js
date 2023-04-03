$(document).ready(function () {
  calendarInit();
});
/*
    달력 렌더링 할 때 필요한 정보 목록 

    현재 월(초기값 : 현재 시간)
    금월 마지막일 날짜와 요일
    전월 마지막일 날짜와 요일
*/

function calendarInit() {
  // 날짜 정보 가져오기
  var date = new Date(); // 현재 날짜(로컬 기준) 가져오기
  var utc = date.getTime() + date.getTimezoneOffset() * 60 * 1000; // uct 표준시 도출
  var kstGap = 9 * 60 * 60 * 1000; // 한국 kst 기준시간 더하기
  var today = new Date(utc + kstGap); // 한국 시간으로 date 객체 만들기(오늘)

  //한국 현재 년,월,일 date객체
  var thisMonth = new Date(
    today.getFullYear(),
    today.getMonth(),
    today.getDate(),
  );
  // 달력에서 표기하는 날짜 객체

  var currentYear = thisMonth.getFullYear(); // 달력에서 표기하는 연
  var currentMonth = thisMonth.getMonth(); // 달력에서 표기하는 월
  var currentDate = thisMonth.getDate(); // 달력에서 표기하는 일

  // kst 기준 현재시간
  // console.log(thisMonth);

  // var currentMonthDate = new Map();


  // 캘린더 렌더링
  renderCalender(thisMonth);


  function renderCalender(thisMonth) {
    // 렌더링을 위한 데이터 정리
    currentYear = thisMonth.getFullYear();
    currentMonth = thisMonth.getMonth();
    currentDate = thisMonth.getDate();

    // 이전 달의 마지막 날 날짜와 요일 구하기
    var startDay = new Date(currentYear, currentMonth, 0);
    var prevDate = startDay.getDate();
    var prevDay = startDay.getDay();

    // 이번 달의 마지막날 날짜와 요일 구하기
    var endDay = new Date(currentYear, currentMonth + 1, 0);
    var nextDate = endDay.getDate();
    var nextDay = endDay.getDay();

    // console.log(prevDate, prevDay, nextDate, nextDay);

    // 현재 월 표기
    $('.year-month').text(currentYear + '.' + (currentMonth + 1));

    const dateArr = [];

    // 렌더링 html 요소 생성
    calendar = document.querySelector('.dates');
    calendar.innerHTML = '';

    // 지난달
    for (var i = prevDate - prevDay + 1; i <= prevDate; i++) {
      calendar.innerHTML =
        calendar.innerHTML + '<div class="day prev disable">' + i + '</div>';
    }
    // 이번달
    for (var i = 1; i <= nextDate; i++) {
      calendar.innerHTML =
        calendar.innerHTML + '<div class="day current">' + i + '</div>';
    }
    // 다음달
    for (var i = 1; i <= (7 - nextDay == 7 ? 0 : 7 - nextDay); i++) {
      calendar.innerHTML =
        calendar.innerHTML + '<div class="day next disable">' + i + '</div>';
    }

    // var days = document.querySelectorAll('.dates .day.current');
    // let daysArr = [];
    // for (const value of days.values()) {
    //   daysArr.push(value);
    //   // console.log(value);
    // }
    // 오늘 날짜 표기
    if (today.getMonth() == currentMonth) {
      todayDate = today.getDate();
      var currentMonthDate = document.querySelectorAll('.dates .day.current');
      dateArr.push(Object.values(currentMonthDate));
      dateArr[0][todayDate - 1].classList.add('today');
    }

    // console.log(Object.values(currentMonthDate));

    // 날짜 선택
    for (const ele of dateArr[0]) {
      ele.addEventListener('click', e => {
        const clickItem = e.target;
        const todayItem = document.querySelector('.current.today');
        console.log(clickItem);
        // console.log(e.target.innerHTML); //클릭한 날짜의 값

        //현재 날짜 표시하는 div의 class 값 제거
        todayItem.classList.remove('today');
        // 선택한 날짜 표시
        clickItem.classList.add('today');

        //선택한 날짜 누르면 의료수첩 작성하는 모달 창 띄우는 이벤트
        clickItem.addEventListener('click', e => {
          // 모달 창 띄우는 거

        },false);

      }, false);
    }
  }

  // console.log(currentMonth+1);

  // 이전달로 이동
  $('.go-prev').on('click', function () {
    thisMonth = new Date(currentYear, currentMonth - 1, 1);
    renderCalender(thisMonth);
  });

  // 다음달로 이동
  $('.go-next').on('click', function () {
    thisMonth = new Date(currentYear, currentMonth + 1, 1);
    renderCalender(thisMonth);
  });
}

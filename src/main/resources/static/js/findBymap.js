//  kakao api 카테고리 라이브러리 지도(병원코드 : HP8) 
// 마커를 클릭하면 장소명을 표출할 인포윈도우 입니다
var infowindow = new kakao.maps.InfoWindow({ zIndex: 1 });

var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
        level: 3 // 지도의 확대 레벨
    };

// 지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption);

// 장소 검색 객체를 생성합니다
var ps = new kakao.maps.services.Places(map);

// 카테고리로 병원을 검색합니다
ps.categorySearch('HP8', placesSearchCB, { useMapBounds: true });

// 키워드 검색 완료 시 호출되는 콜백함수 입니다
function placesSearchCB(data, status, pagination) {
    if (status === kakao.maps.services.Status.OK) {
        for (var i = 0; i < data.length; i++) {
            displayMarker(data[i]);
        }
    }
}

// 지도에 마커를 표시하는 함수입니다
function displayMarker(place) {
    // 마커를 생성하고 지도에 표시합니다
    var marker = new kakao.maps.Marker({
        map: map,
        position: new kakao.maps.LatLng(place.y, place.x)
    });

    // 마커에 클릭이벤트를 등록합니다
    kakao.maps.event.addListener(marker, 'click', function () {
        // 마커를 클릭하면 장소명이 인포윈도우에 표출됩니다
        infowindow.setContent('<div style="padding:5px;font-size:12px;">' + place.place_name + '</div>');
        infowindow.open(map, marker);
    });
}



// 현재위치 정보 지도표시
// 현재위치 설정 버튼
const $myPlaceBtn = document.getElementById('myPlace');
let myPosition = '';
const myPlace_h = e => {
    const geoLocation = navigator.geolocation;
    if (geoLocation) {
        geoLocation.getCurrentPosition((position) => {
            // 내위치 위도, 경도
            myPosition = new kakao.maps.LatLng(position.coords.latitude, position.coords.longitude);

            //내위치로 지도중심이동
            map.setCenter(myPosition);
            //지도의 줌레벨 조정
            map.setLevel(2, { animate: true });

            //  내위치 마커표시
            displayMarker(myPosition);

            // 카테고리로 병원을 검색합니다
            ps.categorySearch('HP8', placesSearchCB, { useMapBounds: true });

            // 키워드 검색 완료 시 호출되는 콜백함수 입니다
            function placesSearchCB(data, status, pagination) {
                if (status === kakao.maps.services.Status.OK) {
                    for (var i = 0; i < data.length; i++) {
                        displayMarker(data[i]);
                    }
                }
            }
            // const mypsMarker = new kakao.maps.Marker({
            //     map: map,
            //     position: new kakao.maps.LatLng(myPosition.La, myPosition.Ma)
            // });


        });
    } else {  // HTML5 GeoLocation 사용할 수 없을 때 마커 위치설정
        myPosition = new kakao.maps.LatLng(33.450701, 126.570667),
            message = '위치정보가 존재하지 않습니다 :(';
        displayMarker(myPosition, message);
        throw new Error('현 브라우저는 위치정보를 제공하지 않습니다!');
    }
};
$myPlaceBtn.addEventListener('click', myPlace_h, false);

//  지역 선택 버튼
const $regionChoiceBtn = document.getElementById('regionChoice');
//  지역선택창 닫힘버튼
const $regionCloseBtn = document.getElementById('regionCloseBtn');
// 지역선택 팝업창
const $regionSelect = document.getElementById('regionSelect');

// 지역선택창 팝업
const regionChoice_h = e => {
    $regionSelect.showModal();
};
$regionChoiceBtn.addEventListener('click', regionChoice_h, false);

// 지역선택창 닫힘
const regionClose_h = e => {
    $regionSelect.close();
};
$regionCloseBtn.addEventListener('click', regionClose_h, false);

//  주소 선택
$('document').ready(function () {
    // 지역데이터
    const area0 = ["시/도 선택", "부산광역시", "울산광역시"];
    const area1 = ["강서구", "금정구", "남구", "동구", "동래구", "부산진구", "북구", "사상구", "사하구", "서구", "수영구", "연제구", "영도구", "중구", "해운대구", "기장군"];
    const area2 = ["남구", "동구", "북구", "중구", "울주군"];

    // 시/도 선택 박스 초기화

    $("select[name^=sido]").each(function () {
        $selsido = $(this);
        $.each(eval(area0), function () {
            $selsido.append("<option value='" + this + "'>" + this + "</option>");
        });

        $selsido.next().append("<option value=''>구/군 선택</option>");
    });

    // 시/도 선택시 구/군 설정

    $("select[name^=sido]").change(function () {
        var area = "area" + $("option", $(this)).index($("option:selected", $(this))); // 선택지역의 구군 Array
        var $gugun = $(this).next(); // 선택영역 군구 객체
        $("option", $gugun).remove(); // 구군 초기화

        if (area == "area0")
            $gugun.append("<option value=''>구/군 선택</option>");
        else {
            $.each(eval(area), function () {
                $gugun.append("<option value='" + this + "'>" + this + "</option>");
            });
        }
    });

    //지역 선택 팝업창 
    const $regionSelect = document.getElementById('regionSelect');
    // 선택한 지역 확인 버튼
    const $regionBtn = document.getElementById
        ('regionBtn');

    // 시/도 선택 셀렉트박스
    const $sido = document.getElementById('sido');
    // 구/군 선택 셀렉트박스
    const $gugun = document.getElementById('gugun');

    //  시/도 추가 dom  객체
    const addEle = document.createElement('p');
    //  구/군 추가 dom  객체
    const addEle2 = document.createElement('p');
    // 선택한 지역 표시 영역
    const parentEle = document.getElementById('searchRes');


    // 지역선택 팝업 확인버튼 이벤트리스너
    const regionBtn_h = e => {
        // 지역선택 팝업 닫기
        $regionSelect.close();
        // 선택한 지역 표시영역에 시/도  표시할 p태그 추가
        parentEle.appendChild(addEle);
        // 선택한 지역 표시영역에 선택한 구/군 표시할 p태그 추가
        parentEle.appendChild(addEle2);
        // 추가한 시/도 객체에 아이디값 추가
        addEle.setAttribute('id', 'sidoRes');
        // 추가한 구/군 객체에 아이디값 추가
        addEle2.setAttribute('id', 'gugunRes');
        // 추가한 태그에 선택한 시/도 추가
        addEle.textContent = $sido.value;
        // 추가한 태그에 선택한 구/군 추가
        addEle2.textContent = $gugun.value;

        const $sidoRes = document.getElementById('sidoRes');
        const $gugunRes = document.getElementById('gugunRes');

        // 주소-좌표 변환 객체를 생성
        var geocoder = new kakao.maps.services.Geocoder();

        // 주소로 좌표 검색
        geocoder.addressSearch(`${$sidoRes.textContent}${$gugunRes.textContent}`, function (result, status) {

            // 정상적으로 검색이 완료됐으면 
            if (status === kakao.maps.services.Status.OK) {

                var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

                // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
                map.setCenter(coords);

                // 카테고리로 병원을 검색합니다
                ps.categorySearch('HP8', placesSearchCB, { useMapBounds: true });

                // 키워드 검색 완료 시 호출되는 콜백함수 입니다
                function placesSearchCB(data, status, pagination) {
                    if (status === kakao.maps.services.Status.OK) {
                        for (var i = 0; i < data.length; i++) {
                            displayMarker(data[i]);
                        }
                    }
                }

                // // 키워드로 장소를 검색합니다
                // ps.keywordSearch('동물병원', placesSearchCB);

                // // 키워드 검색 완료 시 호출되는 콜백함수 입니다
                // function placesSearchCB(data, status, pagination) {
                //     if (status === kakao.maps.services.Status.OK) {

                //         // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
                //         // LatLngBounds 객체에 좌표를 추가합니다
                //         var bounds = new kakao.maps.LatLngBounds();

                //         for (var i = 0; i < data.length; i++) {
                //             displayMarker(data[i]);
                //             bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
                //         }

                //         // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
                //         map.setBounds(bounds);
                //     }
                // }


                // // 결과값으로 받은 위치를 마커로 표시합니다
                // var marker = new kakao.maps.Marker({
                //     map: map,
                //     position: coords
                // });


            }
        });
    };

    // 지역선택 팝업 확인 버튼 클릭 이벤트 추가
    $regionBtn.addEventListener('click', regionBtn_h, false);

});





// 자세히 보기 버튼
const $infoBtn = document.getElementById('infoBtn');
// 상세정보 모달창
const $listDetails = document.querySelector('.list-details');
//  상세정보창 닫힘버튼
const $listDetails_closeBtn = document.getElementById('detailsCloseBtn');

// 자세히 보기 버튼 이벤트 핸들러
const infoBtn_h = e => {
    $listDetails.showModal();
};
//  자세히 보기 버튼 쿨락이벤트 리스너 등록
$infoBtn.addEventListener('click', infoBtn_h, false);

//  상세정보창 닫힘버튼 이벤트핸들러
const detailsCloseBtn_h = e => {
    $listDetails.close();
};
//  상세정보창 닫힘버튼 쿨락이벤트 리스너 등록
$listDetails_closeBtn.addEventListener('click', detailsCloseBtn_h, false);

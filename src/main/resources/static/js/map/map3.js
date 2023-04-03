
// 검색결과 목록 하단에 페이지번호를 표시하는 함수입니다
function displayPagination(pagination) {
    var paginationEl = document.getElementById('pagination'),
        fragment = document.createDocumentFragment(),
        i; 

    // 기존에 추가된 페이지번호를 삭제합니다
    while (paginationEl.hasChildNodes()) {
        paginationEl.removeChild (paginationEl.lastChild);
    }

    for (i=1; i<=pagination.last; i++) {
        var el = document.createElement('a');
        el.href = "#";
        el.innerHTML = i;

        if (i===pagination.current) {
            el.className = 'on';
        } else {
            el.onclick = (function(i) {
                return function() {
                    pagination.gotoPage(i);
                }
            })(i);
        }

        fragment.appendChild(el);
    }
    paginationEl.appendChild(fragment);
}

// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
// 인포윈도우에 장소명을 표시합니다
function displayInfowindow(marker, title) {
    var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';

    infowindow.setContent(content);
    infowindow.open(map, marker);
}

 // 검색결과 목록의 자식 Element를 제거하는 함수입니다
function removeAllChildNods(el) {   
    while (el.hasChildNodes()) {
        el.removeChild (el.lastChild);
    }
}

    // 현재 위치를 얻어내는 함수입니다
    function getCurrentLocation() {
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(function(position) {
                var lat = position.coords.latitude,
                    lon = position.coords.longitude;
                var locPosition = new kakao.maps.LatLng(lat, lon);
                map.setCenter(locPosition);
                searchPlaces();
                addRedMarker(locPosition); // 현재 위치에 빨간색 마커 추가
            }, function() {
                alert('Geolocation을 지원하지 않으므로, 기본 위치를 중심으로 검색합니다.');
                searchPlaces();
            });
        } else {
            alert('이 브라우저에서는 Geolocation이 지원되지 않습니다. 기본 위치를 중심으로 검색합니다.');
            searchPlaces();
        }
    }

    // 키워드로 장소를 검색합니다
    function searchPlaces() {
        var keyword = '동물병원';
        var center = map.getCenter();
        ps.keywordSearch(keyword, placesSearchCB, {
            location: center,
            radius: 5000 // 5km 반경 내에서 검색
        });
    }

    document.getElementById('myps').addEventListener('click', function() {
        getCurrentLocation();
    });
    

        // 빨간색 마커를 생성하고 지도 위에 표시하는 함수입니다
        function addRedMarker(position) {
        var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/red_b.png', // 마커 이미지 url
            imageSize = new kakao.maps.Size(64, 69), // 마커 이미지의 크기
            imageOption = {offset: new kakao.maps.Point(27, 69)},
            markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption),
            marker = new kakao.maps.Marker({
                position: position, // 마커의 위치
                image: markerImage
            });

        marker.setMap(map); // 지도 위에 마커를 표출합니다
    }

    function displaySearchResults(results) {
        // 병원 검색 결과를 div에 표시하는 함수
        const searchResults = ['find1', 'find2', 'find3', 'find4'];
        for (let i = 0; i < results.length && i < searchResults.length; i++) {
          const resultDiv = document.querySelector(`.${searchResults[i]}`);
          resultDiv.innerHTML = results[i].name; // 이 부분에서 병원 정보를 넣어줍니다. 필요한 정보에 따라 수정할 수 있습니다.
        }
      }

      function searchHospitals() {
        // 병원 검색 함수
        fetch("API URL")
          .then(response => response.json())
          .then(data => {
            // 병원 검색이 완료된 후에 결과를 div에 표시하는 함수 호출
            displaySearchResults(data.hospitals);
          })
          .catch(error => {
            console.error("Error fetching hospitals:", error);
          });
      }



// 병원 정보 모달 실험
document.getElementById("modal_opne_btn").onclick = function() {
    document.getElementById("modal").style.display="block";
}

document.getElementById("modal_close_btn").onclick = function() {
    document.getElementById("modal").style.display="none";
}   

$("#modal_opne_btn").click(function(){
    $("#modal").attr("style", "display:block");
});

 $("#modal_close_btn").click(function(){
    $("#modal").attr("style", "display:none");
});      


    // 지도를 생성하고 현재 위치를 얻어옵니다
    getCurrentLocation();
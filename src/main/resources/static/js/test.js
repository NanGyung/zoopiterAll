
     //지도생성옵션
     const defaultPosition = new naver.maps.LatLng(35.540423232278556,129.35398818341366)
     const mapOptions = {
       center: defaultPosition,
       zoom : 16
     };

    //지도생성
    const map = new naver.maps.Map(
        document.getElementById('map'),
        mapOptions);

    //마커 생성하는 함수
    //매개변수(좌표,툴팁), 반환값:마커객체  
    function makeMarker(position,toolTip){  
        //마커 컨텐트
        const markerContent = `<div id="default_position_marker"></div>`;
        
        //마커생성옵션  
        const defaultPositionMarkerOption =  {
                map:map,
                position: position,
                title: toolTip,   //툴팁
                icon: {
                  content : markerContent
                }
        }
        //마커생성
        const defaultPositionMarker = new naver.maps.Marker(defaultPositionMarkerOption);  
  
        return defaultPositionMarker;
      }
  
      //정보창 컨텐트
    //업체명,연락처,홈페이지
    const makeContentsOfInfoWindow = (company,contact,homepage)=>{
        const $html = `<div class="info_window_wrap">
                        <div class="info_window_wrap__company_name">${company}</div>
                        <div class="info_widow_wrap__contact">${contact}</div>
                        <div class="info_widow_wrap__homepage"><a href='${homepage}' target='_blank'>${homepage}</a></div>
                      </div>`;
        return $html;
      }
      const defaultPositionMarkerInfoWindowOption = {
        content : makeContentsOfInfoWindow('태화강역','010-1111-1111','http://www.naver.com'),
        anchorSize : new naver.maps.Size(10,10)
      }
      //정보창 생성
      const defaultPositionMarkerInfoWindow = new naver.maps.InfoWindow(defaultPositionMarkerInfoWindowOption);
  
      //마커에 이벤트 핸들러 등록하기
      const defaultPositionMarker = makeMarker(defaultPosition,'태화강역');

      naver.maps.Event.addListener(defaultPositionMarker,'click',(e)=>{
        //지도상에 마커의 정보창이 있으면 정보창을 닫고 없으면 정보창 띄우기
        if(defaultPositionMarkerInfoWindow.getMap()){
          defaultPositionMarkerInfoWindow.close();
        }else{
          defaultPositionMarkerInfoWindow.open(map,defaultPositionMarker);
        }
      });
  
      //내위치정보 받아오기
      const myps = document.getElementById('myPlace');
      let myPosition = '';
      myps.addEventListener('click', e =>{
        const geolocation = globalThis.navigator.geolocation;
        if(geolocation){
          geolocation.getCurrentPosition((position)=>{
            //내위치의 위도,경도
            myPosition = new naver.maps.LatLng(position.coords.latitude,position.coords.longitude);  
            //내위치 마커표시
            const marker = makeMarker(myPosition,'내위치');
            marker.setIcon({
              content : `<div class='whereIam'></div>`
            })
            //내위치로 지도중심이동
            map.setCenter(myPosition);
            //지도의 줌레벨 조정
            map.setZoom(20);
          });
        }else{
          throw new Error('현 브라우저는 위치정보를 제공하지 않습니다');
        }
      });

    // 주소검색 창 팝업
    const regionChoice = document.getElementById("regionChoice");

    regionChoice.addEventListener('click',()=>{
        document.getElementsByClassName("region-choice")[0].style.display = "flex";
    })
    
    const close = document.getElementById("close");
    close.addEventListener('click',()=>{
        document.getElementsByClassName("region-choice")[0].style.display = "none";
    });

    // 지역 데이터
    $('document').ready(function() {
        var area0 = ["시/도 선택","서울특별시","인천광역시","대전광역시","광주광역시","대구광역시","울산광역시","부산광역시","경기도","강원도","충청북도","충청남도","전라북도","전라남도","경상북도","경상남도","제주도"];
         var area1 = ["강남구","강동구","강북구","강서구","관악구","광진구","구로구","금천구","노원구","도봉구","동대문구","동작구","마포구","서대문구","서초구","성동구","성북구","송파구","양천구","영등포구","용산구","은평구","종로구","중구","중랑구"];
          var area2 = ["계양구","남구","남동구","동구","부평구","서구","연수구","중구","강화군","옹진군"];
          var area3 = ["대덕구","동구","서구","유성구","중구"];
          var area4 = ["광산구","남구","동구",     "북구","서구"];
          var area5 = ["남구","달서구","동구","북구","서구","수성구","중구","달성군"];
          var area6 = ["남구","동구","북구","중구","울주군"];
          var area7 = ["강서구","금정구","남구","동구","동래구","부산진구","북구","사상구","사하구","서구","수영구","연제구","영도구","중구","해운대구","기장군"];
          var area8 = ["고양시","과천시","광명시","광주시","구리시","군포시","김포시","남양주시","동두천시","부천시","성남시","수원시","시흥시","안산시","안성시","안양시","양주시","오산시","용인시","의왕시","의정부시","이천시","파주시","평택시","포천시","하남시","화성시","가평군","양평군","여주군","연천군"];
          var area9 = ["강릉시","동해시","삼척시","속초시","원주시","춘천시","태백시","고성군","양구군","양양군","영월군","인제군","정선군","철원군","평창군","홍천군","화천군","횡성군"];
          var area10 = ["제천시","청주시","충주시","괴산군","단양군","보은군","영동군","옥천군","음성군","증평군","진천군","청원군"];
          var area11 = ["계룡시","공주시","논산시","보령시","서산시","아산시","천안시","금산군","당진군","부여군","서천군","연기군","예산군","청양군","태안군","홍성군"];
          var area12 = ["군산시","김제시","남원시","익산시","전주시","정읍시","고창군","무주군","부안군","순창군","완주군","임실군","장수군","진안군"];
          var area13 = ["광양시","나주시","목포시","순천시","여수시","강진군","고흥군","곡성군","구례군","담양군","무안군","보성군","신안군","영광군","영암군","완도군","장성군","장흥군","진도군","함평군","해남군","화순군"];
          var area14 = ["경산시","경주시","구미시","김천시","문경시","상주시","안동시","영주시","영천시","포항시","고령군","군위군","봉화군","성주군","영덕군","영양군","예천군","울릉군","울진군","의성군","청도군","청송군","칠곡군"];
          var area15 = ["거제시","김해시","마산시","밀양시","사천시","양산시","진주시","진해시","창원시","통영시","거창군","고성군","남해군","산청군","의령군","창녕군","하동군","함안군","함양군","합천군"];
          var area16 = ["서귀포시","제주시","남제주군","북제주군"];
       
        
       
        // 시/도 선택 박스 초기화
       
        $("select[name^=sido]").each(function() {
         $selsido = $(this);
         $.each(eval(area0), function() {
          $selsido.append("<option value='"+this+"'>"+this+"</option>");
         });
         $selsido.next().append("<option value=''>구/군 선택</option>");
        });
       
        
       
        // 시/도 선택시 구/군 설정
       
        $("select[name^=sido]").change(function() {
         var area = "area"+$("option",$(this)).index($("option:selected",$(this))); // 선택지역의 구군 Array
         var $gugun = $(this).next(); // 선택영역 군구 객체
         $("option",$gugun).remove(); // 구군 초기화
       
         if(area == "area0")
          $gugun.append("<option value=''>구/군 선택</option>");
         else {
          $.each(eval(area), function() {
           $gugun.append("<option value='"+this+"'>"+this+"</option>");
          });
         }
        });

       });
   
     
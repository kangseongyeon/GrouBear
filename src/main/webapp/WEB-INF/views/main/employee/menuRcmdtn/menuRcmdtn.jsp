<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

<!-- sweetalert2 -->
<script type="text/javascript" src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<!-- google font -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap" rel="stylesheet">

<!-- axios -->
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

<style>
/* 카카오 Map 시작 */
.map_wrap, .map_wrap * {margin:0;padding:0;font-family:'Malgun Gothic',dotum,'돋움',sans-serif;font-size:12px;}
.map_wrap a, .map_wrap a:hover, .map_wrap a:active{color:#000;text-decoration: none;}
.map_wrap {position:relative;width:100%;height:500px;}
#menu_wrap {position:absolute;top:0;left:0;bottom:0;width:250px;margin:10px 0 30px 10px;padding:5px;overflow-y:auto;background:rgba(255, 255, 255, 0.7);z-index: 1;font-size:12px;border-radius: 10px;}
.bg_white {background:#fff;}
#menu_wrap hr {display: block; height: 1px;border: 0; border-top: 2px solid #5F5F5F;margin:3px 0;}
#menu_wrap .option{text-align: center;}
#menu_wrap .option p {margin:10px 0;}  
#menu_wrap .option button {margin-left:5px;}
#placesList li {list-style: none;}
#placesList .item {position:relative;border-bottom:1px solid #888;overflow: hidden;cursor: pointer;min-height: 65px;}
#placesList .item span {display: block;margin-top:4px;}
#placesList .item h5, #placesList .item .info {text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
#placesList .item .info{padding:10px 0 10px 55px;}
#placesList .info .gray {color:#8a8a8a;}
#placesList .info .jibun {padding-left:26px;background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_jibun.png) no-repeat;}
#placesList .info .tel {color:#009900;}
#placesList .item .markerbg {float:left;position:absolute;width:36px; height:37px;margin:10px 0 0 10px;background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png) no-repeat;}
#placesList .item .marker_1 {background-position: 0 -10px;}
#placesList .item .marker_2 {background-position: 0 -56px;}
#placesList .item .marker_3 {background-position: 0 -102px}
#placesList .item .marker_4 {background-position: 0 -148px;}
#placesList .item .marker_5 {background-position: 0 -194px;}
#placesList .item .marker_6 {background-position: 0 -240px;}
#placesList .item .marker_7 {background-position: 0 -286px;}
#placesList .item .marker_8 {background-position: 0 -332px;}
#placesList .item .marker_9 {background-position: 0 -378px;}
#placesList .item .marker_10 {background-position: 0 -423px;}
#placesList .item .marker_11 {background-position: 0 -470px;}
#placesList .item .marker_12 {background-position: 0 -516px;}
#placesList .item .marker_13 {background-position: 0 -562px;}
#placesList .item .marker_14 {background-position: 0 -608px;}
#placesList .item .marker_15 {background-position: 0 -654px;} 
#pagination {margin:10px auto;text-align: center;}
#pagination a {display:inline-block;margin-right:10px;}
#pagination .on {font-weight: bold; cursor: default;color:#777;}

.customoverlay {position:relative;bottom:85px;border-radius:6px;border: 1px solid #ccc;border-bottom:2px solid #ddd;float:left;}
.customoverlay:nth-of-type(n) {border:0; box-shadow:0px 1px 2px #888;}
.customoverlay a {display:block;text-decoration:none;color:#000;text-align:center;border-radius:6px;font-size:14px;font-weight:bold;overflow:hidden;background: #d95050;background: #d95050 url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/arrow_white.png) no-repeat right 14px center;}
.customoverlay .title {display:block;text-align:center;background:#fff;margin-right:35px;padding:10px 15px;font-size:14px;font-weight:bold;}
.customoverlay:after {content:'';position:absolute;margin-left:-12px;left:50%;bottom:-12px;width:22px;height:12px;background:url('https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/vertex_white.png')}
/* 카카오 Map 끝 */

.weatherDiv {
	border: 3px solid cornflowerblue;
    height: 400px;
    width: 440px;
    border-radius: 50px;
    box-shadow: 10px;
    box-shadow: 0px 0px 20px 0px #3b73d857;
}

.button {
	width: 400px;
    height: 130px;
}

.fontDoHyeun {
	font-family: "Do Hyeon", sans-serif;
	font-weight: 400;
	font-style: normal;
}

.windy {
	position: relative;
    transform: translate(-50%, -50%);
    top: 27px;
    left: -20px;
}

.foodEffect {
	z-index: 1;
	border-radius: 50px;
	box-shadow: 0px 0px 20px 0px #3968bc69;
    animation-name: foodEffect;
    animation-duration: 2s;
    animation-fill-mode: forwards; /* 애니메이션 완료 후 최종 상태 유지 */
    animation-timing-function: ease-in-out; /* 이징 효과 추가 */
}

@keyframes foodEffect {
    0% {
       transform: scale(0.05) rotate(0deg); /* 작게 시작하고 회전 없음 */
    }
    100% {
       transform: scale(0.85) rotate(1440deg); /* 원래 크기로 확대하면서 360도 회전 */
    }
}

.foodName {
	opacity: 0; /* 초기 상태: 투명 */
	width: 95%;
	margin-top: 90px;
    position: absolute;
    z-index: 2;
    animation-delay: 1s; /* 1초 후에 애니메이션 시작 */
    animation-name: foodName;
    animation-duration: 2s;
    animation-fill-mode: forwards; /* 애니메이션 완료 후 최종 상태 유지 */
    animation-timing-function: ease-in-out; /* 이징 효과 추가 */
}

@keyframes foodName {
    0% {
        transform: scale(0.1) rotate(0deg); /* 작게 시작하고 회전 없음 */
        opacity: 1;
    }
    50% {
        transform: scale(1.5) rotate(0deg); /* 원래 크기로 확대 */ 
        opacity: 1;
    }
    100% {
        transform: scale(0.9) rotate(0deg); /* 원래 크기로 확대 */
        opacity: 1;
    }
}

.party {
    position: absolute; /* 부모 요소에 상대적으로 위치 설정 */
    z-index: 0; /* 가장 뒤에 위치 */
    opacity: 0; /* 초기 상태: 투명 */
    animation: fadeIn 0.5s forwards; /* 애니메이션 이름과 지속 시간 설정 */
    animation-delay: 2s; /* 2초 후에 애니메이션 시작 */
    top: 57%; /* Y축 가운데 정렬 */
    left: 50%; /* X축 가운데 정렬 */
    transform: translate(-50%, -50%); /* 중앙 정렬을 위해 변환 */
    width: 800px;
    height: 794px; 
}

@keyframes fadeIn {
    to {
        opacity: 1; /* 애니메이션이 끝날 때: 불투명 */
    }
}

.fontShadow {
    margin-left: -30px;
    width: 40px;
    height: 5px;
    background-color: gray;
    border-radius: 50%;
    opacity: 60%;
    position: absolute;
    margin-top: 25%;
}
</style>

<c:set value="${companyVO }" var="companyVO"/>

<div style="margin-bottom: 30px;">
	<div style="margin-top: -32px;">
		<div class="separator border-2 my-10"></div>
	</div>
	<div style="margin-left: 30px; margin-top: -100px;">
		<h3>메뉴추천</h3>
		<h6>메뉴추천</h6>
	</div>
</div>

<div id="kt_app_content_container" class="app-container container-fluid"> 
	<div class="card card-flush" style="min-height: 65em;"> 
    	
    	<div class="ms-20 ps-10  my-10 mt-20">
    		<span>
	    		<i class="ki-duotone ki-geolocation fs-2tx" style="color: #0074ff"> 
				 <span class="path1"></span>
				 <span class="path2"></span> 
				</i>
    		</span>
    		<span class="fontDoHyeun fs-2tx ms-5">${companyVO.coNm } / ${companyVO.coAddr }</span>
    	</div>
    	
    	<div id="weather" class="row ms-20 me-10 d-flex justify-content-center">
    		
		</div>
		
		<div class="d-flex justify-content-center">
			<button type="button" class="btn btn-light-info button fontDoHyeun fs-3hx mx-10 mt-10 mb-20" data-bs-stacked-modal="#kt_modal_stacked_2" onclick="f_randomRcmdtn()">랜덤메뉴 추천</button>
			<button type="button" class="btn btn-light-danger button fontDoHyeun fs-3hx mx-10 mt-10 mb-20" onclick="f_weatherRcmdtn()">날씨메뉴 추천</button>
		</div>
		
	</div>
	
	<div class="d-flex justify-content-center" style="margin-top: 50px; margin-bottom: 50px; transform: rotate(90deg);">
		<i class="ki-duotone ki-soft-2 fs-6hx" style="color: #6ccf52">
			 <span class="path1"></span> 
			 <span class="path2"></span>
		</i>
	</div>
	
	<div class="card card-flush" style="margin-bottom: 40px; min-height: 55em;">
		<div class="modal-body text-center" style="min-height: 850px;">
			<div class="row"> 
				<div class="col-3 ms-10 mt-20">
	    	        <div class="badge text-bg-light-primary fontDoHyeun fs-3tx ms-3 my-15">오늘의 추천메뉴</div>
	    	        
	    	        <div style="border: 2px solid cornflowerblue; border-radius: 30px; min-height: 510px;">
		    	        <div id="mapFoodName" class="fontDoHyeun fs-4tx mt-15 mb-10"></div>
						<img id="mapFoodImg" src="" class="mw-300px mb-10"> 
	    	        </div>
				</div>
				 
					<div class="card card-flush mt-5 ms-5" style="width: 1100px; height: 800px;">
						<div class="card-header border-0 pt-7"> 
							<h1>추천 메뉴 식당 찾기</h1>
						</div>
						<div class="separator separator-dashed my-0"></div>
						<div class="map_wrap">
						    <div id="kakaoMap" style="width:100%;height:143%;position:relative;overflow:hidden;"></div>
						
						    <div id="menu_wrap" class="bg_white" style="height: 700px; width: 280px;">
						        <div class="option">
						            <div>
						                <form onsubmit="searchPlaces(); return false;" style="display: flex;">
						                   	<input type="text" id="keyword" value="맛집" class="form-control fs-3 ps-3 text-gray-900" style="width: 70%"> 
						                    <button type="submit" id="kakaoSearchBtn" class="btn btn-primary p-3 fs-4" style="width: 30%">검색</button> 
						                </form>  
						            </div>
						        </div>
						        <hr>
						        <ul id="placesList"></ul> 
						        <div id="pagination"></div>
						    </div>
						</div>
					</div>
			</div>
        </div> 
	</div>
	
</div>



<!-- 카카오 Map 시작 -->

<!-- 카카오 Map API -->
<!-- 카카오 Map services, clusterer, drawing 라이브러리 불러오기 -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=4ec7163f5523fef7017bbaeb8274b3a9&libraries=services,clusterer,drawing"></script>

<script>
let lonPoint = ${companyVO.lot};  // 경도 127.4088838
let latPoint = ${companyVO.lat};  // 위도 36.3250154

// 마커를 담을 배열입니다
var markers = [];

var mapContainer = document.getElementById('kakaoMap'), // 지도를 표시할 div 
    mapOption = {
        center: new kakao.maps.LatLng(latPoint, lonPoint), // 지도의 중심좌표
        level: 3	// 지도의 확대 레벨
    };

// 지도를 생성합니다    
var map = new kakao.maps.Map(mapContainer, mapOption);
 
// 장소 검색 객체를 생성합니다
var ps = new kakao.maps.services.Places();

// 검색 결과 목록이나 마커를 클릭했을 때 장소명을 표출할 인포윈도우를 생성합니다
var infowindow = new kakao.maps.InfoWindow({ zIndex: 1 });


// 키워드로 장소를 검색합니다
searchPlaces();


// 키워드 검색을 요청하는 함수입니다
function searchPlaces() {

    var keyword = document.getElementById('keyword').value;
    var radius = 2000; // 반경 2km (2000m)  
    
    // 중심 좌표를 kakao.maps.LatLng 형식으로 생성
    var center = new kakao.maps.LatLng(latPoint, lonPoint);
 
    if (!keyword.replace(/^\s+|\s+$/g, '')) {
        alert('키워드를 입력해주세요!');
        return false; 
    } 

    // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
/*     ps.keywordSearch(keyword, placesSearchCB); */
	
    // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
    ps.keywordSearch(keyword, placesSearchCB, {
        location: center, // 검색할 중심 좌표
        radius: radius, // 검색 반경 (미터 단위)
        level: 3	// 지도의 확대 레벨
    });
 
}

// 장소검색이 완료됐을 때 호출되는 콜백함수 입니다
function placesSearchCB(data, status, pagination) {
    if (status === kakao.maps.services.Status.OK) {

        // 정상적으로 검색이 완료됐으면
        // 검색 목록과 마커를 표출합니다
        displayPlaces(data);
        
        // 페이지 번호를 표출합니다
        displayPagination(pagination);

    } else if (status === kakao.maps.services.Status.ZERO_RESULT) {

        alert('검색 결과가 존재하지 않습니다.');
        return;

    } else if (status === kakao.maps.services.Status.ERROR) {

        alert('검색 결과 중 오류가 발생했습니다.');
        return;

    }
}


// 검색 결과 목록과 마커를 표출하는 함수입니다
function displayPlaces(places) {
    var listEl = document.getElementById('placesList'),
        menuEl = document.getElementById('menu_wrap'),
        fragment = document.createDocumentFragment(),
        bounds = new kakao.maps.LatLngBounds(),
        listStr = '';

    // 검색 결과 목록에 추가된 항목들을 제거합니다
    removeAllChildNods(listEl);

    // 지도에 표시되고 있는 마커를 제거합니다
    removeMarker();

    for (var i = 0; i < places.length; i++) {

        // 마커를 생성하고 지도에 표시합니다
        var placePosition = new kakao.maps.LatLng(places[i].y, places[i].x),
            marker = addMarker(placePosition, i),
            itemEl = getListItem(i, places[i]); // 검색 결과 항목 Element를 생성합니다

        // marker 객체에 itemId를 저장합니다
        marker.itemId = places[i].id; // itemId를 marker 객체에 저장
            
        // 검색된 장소 위치를 기준으로 지도 범위를 재설정하기위해
        // LatLngBounds 객체에 좌표를 추가합니다
        bounds.extend(placePosition);

        // 마커와 검색결과 항목에 mouseover 했을때
        // 해당 장소에 인포윈도우에 장소명을 표시합니다
        // mouseout 했을 때는 인포윈도우를 닫습니다
        (function (marker, title) {
            kakao.maps.event.addListener(marker, 'mouseover', function () {
                displayInfowindow(marker, title);
            });

            kakao.maps.event.addListener(marker, 'mouseout', function () {
                infowindow.close();
            });

            // 마커를 클릭하면 카카오맵 검색 상세 페이지로 이동하기
            kakao.maps.event.addListener(marker, 'click', function () {
            	window.open("https://map.kakao.com?itemId=" + marker.itemId, '_blank');
            });

            // itemEl(목록) 클릭하면 카카오맵 검색 상세 페이지로 이동하기
            itemEl.onclick = function () {
                window.open("https://map.kakao.com?itemId=" + marker.itemId, '_blank'); // 목록 항목 클릭 시 이동
            };
            
            itemEl.onmouseover = function () {
                displayInfowindow(marker, title); 
            };

            itemEl.onmouseout = function () {
                infowindow.close();
            };
        })(marker, places[i].place_name);

        fragment.appendChild(itemEl);
    }

    // 검색결과 항목들을 검색결과 목록 Elemnet에 추가합니다
    listEl.appendChild(fragment);
    menuEl.scrollTop = 0;

    // 검색된 장소 위치를 기준으로 지도 범위를 재설정합니다
    map.setBounds(bounds);
}



// 커스텀 오버레이 마커 만들기
var map = new kakao.maps.Map(mapContainer, mapOption);

var imageSrc = '${pageContext.request.contextPath }/resources/file/image/marker.png', // 마커이미지의 주소입니다    
    imageSize = new kakao.maps.Size(50, 70), // 마커이미지의 크기입니다
    imageOption = {offset: new kakao.maps.Point(27, 69)}; // 마커이미지의 옵션입니다. 마커의 좌표와 일치시킬 이미지 안에서의 좌표를 설정합니다.

// 마커의 이미지정보를 가지고 있는 마커이미지를 생성합니다
var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imageOption),
    markerPosition = new kakao.maps.LatLng(latPoint, lonPoint); // 마커가 표시될 위치입니다

// 마커를 생성합니다
var marker = new kakao.maps.Marker({ 
  position: markerPosition,
  image: markerImage // 마커이미지 설정  
});

// 마커가 지도 위에 표시되도록 설정합니다
marker.setMap(map);  

//커스텀 오버레이에 표출될 내용으로 HTML 문자열이나 document element가 가능합니다
var content = '<div class="customoverlay">' +
    '  <a href="https://map.kakao.com/link/map/7817305" target="_blank">' +
    '    <span class="title">${companyVO.coNm }</span>' +
    '  </a>' +
    '</div>';

// 커스텀 오버레이가 표시될 위치입니다 
var position = new kakao.maps.LatLng(latPoint, lonPoint);   

// 커스텀 오버레이를 생성합니다
var customOverlay = new kakao.maps.CustomOverlay({
    map: map,
    position: position,
    content: content,
    yAnchor: 1 
});




var geocoder = new kakao.maps.services.Geocoder();
function searchDetailAddrFromCoords(coords, callback) {              
    // 좌표로 법정동 상세 주소 정보를 요청합니다
    geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
}            

// 검색결과 항목을 Element로 반환하는 함수입니다
function getListItem(index, places) {

    var el = document.createElement('li'),
        itemStr = '<span class="mt-13 ms-3 markerbg marker_' + (index + 1) + '"></span>' + 
            '<div class="info ps-10">' +
            '   <h5 class="fs-3">' + places.place_name + '</h5>';
 
    if (places.road_address_name) {
        itemStr += '    <span class="fs-3 ms-6"">' + places.road_address_name + '</span>' +
            '   <span class="jibun gray fs-3">' + places.address_name + '</span>';
    } else {
        itemStr += '    <span>' + places.address_name + '</span>';
    }
 
    itemStr += '  <span class="tel fs-3">' + places.phone + '</span>' +
        '</div>';

    el.innerHTML = itemStr;
    el.className = 'item';

    return el;
}

// 마커를 생성하고 지도 위에 마커를 표시하는 함수입니다
function addMarker(position, idx, title) {
    var imageSrc = 'https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png', // 마커 이미지 url, 스프라이트 이미지를 씁니다
        imageSize = new kakao.maps.Size(36, 37),  // 마커 이미지의 크기
        imgOptions = {
            spriteSize: new kakao.maps.Size(36, 691), // 스프라이트 이미지의 크기
            spriteOrigin: new kakao.maps.Point(0, (idx * 46) + 10), // 스프라이트 이미지 중 사용할 영역의 좌상단 좌표
            offset: new kakao.maps.Point(13, 37) // 마커 좌표에 일치시킬 이미지 내에서의 좌표
        },
        markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize, imgOptions),
        marker = new kakao.maps.Marker({
            position: position, // 마커의 위치
            image: markerImage
        });

    marker.setMap(map); // 지도 위에 마커를 표출합니다
    markers.push(marker);  // 배열에 생성된 마커를 추가합니다

    return marker;
}

// 지도 위에 표시되고 있는 마커를 모두 제거합니다
function removeMarker() {
    for (var i = 0; i < markers.length; i++) {
        markers[i].setMap(null);
    }
    markers = [];
}

// 검색결과 목록 하단에 페이지번호를 표시는 함수입니다
function displayPagination(pagination) {
    var paginationEl = document.getElementById('pagination'),
        fragment = document.createDocumentFragment(),
        i;

    // 기존에 추가된 페이지번호를 삭제합니다
    while (paginationEl.hasChildNodes()) {
        paginationEl.removeChild(paginationEl.lastChild);
    }

    for (i = 1; i <= pagination.last; i++) {
        var el = document.createElement('a');
        el.href = "#";
        el.innerHTML = i;

        if (i === pagination.current) {
            el.className = 'on';
        } else {
            el.onclick = (function (i) {
                return function () {
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
    var content = '<div class="displayInfowindow" style="padding:5px;z-index:1;">' + title + '</div>';

    infowindow.setContent(content);
    infowindow.open(map, marker);
}

// 검색결과 목록의 자식 Element를 제거하는 함수입니다
function removeAllChildNods(el) {
    while (el.hasChildNodes()) {
        el.removeChild(el.lastChild);
    }
}
</script>
<!-- 카카오 Map 끝 -->


<!-- 모달 시작 -->
<div class="modal fade" tabindex="-1" id="menuRcmdtn" style="background-color: #000000ab">
	<div class="modal-dialog modal-dialog-centered modal-lg">
	    <div class="modal-content" style="min-height: 800px;">
	        <div class="modal-header">
	            <h3 id="menuTitle" class="modal-title fs-3qx w-100 text-center fontDoHyeun"></h3>
				<img src="${pageContext.request.contextPath }/resources/file/image/food/party.gif" class="party"> 
	            <div class="btn btn-icon btn-sm btn-active-light-primary ms-2" data-bs-dismiss="modal" aria-label="Close">
	                <i class="ki-duotone ki-cross fs-3qx"><span class="path1"></span><span class="path2"></span></i>
	            </div>
	        </div>
	        <div class="modal-body text-center">
	            <div class="fontDoHyeun fs-5tx foodName"></div>
				<img src="" class="mw-750px foodEffect"> 
	        </div>
	    </div>
	</div>
</div>
<!-- 모달 끝 -->
	        

<script>
/* let lonPoint = ${companyVO.lot};  // 경도
let latPoint = ${companyVO.lat};  // 위도 */
let xPoint = "";    // 격자 x 포인트
let yPoint = "";    // 격자 y 포인트 

/** 위도, 경도를 x,y 격자 포인트로 변경 */
var RE = 6371.00877; // 지구 반경(km)
var GRID = 5.0; // 격자 간격(km)
var SLAT1 = 30.0; // 투영 위도1(degree)
var SLAT2 = 60.0; // 투영 위도2(degree)
var OLON = 126.0; // 기준점 경도(degree)
var OLAT = 38.0; // 기준점 위도(degree)
var XO = 43; // 기준점 X좌표(GRID)
var YO = 136; // 기1준점 Y좌표(GRID)


let weather = document.querySelector("#weather");	// 날씨 위젯을 넣을 위치
let todayWeatherState = "";		// 오늘의 날씨 상태 (메뉴추천을 위한 날씨 키워드 세팅)

let allFoodList = [];	// 모든 메뉴 목록
let weatherRcmdtnFoodList = [];	// 날씨 추천 메뉴

let foodNmKor = "";	// 추천받은 메뉴의 이름
let foodNmEng = "";	// 추천받은 메뉴의 영어 이름

const modal = new bootstrap.Modal(menuRcmdtn);

$(function() {

	// 모든 메뉴 목록 가져오기
	axios.get("/employee/foodSelectList.do")
	.then(function(res) {

		if (res.status == 200) {
			let data = res.data;
			
			allFoodList = data;
/* 			console.log("allFoodList");
			console.log(allFoodList); */
		}
	}).catch(function(error) {  
		console.log(error);
		Swal.fire({
			icon: 'warning',
			title: '서버 접속에 실패했습니다.',
			text:  '다시 시도해주세요.',
			confirmButtonColor: '#4FC9DA',
		});
	});

	
	/* 
	# getVilageFcst (단기예보)
	최대치(1000)로 요청 시 11개의 속성이 시간단위로 3일~4일간의 정보가 전달되기 때문에 600 ~ 900 개의 row 값을 갖는다.
	
	- TMP : 1시간 기온
	- UUU: 풍속(동서성분) m/s
	- VVV: 풍속(남북성분) m/s
	- VEC: 풍향 deg
	- WSD: 풍속 m/s
	- SKY: 맑음(1), 구름많음(3), 흐림(4)
	- PTY: 강수형태 - (단기) 없음(0), 비(1), 비/눈(2), 눈(3), 소나기(4)
	- POP: 강수확률 %
	- WAV: 파고 M
	- PCP: 1시간 강수량 (mm)
	- REH: 습도 %
	- SNO: 적설량 (cm)
	*/
	
	
	//오늘 날짜 구하기
	let currentDate = new Date();
	
	let year = currentDate.getFullYear();
	let month = ('0' + (currentDate.getMonth() + 1)).slice(-2);
	let day = ('0' + currentDate.getDate()).slice(-2);
	
	let formattedDate = year + month + day;
	
	// 결과 출력
	
	// 단기예보 기준시간
	let baseTimes = ['0200', '0500', '0800', '1100', '1400', '1700', '2000', '2300'];
	 
	// 현재 시간 기준으로 단기예보 기준시간 중, 예보가 공개된 가장 가까운 시간 구하기
	let formattedTime = null;
	let hours = ('0' + currentDate.getHours()).slice(-2) + "00"; 
	/* console.log("hours : ", hours); */
	 
	for (let i=0; i < baseTimes.length; i++) {
		if (baseTimes[i] < hours) {
			formattedTime = baseTimes[i];
		}
	} 
	/* console.log("formattedTime : ", formattedTime); */
	
	// 좌표를 격자 x,y point로 바꾸기
	let result = dfs_xy_conv("toXY", latPoint, lonPoint);
	/* console.log("좌표를 격자 x,y point로 바꾸기");
	console.log("X:", result.x, "Y:", result.y); */
	
	xPoint = result.x;
	yPoint = result.y;
	
	// 날짜별로 데이터를 정리할 변수
	let forecastData = {};
	
	// 기상청 단기예보 API 요청하기
	let xhr = new XMLHttpRequest();
	let url = 'http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst'; /*URL*/
	let queryParams = '?' + encodeURIComponent('serviceKey') + '='+'AjLqAMVpLCijw8iZyI1GTt9ntTWfCAIjUDyOga5Becn7TLmzEmAYrJ6dNZ%2FtOqZLkQzQ3GWRy2PZ1f0nzgnsKA%3D%3D'; /*인증키*/
	queryParams += '&' + encodeURIComponent('numOfRows') + '=' + encodeURIComponent('1000'); /*한 페이지 결과 수*/
	queryParams += '&' + encodeURIComponent('pageNo') + '=' + encodeURIComponent('1'); /*페이지번호*/
	queryParams += '&' + encodeURIComponent('dataType') + '=' + encodeURIComponent('JSON'); /*요청자료형식(XML/JSON)*/
	queryParams += '&' + encodeURIComponent('base_time') + '=' + encodeURIComponent(formattedTime); /* 발표시각 */
	queryParams += '&' + encodeURIComponent('base_date') + '=' + encodeURIComponent(formattedDate); /* 발표일자 */
	queryParams += '&' + encodeURIComponent('nx') + '=' + encodeURIComponent(xPoint); /* 예보지점 X 좌표 */
	queryParams += '&' + encodeURIComponent('ny') + '=' + encodeURIComponent(yPoint); /* 예보지점 Y 좌표 */
	/* console.log(url + queryParams); */
	
	xhr.open('GET', url + queryParams);
	
	xhr.onreadystatechange = function () {
	    if (this.readyState == 4) {
	        if (this.status == 200) {
	           /*  console.log("Success");
	            console.log(this.responseText);  */
	           
	            // JSON 파싱
	            let jsonResponse = JSON.parse(this.responseText);
	            /* console.log(jsonResponse); */
	            
	            // 필요한 정보 리스트 추출
	            let items = jsonResponse.response.body.items.item;
	
	            
	            /*  
	            - TMP : 1시간 기온
	            - POP: 강수확률 %
	            - PTY: 강수형태 - (단기) 없음(0), 비(1), 비/눈(2), 눈(3), 소나기(4)
	            - SKY: 맑음(1), 구름많음(3), 흐림(4)
	            - WSD: 풍속 m/s
	            - REH: 습도 %
	             */
	            items.forEach(item => {
	                const date = item.fcstDate; // 예보 날짜
	                const category = item.category; // 예보 카테고리
	                const value = parseFloat(item.fcstValue); // 예보 값
	
	             	// 날짜별 객체 생성
	             	// 동일한 날짜의 여러 날씨 데이터를 압축하여 하나의 객체로 통합함 
	                if (!forecastData[date]) {
	                    forecastData[date] = {
	                        temperature: { min: Infinity, max: -Infinity },
	                        rain: { min: Infinity, max: -Infinity },
	                        rainType: { min: Infinity, max: -Infinity },
	                        snow: { min: Infinity, max: -Infinity },
	                        sky: { min: Infinity, max: -Infinity },
	                        windy: { min: Infinity, max: -Infinity },
	                        wet: { min: Infinity, max: -Infinity }
	                    };
	                };
	                 
	                // 데이터 추가
	                if (category === 'TMP') {
	                    // 기온
	                    forecastData[date].temperature.min = Math.min(forecastData[date].temperature.min, parseFloat(value));
	                    forecastData[date].temperature.max = Math.max(forecastData[date].temperature.max, parseFloat(value));
	                } else if (category === 'POP') {
	                    // 강수량
	                    forecastData[date].rain.min = Math.min(forecastData[date].rain.min, parseFloat(value));
	                    forecastData[date].rain.max = Math.max(forecastData[date].rain.max, parseFloat(value));
	                } else if (category === 'PTY') {
	                    // 강수형태
	                    forecastData[date].rainType.min = Math.min(forecastData[date].rainType.min, parseFloat(value));
	                    forecastData[date].rainType.max = Math.max(forecastData[date].rainType.max, parseFloat(value));
	                } else if (category === 'SKY') {
	                    // 하늘 상태
	                    forecastData[date].sky.min = Math.min(forecastData[date].sky.min, parseFloat(value));
	                    forecastData[date].sky.max = Math.max(forecastData[date].sky.max, parseFloat(value));
	                } else if (category === 'WSD') {
	                    // 풍속
	                    forecastData[date].windy.min = Math.min(forecastData[date].windy.min, parseFloat(value));
	                    forecastData[date].windy.max = Math.max(forecastData[date].windy.max, parseFloat(value));
	                } else if (category === 'REH') {
	                    // 습도
	                    forecastData[date].wet.min = Math.min(forecastData[date].wet.min, parseFloat(value));
	                    forecastData[date].wet.max = Math.max(forecastData[date].wet.max, parseFloat(value));
	                }
	            });
	
	            // 결과 출력
	            // JSON.stringify(변환할 객체, 변환 과정에서 사용할 replacer 함수 또는 배열/null로 설정하면 모든 속성이 변환, JSON 문자열의 들여쓰기(spacing) 수준을 지정)
	            /* console.log(JSON.stringify(forecastData, null, 2)); */
	            
	            
	         	// 날짜별로 분류한 데이터를 사용해서 화면에 가공해서 넣기
	         	 
	         	// forecastData가 객체 형태로 되어 있기 때문에, forecastData.length를 사용할 수 없음
	         	// forecastData의 키(날짜)를 배열로 가져오기
				let dates = Object.keys(forecastData);
	            
	            for (let i = 0; i < 3; i++) {	// 날씨는 3일만 출력
	            	// 날짜 (키) 
	            	let date = (dates[i]);
	            	let forecast = forecastData[date];
	            	/* console.log(JSON.stringify(forecast, null, 2)); */
	            	
	            	// 날짜 세팅
	            	let weatherDate = date.substring(4,6) + "." + date.substring(6,8);
	            	
	            	const today = currentDate.getDay();
	            	const dayList = ['일', '월', '화', '수', '목', '금', '토'];
	                const index = (today + i) % dayList.length;
	            	let weatherWeek = dayList[index];
	            	
	            	let weatherDay = "";
	            	if (i == 0) {
	            		weatherDay = "오늘";
	            	} else if (i == 1) {
	            		weatherDay = "내일"; 
	            	} else if (i == 2) {
	            		weatherDay = "모레";
	            	}

					// 하늘 상태 아이콘 세팅
	            	/* let weatherSky = Math.round((forecast.sky.max + forecast.sky.min) / 2); */	// 반올림
	            	let weatherSky = (forecast.sky.max + forecast.sky.min) / 2;	// 소수점 절삭
	            	
					if (weatherSky <= 2) {
						weatherSky = "/resources/file/image/weather/fill/clear-day.svg";
					} else if (weatherSky > 2 && weatherSky <= 3) {
						weatherSky = "/resources/file/image/weather/fill/partly-cloudy-day.svg";
					} else if (weatherSky > 3 && weatherSky <= 4) {
						weatherSky = "/resources/file/image/weather/fill/overcast.svg";
					}
					
					// 온도 세팅
					let weatherTemMin = forecast.temperature.min;
					let weatherTemMax = forecast.temperature.max;
	            	
					// 현재 날씨 상태 글자 세팅
					let weatherState = "";
					switch(forecast.rainType.max) {
						case 0:
							weatherState = "맑음";
							break;
						case 1:
							weatherState = "비";
							break;
						case 2:
							weatherState = "비/눈";
							break;
						case 3:
							weatherState = "눈";
							break;
						case 4:
							weatherState = "소나기";
							break;
					}
					
					// 현재 날씨 상태에 따른 아이콘 변경 (비,눈,소나기)
					if (weatherState == 1) {
						weatherSky = "/resources/file/image/weather/fill/rain.svg";
					} else if (weatherState == 2) {
						weatherSky = "/resources/file/image/weather/fill/sleet.svg";
					} else if (weatherState == 3) {
						weatherSky = "/resources/file/image/weather/fill/snow.svg";
					} else if (weatherState == 4) {
						weatherSky = "/resources/file/image/weather/fill/rain.svg";
					}
					
					// 현재 습도 세팅
					let weatherWet = Math.trunc((forecast.wet.max + forecast.wet.min) / 2);	// 소수점 절삭
					
					// 현재 풍속 아이콘 세팅
					let weatherWindy = Math.trunc((forecast.windy.max + forecast.windy.min) / 2);	// 소수점 절삭;
					/* console.log("weatherWindy : ", weatherWindy); */
					switch(weatherWindy) {
						case 0:
							weatherWindy = "/resources/file/image/weather/fill/wind-beaufort-0.svg";
							break;
						case 1:
							weatherWindy = "/resources/file/image/weather/fill/wind-beaufort-1.svg";
							break;
						case 2:
							weatherWindy = "/resources/file/image/weather/fill/wind-beaufort-2.svg";
							break;
						case 3:
							weatherWindy = "/resources/file/image/weather/fill/wind-beaufort-3.svg";
							break;
						case 4:
							weatherWindy = "/resources/file/image/weather/fill/wind-beaufort-4.svg";
							break;
						case 5:
							weatherWindy = "/resources/file/image/weather/fill/wind-beaufort-5.svg";
							break;
						case 6:
							weatherWindy = "/resources/file/image/weather/fill/wind-beaufort-6.svg";
							break;
						case 7:
							weatherWindy = "/resources/file/image/weather/fill/wind-beaufort-7.svg";
							break;
						case 8:
							weatherWindy = "/resources/file/image/weather/fill/wind-beaufort-8.svg";
							break;
						case 9:
							weatherWindy = "/resources/file/image/weather/fill/wind-beaufort-9.svg";
							break;
						case 10:
							weatherWindy = "/resources/file/image/weather/fill/wind-beaufort-10.svg";
							break;
						case 11:
							weatherWindy = "/resources/file/image/weather/fill/wind-beaufort-11.svg";
							break;
						default:	// 12 이상인 경우
							weatherWindy = "/resources/file/image/weather/fill/wind-beaufort-12.svg";
							break;
					}
					
					// 메뉴추천을 위한 오늘의 날씨 상태 세팅
					if (weatherState == "맑음") {
						todayWeatherState = "맑음";
					} else if (weatherSky == 3 || weatherSky == 4) {
						todayWeatherState = "흐림";
					} else if (weatherState == "눈") {
						todayWeatherState = "추움";
					} else if (weatherTemMax < 20) {
						todayWeatherState = "추움";
					} else if (weatherTemMax > 27) {
						todayWeatherState = "더움";
					} else if (weatherState == "비" || weatherState == "비/눈" || weatherState == "소나기") {
						todayWeatherState = "습함";
					} else if (weatherWet > 90) {
						todayWeatherState = "습함";
					}
					/* console.log("todayWeatherState : ", todayWeatherState); */
					
	            	// 날씨 위젯을 만들어서 화면에 넣기
	                let weatherDiv = document.createElement('div');
	                weatherDiv.className = 'col-4 mb-20 me-10 weatherDiv'; 
	            	 
	            	weatherDiv.innerHTML = `<div class='text-center fontDoHyeun fs-2tx mt-5'>\${weatherDate}(\${weatherWeek}) \${weatherDay}</div>
								    			<div class='d-flex'> 
								    				<img src='${pageContext.request.contextPath }\${weatherSky}' class='mw-200px'>
													<span class='row pt-10 ps-5'> 
														<span class='fs-4hx fontDoHyeun mt-3' style='height: 20px;'>
															<font color='blue'>\${weatherTemMin}&deg;</font>
															<font class='fontDoHyeun'> / </font> 
															<font color='red'>\${weatherTemMax}&deg;</font>  
														</span>		
														<span class='mt-10'> 
															<span class='fs-2tx fontDoHyeun'>\${weatherState}</span>
														</span>							                    
													</span> 
								    			</div>
								    			<div style='margin-top: -25px;'>
								    				<span class='ms-4 me-15' style='width: 50%;'>
									    				<img src='${pageContext.request.contextPath }/resources/file/image/weather/line/humidity.svg' class='mw-100px'>
								    					<span class='fs-3tx fontDoHyeun' style='position: absolute; margin-top: 40px;'>\${weatherWet}<font class='fs-1'>%</font></span> 
								    				</span> 
								    				<span class='ms-15' style='width: 50%;'> 
									    				<img src='${pageContext.request.contextPath }\${weatherWindy}' class='mw-150px'>
								    					<span class="fw-bold fs-2 windy">m/s</span>
									    			</span>
								    			</div>`
	            	
	            	weather.appendChild(weatherDiv);
	            }
				
				// 오늘의 날씨 상태에 따라서 날씨추천 리스트 (weatherRcmdtnFood)에 리스트 넣기
            	allFoodList.forEach(food => {
            		if (food.foodLinkWeather.includes(todayWeatherState)) {
            			weatherRcmdtnFoodList.push(food);
            		}
            	});
				
				
/*             	console.log("todayWeatherState"); 
            	console.log(todayWeatherState);
				console.log("weatherRcmdtnFoodList");
				console.log(weatherRcmdtnFoodList); */
	
	        } else {
	            console.log("Error: " + this.status);
	        }
	    }
	};

	xhr.send('');
	
	
	// 모달이 닫힐 때 이벤트 리스너 추가
	document.querySelector('#menuRcmdtn').addEventListener('hidden.bs.modal', function () {
		let keyword = document.querySelector('#keyword');
		keyword.value = foodNmKor;
		 
		// 하단 지도 card 부분에 있는 메뉴 이름과 메뉴 사진 넣기
		let mapFoodName = document.querySelector('#mapFoodName'); 
		mapFoodName.innerText = foodNmKor; 
		
		let mapFoodImg = document.querySelector('#mapFoodImg');
		mapFoodImg.src = "${pageContext.request.contextPath}/resources/file/image/food/" + foodNmEng + ".jpg";
		
		searchPlaces();
		
		// 스크롤 이동 이벤트 : behavior은 어떻게 이동할지에 대한 옵션 
		// smooth: 스크롤이 부드럽게 움직인다.
		// instant : 스크롤이 바로 해당지점으로 움직인다.
		// auto : 기본 움직임
		window.scrollTo({top: 3000, behavior:'smooth'})
	});

}); 


// 랜덤 메뉴추천 버튼 눌렀을 때
function f_randomRcmdtn() { 
	let index = Math.floor(Math.random() * allFoodList.length);
	f_foodModalPut(allFoodList[index]);
	
	let menuTitle = document.querySelector('#menuTitle'); 
	menuTitle.innerHTML = "<span class='fs-3qx'>오늘의 <span class='fs-4qx'>랜덤</span> 메뉴는?</span>";
	
	modal.show();
}

// 날씨 메뉴추천 버튼 눌렀을 때
function f_weatherRcmdtn() {
	let index = Math.floor(Math.random() * weatherRcmdtnFoodList.length);
	f_foodModalPut(weatherRcmdtnFoodList[index]);
	
	let menuTitle = document.querySelector('#menuTitle');
	menuTitle.innerHTML = "<span class='fs-3qx'>오늘의 날씨는 </span><span class='fs-4qx'>'" + todayWeatherState + "!'</span>";
	
	modal.show();
}

// 랜덤으로 골라진 음식의 이름과 이미지 주소를 DOM에 넣는 함수
function f_foodModalPut(fdList) {
	let foodNameInput = document.querySelector(".foodName");
	foodNameInput.innerText = fdList.foodNmKor;
	
	foodNmKor = fdList.foodNmKor;	// 추천된 메뉴의 한국 이름을 전역변수에 저장
	foodNmEng = fdList.foodNmEng;	// 추천된 메뉴의 영어 이름을 전역변수에 저장
	
	let foodEffect = document.querySelector(".foodEffect");
	foodEffect.src = "${pageContext.request.contextPath }/resources/file/image/food/" + fdList.foodNmEng + ".jpg";
}


// LCC DFS 좌표변환 ( code : "toXY"(위경도->좌표, v1:위도, v2:경도), "toLL"(좌표->위경도,v1:x, v2:y) )
function dfs_xy_conv(code, v1, v2) {
    // LCC DFS 좌표변환을 위한 기초 자료
    var DEGRAD = Math.PI / 180.0;
    var RADDEG = 180.0 / Math.PI;

    var re = RE / GRID;
    var slat1 = SLAT1 * DEGRAD;
    var slat2 = SLAT2 * DEGRAD;
    var olon = OLON * DEGRAD;
    var olat = OLAT * DEGRAD;

    var sn = Math.tan(Math.PI * 0.25 + slat2 * 0.5) / Math.tan(Math.PI * 0.25 + slat1 * 0.5);
    sn = Math.log(Math.cos(slat1) / Math.cos(slat2)) / Math.log(sn);
    var sf = Math.tan(Math.PI * 0.25 + slat1 * 0.5);
    sf = Math.pow(sf, sn) * Math.cos(slat1) / sn;
    var ro = Math.tan(Math.PI * 0.25 + olat * 0.5);
    ro = re * sf / Math.pow(ro, sn);
    var rs = {};
    if (code == "toXY") {
        rs['lat'] = v1;
        rs['lng'] = v2;
        var ra = Math.tan(Math.PI * 0.25 + (v1) * DEGRAD * 0.5);
        ra = re * sf / Math.pow(ra, sn);
        var theta = v2 * DEGRAD - olon;
        if (theta > Math.PI) theta -= 2.0 * Math.PI;
        if (theta < -Math.PI) theta += 2.0 * Math.PI;
        theta *= sn;
        rs['x'] = Math.floor(ra * Math.sin(theta) + XO + 0.5);
        rs['y'] = Math.floor(ro - ra * Math.cos(theta) + YO + 0.5);
    }
    else {
        rs['x'] = v1;
        rs['y'] = v2;
        var xn = v1 - XO;
        var yn = ro - v2 + YO;
        ra = Math.sqrt(xn * xn + yn * yn);
        if (sn < 0.0) - ra;
        var alat = Math.pow((re * sf / ra), (1.0 / sn));
        alat = 2.0 * Math.atan(alat) - Math.PI * 0.5;

        if (Math.abs(xn) <= 0.0) {
            theta = 0.0;
        }
        else {
            if (Math.abs(yn) <= 0.0) {
                theta = Math.PI * 0.5;
                if (xn < 0.0) - theta;
            }
            else theta = Math.atan2(xn, yn);
        }
        var alon = theta / sn + olon;
        rs['lat'] = alat * RADDEG;
        rs['lng'] = alon * RADDEG;
    }
    return rs;
}
</script>
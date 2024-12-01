<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<link href="${pageContext.request.contextPath }/resources/design/plugins/custom/fullcalendar/fullcalendar.bundle.css" rel="stylesheet" type="text/css" />
<script src="${pageContext.request.contextPath }/resources/design/plugins/custom/fullcalendar/fullcalendar.bundle.js"></script>
<script src="${pageContext.request.contextPath }/resources/design/js/custom/apps/calendar/vehicleCalendar.js"></script>
<div style="margin-bottom: 0px;">
	<div style="margin-top: -32px;">
		<div class="separator my-10"></div>
	</div>
	<div style="margin-left: 30px; margin-top: -100px;">
		<h3>차량 예약</h3>
		<h6>차량 예약</h6>
	</div>
</div>
<style>
	.map_wrap,
	.map_wrap * {
	    margin: 0;
	    padding: 0;
	    font-family: 'Malgun Gothic', dotum, '돋움', sans-serif;
	    font-size: 12px;
	}
	
	.map_wrap a,
	.map_wrap a:hover,
	.map_wrap a:active {
	    color: #000;
	    text-decoration: none;
	}
	
	.map_wrap {
	    position: relative;
	    width: 100%;
	    height: 500px;
	}
	
	#menu_wrap {
	    position: absolute;
	    top: 0;
	    left: 0;
	    bottom: 0;
	    width: 250px;
	    margin: 10px 0 30px 10px;
	    padding: 5px;
	    overflow-y: auto;
	    background: rgba(255, 255, 255, 0.7);
	    z-index: 1;
	    font-size: 12px;
	    border-radius: 10px;
	}
	
	.bg_white {
	    background: #fff;
	}
	
	#menu_wrap hr {
	    display: block;
	    height: 1px;
	    border: 0;
	    border-top: 2px solid #5F5F5F;
	    margin: 3px 0;
	}
	
	#menu_wrap .option {
	    text-align: center;
	}
	
	#menu_wrap .option p {
	    margin: 10px 0;
	}
	
	#menu_wrap .option button {
	    margin-left: 5px;
	}
	
	#placesList li {
	    list-style: none;
	}
	
	#placesList .item {
	    position: relative;
	    border-bottom: 1px solid #888;
	    overflow: hidden;
	    cursor: pointer;
	    min-height: 65px;
	}
	
	#placesList .item span {
	    display: block;
	    margin-top: 4px;
	}
	
	#placesList .item h5,
	#placesList .item .info {
	    text-overflow: ellipsis;
	    overflow: hidden;
	    white-space: nowrap;
	}
	
	#placesList .item .info {
	    padding: 10px 0 10px 55px;
	}
	
	#placesList .info .gray {
	    color: #8a8a8a;
	}
	
	#placesList .info .jibun {
	    padding-left: 26px;
	    background: url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_jibun.png) no-repeat;
	}
	
	#placesList .info .tel {
	    color: #009900;
	}
	
	#placesList .item .markerbg {
	    float: left;
	    position: absolute;
	    width: 36px;
	    height: 37px;
	    margin: 10px 0 0 10px;
	    background: url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png) no-repeat;
	}
	
	#placesList .item .marker_1 {
	    background-position: 0 -10px;
	}
	
	#placesList .item .marker_2 {
	    background-position: 0 -56px;
	}
	
	#placesList .item .marker_3 {
	    background-position: 0 -102px
	}
	
	#placesList .item .marker_4 {
	    background-position: 0 -148px;
	}
	
	#placesList .item .marker_5 {
	    background-position: 0 -194px;
	}
	
	#placesList .item .marker_6 {
	    background-position: 0 -240px;
	}
	
	#placesList .item .marker_7 {
	    background-position: 0 -286px;
	}
	
	#placesList .item .marker_8 {
	    background-position: 0 -332px;
	}
	
	#placesList .item .marker_9 {
	    background-position: 0 -378px;
	}
	
	#placesList .item .marker_10 {
	    background-position: 0 -423px;
	}
	
	#placesList .item .marker_11 {
	    background-position: 0 -470px;
	}
	
	#placesList .item .marker_12 {
	    background-position: 0 -516px;
	}
	
	#placesList .item .marker_13 {
	    background-position: 0 -562px;
	}
	
	#placesList .item .marker_14 {
	    background-position: 0 -608px;
	}
	
	#placesList .item .marker_15 {
	    background-position: 0 -654px;
	}
	
	#pagination {
	    margin: 10px auto;
	    text-align: center;
	}
	
	#pagination a {
	    display: inline-block;
	    margin-right: 10px;
	}
	
	#pagination .on {
	    font-weight: bold;
	    cursor: default;
	    color: #777;
	}
    #vhclslideshow-container {
        position: relative;
        width: 100%;
        height: 300px; /* 카드 높이에 맞게 조정 */
        overflow: hidden;
    }
    .slide {
        position: absolute;
        width: 100%;
        height: 100%;
        display: none; /* 기본적으로 숨김 */
    }
</style>
	<div class="card">
		<div style="background-image: url('/upload/Gradient03.jpg'); background-size: cover; background-repeat: no-repeat; background-position: center;">
			<div class="card-header border-0 pt-6">
				<div class="d-flex flex-column fv-row">
					<h3 class="fw-bold text-gray-800 py-3">차량 목록</h3>
					<span class="fs-4 fw-semibold text-gray-600 d-block">
					</span>
				</div>
				<c:choose>
					<c:when test="${empty vhclList}">
						<div class="text-center mt-3">
						    <span>0</span> / <span>0</span>
						</div>
					</c:when>
					<c:otherwise>
						<div id="slide-index" class="text-center mt-3">
						    <span id="current-slide">1</span> / <span id="total-slides">${fn:length(vhclList)}</span>
						</div>
					</c:otherwise>
				</c:choose>
				<div class="card-toolbar pb-3">
				</div>
			</div>
			<div class="d-flex align-items-center justify-content-center h-400px">
			    <div class="image-input px-5" data-kt-image-input="true">
			        <div class="image-input-wrapper w-50px h-50px arrow" onclick="slide('prev')" style="background-image: url('/upload/arrow_back_ios_24dp_E8EAED_FILL0_wght400_GRAD0_opsz24.png'); cursor: pointer;" id="leftBtn"></div>
			    </div>
			    <div class="image-input px-5 h-400px" id="vhclslideshow-container">
					<c:choose>
						<c:when test="${empty vhclList}">
							<div class="slide" style="display: none;">
			                    <div class="row">
					                <div class="image-input d-flex align-items-center justify-content-center" data-kt-image-input="true">
					                    <div class="image-input-wrapper w-900px h-550px" style="background-image: url('/upload/shadow.png'); background-size: contain; background-repeat: no-repeat; background-position: bottom;"></div>
					                </div>
			                    </div>
				            </div>
						</c:when>
						<c:otherwise>
					        <c:forEach items="${vhclList }" var="vhcl">
				            <div class="slide" style="display: none;">
			                    <div class="row vhclNoFind" data-vhcl-no="${vhcl.vhclNo }">
					                <table class="table py-5">
					                    <tbody class="d-flex align-items-center justify-content-center">
					                        <tr>
					                            <td><span class="badge badge-light-success fs-7 fw-bold">모델명 - ${vhcl.vhclMdlNm }</span></td>
					                            <td><span class="badge badge-light-primary fs-7 fw-bold">차량 번호 - ${vhcl.vhclNo }</span></td>
					                            <td><span class="badge badge-light-info fs-7 fw-bold">차종 - ${vhcl.vhclKndNm }</span></td>
					                            <td><span class="badge badge-light fs-7 fw-bold">유종 - ${vhcl.vhclTypeFuel}</span></td>
					                            <td><span class="badge badge-light-danger fs-7 fw-bold">연비 - ${vhcl.vhclAvgFuel }㎞/ℓ</span></td>
					                        </tr>
					                    </tbody>
					                </table>
					                <div class="image-input d-flex align-items-center justify-content-center" data-kt-image-input="true">
					                    <div class="image-input-wrapper w-900px h-350px" style="background-image: url('/upload/${vhcl.vhclImgPath }'); background-size: contain; background-repeat: no-repeat; background-position: center;"></div>
					                </div>
			                    </div>
				            </div>
					        </c:forEach>
						</c:otherwise>
					</c:choose>		        	
			    </div>
			    <div class="image-input px-5" data-kt-image-input="true">
			        <div class="image-input-wrapper w-50px h-50px arrow" onclick="slide('next')" style="background-image: url('/upload/arrow_forward_ios_24dp_E8EAED_FILL0_wght400_GRAD0_opsz24.png'); cursor: pointer;" id="rightBtn"></div>
			    </div>
			</div>
		</div>
	</div>
<input type="hidden" id="proStartDt" value="${proStartDt }">
<input type="hidden" id="proEndDt" value="${proEndDt }">
<div class="d-flex mx-2 py-5">
	<form action="/empvehicle/vehiclereservationinsert.do" method="post" id="rsvtForm">
		<div class="py-3 px-3">
			<div class="card card-flush h-xl-100 d-flex flex-column">
				<div class="card-header border-0 pt-7">
					<h1>차량 예약</h1>
				</div>
				<div class="separator separator-dashed my-0"></div>
				<div class="row card-body pt-5">
					<div class="d-flex flex-column fv-row">
						<label class="fs-5 fw-semibold pt-5">이용 시간</label>
					    <div class="fv-plugins-message-container fv-plugins-message-container--enabled invalid-feedback"></div>
					    <div class="col-12">
					        <div class="d-flex">
					            <input type="hidden" class="form-control flatpickr-input active" id="vhclIndt" name="vhclIndt">
					            <input type="datetime-local" class="form-control flatpickr-input active" id="vhclRntlDt" name="vhclRntlDt" value="2024-11-18T13:00">
					            <input type="datetime-local" class="form-control flatpickr-input active" id="vhclRtnDt" name="vhclRtnDt" value="2024-11-18T16:00">
					        </div>
					    </div>
						    
						<label class="fs-5 fw-semibold pt-5">목적지</label>
						<div class="input-group">
						    <input type="text" class="form-control" placeholder="목적지를 입력해주세요" name="vhclBtdst" id="vhclBtdst" value="옥천">
						    <button type="button" class="btn btn-light-info" data-bs-toggle="modal" data-bs-target="#modal_search_btdst" id="kakaoSearchBtn">
							목적지 검색</button>
						</div>
						
						<label class="fs-5 fw-semibold pt-5">대여사유</label>
						<div class="input-group">
							<textarea class="form-control" placeholder="대여 사유를 입력해주세요" rows="3" name="rntlRsn" id="rntlRsn" value="출장"></textarea> <!-- Bootstrap 클래스 추가 -->
						</div>
						<div class="card-footer d-flex align-middle justify-content-center">
							<div class="card-toolbar">
								<button type="submit" class="btn btn-light-success" id="rstvBtn">
								예약하기</button>
							</div>
						</div>
						
						<div class="separator separator-dashed"></div>
						    
						<label class="fs-5 fw-semibold pt-5">차량 정보</label>
					    <div class="fv-plugins-message-container fv-plugins-message-container--enabled invalid-feedback"></div>
					    <div class="col-12">
					        <div class="d-flex">
					            <input type="text" class="form-control form-control-solid mx-1" id="modifyVhclNo" name="vhclNo" readonly="readonly">
					            <input type="text" class="form-control form-control-solid mx-1" id="modifyVhclMdlNm" name="vhclMdlNm" readonly="readonly">
					        </div>
					    </div>
						<label class="fs-5 fw-semibold form-control-solid pt-5">차종</label>
						<div class="input-group">
						    <input type="text" class="form-control form-control-solid mx-1" name="vhclAvgFuel" id="modifyVhclKndNm" readonly="readonly">
						</div>
						<label class="fs-5 fw-semibold pt-5">유종</label>
						<div class="input-group">
						    <input type="text" class="form-control form-control-solid mx-1" name="vhclAvgFuel" id="modifyVhclTypeFuel" readonly="readonly">
						</div>
						<label class="fs-5 fw-semibold pt-5">연비</label>
						<div class="input-group">
						    <input type="text" class="form-control form-control-solid mx-1" name="vhclAvgFuel" id="modifyVhclAvgFuel" readonly="readonly">
						    <span class="input-group-text">㎞/ℓ</span>
						</div>
					</div>
				</div>
			</div>
		</div>
	</form>
	<div class="col-xl-8 py-3">
		<div class="card card-flush h-xl-100 d-flex flex-column">
			<div class="card-header border-0 pt-7">
				<h1>목적지 주변 검색</h1>
			</div>
			<div class="separator separator-dashed my-0"></div>
			<div class="map_wrap">
			    <div id="kakaoMap" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>
			
			    <div id="menu_wrap" class="bg_white">
			        <div class="option">
			            <div>
			                <form onsubmit="searchPlaces(); return false;" id="kakaoSearch">
			                   	 <input type="hidden" id="keyword" value="대전 시청" size="15"> 
<!-- 			                    <button type="button" id="kakaoSearchBtn">검색하기</button>  -->
			                </form>
			            </div>
			        </div>
			        <hr>
			        <ul id="placesList"></ul>
			        <div id="pagination"></div>
			    </div>
			</div>
<!-- 			<div class="row card-body pt-5"> -->
<!-- 				<div class="flex-column" id="kakaoMap" style="width: container; height: container; float: right;"> -->
<!-- 				</div> -->
<!-- 			</div> -->
		</div>
	</div>
</div>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=241aeb14cce970ce55c42b0bebd05c7b&libraries=services"></script>
	<script>
	
	// 마커를 담을 배열입니다
	var markers = [];
	
	var mapContainer = document.getElementById('kakaoMap'), // 지도를 표시할 div 
	    mapOption = {
	        center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
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
	
	    if (!keyword.replace(/^\s+|\s+$/g, '')) {
	        alert('키워드를 입력해주세요!');
	        return false;
	    }
	
	    // 장소검색 객체를 통해 키워드로 장소검색을 요청합니다
	    ps.keywordSearch(keyword, placesSearchCB);
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
	
	            // 마커에 클릭이벤트를 등록합니다
	            kakao.maps.event.addListener(marker, 'click', function () {
	                var detailAddr;
	                // HTML5의 geolocaiton으로 사용할 수 있는지 확인합니다.
	                if (navigator.geolocation) {
	                    
	                    // GeoLocation을 이용해서 접속 위치를 얻어옵니다.
	                    navigator.geolocation.getCurrentPosition(function(position){
	                        
	                        var lat = position.coords.latitude, // 위도
	                            lon = position.coords.longitude; // 경도
	                            
	                        var locPostion = new kakao.maps.LatLng(lat, lon), //마커가 표시될 위치를 geolocation 좌표로 생성합니다.
	                            message = '<div style="padding:5px;">여기에 계신가요?!</div>'; // 인포윈도우에 표시될 내용입니다.
	                            
	                        // 주소-좌표 변환 객체를 생성합니다
	                        
	                        searchDetailAddrFromCoords(locPostion, function(result, status) {
	                            if (status === kakao.maps.services.Status.OK) {
	                                detailAddr = !!result[0].road_address ? result[0].road_address.address_name : result[0].address.address_name;
	
	
	                                location.href = "https://map.kakao.com/?sName="+detailAddr+"&eName="+title                                            
	                            }   
	                        });                                        
	                    });
	                }      
	            });    
	
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
	
	var geocoder = new kakao.maps.services.Geocoder();
	function searchDetailAddrFromCoords(coords, callback) {              
	    // 좌표로 법정동 상세 주소 정보를 요청합니다
	    geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
	}            
	
	// 검색결과 항목을 Element로 반환하는 함수입니다
	function getListItem(index, places) {
	
	    var el = document.createElement('li'),
	        itemStr = '<span class="markerbg marker_' + (index + 1) + '"></span>' +
	            '<div class="info">' +
	            '   <h5>' + places.place_name + '</h5>';
	
	    if (places.road_address_name) {
	        itemStr += '    <span>' + places.road_address_name + '</span>' +
	            '   <span class="jibun gray">' + places.address_name + '</span>';
	    } else {
	        itemStr += '    <span>' + places.address_name + '</span>';
	    }
	
	    itemStr += '  <span class="tel">' + places.phone + '</span>' +
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
	
	
	let mcnt = 0;
	// 검색결과 목록 또는 마커를 클릭했을 때 호출되는 함수입니다
	// 인포윈도우에 장소명을 표시합니다
	function displayInfowindow(marker, title) {
		console.log("mcnt",mcnt);
	    var content = '<div style="padding:5px;z-index:1;">' + title + '</div>';
	
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
	
	
<div class="py-3 px-5">
	<div class="card card-flush h-xl-100 d-flex flex-column">
		<div class="card-header border-0 pt-7">
			<h1>주행 일정</h1>
		</div>
		<div class="separator separator-dashed my-0"></div>
		<div class="row card-body pt-5">
			<div id="kt_calendar_app"></div>
			<div class="modal fade" id="kt_modal_add_event" tabindex-="1" aria-hidden="true" data-bs-focus="false">
				<div class="modal-dialog modal-dialog-centered mw-650px">
					<div class="modal-content">
						<form class="form" action="#" id="kt_modal_add_event_form">
						</form>
					</div>
				</div>
			</div>
			<div class="modal fade" id="kt_modal_view_event" tabindex="-1" data-bs-focus="false" aria-hidden="true">
				<div class="modal-dialog modal-dialog-centered mw-650px">
					<div class="modal-content">
						<div class="modal-header border-0 justify-content-end">
							<div class="btn btn-icon btn-sm btn-color-gray-500 btn-active-icon-primary me-2" data-bs-toggle="tooltip" data-bs-dismiss="click" title="일정 수정" id="kt_modal_view_event_edit">
								<i class="ki-duotone ki-pencil fs-2">
									<span class="path1"></span>
									<span class="path2"></span>
								</i>
							</div>
							<div class="btn btn-icon btn-sm btn-color-gray-500 btn-active-icon-danger me-2" data-bs-toggle="tooltip" data-bs-dismiss="click" title="일정 삭제" id="kt_modal_view_event_delete">
								<i class="ki-duotone ki-trash fs-2">
									<span class="path1"></span>
									<span class="path2"></span>
									<span class="path3"></span>
									<span class="path4"></span>
									<span class="path5"></span>
								</i>
							</div>
							<div class="btn btn-icon btn-sm btn-color-gray-500 btn-active-icon-primary" data-bs-toggle="tooltip" title="목록" data-bs-dismiss="modal">
								<i class="ki-duotone ki-cross fs-2x">
									<span class="path1"></span>
									<span class="path2"></span>
								</i>
							</div>
						</div>
						<div class="modal-body pt-0 pb-20 px-lg-17">
							<div class="d-flex">
								<i class="ki-duotone ki-calendar-8 fs-1 text-muted me-5">
									<span class="path1"></span>
									<span class="path2"></span>
									<span class="path3"></span>
									<span class="path4"></span>
									<span class="path5"></span>
									<span class="path6"></span>
								</i>
								<div class="mb-9">
									<div class="d-flex align-items-center mb-2">
										<span class="fs-3 fw-bold me-3" data-kt-calendar="event_name"></span>
										<span class="badge badge-light-success" data-kt-calendar="all_day"></span>
									</div>
									<div class="fs-6" data-kt-calendar="event_description"></div>
								</div>
							</div>
							<div class="d-flex align-items-center mb-2">
								<span class="bullet bullet-dot h-10px w-10px bg-success ms-2 me-7"></span>
								<div class="fs-6">
									<span class="fw-bold">시작</span>
									<span data-kt-calendar="event_start_date"></span>
								</div>
							</div>
							<div class="d-flex align-items-center mb-9">
								<span class="bullet bullet-dot h-10px w-10px bg-danger ms-2 me-7"></span>
								<div class="fs-6">
									<span class="fw-bold">종료</span>
									<span data-kt-calendar="event_end_date"></span>
								</div>
							</div>
							<div class="d-flex align-items-center">
								<i class="ki-duotone ki-geolocation fs-1 text-muted me-5">
									<span class="path1"></span>
									<span class="path2"></span>
								</i>
								<div class="fs-6" data-kt-calendar="event_location"></div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>




<!-- <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=APIKEY&libraries=services,clusterer,drawing"></script> -->
<script type="text/javascript">
$(function() {
    let currentSlide = 0; // 현재 슬라이드 인덱스
    const slides = $('#vhclslideshow-container .slide'); // 모든 슬라이드 요소 가져오기
    const totalSlides = slides.length;
    var vhclModifyId = $("#vhclModifyId");
    var delForm = $("#delForm");
    var vhclDelBtn = $("#vhclDelBtn");
    var vhclRntlDt = $("#vhclRntlDt");
    var vhclRtnDt = $("#vhclRtnDt");
    var delVhclNo = $("#delVhclNo");
    var modifyVhclNo = $("#modifyVhclNo");
    var modifyVhclMdlNm = $("#modifyVhclMdlNm");
    var modifyVhclAvgFuel = $("#modifyVhclAvgFuel");
    var modifyVhclKndNm = $("#modifyVhclKndNm");
    var modifyVhclTypeFuel = $("#modifyVhclTypeFuel");
    var modifyVhclImgPath = $("#modifyVhclImgPath");
    var modifyVhclRsvtPsbltyYn = $("#modifyVhclRsvtPsbltyYn");
    var hiddenVhclImgPath = $("#hiddenVhclImgPath");
    var rstvBtn = $("#rstvBtn");
    var kakaoSearchBtn = $("#kakaoSearchBtn");
    var kakaoSearch = $("#kakaoSearch");
    var vhclNo = ""; // 차량 번호를 전역 변수로 선언
    
    kakaoSearchBtn.on("click", function (event) {
    	event.preventDefault();
		$("#keyword").val();
    	
		let vhclBtdst = $("#vhclBtdst").val();
		$("#keyword").val(vhclBtdst);
		$("#kakaoSearch").submit();
	})
    
    // 현재 슬라이드 인덱스 표시 업데이트 함수
    function updateSlideIndex() {
        $('#current-slide').text(currentSlide + 1); // 1부터 시작하도록 +1
        $('#total-slides').text(totalSlides); // 총 슬라이드 수
    }

    // 첫 번째 슬라이드 표시
    function showSlide(index) {
        slides.hide(); // 모든 슬라이드 숨김
        const currentSlideElement = slides.eq(index); // 현재 슬라이드 요소 가져오기
        currentSlideElement.show(); // 현재 슬라이드만 보이도록 설정
        
        // 현재 슬라이드의 vhclNo 값 가져오기
        vhclNo = currentSlideElement.find('.vhclNoFind').data('vhcl-no'); // .vhclNoFind에서 data-vhcl-no 가져오기
        console.log("현재 슬라이드의 vhclNo: " + vhclNo); // 확인을 위한 로그 출력
        
        $.ajax({
            url: "/empvehicle/findvhclvo.do",
            type: "POST",
            contentType: "application/json; charset=utf-8",
            data: JSON.stringify({ vhclNo: vhclNo }), // vhclNo를 JSON 문자열로 변환하여 요청
            success: function(vhcl) {
            	console.log("실행후 나온 번호" + vhcl.vhclNo);
            	
            	modifyVhclNo.val(vhcl.vhclNo);
            	delVhclNo.val(vhcl.vhclNo);
            	modifyVhclMdlNm.val(vhcl.vhclMdlNm);
            	modifyVhclAvgFuel.val(vhcl.vhclAvgFuel);
            	modifyVhclKndNm.val(vhcl.vhclKndNm);
            	modifyVhclTypeFuel.val(vhcl.vhclTypeFuel);
            	hiddenVhclImgPath.val(vhcl.vhclImgPath);
    	    },
            error: function() {
                Swal.fire({
                    icon: 'warning',
                    title: '수정 실행 실패!',
                    confirmButtonColor: '#4FC9DA',
                });
            }
        });

        updateSlideIndex(); // 슬라이드 인덱스 업데이트
    }

    // 슬라이드 이동 함수
    window.slide = function(direction) {
        if (direction === 'next') {
            currentSlide = (currentSlide + 1) % totalSlides; // 다음 슬라이드로 이동 (순환)
        } else if (direction === 'prev') {
            currentSlide = (currentSlide - 1 + totalSlides) % totalSlides; // 이전 슬라이드로 이동 (순환)
        }
        showSlide(currentSlide); // 현재 슬라이드 표시
        
        
    };

    // 페이지 로드 시 첫 번째 슬라이드 표시
    showSlide(currentSlide);
    
    vhclRntlDt.on("change", function () {
		var currentTaskDt = new Date();
		var proTaskStartDt = $(this).val();
		var newTaskStartDt = new Date(proTaskStartDt);
		
		if (newTaskStartDt < currentTaskDt) {
			Swal.fire({
				title: '미래의 시간을 입력해주세요!',
				icon: 'warning',
				confirmButtonColor: '#4FC9DA',
				confirmButtonText: '확인',
				reverseButtons: false,
			});
			$(this).val('');
			return;
		}
		
	});
	
	// 마감일 유효성 검사
	vhclRtnDt.on("change", function () {
		var proTaskEndDt = $(this).val();
		var newTaskEndDt = new Date(proTaskEndDt);
		var proTaskStartDt = new Date($("#vhclRntlDt").val());
		
		if (proTaskStartDt && newTaskEndDt < proTaskStartDt) {
			Swal.fire({
				title: '대여일시보다 미래의 시간을 입력해주세요!',
				icon: 'warning',
				confirmButtonColor: '#4FC9DA',
				confirmButtonText: '확인',
				reverseButtons: false,
			});
			$(this).val('');
			return;
		}
	});

});


// KAKAO 지도 이용하기

	//마커를 담을 배열
	/*var markers = [];
	
	var mapContainer = new kakao.maps.Map(document.getElementById('kakaoMap'), { // 지도를 표시할 div
	    center : new kakao.maps.LatLng(36.2683, 127.6358), // 지도의 중심좌표 
	    level : 3 // 지도의 확대 레벨 
	});
	
	// 	마커 클러스터러를 생성합니다 
	var clusterer = new kakao.maps.MarkerClusterer({
	    map: map, // 마커들을 클러스터로 관리하고 표시할 지도 객체 
	    averageCenter: true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정 
	    minLevel: 10 // 클러스터 할 최소 지도 레벨 
	});
	
	// 주소-좌표 변환 객체를 생성합니다
	var geocoder = new kakao.maps.services.Geocoder();
		
	var marker = new kakao.maps.Marker(), // 클릭한 위치를 표시할 마커입니다
    infowindow = new kakao.maps.InfoWindow({zindex:1}); // 클릭한 위치에 대한 주소를 표시할 인포윈도우입니다
	
// 	var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
	
	// 지도를 표시하는 div 크기를 변경하는 함수입니다
	function resizeMap() {
	    var mapContainer = document.getElementById('kakaoMap');
	    mapContainer.style.width = '100%';
	    mapContainer.style.height = '100%'; 
	}
	
	function relayout() {    
	    
	    // 지도를 표시하는 div 크기를 변경한 이후 지도가 정상적으로 표출되지 않을 수도 있습니다
	    // 크기를 변경한 이후에는 반드시  map.relayout 함수를 호출해야 합니다 
	    // window의 resize 이벤트에 의한 크기변경은 map.relayout 함수가 자동으로 호출됩니다
	    map.relayout();
	}
		
	
	// 데이터를 가져오기 위해 jQuery를 사용합니다
	// 데이터를 가져와 마커를 생성하고 클러스터러 객체에 넘겨줍니다
	$.get("/download/web/data/chicken.json", function(data) {
	    // 데이터에서 좌표 값을 가지고 마커를 표시합니다
	    // 마커 클러스터러로 관리할 마커 객체는 생성할 때 지도 객체를 설정하지 않습니다
	    var markers = $(data.positions).map(function(i, position) {
	        return new kakao.maps.Marker({
	            position : new kakao.maps.LatLng(position.lat, position.lng)
	        });
	    });
	
	    // 클러스터러에 마커들을 추가합니다
	    clusterer.addMarkers(markers);
	});*/
</script>










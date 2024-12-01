<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<div id="kt_app_content_container" class="app-container container-fluid">
	<div class="card card-flush py-4">
		<div class="card-header">
			<div class="card-title">
				<h2>GROUBEAR와 함께하는 기업</h2>
			</div>
		</div>
		<div class="card-body pt-0">
			<div class="card card-flush"
				style="overflow-y: scroll; height: 635px; width: 30%; float: left;">
				<!-- 				<div class="card-header mb-5 pt-7" id="kt_chat_contacts_header"> -->
				<!-- 					<form class="w-100 position-relative" autocomplete="off"> -->
				<!-- 						<i -->
				<!-- 							class="ki-duotone ki-magnifier fs-3 text-gray-500 position-absolute top-50 ms-5 translate-middle-y"> -->
				<!-- 							<span class="path1"></span> <span class="path2"></span> -->
				<!-- 						</i> <input type="text" class="form-control form-control-solid px-13" -->
				<!-- 							name="search" value="" placeholder="검색"> -->
				<!-- 					</form> -->
				<!-- 				</div> -->
				<div class="d-flex align-items-center" style="margin-left: 10px;">

					<form id="searchForm" style="display: contents; margin-left: 10px;">
						<input type="hidden" name="page" id="page"> <input
							id="myInput" name="searchWord" type="text"
							data-kt-ecommerce-product-filter="search"
							class="form-control w-2s50px ps-5 mb-5"
							style="margin-top: 1.5em;" placeholder="검색"
							value="${searchWord }" />
						<button id="searchBtn" type="button"
							class="btn btn-flex btn-light-success ms-1 py-2 px-2 mb-5"
							style="margin-top: 1.5em;">
							<i class="ki-duotone ki-magnifier fs-2x"> <span class="path1"
								style="height: 1.1em;"></span> <span class="path2"></span>
							</i>
						</button>
					</form>

				</div>

<%-- 												<p>${pagingVO.dataList}</p> --%>
				<div id="kt_account_settings_signin_method" class="collapse show">
					<div class="card-body border-top p-9">
<%-- 					<c:set value="${pagingVO.dataList }" var="dataList" /> --%>
						<c:forEach items="${dataList }" var="map">
							<div class="d-flex flex-wrap align-items-center">
								<div id="kt_signin_email">
									<div class="fs-6 fw-bold mb-1">${map.coNm }</div>
									<div class="fw-semibold text-gray-600">${map.coAddr }</div>
								</div>
							</div>
							<div class="separator separator-dashed my-5"></div>
						</c:forEach>
						<div class="clearfix"  id="pagingArea">
							${pagingVO.pagingHTML }</div>
					</div>
				</div>
			</div>
			<div class="flex-column" id="map"
				style="width: 68%; height: 635px; float: right;">
				<c:forEach items="${mapLocation }" var="mapLo">
					<input type="hidden" class="Latitude" value="${mapLo.lat }" />
					<input type="hidden" class="longitude" value="${mapLo.lot }" />
				</c:forEach>
			</div>
		</div>
	</div>




</div>


<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=711db03122284265cef8780056e74af7&libraries=clusterer"></script>
<script type="text/javascript">

// 	pagingArea.on("click", "a", function (event) {
// 		event.preventDefault();
// 		var pageNo = $(this).data("page");
// 		searchForm.find("#page").val(pageNo);
// 	//		$("#myInput").val("");
// 		searchForm.submit();
// 	});

	// <맵 생성>
	var container = document.getElementById('map');
	var options = {
		center : new kakao.maps.LatLng(35.9353581959954, 127.491457326501),
		level : 13
	};

	var map = new kakao.maps.Map(container, options);
	// </맵 생성>

	var positions = [ {
		"lat" : 37.6671972098514,
		"lot" : 127.52278875979
	}, {
		"lat" : 37.2635846787744,
		"lot" : 127.028715898311
	},{
		"lat" : 36.55842906894561,
		"lot" : 128.67633819580078
	}, {
		"lat" : 36.5684607632482,
		"lot" : 128.729587379397
	},{
		"lat" : 36.9910490160221,
		"lot" : 127.925961035784
	}, {
		"lat" : 35.4163627529983,
		"lot" : 127.390396427422
	},{
		"lat" : 35.1601037626662,
		"lot" : 126.851629955742
	},{
		"lat" : 35.5395955247058,
		"lot" : 129.311603446508
	}, {
		"lat" : 35.8713802646197,
		"lot" : 128.601805491072
	}, {
		"lat" : 37.257643055151,
		"lot" : 127.053129481167
	}, {
		"lat" : 37.5279271045092,
		"lot" : 126.929241174348
	}, {
		"lat" : 35.6279621720249,
		"lot" : 129.35243069527
	}, {
		"lat" : 35.8749474146283,
		"lot" : 128.824474448856
	}, {
		"lat" : 36.1989174532,
		"lot" : 126.632859271166
	}, {
		"lat" : 36.1060326861019,
		"lot" : 128.390569381312
	}, {
		"lat" : 35.1855538111604,
		"lot" : 128.593705375051
	}, {
		"lat" : 37.4403870382401,
		"lot" : 126.625266422656
	}, {
		"lat" : 33.2643016976347,
		"lot" : 126.583390695877
	}, {
		"lat" : 37.4990962874664,
		"lot" : 126.725535636576
	}, {
		"lat" : 33.4921418416835,
		"lot" : 126.497034422299
	}, {
		"lat" : 35.2314717029815,
		"lot" : 129.088287065122
	}, {
		"lat" : 35.8965881796611,
		"lot" : 128.85097955158
	}, {
		"lat" : 37.869016935049,
		"lot" : 127.745279832642
	}, {
		"lat" : 37.4776365815105,
		"lot" : 129.127240724682
	}, {
		"lat" : 37.4498138401565,
		"lot" : 129.177852461342
	}, {
		"lat" : 35.9582256770225,
		"lot" : 126.870688840562
	}, {
		"lat" : 37.4816411686596,
		"lot" : 126.952144384523
	}, {
		"lat" : 37.4816411686596,
		"lot" : 126.952144384523
	}, {
		"lat" : 37.4385554509387,
		"lot" : 128.666221197865
	}, {
		"lat" : 36.6457666963996,
		"lot" : 127.437215048743
	}, {
		"lat" : 36.3250165800842,
		"lot" : 127.408883940976
	}, {
		"lat" : 36.3250339877736,
		"lot" : 127.408932253974
	}, {
		"lat" : 37.8380344564235,
		"lot" : 127.506892367428
	}, {
		"lat" : 37.6671972098514,
		"lot" : 127.52278875979
	}, {
		"lat" : 36.4466472,
		"lot" : 127.3932466
	}

	];

	var markers = positions.map(function(position) { // 마커를 배열 단위로 묶음
		return new kakao.maps.Marker({
			position : new kakao.maps.LatLng(position.lat, position.lot)
		});
	});

	var clusterer = new kakao.maps.MarkerClusterer({
		map : map, // 마커들을 클러스터로 관리하고 표시할 지도 객체 
		averageCenter : true, // 클러스터에 포함된 마커들의 평균 위치를 클러스터 마커 위치로 설정 
		minLevel : 5, // 클러스터 할 최소 지도 레벨 
		markers : markers
	// 클러스터에 마커 추가
	});

	var marker = new kakao.maps.Marker({ // 마커를 생성
		position : new kakao.maps.LatLng(37.389794, 126.950768)
	// 범계역 위도와 경도
	});

	clusterer.addMarker(marker); // 마커를 클러스터러에 추가
</script>

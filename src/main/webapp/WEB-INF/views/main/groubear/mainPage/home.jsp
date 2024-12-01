<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>

<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>


<style>
a {
	color: rgb(21, 21, 21);
	text-decoration: none;
}

a:hover {
	color: rgb(57, 196, 215);
	text-decoration: none;
}

.txt_line {
	width: 22em;
	padding: 0 5px;
	overflow: hidden;
	text-overflow: ellipsis;
	white-space: nowrap;
}
</style>


<div style="margin-bottom: 20px;">
	<div style="margin-top: -32px;">
		<div class="separator border-2 my-10"></div>
	</div>
	<div style="margin-left: 30px; margin-top: -100px;">
		<h1>홈피드</h1>
		<!-- <h6></h6> -->
	</div>
</div>

<!-- div 중에 row가 있는 곳이 한 줄이고, row 내부에 card가 하나의 영역이며,
	 row는 kt_app_content_container 클래스가 있는 div 내부에 넣어야 합니다. 참고해주세용.
-->

<!-- 참고 예시 : (아래는 2개의 카드가 들어가있는 1개의 꽉찬 row임) (그리드 영역은 6:6)
	<div class="row gx-5 gx-xl-10 mb-xl-10">
	
		<div class="col-md-6 col-lg-6 col-xl-6 col-xxl-3 mb-10">
			<div class="card card-flush h-md-50 mb-5 mb-xl-10">
				<div class="card-header pt-5">
				</div>
				<div class="card-body pt-2 pb-4 d-flex align-items-center">
				</div>
			</div>
		</div>
		
		<div class="col-md-6 col-lg-6 col-xl-6 col-xxl-3 mb-10">
			<div class="card card-flush h-md-50 mb-5 mb-xl-10">
				<div class="card-header pt-5">
				</div>
				<div class="card-body pt-2 pb-4 d-flex align-items-center">
				</div>
			</div>
		</div>
		
	</div>
-->

<div class="app-main flex-column flex-row-fluid mb-10" id="kt_app_main">
	<div class="d-flex flex-column flex-column-fluid">
		<div id="kt_app_content" class="app-content  flex-column-fluid ">
			<div id="kt_app_content_container"
				class="app-container  container-fluid ">

				<!-- 이 안부터 row넣기 시작 -->

				<div class="row gx-5 gx-xl-10 mb-xl-10">

					<div class="col-md-6 col-lg-6 col-xl-6 col-xxl-3 mb-10">

						<!-- Q&A 위젯 시작 -->
						<div class="card card-flush h-md-50 mb-5 mb-xl-10">

							<c:set value="" var="qstnCountAll" />
							<c:set value="" var="qstnCountService" />
							<c:set value="" var="qstnCountPrice" />
							<c:set value="" var="qstnCountOther" />

							<c:set value="${qstnListCount }" var="qstnListCount" />
							<c:forEach items="${qstnListCount }" var="qstnCount">
								<c:if test="${not empty qstnCount.cmntyQstnAllcount }">
									<c:set value="${qstnCount }" var="qstnCountAll" />
								</c:if>
								<c:if test="${qstnCount.comDtlCd eq 'QSTNKND001' }">
									<c:set value="${qstnCount }" var="qstnCountService" />
								</c:if>
								<c:if test="${qstnCount.comDtlCd eq 'QSTNKND002' }">
									<c:set value="${qstnCount }" var="qstnCountPrice" />
								</c:if>
								<c:if test="${qstnCount.comDtlCd eq 'QSTNKND003' }">
									<c:set value="${qstnCount }" var="qstnCountOther" />
								</c:if>
							</c:forEach>

							<div class="card-header pt-9 ps-12">
								<div class="card-title d-flex flex-column">
									<div class="d-flex align-items-center">
										<span
											class="fs-4 fw-semibold text-gray-500 me-2 align-self-start">
											<i class="ki-duotone ki-question-2 fs-2x mt-1"> <span
												class="path1"></span> <span class="path2"></span> <span
												class="path3"></span>
										</i>
										</span> <span class="fs-2x fw-bold text-gray-900 me-2 lh-1 ls-n2">
											<a href="/groubear/cmntyQstnList.do">Q&A 답변 대기</a>
										</span> <a href="/groubear/cmntyQstnList.do?cmntyQstnSttsYn=N"
											class="badge badge-light-danger fs-base ms-3 fs-3">
											${qstnCountAll.cmntyQstnSttsAllN } /
											${qstnCountAll.cmntyQstnAllcount} </a>
									</div>
								</div>
							</div>

							<div class="card-body pt-2 pb-4 d-flex align-items-center">
								<div
									class="d-flex flex-column content-justify-center w-100 ms-2">

									<div class="d-flex fs-3 fw-semibold align-items-center ms-5">
										<div class="bullet w-15px h-7px rounded-2 bg-danger me-3"></div>
										<div class="text-gray-700 flex-grow-1 ms-2">
											<a href="/groubear/cmntyQstnList.do?cmntyType=QSTNKND001">서비스이용</a>
										</div>
										<div class="fw-bolder text-gray-700 fs-2 me-4">
											<span> <a
												href="/groubear/cmntyQstnList.do?cmntyType=QSTNKND001">
													${qstnCountService.cmntyQstnSttsNCount } </a> /
												${qstnCountService.cmntyQstnSttsNCount + qstnCountService.cmntyQstnSttsYCount}
											</span>
											<c:if test="${qstnCountService.cmntyQstnSttsNCount > 0}">
												<span class="ms-2"> <i
													class="ki-duotone ki-information-5 text-danger fs-1"> <span
														class="path1"></span> <span class="path2"></span> <span
														class="path3"></span>
												</i>
												</span>
											</c:if>
											<c:if test="${qstnCountService.cmntyQstnSttsNCount == 0}">
												<span class="ms-10"> </span>
											</c:if>
										</div>
									</div>

									<div
										class="d-flex fs-3 fw-semibold align-items-center my-3 ms-5">
										<div class="bullet w-15px h-7px rounded-2 bg-primary me-3"></div>
										<div class="text-gray-700 flex-grow-1 ms-2">
											<a href="/groubear/cmntyQstnList.do?cmntyType=QSTNKND002">가격</a>
										</div>
										<div class="fw-bolder text-gray-700 fs-2 me-4">
											<span> <a
												href="/groubear/cmntyQstnList.do?cmntyType=QSTNKND002">
													${qstnCountPrice.cmntyQstnSttsNCount } </a> /
												${qstnCountPrice.cmntyQstnSttsNCount + qstnCountPrice.cmntyQstnSttsYCount}
											</span>
											<c:if test="${qstnCountPrice.cmntyQstnSttsNCount > 0}">
												<span class="ms-2"> <i
													class="ki-duotone ki-information-5 text-danger fs-1"> <span
														class="path1"></span> <span class="path2"></span> <span
														class="path3"></span>
												</i>
												</span>
											</c:if>
											<c:if test="${qstnCountPrice.cmntyQstnSttsNCount == 0}">
												<span class="ms-10"> </span>
											</c:if>
										</div>
									</div>

									<div class="d-flex fs-3 fw-semibold align-items-center ms-5">
										<div class="bullet w-15px h-7px rounded-2 bg-success me-3"></div>
										<div class="text-gray-700 flex-grow-1 ms-2">
											<a href="/groubear/cmntyQstnList.do?cmntyType=QSTNKND003">기타</a>
										</div>
										<div class="fw-bolder text-gray-700 fs-2 me-4">
											<span> <a
												href="/groubear/cmntyQstnList.do?cmntyType=QSTNKND003">
													${qstnCountOther.cmntyQstnSttsNCount } </a> /
												${qstnCountOther.cmntyQstnSttsNCount + qstnCountOther.cmntyQstnSttsYCount}
											</span>
											<c:if test="${qstnCountOther.cmntyQstnSttsNCount > 0}">
												<span class="ms-2"> <i
													class="ki-duotone ki-information-5 text-danger fs-1"> <span
														class="path1"></span> <span class="path2"></span> <span
														class="path3"></span>
												</i>
												</span>
											</c:if>
											<c:if test="${qstnCountOther.cmntyQstnSttsNCount == 0}">
												<span class="ms-10"> </span>
											</c:if>
										</div>
									</div>

								</div>
							</div>

						</div>
						<!-- Q&A 위젯 끝 -->

						<div class="card card-flush h-md-50 mb-xl-10">
							<div class="card-header pt-5">
								<div class="card-title d-flex flex-column">
									<div class="d-flex align-items-center">
										<span class="fs-2x fw-bold text-gray-900 me-2 lh-1 ls-n2">이용현황

											<span class="text-gray-500 pt-1 fw-semibold fs-6"
											style="padding-left: 10px; !important">그루베어 가입 기업합계</span>
										</span>
										<!-- 										<span class="badge badge-light-danger fs-base"> <i -->
										<!-- 											class="ki-duotone ki-arrow-down fs-5 text-danger ms-n1"><span -->
										<!-- 												class="path1"></span><span class="path2"></span></i> 2.2% -->
										<!-- 										</span> -->
										<!-- 									<span class="text-gray-500 pt-1 fw-semibold fs-6">그루베어 -->
										<!-- 										가입 기업합계</span> -->
									</div>
								</div>
							</div>

							<div class="card-body d-flex align-items-start pt-0">
								<div class="d-flex align-items-start flex-column mt-3 w-100"
									style="padding-left: 20px;">


									<!--begin::Info-->
									<div class="mb-0">
										<div
											class="fs-lg-2hx fs-1 fw-bold text-black d-flex flex-center">
											<c:set var="companyCount" value="0" />
											<c:forEach var="stat" items="${count}">
												<c:if test="${stat.name == 'CompanyCount'}">
													<c:set var="companyCount" value="${stat.count}" />
												</c:if>
											</c:forEach>
											<div class="bullet w-15px h-7px rounded-2 bg-danger me-3"></div>
											<span class="text-gray-900 pt-1 fw-semibold fs-2"
												style="margin-right: 50px;"> 가입기업 수 </span>
											<div class="fw-bolder text-gray-900 fs-1 me-4"
												data-kt-countup="true"
												data-kt-countup-value="${companyCount}"
												data-kt-countup-suffix="+">${companyCount}</div>
										</div>
									</div>
									<div class="mb-0">
										<div
											class="fs-lg-2hx fs-2x fw-bold text-black d-flex flex-center">
											<c:set var="empCount" value="0" />
											<c:forEach var="stat" items="${count}">
												<c:if test="${stat.name == 'EmpCount'}">
													<c:set var="empCount" value="${stat.count}" />
												</c:if>
											</c:forEach>
											<div class="bullet w-15px h-7px rounded-2 bg-primary me-3"></div>
											<span class="text-gray-900 pt-1 fw-semibold fs-2"
												style="margin-right: 50px;"> 가입회원 수 </span>
											<div class="fw-bolder text-gray-900 fs-1 me-4"
												data-kt-countup="true" data-kt-countup-value="${empCount}"
												data-kt-countup-suffix="+">${empCount}</div>
										</div>
									</div>
									<div class="mb-0">
										<div
											class="fs-lg-2hx fs-2x fw-bold text-black d-flex flex-center">
											<c:set var="communityCount" value="0" />
											<c:forEach var="stat" items="${count}">
												<c:if test="${stat.name == 'CommunityCount'}">
													<c:set var="communityCount" value="${stat.count}" />
												</c:if>
											</c:forEach>
											<div class="bullet w-15px h-7px rounded-2 bg-success me-3"></div>
											<span class="text-gray-900 pt-1 fw-semibold fs-2"
												style="margin-right: 50px;"> 커뮤니티 수 </span>
											<div class="fw-bolder text-gray-900 fs-1 me-4"
												data-kt-countup="true"
												data-kt-countup-value="${communityCount}"
												data-kt-countup-suffix="+">${communityCount}</div>
										</div>
									</div>
									<div class="mb-0">
										<div
											class="fs-lg-2hx fs-2x fw-bold text-black d-flex flex-center">
											<c:set var="logCount" value="0" />
											<c:forEach var="stat" items="${count}">
												<c:if test="${stat.name == 'LogCount'}">
													<c:set var="logCount" value="${stat.count}" />
												</c:if>
											</c:forEach>
											<div class="bullet w-15px h-7px rounded-2 bg-warning me-3"></div>
											<span class="text-gray-900 pt-1 fw-semibold fs-2"
												style="margin-right: 50px;"> 로그생성 수 </span>
											<div class="fw-bolder text-gray-900 fs-1 me-4"
												data-kt-countup="true" data-kt-countup-value="${logCount}"
												data-kt-countup-suffix="+">${logCount}</div>
										</div>
									</div>

									<!--end::Info-->
								</div>
							</div>
						</div>
					</div>



					<!--begin::Col-->
					<div class="col-md-6 col-lg-6 col-xl-12 col-xxl-3 mb-xl-0">
						<!--begin::Card widget 7-->
						<div class="card card-flush h-xl-100">
							<!--begin::Header-->
							<div class="card-header pt-5">
								<!--begin::Title-->
								<div class="card-title d-flex flex-column">
									<!--begin::Amount-->
									<a href="/groubear/map.do"> <span
										class="fs-2x fw-bold text-gray-900 me-2 lh-1 ls-n2 mb-1">기업현황</span>
									</a>
									<!--end::Amount-->

									<!--begin::Subtitle-->
									<span class="text-gray-500 pt-1 fw-semibold fs-">GROUBEAR와
										함께하는 기업</span>
									<!--end::Subtitle-->
								</div>
								<!--end::Title-->
							</div>
							<!--end::Header-->

							<!--begin::Card body-->
							<div
								class="card-body d-flex flex-column justify-content-end pe-0"
								style="padding: 5px; !important">
								<div class="flex-column" id="map"
									style="width: 350px; height: 450px; float: right;">
									<c:forEach items="${mapLocation }" var="mapLo">
										<input type="hidden" class="Latitude" value="${mapLo.lat }" />
										<input type="hidden" class="longitude" value="${mapLo.lot }" />
									</c:forEach>
								</div>
							</div>
							<!--end::Card body-->
						</div>
						<!--end::Card widget 7-->
					</div>
					<!--end::Col-->

					<!--begin::Col-->
					<div class="col-lg-12 col-xl-12 col-xxl-6 mb-5 mb-xl-0">

						<div class="card card-flush h-xl-100">
							<div class="card-header pt-7">
								<h3 class="card-title">
									<span> <i
										class="ki-duotone ki-information-4 fs-2tx me-3"> <span
											class="path1"></span> <span class="path2"></span> <span
											class="path3"></span>
									</i>
									</span> <span class="card-label fw-bold text-gray-900 fs-2x">공지사항</span>
								</h3>

								<div class="card-toolbar">
									<div class="d-flex flex-stack flex-wrap gap-4">
										<button class="btn btn-light btn-lg btn-light-primary"
											onclick="location.href='/groubear/cmntyNoticeList.do'">더보기</button>
									</div>
								</div>
							</div>

							<div class="card-body">
								<!--begin::Table-->
								<div id="kt_table_widget_5_table_wrapper"
									class="dt-container dt-bootstrap5 dt-empty-footer">
									<div id="" class="table-responsive">
										<table
											class="table align-middle table-row-dashed fs-6 gy-3 dataTable"
											id="kt_table_widget_5_table" style="width: 100%;">
											<colgroup>
												<col style="width: 7%;">
												<col style="width: 30%;">
												<col style="width: 10%;">
												<col style="width: 18%;">
												<col style="width: 10%;">
											</colgroup>
											<thead>
												<tr
													class="text-gray-500 fw-bold fs-7 text-uppercase gs-0 text-center">
													<th class="text-center h4">번호</th>
													<th class="text-start h4">제목</th>
													<th class="text-center h4">등록자</th>
													<th class="text-center h4">등록일시</th>
													<th class="text-center h4">조회수</th>
												</tr>
											</thead>

											<tbody class="fw-bold text-gray-600">

												<c:choose>
													<c:when test="${empty cmntyNoticeList }">
														<tr>
															<td colspan="6" class="text-center pt-5">조회하신 게시글이
																존재하지 않습니다.</td>
														</tr>
													</c:when>
													<c:otherwise>
														<c:forEach items="${cmntyNoticeList }" var="cmntyNoticeVO">
															<c:choose>
																<c:when test="${cmntyNoticeVO.cmntyNoticeYn eq 'Y' }">
																	<tr style="height: 3.5em;">
																		<td class="text-center">${cmntyNoticeVO.cmntyNo }</td>
																		<td>
																			<div>
																				<div class="text-start txt_line">
																					<a
																						href="/groubear/cmntyNoticeDetail.do?cmntyNo=${cmntyNoticeVO.cmntyNo }">
																						<font class="fw-bold" style="color: red">[공지]
																					</font> <font class="fw-bold text-gray-800">${cmntyNoticeVO.cmntyTtl }</font>
																					</a>
																				</div>
																			</div>
																		</td>
																		<td>
																			<div class="text-center">${cmntyNoticeVO.empId }</div>
																		</td>
																		<td>
																			<div class="text-center">
																				<c:out
																					value="${fn:substring(cmntyNoticeVO.cmntyRegDt, 0, 10)}" />
																			</div>
																		</td>
																		<td class="text-end text-center">${cmntyNoticeVO.cmntyInqCnt }</td>
																	</tr>
																</c:when>
																<c:otherwise>
																	<tr style="height: 3.5em;">
																		<td class="text-center">${cmntyNoticeVO.cmntyNo }</td>
																		<td>
																			<div>
																				<div class="text-start txt_line">
																					<a
																						href="/groubear/cmntyNoticeDetail.do?cmntyNo=${cmntyNoticeVO.cmntyNo }">
																						<font class="text-gray-800">${cmntyNoticeVO.cmntyTtl }</font>
																					</a>
																				</div>
																			</div>
																		</td>
																		<td>
																			<div class="text-center">${cmntyNoticeVO.empId }</div>
																		</td>
																		<td>
																			<div class="text-center">
																				<c:out
																					value="${fn:substring(cmntyNoticeVO.cmntyRegDt, 0, 10)}" />
																			</div>
																		</td>
																		<td class="text-end text-center">${cmntyNoticeVO.cmntyInqCnt }</td>
																	</tr>
																</c:otherwise>
															</c:choose>
														</c:forEach>
													</c:otherwise>
												</c:choose>

											</tbody>
										</table>
									</div>
								</div>

								<div class="d-flex justify-content-center">
									<button
										class="btn btn-secondary p-0 ki-duotone ki-dots-vertical text-dark"
										onclick="location.href='/groubear/cmntyNoticeList.do'">
										<i class="fw-bold fs-1 p-0"> <span class="path1"></span> <span
											class="path2"></span> <span class="path3"></span>
										</i>
									</button>
								</div>
							</div>
						</div>

					</div>
					<!--end::Col-->
				</div>
				<!--end::Row-->

				<div class="row">
					<!-- 막대형 차트 -->
					<div class="col-md-6">
						<!-- 6열, 총 12열 중 6열을 사용 -->
						<div class="card card-bordered">
							<div class="card-body">
								<div id="kt_apexcharts_1" style="height: 350px;"></div>
							</div>
						</div>
					</div>

					<!-- 라인 차트 -->
					<div class="col-md-6">
						<!-- 6열, 총 12열 중 6열을 사용 -->
						<div class="card card-bordered">
							<div class="card-body">
								<div id="kt_apexcharts_3" style="height: 350px;"></div>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!-- 이 안부터 row넣기 끝 -->
		</div>
	</div>
</div>

<script type="text/javascript"
	src="//dapi.kakao.com/v2/maps/sdk.js?appkey=711db03122284265cef8780056e74af7&libraries=clusterer"></script>

<script type="text/javascript">
$(function() {
	
	// <맵 생성>
	var container = document.getElementById('map');
	var options = {
		center : new kakao.maps.LatLng(36.22756311983172, 127.92564584257092),
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
	
	
	
	
	
	
	
	// 라인차트
    var element = document.getElementById('kt_apexcharts_3');
    var height = parseInt(KTUtil.css(element, 'height'));
    var labelColor = 'black';
    var borderColor = 'black';
    var lightColor = 'skyblue';

    if (!element) {
        return;
    }

    var empMonths = [];
    var empCounts = [];
    var comMonths = [];
    var comCounts = [];

    // 월간 데이터 처리
    <c:if test="${salesMsg eq 'month' }">
        <c:forEach var="emp" items="${monthlyEmp}">
            empMonths.push('${emp.joinMonth}'); // YYYY-MM 형식
            empCounts.push(${emp.employeeCount}); // 사원 수
        </c:forEach>
        <c:forEach var="com" items="${monthlyCom}">
            comMonths.push('${com.comMonth}'); // YYYY-MM 형식
            comCounts.push(${com.companyCount}); // 기업 수 추가
        </c:forEach>
    </c:if>

    // 연간 데이터 처리
    <c:if test="${salesMsg eq 'year' }">
        <c:forEach var="yearEmp" items="${yearlyEmp}">
            empMonths.push('${yearEmp.joinYear}'); // YYYY 형식
            empCounts.push(${yearEmp.employeeCount}); // 사원 수
        </c:forEach>
        <c:forEach var="yearCom" items="${yearlyCom}">
        	comMonths.push('${yearCom.comYear}'); // YYYY-MM 형식
            comCounts.push(${yearCom.companyCount}); // 기업 수 추가
        </c:forEach>
    </c:if>
    
    console.log('Emp Months:', empMonths);
    console.log('Emp Counts:', empCounts);
    console.log('Com Months:', comMonths);
    console.log('Com Counts:', comCounts);
    

 // 현재 날짜를 기준으로 년도와 월 정보를 가져옴
    var currentDate = new Date();
    var currentYear = currentDate.getFullYear(); 
    var currentMonth = currentDate.getMonth() + 1; // 월은 0부터 시작하므로 1을 추가

    var filteredMonths = [];
    var filteredCounts = []; // empCounts를 필터링하여 사용할 배열
    var filteredCompanyCounts = []; // 기업 수 필터링 배열

    if ('${salesMsg}' === 'month') {
        // 월간 데이터 필터링
        for (var i = 1; i <= currentMonth; i++) {
            var monthString = currentYear + '-' + (i < 10 ? '0' + i : i);
            filteredMonths.push(monthString);
            
            var countFound = false;
            for (var j = 0; j < empMonths.length; j++) {
                if (empMonths[j] === monthString) {
                    filteredCounts.push(empCounts[j]);
                    countFound = true;
                    break; // empCounts가 존재하면 루프 종료
                }
            }

            // 기업 수 추가
            if (countFound) {
                var companyCountFound = false; // 기업 수 체크를 위한 변수
                for (var j = 0; j < comMonths.length; j++) {
                    if (comMonths[j] === monthString) {
                        filteredCompanyCounts.push(comCounts[j]); // 기업 수 추가
                        companyCountFound = true; // 기업 수가 존재하면 체크
                        break; // 기업 수가 존재하면 루프 종료
                    }
                }
                if (!companyCountFound) {
                    filteredCompanyCounts.push(0); // 기업 수가 없는 경우 0 추가
                }
            } else {
                filteredCounts.push(0); // 데이터가 없으면 0으로 설정
                filteredCompanyCounts.push(0); // 데이터가 없으면 0으로 설정
            }
        }
    } else {
        // 연간 데이터 필터링
        for (var year = 2020; year <= currentYear; year++) {
            filteredMonths.push(year + '년');
            var countFound = false;

            for (var j = 0; j < empMonths.length; j++) {
                if (empMonths[j] === year.toString()) { // 연도 비교
                    filteredCounts.push(empCounts[j]);
                    countFound = true;
                    break; // empCounts가 존재하면 루프 종료
                }
            }

            // 기업 수 추가
            if (countFound) {
                var companyCountFound = false; // 기업 수 체크를 위한 변수
                for (var j = 0; j < comMonths.length; j++) {
                    if (comMonths[j] === year.toString()) { // 연도 비교
                        filteredCompanyCounts.push(comCounts[j]); // 기업 수 추가
                        companyCountFound = true; // 기업 수가 존재하면 체크
                        break; // 기업 수가 존재하면 루프 종료
                    }
                }
                if (!companyCountFound) {
                    filteredCompanyCounts.push(0); // 기업 수가 없는 경우 0 추가
                }
            } else {
                filteredCounts.push(0); // 해당 연도에 데이터가 없으면 0으로 설정
                filteredCompanyCounts.push(0); // 해당 연도에 데이터가 없으면 0으로 설정
            }
        }
    }


    
    console.log('filteredMonths:', filteredMonths);
    console.log('filteredCounts:', filteredCounts);
    console.log('Filtered Company Counts:', filteredCompanyCounts);
    
    
    var options = {
        series: [{
	            name: '사원수',
	            data: filteredCounts 	// 필터링된 사원 수 데이터 사용
        	},
        	{
                name: '기업수', // 기업 수 시리즈 추가
                data: filteredCompanyCounts // 기업 수 데이터 사용

            }
        ],
        chart: {
            fontFamily: 'inherit',
            type: 'line', 			// 라인 차트
            height: height,
            toolbar: {
                show: false
            },
//             background: '#C0EBA6' // 여기에서 차트 배경색을 설정합니다.
        },
        title: {
            text: '연도별 가입 기업, 사원 수', // 차트 제목
            align: 'center', // 제목 정렬, 'left', 'center', 'right' 중 선택
            style: {
                fontSize: '20px', // 제목 폰트 크기
                fontWeight: 'bold', // 제목 두께
                color: '#000B58' // 제목 색상
            }
        },
        xaxis: {
            categories: filteredMonths, // 필터링된 월 또는 연도 데이터 사용
            axisBorder: {
                show: false,
            },
            axisTicks: {
                show: false
            },
            labels: {
                style: {
                    colors: '#000B58',		// 차트 하단 월 색상
                    fontSize: '12px'
                }
            }
        },
        tooltip: {
        	y: {
                formatter: function(val, { seriesIndex }) {
                    if (seriesIndex === 0) {
                        // 사원 수
                        return val + ' 명'; // 사원 수 표시
                    } else if (seriesIndex === 1) {
                        // 기업 수
                        return val + ' 개'; // 기업 수 표시
                    }
                    return val; // 기본 반환
                }
            }
        },
        colors: ['#789DBC', '#FF5733'],		// 곡선 차트 색상
        
//         fill: {
//             type: 'gradient',          // 채우기 타입 설정 (solid, gradient 등)
//             opacity: 0.5,           // 채우기 투명도 (0~1)
//             colors: ['#D2FF72']     // 채우기 색상
//         },
        grid: {
            borderColor: '#15B392',	// 차트 가로줄 색상
            strokeDashArray: 4,
            yaxis: {
                lines: {
                    show: true
                }
            }
        }
    };

    var chart = new ApexCharts(element, options);
    chart.render();
    

});


$(function() {
    // 막대형 차트
    
    var element = document.getElementById('kt_apexcharts_1');

    if (!element) {
        return;
    }

    var months = [];
    var totalPayments = [];

    <c:if test="${salesMsg eq 'year' }">
        <c:forEach var="yearData" items="${yearlyData}">
            months.push('${yearData.year}년'); // 연도
            totalPayments.push(${yearData.totalPayment}); // 총 결제 금액
        </c:forEach>
    </c:if>

    <c:if test="${salesMsg eq 'month' }">
        <c:forEach var="item" items="${monthlyData}">
            months.push('${item.month}'); // 결제 년월
            totalPayments.push(${item.totalPayment}); // 총 결제 금액
        </c:forEach>
    </c:if>

    console.log('Months:', months);
    console.log('Total Payments:', totalPayments);

    // 현재 날짜를 기준으로 년도와 월 정보를 가져옴
    var currentDate = new Date();
    var currentYear = currentDate.getFullYear();
    var currentMonth = currentDate.getMonth() + 1; // 월은 0부터 시작하므로 1을 추가

    var filteredMonths = [];
    var filteredPayments = [];

    if ('${salesMsg}' === 'month') {
        for (var i = 1; i <= currentMonth; i++) {
            var monthString = currentYear + '-' + (i < 10 ? '0' + i : i);
            filteredMonths.push(monthString);
            
            var paymentFound = false;
            for (var j = 0; j < months.length; j++) {
                if (months[j] === monthString) {
                    filteredPayments.push(totalPayments[j]);
                    paymentFound = true;
                    break;
                }
            }
            
            if (!paymentFound) {
                filteredPayments.push(0);
            }
        }
    } else {
        // 연간일 경우 2020년부터 현재 연도까지 반복하여 필터링
        for (var year = 2020; year <= currentYear; year++) {
            filteredMonths.push(year + '년');
            var paymentFound = false;
            for (var j = 0; j < months.length; j++) {
                if (months[j] === (year + '년')) {
                    filteredPayments.push(totalPayments[j]);
                    paymentFound = true;
                    break;
                }
            }
            if (!paymentFound) {
                filteredPayments.push(0); // 해당 연도에 데이터가 없으면 0으로 설정
            }
        }
    }

    var options = {
        series: [{
            name: '총 결제 금액',
            data: filteredPayments // 총 결제 금액 데이터
        }],
        chart: {
            fontFamily: 'inherit',
            type: 'bar',
            height: element.offsetHeight,
            toolbar: {
                show: false
            }
        },
        title: {
            text: '연도별 총 매출(원)', // 차트 제목
            align: 'center', // 제목 정렬, 'left', 'center', 'right' 중 선택
            style: {
                fontSize: '20px', // 제목 폰트 크기
                fontWeight: 'bold', // 제목 두께
                color: '#000B58' // 제목 색상
            }
        },
        plotOptions: {
            bar: {
                horizontal: false,
                columnWidth: ['30%'],
                endingShape: 'rounded'
            },
        },
        legend: {
            show: false
        },
        dataLabels: {
            enabled: false
        },
        stroke: {
            show: true,
            width: 2,
            colors: ['transparent']
        },
        xaxis: {
            categories: filteredMonths, // 필터링된 결제 년월 데이터
            axisBorder: {
                show: false,
            },
            axisTicks: {
                show: false
            },
            labels: {
                style: {
                    colors: '#000B58',		// 하단 년도 색상
                    fontSize: '12px'
                }
            }
        },
        yaxis: {
            labels: {
                style: {
                    colors: '#000B58', // 값 색상
                    fontSize: '12px'
                },
                formatter: function (value) {
                    return value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","); // 천 단위 콤마 추가
                }
            }
        },

        fill: {
            opacity: 1
        },
        tooltip: {
            style: {
                fontSize: '12px'
            },
            y: {
                formatter: function (val) {
                    return val.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",") + ' 원'; // 천 단위 콤마 추가
                }
            }
        },
        colors: ['#C1CFA1'],			// 차트 막대 색상
        grid: {
            borderColor: '#C9E9D2',		// 차트 가로줄 색상
            strokeDashArray: 4,
            yaxis: {
                lines: {
                    show: true
                }
            }
        }
    };

    var chart = new ApexCharts(element, options);
    chart.render();
});
</script>
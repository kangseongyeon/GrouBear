<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<style>
    .disabled-input {
        background-color: #A6AEBF; /* 어두운 회색 배경 */
        color: #fff; /* 흰색 텍스트 색상 */
    }
</style>



<div style="margin-bottom: 50px;">
	<div style="margin-top: -32px;">
		<div class="separator border-2 my-10"></div>
	</div>
	<div style="margin-left: 30px; margin-top: -100px;">
		<h3>화상채팅</h3>
		<h6>화상채팅</h6>
	</div>
</div>

<div>
	<div class="d-flex flex-column flex-root app-root" id="kt_app_root">
		<div class="app-page flex-column flex-column-fluid" id="kt_app_page">
			<div class="app-main flex-column flex-row-fluid" id="kt_app_main">
				<div class="d-flex flex-column flex-column-fluid">
					<div id="kt_app_content" class="app-content flex-column-fluid">
						<div id="kt_app_content_container"
							class="app-container container-fluid">
							<div class="card card-flush">
								<div style="display: flex; flex-direction: row; justify-content: space-between;">
									<form id="searchForm">
										<input type="hidden" name="page" id="page">
										<div class="card-header align-items-center py-5 gap-2 gap-md-5">
											<div class="card-title">
												<div class="d-flex align-items-center position-relative my-1">
													<i class="ki-duotone ki-magnifier fs-3 position-absolute ms-4">
														<span class="path1"></span> <span class="path2"></span>
													</i> <input id="myInput" name="searchWord" type="text"
														data-kt-ecommerce-product-filter="search"
														class="form-control form-control-solid w-250px ps-12"
														placeholder="검색" value="${searchWord }" />
												</div>
											</div>
										</div>
									</form>
									<div
										style="display: flex; align-items: center; padding-right: 27px">
										<div
											style="display: flex; align-items: center; padding-right: 27px;">
<!-- 											<input type="text" id="createValue" -->
<!-- 												data-kt-ecommerce-product-filter="search" -->
<!-- 												class="form-control form-control-solid w-175px ps-12" -->
<!-- 												placeholder="방이름" /> -->
											<button type="button" data-bs-toggle="modal" data-bs-target="#create" class="btn btn-success">방생성</button>
										</div>
									</div>
								</div>
							</div>
							<div class="card-body pt-5">
								<table
									class="table align-middle table-row-dashed fs-6 gy-5 table-bordered"
									id="kt_ecommerce_products_table">
									<thead>
										<tr
											class="text-start text-gray-500 fw-bold fs-7 text-uppercase gs-0 text-center">
											<th class="min-w-50px h4">번호</th>
											<th class="min-w-150px h4">방이름</th>
											<th class="min-w-100px h4">기업명</th>
											<th class="min-w-100px h4">방장</th>
											<th class="min-w-100px h4">개설시간</th>
											<th class="min-w-100px h4">참여/삭제</th>
										</tr>
									</thead>

									<tbody class="fw-semibold text-gray-600" id="myRoomList">
										<c:set value="${pagingVO.dataList }" var="vcList" />
										<c:choose>
											<c:when test="${empty vcList }">
												<tr>
													<td class="text-center" colspan="8">
													<img src="${pageContext.request.contextPath }/resources/file/image/cloudEmpty.png" class="mw-250px">
									                    <div class="fs-3 fw-bolder text-dark">화상채팅방이 존재하지 않습니다.</div>
													</td>
												</tr>
											</c:when>
											<c:otherwise>
												<c:forEach items="${vcList }" var="item">
													<tr>
														<td><div class="text-center">${item.chatNo }</div></td>
														<td id="videoChatNm"><div class="text-center">${item.videoChatNm }</div></td>
														<td><div class="text-center">${item.coNm}</div></td>
														<td><div class="text-center">${item.videoChatMas } (${item.videoChatId })</div></td>
														<td><div class="text-center">${item.videoChatDate }</div></td>
														<td class="d-flex justify-content-center"><span
															class="btn btn-primary mx-2" id="joinRoom" data-toggle="modal"
															data-target="#joinRoom${item.videoChatNm}">참여</span>
															<button class="btn btn-danger" data-id="${item.chatNo}">삭제</button>
															<!-- data-id 추가 --></td>
													</tr>
												</c:forEach>
											</c:otherwise>
										</c:choose>
									</tbody>
								</table>
							</div>
							<div class="card-footer clearfix" id="pagingArea">${pagingVO.pagingHTML }
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="modal fade" tabindex="-1" id="create">
    <div class="modal-dialog modal-dialog-scrollable" style="margin-left: 50%; margin-top: 10%">
        <div class="modal-content" style="width: 300px;">
            <div class="modal-header">
                <h5 class="modal-title">방 만들기</h5>
                <div class="btn btn-icon btn-sm btn-active-light-primary ms-2" data-bs-dismiss="modal">
                    <i class="ki-duotone ki-cross fs-2x"></i>
                </div>
            </div>
            <div class="modal-body" style="min-height: 250px;">
                <div class="mb-3">
                <label class="fs-6 fw-semibold required mb-2">방이름</label>
					<input type="text" id="createValue"
						data-kt-ecommerce-product-filter="search"
						class="form-control form-control-solid w-175px ps-12"
						placeholder="방이름" />
				</div>
				<div class="mb-3">
                 <label class="fs-6 fw-semibold mb-2">비밀번호</label>
                    <input type="checkbox" id="passwordRequired" > 
                    <label for="passwordRequired" style="margin-left: 8px;">비공개</label>
                    <input type="password" id="roomPassword" class="form-control form-control-solid w-175px ps-12 me-3 disabled-input" placeholder="비밀번호" />
                </div>
            </div>
            <div class="modal-footer" style="height: 100px">
                <button type="button" class="btn btn-primary" id="createBtn">방생성</button>
                <button type="button" class="btn btn-light" data-bs-dismiss="modal">닫기</button>
            </div>
        </div>
    </div>
</div>


<div class="modal fade" tabindex="-1" id="joinRoomModal">
    <div class="modal-dialog modal-dialog-scrollable" style="margin-left: 25%">
        <div class="modal-content" style="width: 400px;">
            <div class="modal-header">
                <h5 class="modal-title">방에 참여하기</h5>
                <div id="roomName"></div>
                <div class="btn btn-icon btn-sm btn-active-light-primary ms-2" data-bs-dismiss="modal">
                    <i class="ki-duotone ki-cross fs-2x"></i>
                </div>
            </div>
            <div class="modal-body">
                <div class="mb-3">
                    <label class="fs-6 fw-semibold required mb-2">비밀번호 입력</label>
                    <input type="password" id="joinRoomPassword" class="form-control form-control-solid" placeholder="비밀번호" />
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-info" id="confirmJoinBtn">참여하기</button>
                <button type="button" class="btn btn-light" data-bs-dismiss="modal">닫기</button>
            </div>
        </div>
    </div>
</div>



<script type="text/javascript">
let rooms = [];

$(function(){
	let searchForm = $('#searchForm');      // 검색 및 페이징 처리 위한 Form
	let pagingArea = $('#pagingArea');		// 페이징 처리 위한 div
	
	// pagingArea 내의 a 태그를 클릭했을 경우의 이벤트 주기
	   pagingArea.on('click', 'a', function(event) {
	      event.preventDefault();
	      let pageNo = $(this).data('page');
	      searchForm.find('#page').val(pageNo);
	      searchForm.submit();
	   });
});


$('#createBtn').on('click', function() {
	 let value = $('#createValue').val().trim(); // 방 이름을 가져오고 양쪽 공백을 제거
	    if (value === "") {
	        // 방 이름이 비어있을 경우 경고창 띄우기
	        Swal.fire({
                icon: 'error',
                title: '방제목을 입력해주세요!',
            }); // 경고 메시지
	        return; // 함수 종료
	    }
	 
	 // 중복 검사
	 console.log(rooms);
	    let isDuplicate = rooms.some(room => room.name === value);
	    if (isDuplicate) {
	        Swal.fire({
	            icon: 'error',
	            title: '이미 존재하는 방 이름입니다.',
	        });
	        return; // 중복일 경우 함수 종료
	    }
	 
	 
	 
	 
	 // 비밀번호가 필요한 경우
	    let passwordRequired = $('#passwordRequired').is(':checked');
	    let videoChatPw = passwordRequired ? $('#roomPassword').val().trim() : null; // 비밀번호
	
	    // 방 정보를 rooms 배열에 저장
	    rooms.push({ name: value, videoChatPw: videoChatPw, passwordRequired: passwordRequired });

	    console.log('현재 방 목록:', rooms); // 확인용 로그
	    
	    var obj = { value: value, videoChatPw: videoChatPw, passwordRequired: passwordRequired };
	    var jsonObj = JSON.stringify(obj);
	    
//     var obj = { value: value };
//     var jsonObj = JSON.stringify(obj);

    console.log(value);

    $.ajax({
        url: "/employee/createroom",
        type: "POST",
        data: jsonObj,
        contentType: "application/json; charset=UTF-8",
        dataType: "json",
        success: function(res) {
            var list = res.data.list;
            console.log(list[1]);

//             for (var i = 0; i < list.length; i++) {
//                 html += "<tr>";
//                 html += "<td>" + (list.length - i) + "</td>";
//                 html += "<td id='videoChatNm' style='display:none'>" + list[i].videoChatNm + "</td>";
//                 html += "<td>" + list[i].roomTitle + "</td>";
//                 html += "<td>" + list[i].endDate + "</td>";
//                 html += "<td><button id='delBtn' class='btn btn-warning'>삭제하기</button></td>";
//                 html += "<td><span class='btn btn-primary' id='modalBtn' data-toggle='modal' data-target='#exampleModalCenter" + list[i].videoChatNm + "'>참여</span></td>";
//                 html += "</tr>";
//             }

//             $('#myRoomList').html('');
//             $('#myRoomList').html(html);
//             $('#createValue').val('');
            alert("방 생성이 완료되었습니다.");
            
            window.location.reload();
        },
        error: function(xhr) {
            alert(xhr.status);
        }
    });
});


$('#passwordRequired').change(function() {
    if ($(this).is(':checked')) {
        // 체크박스가 체크되면 비밀번호 입력 박스를 활성화하고 색상 복원
        $('#roomPassword').prop('disabled', false).removeClass('disabled-input').css({
            'background-color': '',  // 기본 배경색으로 복원
            'color': ''  // 기본 텍스트 색상으로 복원
        });
    } else {
        // 체크박스가 체크 해제되면 비밀번호 입력 박스를 비활성화하고 색상 변경
        $('#roomPassword').prop('disabled', true).val('') // 비밀번호 입력값도 초기화
          .addClass('disabled-input').css({
              'background-color': '#A6AEBF', // 어두운 회색 배경
              'color': '#fff' // 흰색 텍스트 색상
          });
    }
});



    // 방 참여 버튼 클릭 이벤트
    $('#myRoomList').on('click', '.btn-primary', function() {
        // 클릭한 버튼에서 방 ID 가져오기
        var videoChatNm = $(this).closest('tr').find('td#videoChatNm').text().trim();
        $("#roomName").text(videoChatNm);
        console.log('참여하려는 방 이름:', videoChatNm); // 확인용 로그

        console.log(rooms);
     // 방 정보 검색
//         let room = rooms.find(r => r.name === videoChatNm);
     for (var i = 0; i < rooms.length; i++) {
    	 if (videoChatNm == rooms[i].videoChatNm) {
			if(rooms[i].passwordRequired){
				$('#joinRoomModal').modal('show');
			}else{
	            var enterUrl = `http://biz.gooroomee.com/\${videoChatNm}`;
	            window.open(enterUrl, '_blank');				
			}
		}
	}
     
//         console.log('조회된 방:', room); // 확인용 로그
     
//         if (room && room.passwordRequired) {
//             $('#joinRoom').modal('show'); // 비밀번호 입력 모달 보여주기
//         } else {
//             // 방에 바로 참여
//             var enterUrl = `http://biz.gooroomee.com/\${videoChatNm}`;
//             window.open(enterUrl, '_blank');
//         }
    });

    
 // 비밀번호 확인 버튼 클릭 이벤트
    $('#confirmJoinBtn').on('click', function() {
        let inputPassword = $('#joinRoomPassword').val().trim();
        var videoChatNm = $("#roomName").text();

        // 방 정보 검색
//         let room = rooms.find(r => r.name === videoChatNm);
        
	        
	    for (var i = 0; i < rooms.length; i++) {
	    	 if (videoChatNm == rooms[i].videoChatNm) {
		    	 if (rooms[i].videoChatPw == inputPassword) {
		             var enterUrl = `http://biz.gooroomee.com/\${videoChatNm}`;
		             window.open(enterUrl, '_blank');
		             $('#joinRoom').modal('hide'); // 모달 닫기
				}else {
		            Swal.fire({
		                icon: 'error',
		                title: '비밀번호가 틀렸습니다!',
		            });
				}
			}
		}
        
//         if (room && room.videoChatPw  === inputPassword) {
//             // 비밀번호가 맞을 때 방에 참여
//             var enterUrl = `http://biz.gooroomee.com/\${roomName}`;
//             window.open(enterUrl, '_blank');
//             $('#joinRoom').modal('hide'); // 모달 닫기
//         } else {
//             Swal.fire({
//                 icon: 'error',
//                 title: '비밀번호가 틀렸습니다!',
//             });
//         }
    });

    
 // 방 삭제 버튼 클릭 이벤트
    $('#myRoomList').on('click', '.btn-danger', function() {
    var roomId = $(this).data('id'); // 버튼에 저장된 방 ID 가져오기
    var row = $(this).closest('tr'); // 삭제할 행을 가져오기

    // 스왈창을 사용하여 삭제 확인
    Swal.fire({
        title: '화상채팅방을 삭제하시겠습니까?',
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#F06445',
        cancelButtonColor: '#4FC9DA',
        confirmButtonText: '예',
        cancelButtonText: '아니요',
        reverseButtons: false,
    }).then((result) => {
        if (result.isConfirmed) {
            // 사용자가 '예'를 클릭한 경우
            $.ajax({
                url: "/employee/deleteroom/" + roomId, // 삭제 요청 URL
                type: "POST",
                success: function() {
                    row.remove(); // 행 삭제
                    Swal.fire('삭제 완료!', '방이 삭제되었습니다.', 'success'); // 삭제 완료 메시지
                },
                error: function(xhr) {
                    alert("삭제 실패: " + xhr.status); // 실패 메시지 표시
                }
            });
        } else {
            // 사용자가 '아니요'를 클릭한 경우
            Swal.fire('취소됨', '방 삭제가 취소되었습니다.', 'info'); // 취소 메시지
        }
    });
});
 
 
    function getRoomList() {
   	 $.ajax({
   	     url: "/employee/getRoomList", // 방 목록을 가져오는 API 엔드포인트
   	     type: "GET",
   	     dataType: "json",
   	     success: function(res) {
   	    	if (res) {
   	         rooms = res; // 서버에서 받은 방 목록으로 업데이트
   	         console.log('서버에서 가져온 방 목록:', rooms); // 확인용 로그
   	     } else {
   	         console.error("방 목록을 가져오는 데 실패했습니다. 응답:", res);
   	         alert("방 목록을 가져오는 데 실패했습니다.");
   	     }
   	 }
   	 });
   	}

   	//페이지 로딩 시 방 목록 가져오기
   	$(document).ready(function() {
   	 getRoomList();
   	});

</script>

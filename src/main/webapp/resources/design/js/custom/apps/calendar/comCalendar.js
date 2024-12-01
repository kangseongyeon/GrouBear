"use strict";

// Class definition
var KTAppCalendar = function () {
    // Shared variables
    // Calendar variables
    var calendar;
    var data = {
        id: '',
        eventName: '',
        eventDescription: '',
        eventLocation: '',
        startDate: '',
        endDate: '',
        allDay: false
    };

    // Add event variables
    var eventName;
    var eventDescription;
    var eventLocation;
    var startDatepicker;
    var startFlatpickr;
    var endDatepicker;
    var endFlatpickr;
    var startTimepicker;
    var startTimeFlatpickr;
    var endTimepicker
    var endTimeFlatpickr;
    var modal;
    var modalTitle;
    var form;
    var validator;
    var addButton;
    var submitButton;
    var cancelButton;
    var closeButton;

    // View event variables
    var viewEventName;
    var viewAllDay;
    var viewEventDescription;
    var viewEventLocation;
    var viewStartDate;
    var viewEndDate;
    var viewModal;
    var viewEditButton;
    var viewDeleteButton;


    // Private functions
    var initCalendarApp = function () {
        // Define variables
        var calendarEl = document.getElementById('kt_calendar_app');
        var todayDate = moment().startOf('day');
        var YM = todayDate.format('YYYY-MM');
        var YESTERDAY = todayDate.clone().subtract(1, 'day').format('YYYY-MM-DD');
        var TODAY = todayDate.format('YYYY-MM-DD');
        var TOMORROW = todayDate.clone().add(1, 'day').format('YYYY-MM-DD');

        // Init calendar --- more info: https://fullcalendar.io/docs/initialize-globals
        calendar = new FullCalendar.Calendar(calendarEl, {
            //locale: 'es', // Set local --- more info: https://fullcalendar.io/docs/locale
            headerToolbar: {
                left: 'prev,next today',
                center: 'title',
                right: 'dayGridMonth,timeGridWeek,timeGridDay'
            },
            locale: "ko",
            buttonText : {
            	today : '오늘',
            	month : '월',
            	week : '주',
            	day : '일',
            	list : '목록'
            },
            
            initialDate: TODAY,
            navLinks: true, // can click day/week names to navigate views
            selectable: true,
            selectMirror: true,

            // Select dates action --- more info: https://fullcalendar.io/docs/select-callback
            select: function (arg) {
            
            	startFlatpickr.setDate(arg.start, true, "Y-m-d");
            	endFlatpickr.setDate(arg.end, true, "Y-m-d");
                formatArgs(arg);
                handleNewEvent();
            },

            // Click event --- more info: https://fullcalendar.io/docs/eventClick
            eventClick: function (arg) {
                formatArgs({
                    id: arg.event.id,
                    title: arg.event.title,
                    description: arg.event.extendedProps.description,
                    location: arg.event.extendedProps.location,
                    //startStr: arg.event.startStr,
                    //endStr: arg.event.endStr,
                    
                    startStr: moment(arg.event.start).format('YYYY-MM-DDTHH:mm'),
        			endStr: moment(arg.event.end).format('YYYY-MM-DDTHH:mm'),
                    allDay: arg.event.allDay
                });
                
                handleViewEvent();
            },
			// Inside eventClick function

            editable: true,
            dayMaxEvents: true, // allow "more" link when too many events
            events: '/company/calendarList.do',

            // Handle changing calendar views --- more info: https://fullcalendar.io/docs/datesSet
            datesSet: function(){
                // do some stuff
            },
            
            // 일정 드래그 시 날짜 업데이트
		    eventDrop: function (info) {
		        var updatedEvent = {
			        calendarNo: info.event.id,
			        calendarDt: moment(info.event.start).format('YYYY-MM-DD'),
			        calendarEndDt: info.event.end ? moment(info.event.end).format('YYYY-MM-DD') : moment(info.event.start).format('YYYY-MM-DD')
			    };
		
		        $.ajax({
		            url: '/company/updateCalendarDate.do',
		            type: 'POST',
		            data: JSON.stringify(updatedEvent),
		            contentType: 'application/json',
		            success: function (response) {
		                if (response === 'OK') {
		                    Swal.fire({
		                        text: "일정이 성공적으로 업데이트되었습니다.",
		                        icon: "success",
		                        confirmButtonText: "확인"
		                    });
		                } else {
		                    Swal.fire({
		                        text: "업데이트 중 문제가 발생했습니다. 다시 시도해주세요.",
		                        icon: "error",
		                        confirmButtonText: "확인"
		                    });
		                }
		            },
		            error: function () {
		                Swal.fire({
		                    text: "서버 오류로 업데이트에 실패했습니다. 다시 시도해주세요.",
		                    icon: "error",
		                    confirmButtonText: "확인"
		                });
		            }
		        });
		    }
		});

        calendar.render();
    };

    // Init validator
    const initValidator = () => {
        // Init form validation rules. For more info check the FormValidation plugin's official documentation:https://formvalidation.io/
        validator = FormValidation.formValidation(
            form,
            {
                fields: {
                    'calendar_event_name': {
                        validators: {
                            notEmpty: {
                                message: '일정명을 입력해주세요'
                            }
                        }
                    },
                    'calendar_event_start_date': {
                        validators: {
                            notEmpty: {
                                message: '일정 시작일을 입력해주세요'
                            }
                        }
                    },
                    'calendar_event_end_date': {
                        validators: {
                            notEmpty: {
                                message: '일정 종료일을 입력해주세요'
                            }
                        }
                    }
                },

                plugins: {
                    trigger: new FormValidation.plugins.Trigger(),
                    bootstrap: new FormValidation.plugins.Bootstrap5({
                        rowSelector: '.fv-row',
                        eleInvalidClass: '',
                        eleValidClass: ''
                    })
                }
            }
        );
    }

    // Initialize datepickers --- more info: https://flatpickr.js.org/
    const initDatepickers = () => {
        startFlatpickr = flatpickr(startDatepicker, {
            enableTime: false,
            dateFormat: "Y-m-d",
        });

        endFlatpickr = flatpickr(endDatepicker, {
            enableTime: false,
            dateFormat: "Y-m-d",
        });

        startTimeFlatpickr = flatpickr(startTimepicker, {
            enableTime: true,
            noCalendar: true,
            dateFormat: "H:i",
        });

        endTimeFlatpickr = flatpickr(endTimepicker, {
            enableTime: true,
            noCalendar: true,
            dateFormat: "H:i",
        });
    }

    // Handle add button
    const handleAddButton = () => {
        addButton.addEventListener('click', e => {
            // Reset form data
            data = {
                id: '',
                eventName: '',
                eventDescription: '',
                startDate: new Date(),
                endDate: new Date(),
                allDay: false
            };
            handleNewEvent();
        });
    }

    // Handle add new event
    // 일정 추가
    const handleNewEvent = () => {
        // Update modal title
        modalTitle.innerText = "일정 추가";

        modal.show();

        // Select datepicker wrapper elements
        const datepickerWrappers = form.querySelectorAll('[data-kt-calendar="datepicker"]');

        // Handle all day toggle
        const allDayToggle = form.querySelector('#kt_calendar_datepicker_allday');
        allDayToggle.addEventListener('click', e => {
            if (e.target.checked) {
                datepickerWrappers.forEach(dw => {
                    dw.classList.add('d-none');
                });
            } else {
                endFlatpickr.setDate(data.startDate, true, 'Y-m-d');
                datepickerWrappers.forEach(dw => {
                    dw.classList.remove('d-none');
                });
            }
        });

        populateForm(data);

        // Handle submit form
        /*
        submitButton.addEventListener('click', function (e) {
            // Prevent default button action
            e.preventDefault();

            // Validate form before submit
            if (validator) {
                validator.validate().then(function (status) {

                    if (status == 'Valid') {
                        // Show loading indication
                        submitButton.setAttribute('data-kt-indicator', 'on');

                        // Disable submit button whilst loading
                        submitButton.disabled = true;

                        // Simulate form submission
                        setTimeout(function () {
                        	
                            // Simulate form submission
                            submitButton.removeAttribute('data-kt-indicator');
                            

                            // Show popup confirmation 
                            Swal.fire({
                                text: "일정이 성공적으로 추가되었습니다!",
                                icon: "success",
                                buttonsStyling: false,
                                confirmButtonText: "확인!",
                                customClass: {
                                    confirmButton: "btn btn-primary"
                                }
                            }).then(function (result) {
                                if (result.isConfirmed) {
                                    modal.hide();
                                    
                                    // Enable submit button after loading
                                    submitButton.disabled = false;

                                    // Detect if is all day event
                                    let allDayEvent = false;
                                    if (allDayToggle.checked) { allDayEvent = true; }
                                    if (startTimeFlatpickr.selectedDates.length === 0) { allDayEvent = true; }

                                    // Merge date & time
                                    var startDateTime = moment(startFlatpickr.selectedDates[0]).format();
                                    var endDateTime = moment(endFlatpickr.selectedDates[endFlatpickr.selectedDates.length - 1]).format();
                                    if (!allDayEvent) {
                                        const startDate = moment(startFlatpickr.selectedDates[0]).format('YYYY-MM-DD');
                                        const endDate = startDate;
                                        const startTime = moment(startTimeFlatpickr.selectedDates[0]).format('HH:mm:ss');
                                        const endTime = moment(endTimeFlatpickr.selectedDates[0]).format('HH:mm:ss');

                                        startDateTime = startDate + 'T' + startTime;
                                        endDateTime = endDate + 'T' + endTime;
                                    }

                                    // Add new event to calendar
                                    calendar.addEvent({
                                        id: uid(),
                                        title: eventName.value,
                                        description: eventDescription.value,
                                        location: eventLocation.value,
                                        start: startDateTime,
                                        end: endDateTime,
                                        allDay: allDayEvent
                                    });
                                    calendar.render();

                                    // Reset form for demo purposes only
                                    // form.reset();
                                }
                            });

                            form.submit(); // Submit form
                        }, 2000);
                    } else {
                        // Show popup warning 
                        Swal.fire({
                            text: "필수 항목을 입력해주세요!",
                            icon: "error",
                            buttonsStyling: false,
                            confirmButtonText: "확인",
                            customClass: {
                                confirmButton: "btn btn-primary"
                            }
                        });
                    }
                });
            }
        });
        */
        
        // 저장 버튼 클릭 시 이벤트 핸들러
		submitButton.addEventListener('click', function (e) {
		    // 기본 버튼 동작 방지
		    e.preventDefault();
		
		    // 폼 유효성 검사
		    if (validator) {
		        validator.validate().then(function (status) {
		            if (status === 'Valid') {
		                // 버튼 로딩 상태로 변경
		                submitButton.setAttribute('data-kt-indicator', 'on');
		                submitButton.disabled = true;
		
		                // allDay 여부에 따라 시작, 종료 날짜/시간 설정
		                // Detect if is all day event
                        let allDayEvent = false;
                        if (allDayToggle.checked) { allDayEvent = true; }
                        if (startTimeFlatpickr.selectedDates.length === 0) { allDayEvent = true; }

                        // Merge date & time
                        var startDateTime = moment(startFlatpickr.selectedDates[0]).format();
                        var endDateTime = moment(endFlatpickr.selectedDates[endFlatpickr.selectedDates.length - 1]).format();
                        if (!allDayEvent) {
                            const startDate = moment(startFlatpickr.selectedDates[0]).format('YYYY-MM-DD');
                            const endDate = startDate;
                            const startTime = moment(startTimeFlatpickr.selectedDates[0]).format('HH:mm:ss');
                            const endTime = moment(endTimeFlatpickr.selectedDates[0]).format('HH:mm:ss');

                            startDateTime = startDate + 'T' + startTime;
                            endDateTime = endDate + 'T' + endTime;
                        }
		                
		                /*
		                let allDayEvent = document.querySelector('#kt_calendar_datepicker_allday').checked;
		                let startDateTime, endDateTime;
		
		                if (allDayEvent) {
		                    startDateTime = moment(startFlatpickr.selectedDates[0]).format('YYYY-MM-DD');
		                    endDateTime = moment(endFlatpickr.selectedDates[0]).format('YYYY-MM-DD');
		                } else {
		                    startDateTime = moment(startFlatpickr.selectedDates[0]).format('YYYY-MM-DD') + ' ' + moment(startTimeFlatpickr.selectedDates[0]).format('HH:mm:ss');
		                    endDateTime = moment(endFlatpickr.selectedDates[0]).format('YYYY-MM-DD') + ' ' + moment(endTimeFlatpickr.selectedDates[0]).format('HH:mm:ss');
		                }
						*/		
		
		                // AJAX 요청을 사용해 서버에 데이터 전송
		                $.ajax({
		                    url: '/company/calInsert.do', // 서버 엔드포인트
		                    type: 'POST',
		                    data: JSON.stringify({
		                    /*
		                        calendarNm: eventName.value,
		                        calendarCn: eventDescription.value,
		                        calendarDaddr: eventLocation.value,
		                        calendarDt: startDateTime,
		                        calendarEndDt: endDateTime,
		                        empId: data.empId // 필요한 경우 추가 데이터 전달
		                    */
			                    calendarNm: document.getElementById('calendarNm').value,
						        calendarCn: document.getElementById('calendarCn').value,
						        calendarDaddr: document.getElementById('calendarDaddr').value,
						        calendarDt: moment(startFlatpickr.selectedDates[0]).format('YYYY-MM-DD'),
						        calendarEndDt: moment(endFlatpickr.selectedDates[0]).format('YYYY-MM-DD'),
						        calendarStartTime: moment(startTimeFlatpickr.selectedDates[0]).format('HH:mm:ss'),
						        calendarEndTime: moment(endTimeFlatpickr.selectedDates[0]).format('HH:mm:ss'),
						        empId: data.empId
		                    
		                    }),
		                    contentType: 'application/json',
		                    success: function (response) {
		                        if (response === 'OK') {
		                            // 모달 닫기 및 성공 메시지 표시
		                            Swal.fire({
		                                text: "일정이 성공적으로 추가되었습니다!",
		                                icon: "success",
		                                buttonsStyling: false,
		                                confirmButtonText: "확인",
		                                customClass: {
				                            confirmButton: "btn btn-primary"
				                        }
		                            }).then(function () {
		                                modal.hide();
		                                submitButton.disabled = false;
		                                submitButton.removeAttribute('data-kt-indicator');
		                                
		                                // 캘린더에 이벤트 추가
		                                calendar.addEvent({
		                                    /*
		                                    id: uid(),
		                                    title: eventName.value,
		                                    description: eventDescription.value,
		                                    location: eventLocation.value,
		                                    start: startDateTime,
		                                    end: endDateTime,
		                                    allDay: allDayEvent
		                                    */
		                                    
		                                    id: uid(),
						                    title: document.getElementById('calendarNm').value,
						                    description: document.getElementById('calendarCn').value,
						                    location: document.getElementById('calendarDaddr').value,
						                    start: moment(startFlatpickr.selectedDates[0]).format('YYYY-MM-DDTHH:mm:ss'),
						                    end: moment(endFlatpickr.selectedDates[0]).format('YYYY-MM-DDTHH:mm:ss'),
						                    allDay: allDayToggle.checked
		                                    
		                                });
		                            });
		                        } else {
		                            Swal.fire({
		                                text: "서버에 문제가 발생했습니다. 다시 시도해주세요.",
		                                icon: "error",
		                                confirmButtonText: "확인"
		                            });
		                            submitButton.disabled = false;
		                            submitButton.removeAttribute('data-kt-indicator');
		                        }
		                    },
		                    error: function () {
		                        Swal.fire({
		                            text: "서버 연결 오류가 발생했습니다. 다시 시도해주세요.",
		                            icon: "error",
		                            confirmButtonText: "확인"
		                        });
		                        submitButton.disabled = false;
		                        submitButton.removeAttribute('data-kt-indicator');
		                    }
		                });
		            } else {
		                // 유효성 검사 실패 시 경고 메시지 표시
		                Swal.fire({
		                    text: "필수 항목을 입력해주세요!",
		                    icon: "error",
		                    confirmButtonText: "확인"
		                });
		            }
		        });
		    }
		});
		        
    }

    // Handle edit event
    // 일정 수정
    /*
    const handleEditEvent = () => {
        // Update modal title
        modalTitle.innerText = "일정 수정";

        modal.show();

        // Select datepicker wrapper elements
        const datepickerWrappers = form.querySelectorAll('[data-kt-calendar="datepicker"]');

        // Handle all day toggle
        const allDayToggle = form.querySelector('#kt_calendar_datepicker_allday');
        allDayToggle.addEventListener('click', e => {
            if (e.target.checked) {
                datepickerWrappers.forEach(dw => {
                    dw.classList.add('d-none');
                });
            } else {
                endFlatpickr.setDate(data.startDate, true, 'Y-m-d');
                datepickerWrappers.forEach(dw => {
                    dw.classList.remove('d-none');
                });
            }
        });

        populateForm(data);

        // Handle submit form
        submitButton.addEventListener('click', function (e) {
            // Prevent default button action
            e.preventDefault();

            // Validate form before submit
            if (validator) {
                validator.validate().then(function (status) {
                    console.log('validated!');

                    if (status == 'Valid') {
                        // Show loading indication
                        submitButton.setAttribute('data-kt-indicator', 'on');

                        // Disable submit button whilst loading
                        submitButton.disabled = true;

                        // Simulate form submission
                        setTimeout(function () {
                            // Simulate form submission
                            submitButton.removeAttribute('data-kt-indicator');

                            // Show popup confirmation 
                            Swal.fire({
                                text: "New event added to calendar!",
                                icon: "success",
                                buttonsStyling: false,
                                confirmButtonText: "Ok, got it!",
                                customClass: {
                                    confirmButton: "btn btn-primary"
                                }
                            }).then(function (result) {
                                if (result.isConfirmed) {
                                    modal.hide();

                                    // Enable submit button after loading
                                    submitButton.disabled = false;

                                    // Remove old event
                                    calendar.getEventById(data.id).remove();

                                    // Detect if is all day event
                                    let allDayEvent = false;
                                    if (allDayToggle.checked) { allDayEvent = true; }
                                    if (startTimeFlatpickr.selectedDates.length === 0) { allDayEvent = true; }

                                    // Merge date & time
                                    var startDateTime = moment(startFlatpickr.selectedDates[0]).format();
                                    var endDateTime = moment(endFlatpickr.selectedDates[endFlatpickr.selectedDates.length - 1]).format();
                                    if (!allDayEvent) {
                                        const startDate = moment(startFlatpickr.selectedDates[0]).format('YYYY-MM-DD');
                                        const endDate = startDate;
                                        const startTime = moment(startTimeFlatpickr.selectedDates[0]).format('HH:mm:ss');
                                        const endTime = moment(endTimeFlatpickr.selectedDates[0]).format('HH:mm:ss');

                                        startDateTime = startDate + 'T' + startTime;
                                        endDateTime = endDate + 'T' + endTime;
                                    }

                                    // Add new event to calendar
                                    calendar.addEvent({
                                        id: uid(),
                                        title: eventName.value,
                                        description: eventDescription.value,
                                        location: eventLocation.value,
                                        start: startDateTime,
                                        end: endDateTime,
                                        allDay: allDayEvent
                                    });
                                    calendar.render();

                                    // Reset form for demo purposes only
                                    form.reset();
                                }
                            });

                            //form.submit(); // Submit form
                        }, 2000);
                    } else {
                        // Show popup warning 
                        Swal.fire({
                            text: "Sorry, looks like there are some errors detected, please try again.",
                            icon: "error",
                            buttonsStyling: false,
                            confirmButtonText: "Ok, got it!",
                            customClass: {
                                confirmButton: "btn btn-primary"
                            }
                        });
                    }
                });
            }
        });
    }
    */
    
    // KTAppCalendar 함수 내부

// 수정 버튼 핸들러
// AJAX 요청으로 수정할 일정 데이터 가져오기
const handleEditButton = () => {
    viewEditButton.addEventListener('click', (e) => {
        e.preventDefault();

        viewModal.hide();

        $.ajax({
            url: '/company/calendarUpdate.do',
            type: 'GET',
            data: { calendarNo: data.id },
            success: function(response) {
                if (response) {
                    data.calendarNm = response.calendarNm;
                    data.calendarCn = response.calendarCn;
                    data.calendarDaddr = response.calendarDaddr;
                    data.calendarDt = response.calendarDt;
                    data.calendarEndDt = response.calendarEndDt;
                    data.allDay = response.calendarAlldayYn === "Y";

                    populateForm(data);
                    modal.show();  // 모달 표시
                } else {
                    Swal.fire({
                        text: "일정을 불러오는 데 실패했습니다.",
                        icon: "error",
                        confirmButtonText: "확인"
                    });
                }
            },
            error: function() {
                Swal.fire({
                    text: "서버 오류로 일정을 불러오지 못했습니다.",
                    icon: "error",
                    confirmButtonText: "확인"
                });
            }
        });
    });
};



// 수정 모달 표시 및 폼 채우기
const handleEditEvent = () => {
    // 모달 제목 변경
    modalTitle.innerText = "일정 수정";
    modal.show();

    // 폼에 데이터 반영
    populateForm(data);

    // 제출 버튼 핸들러 추가
    submitButton.addEventListener('click', function (e) {
        e.preventDefault();
        
        // 폼 유효성 검사 후 제출
        if (validator) {
            validator.validate().then(function (status) {
                if (status === 'Valid') {
                    // 서버로 수정 데이터 전송
                    $.ajax({
                        url: '/company/calendarUpdate.do',
                        type: 'POST',
                        data: JSON.stringify({
                            calendarNo: data.id,
                            calendarNm: document.getElementById('calendarNm').value,
                            calendarCn: document.getElementById('calendarCn').value,
                            calendarDaddr: document.getElementById('calendarDaddr').value,
                            calendarDt: startFlatpickr.selectedDates[0],
                            calendarEndDt: endFlatpickr.selectedDates[0],
                            allDay: allDayToggle.checked
                        }),
                        contentType: 'application/json',
                        success: function(response) {
                            if (response === 'OK') {
                                Swal.fire({
                                    text: "일정이 성공적으로 수정되었습니다!",
                                    icon: "success",
                                    confirmButtonText: "확인"
                                }).then(function() {
                                    modal.hide();
                                    calendar.getEventById(data.id).remove();
                                    calendar.addEvent({
                                        id: data.id,
                                        title: document.getElementById('calendarNm').value,
                                        description: document.getElementById('calendarCn').value,
                                        location: document.getElementById('calendarDaddr').value,
                                        start: startFlatpickr.selectedDates[0],
                                        end: endFlatpickr.selectedDates[0],
                                        allDay: allDayToggle.checked
                                    });
                                });
                            } else {
                                Swal.fire({
                                    text: "수정 중 문제가 발생했습니다. 다시 시도해주세요.",
                                    icon: "error",
                                    confirmButtonText: "확인"
                                });
                            }
                        },
                        error: function() {
                            Swal.fire({
                                text: "서버 오류로 수정에 실패했습니다.",
                                icon: "error",
                                confirmButtonText: "확인"
                            });
                        }
                    });
                }
            });
        }
    });
};

    

    // Handle view event
    // 일정 상세보기
    const handleViewEvent = () => {
        viewModal.show();

        // Detect all day event
        var eventNameMod;
        var startDateMod;
        var endDateMod;

        // Generate labels
        // 시간 표시
		if (data.allDay) {
		    eventNameMod = 'All Day';
		    startDateMod = moment(data.startDate).format('YYYY년 MM월 DD일');
		    endDateMod = moment(data.endDate).format('YYYY년 MM월 DD일');
		} else {
		    eventNameMod = '';
		    startDateMod = moment(data.startDate).format('YYYY년 MM월 DD일 - A h:mm');
		    endDateMod = moment(data.endDate).format('YYYY년 MM월 DD일 - A h:mm');
		}
				
        // Populate view data
        viewEventName.innerText = data.eventName;
        viewAllDay.innerText = eventNameMod;
        viewEventDescription.innerText = data.eventDescription ? data.eventDescription : '--';
        viewEventLocation.innerText = data.eventLocation ? data.eventLocation : '--';
        viewStartDate.innerText = startDateMod;
        viewEndDate.innerText = endDateMod;
    }

    // Handle delete event
    // 캘린더 일정 삭제
	const handleDeleteEvent = () => {
	    viewDeleteButton.addEventListener('click', e => {
	        e.preventDefault();
	
	        Swal.fire({
	            text: "일정을 삭제하시겠습니까?",
	            icon: "warning",
	            showCancelButton: true,
	            buttonsStyling: false,
	            confirmButtonText: "네",
	            cancelButtonText: "아니요",
	            customClass: {
	                confirmButton: "btn btn-primary",
	                cancelButton: "btn btn-active-light"
	            }
	        }).then(function (result) {
	            if (result.isConfirmed) {
	                $.ajax({
	                    url: '/company/calendarDelete.do',
	                    type: 'POST',
	                    data: {
	                        calendarNo: data.id
	                    },
	                    success: function (response) {
	                        if (response === 'OK') {
	                            calendar.getEventById(data.id).remove();
	                            viewModal.hide();
	                            Swal.fire({
	                                text: "삭제가 완료되었습니다.",
	                                icon: "success",
	                                confirmButtonText: "확인",
	                                customClass: {
	                                    confirmButton: "btn btn-primary"
	                                }
	                            });
	                        } else {
	                            Swal.fire({
	                                text: "서버 오류로 삭제에 실패했습니다12. 다시 시도해주세요.",
	                                icon: "error",
	                                confirmButtonText: "확인",
	                                customClass: {
	                                    confirmButton: "btn btn-primary"
	                                }
	                            });
	                        }
	                    },
	                    error: function () {
	                        Swal.fire({
	                            text: "서버 오류로 삭제에 실패했습니다. 다시 시도해주세요.",
	                            icon: "error",
	                            confirmButtonText: "확인",
	                            customClass: {
	                                confirmButton: "btn btn-primary"
	                            }
	                        });
	                    }
	                });
	            } else if (result.dismiss === 'cancel') {
	                Swal.fire({
	                    text: "일정이 삭제되지 않았습니다",
	                    icon: "error",
	                    buttonsStyling: false,
	                    confirmButtonText: "확인",
	                    customClass: {
	                        confirmButton: "btn btn-primary"
	                    }
	                });
	            }
	        });
	    });
	};


    // Handle edit button
    // 일정 수정 버튼
    /*
    const handleEditButton = () => {
        viewEditButton.addEventListener('click', e => {
            e.preventDefault();

            viewModal.hide();
            handleEditEvent();
        });
    }
	*/

    // Handle cancel button
    // 일정 작성 취소 버튼
    const handleCancelButton = () => {
        // Edit event modal cancel button
        cancelButton.addEventListener('click', function (e) {
            e.preventDefault();

            Swal.fire({
                text: "작성을 취소하시겠습니까?",
                icon: "warning",
                showCancelButton: true,
                buttonsStyling: false,
                confirmButtonText: "네",
                cancelButtonText: "아니요",
                customClass: {
                    confirmButton: "btn btn-primary",
                    cancelButton: "btn btn-active-light"
                }
            }).then(function (result) {
                if (result.value) {
                    form.reset(); // Reset form	
                    modal.hide(); // Hide modal				
                } else if (result.dismiss === 'cancel') {
                    Swal.fire({
                        text: "작성이 취소되지 않았습니다.",
                        icon: "error",
                        buttonsStyling: false,
                        confirmButtonText: "확인",
                        customClass: {
                            confirmButton: "btn btn-primary",
                        }
                    });
                }
            });
        });
    }

    // Handle close button
    // 일정 취소 버튼
    const handleCloseButton = () => {
        // Edit event modal close button
        closeButton.addEventListener('click', function (e) {
            e.preventDefault();

            Swal.fire({
                text: "작성을 취소하시겠습니까?",
                icon: "warning",
                showCancelButton: true,
                buttonsStyling: false,
                confirmButtonText: "네",
                cancelButtonText: "아니요",
                customClass: {
                    confirmButton: "btn btn-primary",
                    cancelButton: "btn btn-active-light"
                }
            }).then(function (result) {
                if (result.value) {
                    form.reset(); // Reset form	
                    modal.hide(); // Hide modal				
                } else if (result.dismiss === 'cancel') {
                    Swal.fire({
                        text: "작성이 취소되지 않았습니다.",
                        icon: "error",
                        buttonsStyling: false,
                        confirmButtonText: "확인",
                        customClass: {
                            confirmButton: "btn btn-primary",
                        }
                    });
                }
            });
        });
    }

    // Handle view button
    const handleViewButton = () => {
        const viewButton = document.querySelector('#kt_calendar_event_view_button');
        viewButton.addEventListener('click', e => {
            e.preventDefault();

            hidePopovers();
            handleViewEvent();
        });
    }

    // Helper functions

    // Reset form validator on modal close
    const resetFormValidator = (element) => {
        // Target modal hidden event --- For more info: https://getbootstrap.com/docs/5.0/components/modal/#events
        element.addEventListener('hidden.bs.modal', e => {
            if (validator) {
                // Reset form validator. For more info: https://formvalidation.io/guide/api/reset-form
                validator.resetForm(true);
            }
        });
    }

    // Populate form 
    /*
    const populateForm = () => {
        eventName.value = data.eventName ? data.eventName : '';
        eventDescription.value = data.eventDescription ? data.eventDescription : '';
        eventLocation.value = data.eventLocation ? data.eventLocation : '';
        startFlatpickr.setDate(data.startDate, true, 'Y-m-d');

        // Handle null end dates
        const endDate = data.endDate ? data.endDate : moment(data.startDate).format();
        endFlatpickr.setDate(endDate, true, 'Y-m-d');

        const allDayToggle = form.querySelector('#kt_calendar_datepicker_allday');
        const datepickerWrappers = form.querySelectorAll('[data-kt-calendar="datepicker"]');
        if (data.allDay) {
            allDayToggle.checked = true;
            datepickerWrappers.forEach(dw => {
                dw.classList.add('d-none');
            });
        } else {
            startTimeFlatpickr.setDate(data.startDate, true, 'Y-m-d H:i');
            endTimeFlatpickr.setDate(data.endDate, true, 'Y-m-d H:i');
            endFlatpickr.setDate(data.startDate, true, 'Y-m-d');
            allDayToggle.checked = false;
            datepickerWrappers.forEach(dw => {
                dw.classList.remove('d-none');
            });
        }
    }
	*/
	
	const populateForm = (data) => {
	    document.getElementById('calendarNm').value = data.calendarNm ? data.calendarNm : '';
	    document.getElementById('calendarCn').value = data.calendarCn ? data.calendarCn : '';
	    document.getElementById('calendarDaddr').value = data.calendarDaddr ? data.calendarDaddr : '';
	    startFlatpickr.setDate(data.calendarDt, true, 'Y-m-d');
	    endFlatpickr.setDate(data.calendarEndDt, true, 'Y-m-d');
	    // 시간 정보도 필요 시 설정
	    startTimeFlatpickr.setDate(data.calendarDt, true, 'Y-m-d H:i');
	    endTimeFlatpickr.setDate(data.calendarEndDt, true, 'Y-m-d H:i');
	};
	

    // Format FullCalendar reponses
    const formatArgs = (res) => {
        data.id = res.id;
        data.eventName = res.title;
        data.eventDescription = res.description;
        data.eventLocation = res.location;
        // data.startDate = res.startStr;
        // data.endDate = res.endStr;
        
      	// 시작 날짜 및 시간 포함 (ISO 8601 형식으로 변환)
	    data.startDate = moment(res.startStr).format('YYYY-MM-DDTHH:mm');
	
	    // 종료 날짜 및 시간 포함 (ISO 8601 형식으로 변환, 없을 경우 시작 시간과 동일하게 설정)
	    data.endDate = res.endStr ? moment(res.endStr).format('YYYY-MM-DDTHH:mm') : data.startDate;
	        
        data.allDay = res.allDay;
    }

    // Generate unique IDs for events
    const uid = () => {
        return Date.now().toString() + Math.floor(Math.random() * 1000).toString();
    }

    return {
        // Public Functions
        init: function () {
            // Define variables
            // Add event modal
            const element = document.getElementById('kt_modal_add_event');
            form = element.querySelector('#kt_modal_add_event_form');
            eventName = form.querySelector('[name="calendar_event_name"]');
            eventDescription = form.querySelector('[name="calendar_event_description"]');
            eventLocation = form.querySelector('[name="calendar_event_location"]');
            startDatepicker = form.querySelector('#kt_calendar_datepicker_start_date');
            endDatepicker = form.querySelector('#kt_calendar_datepicker_end_date');
            startTimepicker = form.querySelector('#kt_calendar_datepicker_start_time');
            endTimepicker = form.querySelector('#kt_calendar_datepicker_end_time');
            addButton = document.querySelector('[data-kt-calendar="add"]');
            submitButton = form.querySelector('#kt_modal_add_event_submit');
            cancelButton = form.querySelector('#kt_modal_add_event_cancel');
            closeButton = element.querySelector('#kt_modal_add_event_close');
            modalTitle = form.querySelector('[data-kt-calendar="title"]');
            modal = new bootstrap.Modal(element);

            // View event modal
            const viewElement = document.getElementById('kt_modal_view_event');
            viewModal = new bootstrap.Modal(viewElement);
            viewEventName = viewElement.querySelector('[data-kt-calendar="event_name"]');
            viewAllDay = viewElement.querySelector('[data-kt-calendar="all_day"]');
            viewEventDescription = viewElement.querySelector('[data-kt-calendar="event_description"]');
            viewEventLocation = viewElement.querySelector('[data-kt-calendar="event_location"]');
            viewStartDate = viewElement.querySelector('[data-kt-calendar="event_start_date"]');
            viewEndDate = viewElement.querySelector('[data-kt-calendar="event_end_date"]');
            viewEditButton = viewElement.querySelector('#kt_modal_view_event_edit');
            viewDeleteButton = viewElement.querySelector('#kt_modal_view_event_delete');

            initCalendarApp();
            initValidator();
            initDatepickers();
            handleEditButton();
            handleAddButton();
            handleDeleteEvent();
            handleCancelButton();
            handleCloseButton();
            resetFormValidator(element);
        }
    };
}();

// On document ready
KTUtil.onDOMContentLoaded(function () {
    KTAppCalendar.init();
});

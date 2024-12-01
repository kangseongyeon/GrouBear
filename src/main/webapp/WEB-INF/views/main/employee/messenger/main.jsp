<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<div class="d-flex flex-column flex-lg-row">
	<!--begin::Sidebar-->
	<div
		class="flex-column flex-lg-row-auto w-100 w-lg-300px w-xl-400px mb-10 mb-lg-0">
		<!--begin::Contacts-->
		<div class="card card-flush">
			<!--begin::Card header-->
			<div class="card-header pt-7" id="kt_chat_contacts_header"
				style="padding-bottom: 20px;">
				<!--begin::Form-->
				<form class="w-100 position-relative" autocomplete="off">
					<!--begin::Icon-->
					<i
						class="ki-duotone ki-magnifier fs-3 text-gray-500 position-absolute top-50 ms-5 translate-middle-y">
						<span class="path1"></span> <span class="path2"></span>
					</i>
					<!--end::Icon-->
					<!--begin::Input-->
					<input type="text" class="form-control form-control-solid px-13"
						name="search" value=""
						placeholder="Search by username or email...">
					<!--end::Input-->
				</form>
				<!--end::Form-->
			</div>
			<!--end::Card header-->
			<div>

				<ul class="d-flex nav nav-tabs nav-line-tabs mb-5 fs-6">
					<li class="nav-item"><a class="nav-link active"
						data-bs-toggle="tab" href="#kt_tab_pane_1">주소록</a></li>
					<li class="nav-item"><a class="nav-link" data-bs-toggle="tab"
						href="#kt_tab_pane_2">채팅방</a></li>
				</ul>

				<div class="tab-content" id="myTabContent">
					<div class="tab-pane fade show active" id="kt_tab_pane_1"
						role="tabpanel">
						주소록
						<div class="card-body pt-5" id="kt_chat_contacts_body">
							<!--begin::List-->
							<div class="scroll-y me-n5 pe-5 h-200px h-lg-auto"
								data-kt-scroll="true"
								data-kt-scroll-activate="{default: false, lg: true}"
								data-kt-scroll-max-height="auto"
								data-kt-scroll-dependencies="#kt_header, #kt_app_header, #kt_toolbar, #kt_app_toolbar, #kt_footer, #kt_app_footer, #kt_chat_contacts_header"
								data-kt-scroll-wrappers="#kt_content, #kt_app_content, #kt_chat_contacts_body"
								data-kt-scroll-offset="5px" style="max-height: 458px;">
								<!--begin::User-->
								<div class="d-flex flex-stack py-4">
									<!--begin::Details-->
									<div class="d-flex align-items-center">
										<!--begin::Avatar-->
										<div class="symbol symbol-45px symbol-circle">
											<span
												class="symbol-label bg-light-danger text-danger fs-6 fw-bolder">M</span>
										</div>
										<!--end::Avatar-->
										<!--begin::Details-->
										<div class="ms-5">
											<a href="#"
												class="fs-5 fw-bold text-gray-900 text-hover-primary mb-2">Melody
												Macy</a>
											<div class="fw-semibold text-muted">melody@altbox.com</div>
										</div>
										<!--end::Details-->
									</div>
									<!--end::Details-->
									<!--begin::Lat seen-->
									<div class="d-flex flex-column align-items-end ms-2">
										<span class="text-muted fs-7 mb-1">1 week</span>
									</div>
									<!--end::Lat seen-->
								</div>
								<!--end::User-->
								<!--begin::Separator-->
								<div class="separator separator-dashed d-none"></div>
								<!--end::Separator-->
								<!--begin::User-->
								<div class="d-flex flex-stack py-4">
									<!--begin::Details-->
									<div class="d-flex align-items-center">
										<!--begin::Avatar-->
										<div class="symbol symbol-45px symbol-circle">
											<img alt="Pic" src="assets/media/avatars/300-1.jpg">
										</div>
										<!--end::Avatar-->
										<!--begin::Details-->
										<div class="ms-5">
											<a href="#"
												class="fs-5 fw-bold text-gray-900 text-hover-primary mb-2">Max
												Smith</a>
											<div class="fw-semibold text-muted">max@kt.com</div>
										</div>
										<!--end::Details-->
									</div>
									<!--end::Details-->
									<!--begin::Lat seen-->
									<div class="d-flex flex-column align-items-end ms-2">
										<span class="text-muted fs-7 mb-1">2 weeks</span> <span
											class="badge badge-sm badge-circle badge-light-success">2</span>
									</div>
									<!--end::Lat seen-->
								</div>
								<!--end::User-->
								<!--begin::Separator-->
								<div class="separator separator-dashed d-none"></div>
								<!--end::Separator-->
								<!--begin::User-->
								<div class="d-flex flex-stack py-4">
									<!--begin::Details-->
									<div class="d-flex align-items-center">
										<!--begin::Avatar-->
										<div class="symbol symbol-45px symbol-circle">
											<img alt="Pic" src="assets/media/avatars/300-5.jpg">
											<div
												class="symbol-badge bg-success start-100 top-100 border-4 h-8px w-8px ms-n2 mt-n2"></div>
										</div>
										<!--end::Avatar-->
										<!--begin::Details-->
										<div class="ms-5">
											<a href="#"
												class="fs-5 fw-bold text-gray-900 text-hover-primary mb-2">Sean
												Bean</a>
											<div class="fw-semibold text-muted">sean@dellito.com</div>
										</div>
										<!--end::Details-->
									</div>
									<!--end::Details-->
									<!--begin::Lat seen-->
									<div class="d-flex flex-column align-items-end ms-2">
										<span class="text-muted fs-7 mb-1">5 hrs</span>
									</div>
									<!--end::Lat seen-->
								</div>
								<!--end::User-->
								<!--begin::Separator-->
								<div class="separator separator-dashed d-none"></div>
								<!--end::Separator-->
								<!--begin::User-->
								<div class="d-flex flex-stack py-4">
									<!--begin::Details-->
									<div class="d-flex align-items-center">
										<!--begin::Avatar-->
										<div class="symbol symbol-45px symbol-circle">
											<img alt="Pic" src="assets/media/avatars/300-25.jpg">
										</div>
										<!--end::Avatar-->
										<!--begin::Details-->
										<div class="ms-5">
											<a href="#"
												class="fs-5 fw-bold text-gray-900 text-hover-primary mb-2">Brian
												Cox</a>
											<div class="fw-semibold text-muted">brian@exchange.com</div>
										</div>
										<!--end::Details-->
									</div>
									<!--end::Details-->
									<!--begin::Lat seen-->
									<div class="d-flex flex-column align-items-end ms-2">
										<span class="text-muted fs-7 mb-1">1 day</span>
									</div>
									<!--end::Lat seen-->
								</div>
								<!--end::User-->
								<!--begin::Separator-->
								<div class="separator separator-dashed d-none"></div>
								<!--end::Separator-->
								<!--begin::User-->
								<div class="d-flex flex-stack py-4">
									<!--begin::Details-->
									<div class="d-flex align-items-center">
										<!--begin::Avatar-->
										<div class="symbol symbol-45px symbol-circle">
											<span
												class="symbol-label bg-light-warning text-warning fs-6 fw-bolder">C</span>
											<div
												class="symbol-badge bg-success start-100 top-100 border-4 h-8px w-8px ms-n2 mt-n2"></div>
										</div>
										<!--end::Avatar-->
										<!--begin::Details-->
										<div class="ms-5">
											<a href="#"
												class="fs-5 fw-bold text-gray-900 text-hover-primary mb-2">Mikaela
												Collins</a>
											<div class="fw-semibold text-muted">mik@pex.com</div>
										</div>
										<!--end::Details-->
									</div>
									<!--end::Details-->
									<!--begin::Lat seen-->
									<div class="d-flex flex-column align-items-end ms-2">
										<span class="text-muted fs-7 mb-1">3 hrs</span>
									</div>
									<!--end::Lat seen-->
								</div>
								<!--end::User-->
								<!--begin::Separator-->
								<div class="separator separator-dashed d-none"></div>
								<!--end::Separator-->
								<!--begin::User-->
								<div class="d-flex flex-stack py-4">
									<!--begin::Details-->
									<div class="d-flex align-items-center">
										<!--begin::Avatar-->
										<div class="symbol symbol-45px symbol-circle">
											<img alt="Pic" src="assets/media/avatars/300-9.jpg">
										</div>
										<!--end::Avatar-->
										<!--begin::Details-->
										<div class="ms-5">
											<a href="#"
												class="fs-5 fw-bold text-gray-900 text-hover-primary mb-2">Francis
												Mitcham</a>
											<div class="fw-semibold text-muted">f.mit@kpmg.com</div>
										</div>
										<!--end::Details-->
									</div>
									<!--end::Details-->
									<!--begin::Lat seen-->
									<div class="d-flex flex-column align-items-end ms-2">
										<span class="text-muted fs-7 mb-1">2 weeks</span> <span
											class="badge badge-sm badge-circle badge-light-success">6</span>
									</div>
									<!--end::Lat seen-->
								</div>
								<!--end::User-->
								<!--begin::Separator-->
								<div class="separator separator-dashed d-none"></div>
								<!--end::Separator-->
								<!--begin::User-->
								<div class="d-flex flex-stack py-4">
									<!--begin::Details-->
									<div class="d-flex align-items-center">
										<!--begin::Avatar-->
										<div class="symbol symbol-45px symbol-circle">
											<span
												class="symbol-label bg-light-danger text-danger fs-6 fw-bolder">O</span>
											<div
												class="symbol-badge bg-success start-100 top-100 border-4 h-8px w-8px ms-n2 mt-n2"></div>
										</div>
										<!--end::Avatar-->
										<!--begin::Details-->
										<div class="ms-5">
											<a href="#"
												class="fs-5 fw-bold text-gray-900 text-hover-primary mb-2">Olivia
												Wild</a>
											<div class="fw-semibold text-muted">olivia@corpmail.com</div>
										</div>
										<!--end::Details-->
									</div>
									<!--end::Details-->
									<!--begin::Lat seen-->
									<div class="d-flex flex-column align-items-end ms-2">
										<span class="text-muted fs-7 mb-1">3 hrs</span> <span
											class="badge badge-sm badge-circle badge-light-warning">9</span>
									</div>
									<!--end::Lat seen-->
								</div>
								<!--end::User-->
								<!--begin::Separator-->
								<div class="separator separator-dashed d-none"></div>
								<!--end::Separator-->
								<!--begin::User-->
								<div class="d-flex flex-stack py-4">
									<!--begin::Details-->
									<div class="d-flex align-items-center">
										<!--begin::Avatar-->
										<div class="symbol symbol-45px symbol-circle">
											<span
												class="symbol-label bg-light-primary text-primary fs-6 fw-bolder">N</span>
											<div
												class="symbol-badge bg-success start-100 top-100 border-4 h-8px w-8px ms-n2 mt-n2"></div>
										</div>
										<!--end::Avatar-->
										<!--begin::Details-->
										<div class="ms-5">
											<a href="#"
												class="fs-5 fw-bold text-gray-900 text-hover-primary mb-2">Neil
												Owen</a>
											<div class="fw-semibold text-muted">owen.neil@gmail.com</div>
										</div>
										<!--end::Details-->
									</div>
									<!--end::Details-->
									<!--begin::Lat seen-->
									<div class="d-flex flex-column align-items-end ms-2">
										<span class="text-muted fs-7 mb-1">1 week</span>
									</div>
									<!--end::Lat seen-->
								</div>
								<!--end::User-->
								<!--begin::Separator-->
								<div class="separator separator-dashed d-none"></div>
								<!--end::Separator-->
								<!--begin::User-->
								<div class="d-flex flex-stack py-4">
									<!--begin::Details-->
									<div class="d-flex align-items-center">
										<!--begin::Avatar-->
										<div class="symbol symbol-45px symbol-circle">
											<img alt="Pic" src="assets/media/avatars/300-23.jpg">
											<div
												class="symbol-badge bg-success start-100 top-100 border-4 h-8px w-8px ms-n2 mt-n2"></div>
										</div>
										<!--end::Avatar-->
										<!--begin::Details-->
										<div class="ms-5">
											<a href="#"
												class="fs-5 fw-bold text-gray-900 text-hover-primary mb-2">Dan
												Wilson</a>
											<div class="fw-semibold text-muted">dam@consilting.com</div>
										</div>
										<!--end::Details-->
									</div>
									<!--end::Details-->
									<!--begin::Lat seen-->
									<div class="d-flex flex-column align-items-end ms-2">
										<span class="text-muted fs-7 mb-1">20 hrs</span>
									</div>
									<!--end::Lat seen-->
								</div>
								<!--end::User-->
								<!--begin::Separator-->
								<div class="separator separator-dashed d-none"></div>
								<!--end::Separator-->
								<!--begin::User-->
								<div class="d-flex flex-stack py-4">
									<!--begin::Details-->
									<div class="d-flex align-items-center">
										<!--begin::Avatar-->
										<div class="symbol symbol-45px symbol-circle">
											<span
												class="symbol-label bg-light-danger text-danger fs-6 fw-bolder">E</span>
										</div>
										<!--end::Avatar-->
										<!--begin::Details-->
										<div class="ms-5">
											<a href="#"
												class="fs-5 fw-bold text-gray-900 text-hover-primary mb-2">Emma
												Bold</a>
											<div class="fw-semibold text-muted">emma@intenso.com</div>
										</div>
										<!--end::Details-->
									</div>
									<!--end::Details-->
									<!--begin::Lat seen-->
									<div class="d-flex flex-column align-items-end ms-2">
										<span class="text-muted fs-7 mb-1">2 weeks</span>
									</div>
									<!--end::Lat seen-->
								</div>
								<!--end::User-->
							</div>
							<!--end::List-->
						</div>
					</div>












					<!-- 채ㅐ팅방 시작 -->
					<div class="tab-pane fade" id="kt_tab_pane_2" role="tabpanel">
						채팅방
						<div class="card-body pt-5" id="kt_chat_contacts_body">
							<!--begin::List-->
							<div class="scroll-y me-n5 pe-5 h-200px h-lg-auto"
								data-kt-scroll="true"
								data-kt-scroll-activate="{default: false, lg: true}"
								data-kt-scroll-max-height="auto"
								data-kt-scroll-dependencies="#kt_header, #kt_app_header, #kt_toolbar, #kt_app_toolbar, #kt_footer, #kt_app_footer, #kt_chat_contacts_header"
								data-kt-scroll-wrappers="#kt_content, #kt_app_content, #kt_chat_contacts_body"
								data-kt-scroll-offset="5px" style="max-height: 458px;">
								<!--begin::User-->
								<div class="d-flex flex-stack py-4">
									<!--begin::Details-->
									<div class="d-flex align-items-center">
										<!--begin::Avatar-->
										<div class="symbol symbol-45px symbol-circle">
											<span
												class="symbol-label bg-light-danger text-danger fs-6 fw-bolder">M</span>
										</div>
										<!--end::Avatar-->
										<!--begin::Details-->
										<div class="ms-5">
											<a href="#"
												class="fs-5 fw-bold text-gray-900 text-hover-primary mb-2">Melody
												Macy</a>
											<div class="fw-semibold text-muted">melody@altbox.com</div>
										</div>
										<!--end::Details-->
									</div>
									<!--end::Details-->
									<!--begin::Lat seen-->
									<div class="d-flex flex-column align-items-end ms-2">
										<span class="text-muted fs-7 mb-1">1 week</span>
									</div>
									<!--end::Lat seen-->
								</div>
								<!--end::User-->
								<!--begin::Separator-->
								<div class="separator separator-dashed d-none"></div>
								<!--end::Separator-->
								<!--begin::User-->
								<div class="d-flex flex-stack py-4">
									<!--begin::Details-->
									<div class="d-flex align-items-center">
										<!--begin::Avatar-->
										<div class="symbol symbol-45px symbol-circle">
											<img alt="Pic" src="assets/media/avatars/300-1.jpg">
										</div>
										<!--end::Avatar-->
										<!--begin::Details-->
										<div class="ms-5">
											<a href="#"
												class="fs-5 fw-bold text-gray-900 text-hover-primary mb-2">Max
												Smith</a>
											<div class="fw-semibold text-muted">max@kt.com</div>
										</div>
										<!--end::Details-->
									</div>
									<!--end::Details-->
									<!--begin::Lat seen-->
									<div class="d-flex flex-column align-items-end ms-2">
										<span class="text-muted fs-7 mb-1">2 weeks</span> <span
											class="badge badge-sm badge-circle badge-light-success">2</span>
									</div>
									<!--end::Lat seen-->
								</div>
								<!--end::User-->
								<!--begin::Separator-->
								<div class="separator separator-dashed d-none"></div>
								<!--end::Separator-->
								<!--begin::User-->
								<div class="d-flex flex-stack py-4">
									<!--begin::Details-->
									<div class="d-flex align-items-center">
										<!--begin::Avatar-->
										<div class="symbol symbol-45px symbol-circle">
											<img alt="Pic" src="assets/media/avatars/300-5.jpg">
											<div
												class="symbol-badge bg-success start-100 top-100 border-4 h-8px w-8px ms-n2 mt-n2"></div>
										</div>
										<!--end::Avatar-->
										<!--begin::Details-->
										<div class="ms-5">
											<a href="#"
												class="fs-5 fw-bold text-gray-900 text-hover-primary mb-2">Sean
												Bean</a>
											<div class="fw-semibold text-muted">sean@dellito.com</div>
										</div>
										<!--end::Details-->
									</div>
									<!--end::Details-->
									<!--begin::Lat seen-->
									<div class="d-flex flex-column align-items-end ms-2">
										<span class="text-muted fs-7 mb-1">5 hrs</span>
									</div>
									<!--end::Lat seen-->
								</div>
								<!--end::User-->
								<!--begin::Separator-->
								<div class="separator separator-dashed d-none"></div>
								<!--end::Separator-->
								<!--begin::User-->
								<div class="d-flex flex-stack py-4">
									<!--begin::Details-->
									<div class="d-flex align-items-center">
										<!--begin::Avatar-->
										<div class="symbol symbol-45px symbol-circle">
											<img alt="Pic" src="assets/media/avatars/300-25.jpg">
										</div>
										<!--end::Avatar-->
										<!--begin::Details-->
										<div class="ms-5">
											<a href="#"
												class="fs-5 fw-bold text-gray-900 text-hover-primary mb-2">Brian
												Cox</a>
											<div class="fw-semibold text-muted">brian@exchange.com</div>
										</div>
										<!--end::Details-->
									</div>
									<!--end::Details-->
									<!--begin::Lat seen-->
									<div class="d-flex flex-column align-items-end ms-2">
										<span class="text-muted fs-7 mb-1">1 day</span>
									</div>
									<!--end::Lat seen-->
								</div>
								<!--end::User-->
								<!--begin::Separator-->
								<div class="separator separator-dashed d-none"></div>
								<!--end::Separator-->
								<!--begin::User-->
								<div class="d-flex flex-stack py-4">
									<!--begin::Details-->
									<div class="d-flex align-items-center">
										<!--begin::Avatar-->
										<div class="symbol symbol-45px symbol-circle">
											<span
												class="symbol-label bg-light-warning text-warning fs-6 fw-bolder">C</span>
											<div
												class="symbol-badge bg-success start-100 top-100 border-4 h-8px w-8px ms-n2 mt-n2"></div>
										</div>
										<!--end::Avatar-->
										<!--begin::Details-->
										<div class="ms-5">
											<a href="#"
												class="fs-5 fw-bold text-gray-900 text-hover-primary mb-2">Mikaela
												Collins</a>
											<div class="fw-semibold text-muted">mik@pex.com</div>
										</div>
										<!--end::Details-->
									</div>
									<!--end::Details-->
									<!--begin::Lat seen-->
									<div class="d-flex flex-column align-items-end ms-2">
										<span class="text-muted fs-7 mb-1">3 hrs</span>
									</div>
									<!--end::Lat seen-->
								</div>
								<!--end::User-->
								<!--begin::Separator-->
								<div class="separator separator-dashed d-none"></div>
								<!--end::Separator-->
								<!--begin::User-->
								<div class="d-flex flex-stack py-4">
									<!--begin::Details-->
									<div class="d-flex align-items-center">
										<!--begin::Avatar-->
										<div class="symbol symbol-45px symbol-circle">
											<img alt="Pic" src="assets/media/avatars/300-9.jpg">
										</div>
										<!--end::Avatar-->
										<!--begin::Details-->
										<div class="ms-5">
											<a href="#"
												class="fs-5 fw-bold text-gray-900 text-hover-primary mb-2">Francis
												Mitcham</a>
											<div class="fw-semibold text-muted">f.mit@kpmg.com</div>
										</div>
										<!--end::Details-->
									</div>
									<!--end::Details-->
									<!--begin::Lat seen-->
									<div class="d-flex flex-column align-items-end ms-2">
										<span class="text-muted fs-7 mb-1">2 weeks</span> <span
											class="badge badge-sm badge-circle badge-light-success">6</span>
									</div>
									<!--end::Lat seen-->
								</div>
								<!--end::User-->
								<!--begin::Separator-->
								<div class="separator separator-dashed d-none"></div>
								<!--end::Separator-->
								<!--begin::User-->
								<div class="d-flex flex-stack py-4">
									<!--begin::Details-->
									<div class="d-flex align-items-center">
										<!--begin::Avatar-->
										<div class="symbol symbol-45px symbol-circle">
											<span
												class="symbol-label bg-light-danger text-danger fs-6 fw-bolder">O</span>
											<div
												class="symbol-badge bg-success start-100 top-100 border-4 h-8px w-8px ms-n2 mt-n2"></div>
										</div>
										<!--end::Avatar-->
										<!--begin::Details-->
										<div class="ms-5">
											<a href="#"
												class="fs-5 fw-bold text-gray-900 text-hover-primary mb-2">Olivia
												Wild</a>
											<div class="fw-semibold text-muted">olivia@corpmail.com</div>
										</div>
										<!--end::Details-->
									</div>
									<!--end::Details-->
									<!--begin::Lat seen-->
									<div class="d-flex flex-column align-items-end ms-2">
										<span class="text-muted fs-7 mb-1">3 hrs</span> <span
											class="badge badge-sm badge-circle badge-light-warning">9</span>
									</div>
									<!--end::Lat seen-->
								</div>
								<!--end::User-->
								<!--begin::Separator-->
								<div class="separator separator-dashed d-none"></div>
								<!--end::Separator-->
								<!--begin::User-->
								<div class="d-flex flex-stack py-4">
									<!--begin::Details-->
									<div class="d-flex align-items-center">
										<!--begin::Avatar-->
										<div class="symbol symbol-45px symbol-circle">
											<span
												class="symbol-label bg-light-primary text-primary fs-6 fw-bolder">N</span>
											<div
												class="symbol-badge bg-success start-100 top-100 border-4 h-8px w-8px ms-n2 mt-n2"></div>
										</div>
										<!--end::Avatar-->
										<!--begin::Details-->
										<div class="ms-5">
											<a href="#"
												class="fs-5 fw-bold text-gray-900 text-hover-primary mb-2">Neil
												Owen</a>
											<div class="fw-semibold text-muted">owen.neil@gmail.com</div>
										</div>
										<!--end::Details-->
									</div>
									<!--end::Details-->
									<!--begin::Lat seen-->
									<div class="d-flex flex-column align-items-end ms-2">
										<span class="text-muted fs-7 mb-1">1 week</span>
									</div>
									<!--end::Lat seen-->
								</div>
								<!--end::User-->
								<!--begin::Separator-->
								<div class="separator separator-dashed d-none"></div>
								<!--end::Separator-->
								<!--begin::User-->
								<div class="d-flex flex-stack py-4">
									<!--begin::Details-->
									<div class="d-flex align-items-center">
										<!--begin::Avatar-->
										<div class="symbol symbol-45px symbol-circle">
											<img alt="Pic" src="assets/media/avatars/300-23.jpg">
											<div
												class="symbol-badge bg-success start-100 top-100 border-4 h-8px w-8px ms-n2 mt-n2"></div>
										</div>
										<!--end::Avatar-->
										<!--begin::Details-->
										<div class="ms-5">
											<a href="#"
												class="fs-5 fw-bold text-gray-900 text-hover-primary mb-2">Dan
												Wilson</a>
											<div class="fw-semibold text-muted">dam@consilting.com</div>
										</div>
										<!--end::Details-->
									</div>
									<!--end::Details-->
									<!--begin::Lat seen-->
									<div class="d-flex flex-column align-items-end ms-2">
										<span class="text-muted fs-7 mb-1">20 hrs</span>
									</div>
									<!--end::Lat seen-->
								</div>
								<!--end::User-->
								<!--begin::Separator-->
								<div class="separator separator-dashed d-none"></div>
								<!--end::Separator-->
								<!--begin::User-->
								<div class="d-flex flex-stack py-4">
									<!--begin::Details-->
									<div class="d-flex align-items-center">
										<!--begin::Avatar-->
										<div class="symbol symbol-45px symbol-circle">
											<span
												class="symbol-label bg-light-danger text-danger fs-6 fw-bolder">E</span>
										</div>
										<!--end::Avatar-->
										<!--begin::Details-->
										<div class="ms-5">
											<a href="#"
												class="fs-5 fw-bold text-gray-900 text-hover-primary mb-2">Emma
												Bold</a>
											<div class="fw-semibold text-muted">emma@intenso.com</div>
										</div>
										<!--end::Details-->
									</div>
									<!--end::Details-->
									<!--begin::Lat seen-->
									<div class="d-flex flex-column align-items-end ms-2">
										<span class="text-muted fs-7 mb-1">2 weeks</span>
									</div>
									<!--end::Lat seen-->
								</div>
								<!--end::User-->
							</div>
							<!--end::List-->
						</div>
					</div>
				</div>

			</div>
			<!--begin::Card body-->
			<!--end::Card body-->
		</div>
		<!--end::Contacts-->
	</div>
	<!--end::Sidebar-->
	<!--begin::Content-->
	<div class="flex-lg-row-fluid ms-lg-7 ms-xl-10">
		<!--begin::Messenger-->
		<div class="card" id="kt_chat_messenger">
			<!--begin::Card header-->
			<div class="card-header" id="kt_chat_messenger_header">
				<!--begin::Title-->
				<div class="card-title">
					<!--begin::Users-->
					<div class="symbol-group symbol-hover">
						<!--begin::Avatar-->
						<div class="symbol symbol-35px symbol-circle">
							<img alt="Pic" src="assets/media/avatars/300-5.jpg">
						</div>
						<!--end::Avatar-->
						<!--begin::Avatar-->
						<div class="symbol symbol-35px symbol-circle">
							<img alt="Pic" src="assets/media/avatars/300-25.jpg">
						</div>
						<!--end::Avatar-->
						<!--begin::Avatar-->
						<div class="symbol symbol-35px symbol-circle">
							<span class="symbol-label bg-light-warning text-warning 40px">C</span>
						</div>
						<!--end::Avatar-->
						<!--begin::Avatar-->
						<div class="symbol symbol-35px symbol-circle">
							<img alt="Pic" src="assets/media/avatars/300-9.jpg">
						</div>
						<!--end::Avatar-->
						<!--begin::Avatar-->
						<div class="symbol symbol-35px symbol-circle">
							<span class="symbol-label bg-light-danger text-danger 40px">O</span>
						</div>
						<!--end::Avatar-->
						<!--begin::Avatar-->
						<div class="symbol symbol-35px symbol-circle">
							<span class="symbol-label bg-light-primary text-primary 40px">N</span>
						</div>
						<!--end::Avatar-->
						<!--begin::Avatar-->
						<div class="symbol symbol-35px symbol-circle">
							<img alt="Pic" src="assets/media/avatars/300-23.jpg">
						</div>
						<!--end::Avatar-->
						<!--begin::All users-->
						<a href="#" class="symbol symbol-35px symbol-circle"
							data-bs-toggle="modal" data-bs-target="#kt_modal_view_users">
							<span class="symbol-label fs-8 fw-bold" data-bs-toggle="tooltip"
							data-bs-trigger="hover" data-bs-original-title="View more users"
							data-kt-initialized="1">+42</span>
						</a>
						<!--end::All users-->
					</div>
					<!--end::Users-->
				</div>
				<!--end::Title-->
				<!--begin::Card toolbar-->
				<div class="card-toolbar">
					<!--begin::Menu-->
					<div class="me-n3">
						<button class="btn btn-sm btn-icon btn-active-light-primary"
							data-kt-menu-trigger="click" data-kt-menu-placement="bottom-end">
							<i class="ki-duotone ki-dots-square fs-2"> <span
								class="path1"></span> <span class="path2"></span> <span
								class="path3"></span> <span class="path4"></span>
							</i>
						</button>
						<!--begin::Menu 3-->
						<div
							class="menu menu-sub menu-sub-dropdown menu-column menu-rounded menu-gray-800 menu-state-bg-light-primary fw-semibold w-200px py-3"
							data-kt-menu="true">
							<!--begin::Heading-->
							<div class="menu-item px-3">
								<div
									class="menu-content text-muted pb-2 px-3 fs-7 text-uppercase">Contacts</div>
							</div>
							<!--end::Heading-->
							<!--begin::Menu item-->
							<div class="menu-item px-3">
								<a href="#" class="menu-link px-3" data-bs-toggle="modal"
									data-bs-target="#kt_modal_users_search">Add Contact</a>
							</div>
							<!--end::Menu item-->
							<!--begin::Menu item-->
							<div class="menu-item px-3">
								<a href="#" class="menu-link flex-stack px-3"
									data-bs-toggle="modal"
									data-bs-target="#kt_modal_invite_friends">Invite Contacts <span
									class="ms-2" data-bs-toggle="tooltip"
									aria-label="Specify a contact email to send an invitation"
									data-bs-original-title="Specify a contact email to send an invitation"
									data-kt-initialized="1"> <i
										class="ki-duotone ki-information fs-7"> <span
											class="path1"></span> <span class="path2"></span> <span
											class="path3"></span>
									</i>
								</span></a>
							</div>
							<!--end::Menu item-->
							<!--begin::Menu item-->
							<div class="menu-item px-3" data-kt-menu-trigger="hover"
								data-kt-menu-placement="right-start">
								<a href="#" class="menu-link px-3"> <span class="menu-title">Groups</span>
									<span class="menu-arrow"></span>
								</a>
								<!--begin::Menu sub-->
								<div class="menu-sub menu-sub-dropdown w-175px py-4">
									<!--begin::Menu item-->
									<div class="menu-item px-3">
										<a href="#" class="menu-link px-3" data-bs-toggle="tooltip"
											data-bs-original-title="Coming soon" data-kt-initialized="1">Create
											Group</a>
									</div>
									<!--end::Menu item-->
									<!--begin::Menu item-->
									<div class="menu-item px-3">
										<a href="#" class="menu-link px-3" data-bs-toggle="tooltip"
											data-bs-original-title="Coming soon" data-kt-initialized="1">Invite
											Members</a>
									</div>
									<!--end::Menu item-->
									<!--begin::Menu item-->
									<div class="menu-item px-3">
										<a href="#" class="menu-link px-3" data-bs-toggle="tooltip"
											data-bs-original-title="Coming soon" data-kt-initialized="1">Settings</a>
									</div>
									<!--end::Menu item-->
								</div>
								<!--end::Menu sub-->
							</div>
							<!--end::Menu item-->
							<!--begin::Menu item-->
							<div class="menu-item px-3 my-1">
								<a href="#" class="menu-link px-3" data-bs-toggle="tooltip"
									data-bs-original-title="Coming soon" data-kt-initialized="1">Settings</a>
							</div>
							<!--end::Menu item-->
						</div>
						<!--end::Menu 3-->
					</div>
					<!--end::Menu-->
				</div>
				<!--end::Card toolbar-->
			</div>
			<!--end::Card header-->
			<!--begin::Card body-->
			<div class="card-body" id="kt_chat_messenger_body">
				<!--begin::Messages-->
				<div class="scroll-y me-n5 pe-5 h-300px h-lg-auto"
					data-kt-element="messages" data-kt-scroll="true"
					data-kt-scroll-activate="{default: false, lg: true}"
					data-kt-scroll-max-height="auto"
					data-kt-scroll-dependencies="#kt_header, #kt_app_header, #kt_app_toolbar, #kt_toolbar, #kt_footer, #kt_app_footer, #kt_chat_messenger_header, #kt_chat_messenger_footer"
					data-kt-scroll-wrappers="#kt_content, #kt_app_content, #kt_chat_messenger_body"
					data-kt-scroll-offset="5px" style="max-height: 316px;">
					<!--begin::Message(in)-->
					<div class="d-flex justify-content-start mb-10">
						<!--begin::Wrapper-->
						<div class="d-flex flex-column align-items-start">
							<!--begin::User-->
							<div class="d-flex align-items-center mb-2">
								<!--begin::Avatar-->
								<div class="symbol symbol-35px symbol-circle">
									<img alt="Pic" src="assets/media/avatars/300-25.jpg">
								</div>
								<!--end::Avatar-->
								<!--begin::Details-->
								<div class="ms-3">
									<a href="#"
										class="fs-5 fw-bold text-gray-900 text-hover-primary me-1">Brian
										Cox</a> <span class="text-muted fs-7 mb-1">2 mins</span>
								</div>
								<!--end::Details-->
							</div>
							<!--end::User-->
							<!--begin::Text-->
							<div
								class="p-5 rounded bg-light-info text-gray-900 fw-semibold mw-lg-400px text-start"
								data-kt-element="message-text">How likely are you to
								recommend our company to your friends and family ?</div>
							<!--end::Text-->
						</div>
						<!--end::Wrapper-->
					</div>
					<!--end::Message(in)-->
					<!--begin::Message(out)-->
					<div class="d-flex justify-content-end mb-10">
						<!--begin::Wrapper-->
						<div class="d-flex flex-column align-items-end">
							<!--begin::User-->
							<div class="d-flex align-items-center mb-2">
								<!--begin::Details-->
								<div class="me-3">
									<span class="text-muted fs-7 mb-1">5 mins</span> <a href="#"
										class="fs-5 fw-bold text-gray-900 text-hover-primary ms-1">You</a>
								</div>
								<!--end::Details-->
								<!--begin::Avatar-->
								<div class="symbol symbol-35px symbol-circle">
									<img alt="Pic" src="assets/media/avatars/300-1.jpg">
								</div>
								<!--end::Avatar-->
							</div>
							<!--end::User-->
							<!--begin::Text-->
							<div
								class="p-5 rounded bg-light-primary text-gray-900 fw-semibold mw-lg-400px text-end"
								data-kt-element="message-text">Hey there, we’re just
								writing to let you know that you’ve been subscribed to a
								repository on GitHub.</div>
							<!--end::Text-->
						</div>
						<!--end::Wrapper-->
					</div>
					<!--end::Message(out)-->
					<!--begin::Message(in)-->
					<div class="d-flex justify-content-start mb-10">
						<!--begin::Wrapper-->
						<div class="d-flex flex-column align-items-start">
							<!--begin::User-->
							<div class="d-flex align-items-center mb-2">
								<!--begin::Avatar-->
								<div class="symbol symbol-35px symbol-circle">
									<img alt="Pic" src="assets/media/avatars/300-25.jpg">
								</div>
								<!--end::Avatar-->
								<!--begin::Details-->
								<div class="ms-3">
									<a href="#"
										class="fs-5 fw-bold text-gray-900 text-hover-primary me-1">Brian
										Cox</a> <span class="text-muted fs-7 mb-1">1 Hour</span>
								</div>
								<!--end::Details-->
							</div>
							<!--end::User-->
							<!--begin::Text-->
							<div
								class="p-5 rounded bg-light-info text-gray-900 fw-semibold mw-lg-400px text-start"
								data-kt-element="message-text">Ok, Understood!</div>
							<!--end::Text-->
						</div>
						<!--end::Wrapper-->
					</div>
					<!--end::Message(in)-->
					<!--begin::Message(out)-->
					<div class="d-flex justify-content-end mb-10">
						<!--begin::Wrapper-->
						<div class="d-flex flex-column align-items-end">
							<!--begin::User-->
							<div class="d-flex align-items-center mb-2">
								<!--begin::Details-->
								<div class="me-3">
									<span class="text-muted fs-7 mb-1">2 Hours</span> <a href="#"
										class="fs-5 fw-bold text-gray-900 text-hover-primary ms-1">You</a>
								</div>
								<!--end::Details-->
								<!--begin::Avatar-->
								<div class="symbol symbol-35px symbol-circle">
									<img alt="Pic" src="assets/media/avatars/300-1.jpg">
								</div>
								<!--end::Avatar-->
							</div>
							<!--end::User-->
							<!--begin::Text-->
							<div
								class="p-5 rounded bg-light-primary text-gray-900 fw-semibold mw-lg-400px text-end"
								data-kt-element="message-text">You’ll receive
								notifications for all issues, pull requests!</div>
							<!--end::Text-->
						</div>
						<!--end::Wrapper-->
					</div>
					<!--end::Message(out)-->
					<!--begin::Message(in)-->
					<div class="d-flex justify-content-start mb-10">
						<!--begin::Wrapper-->
						<div class="d-flex flex-column align-items-start">
							<!--begin::User-->
							<div class="d-flex align-items-center mb-2">
								<!--begin::Avatar-->
								<div class="symbol symbol-35px symbol-circle">
									<img alt="Pic" src="assets/media/avatars/300-25.jpg">
								</div>
								<!--end::Avatar-->
								<!--begin::Details-->
								<div class="ms-3">
									<a href="#"
										class="fs-5 fw-bold text-gray-900 text-hover-primary me-1">Brian
										Cox</a> <span class="text-muted fs-7 mb-1">3 Hours</span>
								</div>
								<!--end::Details-->
							</div>
							<!--end::User-->
							<!--begin::Text-->
							<div
								class="p-5 rounded bg-light-info text-gray-900 fw-semibold mw-lg-400px text-start"
								data-kt-element="message-text">
								You can unwatch this repository immediately by clicking here: <a
									href="https://keenthemes.com">Keenthemes.com</a>
							</div>
							<!--end::Text-->
						</div>
						<!--end::Wrapper-->
					</div>
					<!--end::Message(in)-->
					<!--begin::Message(out)-->
					<div class="d-flex justify-content-end mb-10">
						<!--begin::Wrapper-->
						<div class="d-flex flex-column align-items-end">
							<!--begin::User-->
							<div class="d-flex align-items-center mb-2">
								<!--begin::Details-->
								<div class="me-3">
									<span class="text-muted fs-7 mb-1">4 Hours</span> <a href="#"
										class="fs-5 fw-bold text-gray-900 text-hover-primary ms-1">You</a>
								</div>
								<!--end::Details-->
								<!--begin::Avatar-->
								<div class="symbol symbol-35px symbol-circle">
									<img alt="Pic" src="assets/media/avatars/300-1.jpg">
								</div>
								<!--end::Avatar-->
							</div>
							<!--end::User-->
							<!--begin::Text-->
							<div
								class="p-5 rounded bg-light-primary text-gray-900 fw-semibold mw-lg-400px text-end"
								data-kt-element="message-text">Most purchased Business
								courses during this sale!</div>
							<!--end::Text-->
						</div>
						<!--end::Wrapper-->
					</div>
					<!--end::Message(out)-->
					<!--begin::Message(in)-->
					<div class="d-flex justify-content-start mb-10">
						<!--begin::Wrapper-->
						<div class="d-flex flex-column align-items-start">
							<!--begin::User-->
							<div class="d-flex align-items-center mb-2">
								<!--begin::Avatar-->
								<div class="symbol symbol-35px symbol-circle">
									<img alt="Pic" src="assets/media/avatars/300-25.jpg">
								</div>
								<!--end::Avatar-->
								<!--begin::Details-->
								<div class="ms-3">
									<a href="#"
										class="fs-5 fw-bold text-gray-900 text-hover-primary me-1">Brian
										Cox</a> <span class="text-muted fs-7 mb-1">5 Hours</span>
								</div>
								<!--end::Details-->
							</div>
							<!--end::User-->
							<!--begin::Text-->
							<div
								class="p-5 rounded bg-light-info text-gray-900 fw-semibold mw-lg-400px text-start"
								data-kt-element="message-text">Company BBQ to celebrate
								the last quater achievements and goals. Food and drinks provided</div>
							<!--end::Text-->
						</div>
						<!--end::Wrapper-->
					</div>
					<!--end::Message(in)-->
					<!--begin::Message(template for out)-->
					<div class="d-flex justify-content-end mb-10 d-none"
						data-kt-element="template-out">
						<!--begin::Wrapper-->
						<div class="d-flex flex-column align-items-end">
							<!--begin::User-->
							<div class="d-flex align-items-center mb-2">
								<!--begin::Details-->
								<div class="me-3">
									<span class="text-muted fs-7 mb-1">Just now</span> <a href="#"
										class="fs-5 fw-bold text-gray-900 text-hover-primary ms-1">You</a>
								</div>
								<!--end::Details-->
								<!--begin::Avatar-->
								<div class="symbol symbol-35px symbol-circle">
									<img alt="Pic" src="assets/media/avatars/300-1.jpg">
								</div>
								<!--end::Avatar-->
							</div>
							<!--end::User-->
							<!--begin::Text-->
							<div
								class="p-5 rounded bg-light-primary text-gray-900 fw-semibold mw-lg-400px text-end"
								data-kt-element="message-text"></div>
							<!--end::Text-->
						</div>
						<!--end::Wrapper-->
					</div>
					<!--end::Message(template for out)-->
					<!--begin::Message(template for in)-->
					<div class="d-flex justify-content-start mb-10 d-none"
						data-kt-element="template-in">
						<!--begin::Wrapper-->
						<div class="d-flex flex-column align-items-start">
							<!--begin::User-->
							<div class="d-flex align-items-center mb-2">
								<!--begin::Avatar-->
								<div class="symbol symbol-35px symbol-circle">
									<img alt="Pic" src="assets/media/avatars/300-25.jpg">
								</div>
								<!--end::Avatar-->
								<!--begin::Details-->
								<div class="ms-3">
									<a href="#"
										class="fs-5 fw-bold text-gray-900 text-hover-primary me-1">Brian
										Cox</a> <span class="text-muted fs-7 mb-1">Just now</span>
								</div>
								<!--end::Details-->
							</div>
							<!--end::User-->
							<!--begin::Text-->
							<div
								class="p-5 rounded bg-light-info text-gray-900 fw-semibold mw-lg-400px text-start"
								data-kt-element="message-text">Right before vacation
								season we have the next Big Deal for you.</div>
							<!--end::Text-->
						</div>
						<!--end::Wrapper-->
					</div>
					<!--end::Message(template for in)-->
				</div>
				<!--end::Messages-->
			</div>
			<!--end::Card body-->
			<!--begin::Card footer-->
			<div class="card-footer pt-4" id="kt_chat_messenger_footer">
				<!--begin::Input-->
				<textarea class="form-control form-control-flush mb-3" rows="1"
					data-kt-element="input" placeholder="Type a message"></textarea>
				<!--end::Input-->
				<!--begin:Toolbar-->
				<div class="d-flex flex-stack">
					<!--begin::Actions-->
					<div class="d-flex align-items-center me-2">
						<button class="btn btn-sm btn-icon btn-active-light-primary me-1"
							type="button" data-bs-toggle="tooltip" aria-label="Coming soon"
							data-bs-original-title="Coming soon" data-kt-initialized="1">
							<i class="ki-duotone ki-paper-clip fs-3"></i>
						</button>
						<button class="btn btn-sm btn-icon btn-active-light-primary me-1"
							type="button" data-bs-toggle="tooltip" aria-label="Coming soon"
							data-bs-original-title="Coming soon" data-kt-initialized="1">
							<i class="ki-duotone ki-exit-up fs-3"> <span class="path1"></span>
								<span class="path2"></span>
							</i>
						</button>
					</div>
					<!--end::Actions-->
					<!--begin::Send-->
					<button class="btn btn-primary" type="button"
						data-kt-element="send">Send</button>
					<!--end::Send-->
				</div>
				<!--end::Toolbar-->
			</div>
			<!--end::Card footer-->
		</div>
		<!--end::Messenger-->
	</div>
	<!--end::Content-->
</div>


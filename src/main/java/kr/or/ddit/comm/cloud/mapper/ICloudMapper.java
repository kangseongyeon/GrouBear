package kr.or.ddit.comm.cloud.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.comm.cloud.vo.CloudFileVO;
import kr.or.ddit.comm.cloud.vo.CloudFldrAuthrtVO;
import kr.or.ddit.comm.cloud.vo.CloudFldrOrFileVO;
import kr.or.ddit.comm.cloud.vo.CloudStrgFldrVO;
import kr.or.ddit.comm.cloud.vo.CloudStrgVO;
import kr.or.ddit.comm.cloud.vo.StrgListVO;
import kr.or.ddit.comm.empallinfo.vo.EmployeeAllVO;
import kr.or.ddit.comm.form.vo.FormVO;
import kr.or.ddit.comm.paging.vo.PaginationInfoVO;
import kr.or.ddit.comm.security.vo.EmployeeVO;
import kr.or.ddit.comm.serviceresult.ServiceResult;
import kr.or.ddit.company.personnelInformation.vo.JobGradeVO;

public interface ICloudMapper {
	
  	/**
  	 * 기업 관리자가 가입했을 때 전사 보관함 생성
  	 * @param empVO
  	 * @return
  	 */
  	public int comCloudStrgCreate(EmployeeVO empVO);
  	
  	/** 부서가 생성됐을 때 부서 보관함 생성
  	 * 
  	 * @param empVO
  	 * @return
  	 */
  	public int deptCloudStrgCreate(EmployeeAllVO empAllVO);
  	
  	/**
  	 * 사원이 가입했을 때 개인 기본 보관함 생성
  	 * @param empVO
  	 * @return
  	 */
  	public int empCloudStrgCreate(EmployeeVO empVO);
	
	/**
	 * 로그인한 사람의 전사, 부서, 개인 클라우드함 가져오기 (사이드바 클라우드함 리스트)
	 * @param employeeAllVO
	 * @return
	 */
	public List<CloudStrgVO> selectMainCloudStrgList(EmployeeAllVO employeeAllVO);

	/**
	 * 클라우드함 내부의 폴더 및 파일 불러오기
	 * @param cloudStrgCd
	 * @return
	 */
	public List<CloudStrgVO> selectCloudStrgInFldrAndFileList(String cloudStrgCd);

	/**
	 * 폴더 내부의 폴더 및 파일 불러오기
	 * @param cloudStrgFldrCd
	 * @return
	 */
	public List<CloudStrgVO> selectCloudFldrInFldrAndFileList(String cloudStrgFldrCd);

	/**
	 * 선택한 폴더의 정보 및 권한 리스트 불러오기
	 * @param cloudStrgFldrCd
	 * @return
	 */
	public CloudStrgFldrVO selectCloudFldrDetail(String cloudStrgFldrCd);

	/**
	 * 선택한 폴더의 경로를 계층형으로 가져오기
	 * @param cloudStrgFldrCd
	 * @return
	 */
	public List<CloudStrgVO> selectCloudPath(String cloudStrgFldrCd);

	/**
	 * 개인 클라우드함에 속한 커스텀 클라우드함 불러오기 
	 * @param empVO
	 * @return
	 */
	public List<CloudStrgVO> selectMyCloudStrgCustomList(EmployeeVO empVO);

	/**
	 * Jstree를 가져오기 위한 루트 클라우드함 리스트 가져오기
	 * @param map
	 * @return
	 */
	public List<StrgListVO> cloudSelectRootStrg(Map<String, String> map);

	/**
	 * 업로드시 선택할 클라우드함 및 폴더 경로 출력하기 
	 * @param rootStrg
	 * @return
	 */
	public List<StrgListVO> cloudSelectJstree(List<StrgListVO> rootStrg);
	
	/**
	 * 클라우드 파일 업로드하기
	 * @param cloudFileVO
	 * @return
	 */
	public int cloudFileListInsert(CloudFileVO cloudFileVO);

	/**
	 * 선택한 폴더 또는 클라우드함의 가장 상위 클라우드함 가져오기
	 * @param cloudStrgCd
	 * @return
	 */
	public CloudStrgVO selectParentCloud(String cloudStrgCd);

	/**
	 * 클라우드함에서 가져온 폴더 및 파일의 총 카운트 수
	 * @param cloudStrgCd
	 * @return
	 */
	public int selectCloudStrgInFldrAndFileCount(String cloudStrgCd);

	/**
	 * 폴더에서 가져온 폴더 및 파일의 총 카운트 수
	 * @param cloudStrgCd
	 * @return
	 */
	public int selectCloudFldrInFldrAndFileCount(String cloudStrgCd);

	/**
	 * 폴더를 다른 저장소로 이동하기
	 * @param cloudStrgFldrVO
	 * @return
	 */
	public int cloudMoveFldr(CloudFldrOrFileVO cloudMoveVO);

	/**
	 * 파일을 다른 저장소로 이동하기
	 * @param cloudFileVO
	 * @return
	 */
	public int cloudMoveFile(CloudFldrOrFileVO cloudMoveVO);

	/**
	 * 선택한 폴더 중에 하위 폴더가 있는지 여부 확인
	 * @param cloudMoveVO
	 * @return
	 */
	public int innerDownFlrdCheck(CloudFldrOrFileVO cloudMoveVO);

	/**
	 * 키워드 검색하기
	 * @param pagingVO
	 * @return
	 */
	public int cloudListSearchCount(PaginationInfoVO<CloudStrgVO> pagingVO);

	/**
	 * 키워드 검색하기 카운트
	 * @param pagingVO
	 * @return
	 */
	public List<CloudStrgVO> cloudListSearch(PaginationInfoVO<CloudStrgVO> pagingVO);
	
	/**
	 * 개인 커스텀 클라우드함 만들기
	 * @param cloudStrgVO
	 * @return
	 */
	public int cloudStrgCustomInsert(CloudStrgVO cloudStrgVO);

	/**
	 * 개인 커스텀 클라우드함 삭제하기
	 * @param cloudStrgVO
	 * @return
	 */
	public int cloudStrgCustomDelete(CloudStrgVO cloudStrgVO);
	
	/**
	 * 특정 클라우드함의 정보 가져오기
	 * @param delVO
	 * @return
	 */
	public CloudStrgVO selectCloudStrg(String cloudStrg);

	/**
	 * 특정 파일의 정보 가져오기
	 * @param delVO
	 * @return
	 */
	public CloudFileVO selectCloudFile(CloudFldrOrFileVO delVO);

	/**
	 * 특정 폴더의 정보 가져오기
	 * @param delVO
	 * @return
	 */
	public CloudStrgFldrVO selectCloudFldr(CloudFldrOrFileVO delVO);

	/**
	 * 폴더 삭제하기
	 * @param delVO
	 * @return
	 */
	public int cloudFldrDelete(CloudFldrOrFileVO delVO);

	/**
	 * 파일 삭제하기
	 * @param delVO
	 * @return
	 */
	public int cloudFileDelete(CloudFldrOrFileVO delVO);

	/**
	 * 로그인한 사람의 회사 직급 리스트 가져오기
	 * @param coCd
	 * @return
	 */
	public List<JobGradeVO> jobgradeSelectList(String coCd);

	/**
	 * 새폴더 만들기
	 * @param cloudStrgFldrVO
	 * @return
	 */
	public int cloudNewFldrInsert(CloudStrgFldrVO cloudStrgFldrVO);

	/**
	 * 폴더 권한 리스트 생성하기
	 * @param cloudFldrAuthrtList
	 * @return
	 */
	public int cloudFldrAuthListInsert(CloudFldrAuthrtVO cloudFldrAuthrtList);

	/**
	 * 기존 폴더의 열람 권한 리스트 불러오기
	 * @param cloudStrgFldrCd
	 * @return
	 */
	public List<CloudFldrAuthrtVO> cloudFldrAuthrtListSelect(String cloudStrgFldrCd);

	/**
	 * 클라우드 폴더 수정하기
	 * @param cloudStrgFldrVO
	 * @return
	 */
	public int cloudFldrUpdate(CloudStrgFldrVO cloudStrgFldrVO);

	/**
	 * 클라우드 폴더의 열람권한 리스트 삭제하기
	 * @param cloudStrgFldrVO
	 * @return
	 */
	public int cloudFldrAuthrtListDelete(CloudStrgFldrVO cloudStrgFldrVO);

	/**
	 * 새폴더명 중복 체크하기
	 * @param cloudFldrName
	 * @return
	 */
	public int newCloudFldrNameCheck(CloudStrgFldrVO cloudStrgFldrVO);
	
	/**
	 * 기존 폴더명 중복 체크하기
	 * @param cloudFldrName
	 * @return
	 */
	public int modifyCloudFldrNameCheck(CloudStrgFldrVO cloudStrgFldrVO);

	/**
	 * 특정 폴더의 권한 가져오기
	 * @param cloudStrgFldrCd
	 * @return
	 */
	public List<CloudFldrAuthrtVO> fldrAuthrtSelectList(String cloudStrgFldrCd);

	/**
	 * 폴더 권한 바꾸기 (Y)
	 * @param authrtVO
	 */
	public int cloudFldrAuthListUpdateY(CloudFldrAuthrtVO authrtVO);

	/**
	 * 폴더 권한 바꾸기 (N)
	 * @param authrtVO
	 */
	public int cloudFldrAuthListUpdateN(CloudFldrAuthrtVO authrtVO);
	

	/**
	 * 특정 폴더에 속한 파일 리스트 가져오기
	 * @param cloudStrgFldrCd
	 * @return
	 */
	public List<CloudFileVO> cloudFileListSelect(String cloudStrgFldrCd);
	
	/**
	 * 파일의 저장 경로명 수정하기
	 * @param fileVO
	 */
	public int cloudFilePathUpdate(CloudFileVO fileVO);

	/**
	 * 지정한 클라우드함 내의 모든 파일 크기의 합 가져오기
	 * @param selectStrgCd
	 * @return
	 */
	public long cloudStrgFileSizeSumSelect(String selectStrgCd);

	/**
	 * 업로드하려는 폴더에 중복 파일 이름이 있는지 체크하기
	 * @param CloudFileVO
	 * @return
	 */
	public int cloudFileNameCheck(CloudFileVO param);

	/**
	 * 각 폴더가 내 직급으로 열람 권한이 있는지 여부를 확인하기
	 * @param map
	 * @return
	 */
	public String cloudFldrAuthCheckOne(Map<String, String> map);
	
}

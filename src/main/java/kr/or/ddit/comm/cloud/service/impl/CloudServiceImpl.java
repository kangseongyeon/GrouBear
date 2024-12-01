package kr.or.ddit.comm.cloud.service.impl;

import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.google.common.io.Files;

import kr.or.ddit.comm.cloud.mapper.ICloudMapper;
import kr.or.ddit.comm.cloud.service.ICloudService;
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
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class CloudServiceImpl implements ICloudService {
	@Resource(name = "cloudPath")
	private String cloudPath;
	
	@Inject
	private ICloudMapper cloudMapper;

	@Override
	public int comCloudStrgCreate(EmployeeVO empVO) {
		return cloudMapper.comCloudStrgCreate(empVO);
	}

	@Override
	public int deptCloudStrgCreate(EmployeeAllVO empAllVO) {
		return cloudMapper.deptCloudStrgCreate(empAllVO);
	}

	@Override
	public int empCloudStrgCreate(EmployeeVO empVO) {
		return cloudMapper.empCloudStrgCreate(empVO);
	}
	
	/**
	 * 전사, 부서, 개인 클라우드함 가져오기 (사이드바 클라우드함 리스트)
	 */
	@Override
	public List<CloudStrgVO> selectMainCloudStrgList(EmployeeAllVO employeeAllVO) {
		return cloudMapper.selectMainCloudStrgList(employeeAllVO);
	}

	/**
	 * 클라우드함 내부의 폴더 및 파일 불러오기
	 */
	@Override
	public List<CloudStrgVO> selectCloudStrgInFldrAndFileList(String cloudStrgCd) {
		return cloudMapper.selectCloudStrgInFldrAndFileList(cloudStrgCd);
	}

	/**
	 * 폴더 내부의 폴더 및 파일 불러오기
	 */
	@Override
	public List<CloudStrgVO> selectCloudFldrInFldrAndFileList(String cloudStrgFldrCd) {
		return cloudMapper.selectCloudFldrInFldrAndFileList(cloudStrgFldrCd);
	}

	/**
	 * 선택한 폴더의 정보 및 권한 리스트 불러오기
	 */
	@Override
	public CloudStrgFldrVO selectCloudFldrDetail(String cloudStrgFldrCd) {
		return cloudMapper.selectCloudFldrDetail(cloudStrgFldrCd);
	}

	/**
	 * 선택한 폴더의 경로를 계층형으로 가져오기
	 */
	@Override
	public List<CloudStrgVO> selectCloudPath(String cloudStrgFldrCd) {
		return cloudMapper.selectCloudPath(cloudStrgFldrCd);
	}

	/**
	 * 개인 클라우드함에 속한 커스텀 클라우드함 불러오기 
	 */
	@Override
	public List<CloudStrgVO> selectMyCloudStrgCustomList(EmployeeVO empVO) {
		return cloudMapper.selectMyCloudStrgCustomList(empVO);
	}

	/**
	 * Jstree를 가져오기 위한 루트 클라우드함 리스트 가져오기
	 */
	@Override
	public List<StrgListVO> cloudSelectJstree(Map<String, String> map) {
		
		List<StrgListVO> rootStrg = cloudMapper.cloudSelectRootStrg(map);
		List<StrgListVO> result = cloudMapper.cloudSelectJstree(rootStrg);
		
		for (StrgListVO strgListVO : rootStrg) {
			result.add(strgListVO);
		}
		return result;
	}

	/**
	 * 클라우드 파일 업로드하기
	 */
	@Override
	public ServiceResult cloudFileListInsert(String strgSelectCd, EmployeeVO empVO, List<CloudFileVO> cloudFileList) {
		ServiceResult result = null;
		int status = 0;
		
		// 파일 리스트가 비어있는지 확인 & 파일 insert하기
		if (cloudFileList != null && cloudFileList.size() > 0) {
			for (CloudFileVO cloudFileVO : cloudFileList) {
				
				String filePath = "";
				List<CloudStrgVO> CloudStrgList = cloudMapper.selectCloudPath(cloudFileVO.getCloudFileUpCd());	// 경로 가져오기
				log.info(CloudStrgList.toString());
				if (CloudStrgList.isEmpty()) {	// 클라우드함에 보관일 때
					CloudStrgVO cloudStrgVO = cloudMapper.selectCloudStrg(cloudFileVO.getCloudFileUpCd());
					filePath = File.separator + cloudStrgVO.getCloudStrgCd() + "_" + cloudStrgVO.getCloudStrgNm();
				} else {						// 폴더에 보관일 때
					for (CloudStrgVO cloudStrgVO : CloudStrgList) {
						if (cloudStrgVO.getCloudCd().contains("STR")) {
							CloudStrgVO strgVO = cloudMapper.selectCloudStrg(cloudStrgVO.getCloudCd());
							filePath = File.separator + strgVO.getCloudStrgCd() + "_" + strgVO.getCloudStrgNm();
						} else {
							CloudFldrOrFileVO param = new CloudFldrOrFileVO();
							param.setFldrOrFileCd(cloudStrgVO.getCloudCd());
							
							CloudStrgFldrVO cloudStrgFldrVO = cloudMapper.selectCloudFldr(param);
							filePath +=  File.separator + cloudStrgFldrVO.getCloudStrgFldrCd() + "_" + cloudStrgFldrVO.getCloudStrgFldrNm();
						}
					}
				}
				// 최종 파일 보관 위치 (파일 이름 붙여야 함)
				String locatePath = cloudPath + File.separator + empVO.getCoCd() + filePath;
				
				// 파일 경로 여부 확인 & 파일 복사하기
				fileUpload(locatePath, empVO, cloudFileList);
				
				
				cloudFileVO.setCloudFilePathNm(locatePath);
				int res = cloudMapper.cloudFileListInsert(cloudFileVO);
				status += res;
				
				// 파일 경로 여부 확인 & 파일 복사하기
//				fileUpload(filePath, empVO, cloudFileList);
			}
			
			if (status > 0) {
				result = ServiceResult.OK;
			} else {
				result = ServiceResult.FAILED;
			}
		}
		return result;
	}

	public void fileUpload(String locatePath, EmployeeVO empVO, List<CloudFileVO> cloudFileList) {
		String cloudFilePath = locatePath;	// 저장할 클라우드 또는 폴더의 최종 경로
		
		// 파일 저장할 경로 만들기
		File file = new File(cloudFilePath);
		if (!file.exists()) {
			if(file.mkdirs()) {
				log.info(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 디렉토리 생성완료");
			} else {
				log.info(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 디렉토리 생성실패");
			}
		}
		
		// 파일 복사하기
		for (CloudFileVO cloudFileVO : cloudFileList) {
			String saveLocate = cloudFilePath + File.separator + cloudFileVO.getCloudFileStrgNm();
			
			File saveFile = new File(saveLocate);
			
			try {
				cloudFileVO.getMultiFile().transferTo(saveFile);
				log.info(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 파일이 저장되었습니다 : " + saveLocate);
			} catch (IOException e) {
				log.info(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 파일 저장 중 오류 발생: " + e.getMessage());
			}
		}
	}

	@Override
	public CloudStrgVO selectParentCloud(String cloudStrgCd) {
		return cloudMapper.selectParentCloud(cloudStrgCd);
	}

	@Override
	public int selectCloudStrgInFldrAndFileCount(String cloudStrgCd) {
		return cloudMapper.selectCloudStrgInFldrAndFileCount(cloudStrgCd);
	}

	@Override
	public int selectCloudFldrInFldrAndFileCount(String cloudStrgCd) {
		return cloudMapper.selectCloudFldrInFldrAndFileCount(cloudStrgCd);
	}
	
	@Override
	public ServiceResult cloudMove(CloudFldrOrFileVO cloudMoveVO, String coCd) {
	ServiceResult result = null;
		int status = 0;
		log.info("cloudMove->cloudMoveVO : " + cloudMoveVO);
		log.info("cloudMove->coCd : " + coCd);
		
		if (cloudMoveVO.getFldrOrFileCd().contains("FDR")) {
			// 폴더 내부에 있는 파일 먼저 옮기기
			List<CloudFileVO> fileList = cloudMapper.cloudFileListSelect(cloudMoveVO.getFldrOrFileCd());
			String oldPath = "";
			
			if (fileList.isEmpty()) {	// 폴더 내에 파일이 없다면
				// 기존에 있던 폴더 삭제하기
				String fldrPath = "";
				List<CloudStrgVO> CloudStrgList = cloudMapper.selectCloudPath(cloudMoveVO.getFldrOrFileCd());	// 경로 가져오기
				
				for (CloudStrgVO cloudStrgVO : CloudStrgList) {
					if (cloudStrgVO.getCloudCd().contains("STR")) {
						CloudStrgVO strgVO = cloudMapper.selectCloudStrg(cloudStrgVO.getCloudCd());
						fldrPath = File.separator + strgVO.getCloudStrgCd() + "_" + strgVO.getCloudStrgNm();
					} else {
						CloudFldrOrFileVO param = new CloudFldrOrFileVO();
						param.setFldrOrFileCd(cloudStrgVO.getCloudCd());
						
						CloudStrgFldrVO cloudStrgFldrVO = cloudMapper.selectCloudFldr(param);
						fldrPath +=  File.separator + cloudStrgFldrVO.getCloudStrgFldrCd() + "_" + cloudStrgFldrVO.getCloudStrgFldrNm();
					}
				}
				
				String locatePath = cloudPath + File.separator + coCd + fldrPath;
				File file = new File(locatePath);
				
				if (file.exists()) {
					file.delete();
				}
				
				status += cloudMapper.cloudMoveFldr(cloudMoveVO);
			} else {	// 폴더 내에 파일이 있다면
				
				// 폴더 내부 파일 먼저 옮기기
				for (CloudFileVO cloudFileVO : fileList) {
					// 새로운 경로 세팅하기
					List<CloudStrgVO> CloudStrgList = cloudMapper.selectCloudPath(cloudMoveVO.getCloudUpCd());	// 경로 가져오기
					String newPath = "";
					
					if (CloudStrgList.isEmpty()) {	// 클라우드함에 보관일 때
						CloudStrgVO cloudStrgVO = cloudMapper.selectCloudStrg(cloudFileVO.getCloudFileUpCd());
						newPath = File.separator + cloudStrgVO.getCloudCd() + "_" + cloudStrgVO.getCloudNm();
					} else {						// 폴더에 보관일 때
						for (CloudStrgVO cloudStrgVO : CloudStrgList) {
							if (cloudStrgVO.getCloudCd().contains("STR")) {
								CloudStrgVO strgVO = cloudMapper.selectCloudStrg(cloudStrgVO.getCloudCd());
								newPath = File.separator + strgVO.getCloudStrgCd() + "_" + strgVO.getCloudStrgNm();
							} else {
								CloudFldrOrFileVO param = new CloudFldrOrFileVO();
								param.setFldrOrFileCd(cloudStrgVO.getCloudCd());
								
								CloudStrgFldrVO cloudStrgFldrVO = cloudMapper.selectCloudFldr(param);
								newPath +=  File.separator + cloudStrgFldrVO.getCloudStrgFldrCd() + "_" + cloudStrgFldrVO.getCloudStrgFldrNm();
							}
						}
					}
					
					// 기존 경로 가져오기
					CloudFldrOrFileVO param = new CloudFldrOrFileVO();
					param.setFldrOrFileCd(cloudMoveVO.getFldrOrFileCd());
					param.setCloudUpCd(cloudMoveVO.getCloudUpCd());
					
					status += cloudMapper.cloudMoveFldr(param);
					
					// 새로 옮기는 파일의 경로 만들기
					// C:\GrouBear\cloudFile\b001\STR1\FDR138\FDR139
					CloudStrgFldrVO fldrVO = cloudMapper.selectCloudFldr(cloudMoveVO);
					
					File file = new File(cloudPath + File.separator + coCd + newPath + File.separator + fldrVO.getCloudStrgFldrCd() + "_" + fldrVO.getCloudStrgFldrNm());
					if (!file.exists()) {
						file.mkdirs();
					}
					
					oldPath = cloudFileVO.getCloudFilePathNm();
					String oldLocatePath = cloudFileVO.getCloudFilePathNm() + File.separator + cloudFileVO.getCloudFileStrgNm();
					String newLocatePath = cloudPath + File.separator + coCd + newPath + File.separator + fldrVO.getCloudStrgFldrCd() + "_" + fldrVO.getCloudStrgFldrNm() + File.separator + cloudFileVO.getCloudFileStrgNm();
					
					// 파일 이동하기
					// C:\GrouBear\cloudFile\b001\STR1\FDR139\
					File oldFile = new File(oldLocatePath);
					// C:\GrouBear\cloudFile\b001\STR1\FDR138\FDR139\
					File newFile = new File(newLocatePath);
					try {
						Files.move(oldFile, newFile);
					} catch (IOException e) {
						e.printStackTrace();
					}
					
					cloudFileVO.setCloudFilePathNm(cloudPath + File.separator + coCd + newPath + File.separator + fldrVO.getCloudStrgFldrCd() + "_" + fldrVO.getCloudStrgFldrNm());
					status += cloudMapper.cloudFilePathUpdate(cloudFileVO);
				}
					
				// 기존에 있던 폴더 삭제하기
				File file2 = new File(oldPath);
				
				if (file2.exists()) {
					file2.delete();
				}
				
				status += cloudMapper.cloudMoveFile(cloudMoveVO);
			}
			
		} else if (cloudMoveVO.getFldrOrFileCd().contains("FIL")) {//FIL259
			// 실제 서버에 업로드된 수정된 위치로 파일 옮기기
			// 새로운 경로 세팅하기
			List<CloudStrgVO> CloudStrgList = cloudMapper.selectCloudPath(cloudMoveVO.getCloudUpCd());	// 경로 가져오기
			String newPath = "";
			
			if (CloudStrgList.isEmpty()) {	// 클라우드함에 보관일 때
				CloudStrgVO cloudStrgVO = cloudMapper.selectCloudStrg(cloudMoveVO.getCloudUpCd());
				newPath = File.separator + cloudStrgVO.getCloudCd() + "_" + cloudStrgVO.getCloudNm();
			} else {						// 폴더에 보관일 때
				for (CloudStrgVO cloudStrgVO : CloudStrgList) {
					if (cloudStrgVO.getCloudCd().contains("STR")) {
						CloudStrgVO strgVO = cloudMapper.selectCloudStrg(cloudStrgVO.getCloudCd());
						newPath = File.separator + strgVO.getCloudStrgCd() + "_" + strgVO.getCloudStrgNm();
					} else {
						CloudFldrOrFileVO param = new CloudFldrOrFileVO();
						param.setFldrOrFileCd(cloudStrgVO.getCloudCd());
						
						CloudStrgFldrVO cloudStrgFldrVO = cloudMapper.selectCloudFldr(param);
						newPath +=  File.separator + cloudStrgFldrVO.getCloudStrgFldrCd() + "_" + cloudStrgFldrVO.getCloudStrgFldrNm();
					}
				}
			}
			
			// 기존 경로 가져오기
			CloudFileVO fileVO = cloudMapper.selectCloudFile(cloudMoveVO);
			
			// 새로 옮기는 파일의 경로 만들기
			File file = new File(cloudPath + File.separator + coCd + newPath);
			if (!file.exists()) {
				file.mkdirs();
			}
			
			// 기존 경로와 이동 경로 완성
			String oldLocatePath = fileVO.getCloudFilePathNm() + File.separator + fileVO.getCloudFileStrgNm();
			String newLocatePath = cloudPath + File.separator + coCd + newPath + File.separator + fileVO.getCloudFileStrgNm();
			
			// 파일VO의 경로명 새로 수정하기
			fileVO.setCloudFilePathNm(cloudPath + File.separator + coCd + newPath);
			cloudMapper.cloudFilePathUpdate(fileVO);
			
			// 파일 이동하기
			File oldFile = new File(oldLocatePath);
			File newFile = new File(newLocatePath);
			try {
				Files.move(oldFile, newFile);
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			status += cloudMapper.cloudMoveFile(cloudMoveVO);
		}
		 
		if (status > 0) {
			result = ServiceResult.OK;
		}
		
		return result;
	}

	@Override
	public int innerDownFlrdCheck(CloudFldrOrFileVO cloudMoveVO) {
		return cloudMapper.innerDownFlrdCheck(cloudMoveVO);
	}

	@Override
	public int cloudListSearchCount(PaginationInfoVO<CloudStrgVO> pagingVO) {
		return cloudMapper.cloudListSearchCount(pagingVO);
	}

	@Override
	public List<CloudStrgVO> cloudListSearch(PaginationInfoVO<CloudStrgVO> pagingVO) {
		return cloudMapper.cloudListSearch(pagingVO);
	}

	@Override
	public ServiceResult cloudStrgCustomInsert(CloudStrgVO cloudStrgVO) {
		ServiceResult result = null;
		
		int status = cloudMapper.cloudStrgCustomInsert(cloudStrgVO);
		
		if (status > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}
		
		return result;
	}

	@Override
	public ServiceResult cloudStrgCustomDelete(CloudStrgVO cloudStrgVO) {
		ServiceResult result = null;
		
		int status = cloudMapper.cloudStrgCustomDelete(cloudStrgVO);
		
		if (status > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}
		
		return result;
	}

	@Override
	public ServiceResult cloudFldrOrFileDelete(EmployeeVO empVO, CloudFldrOrFileVO delVO) {
		ServiceResult result = null;
		int status = 0;
		
		CloudFileVO cloudFileVO = new CloudFileVO();
		
		if (delVO.getFldrOrFileCd().contains("FDR")) {	// 폴더라면
			// 해당 폴더 내에 있는 파일 먼저 삭제하기
			List<CloudFileVO> fileList = cloudMapper.cloudFileListSelect(delVO.getFldrOrFileCd());
			
			if (fileList.isEmpty()) {	// 폴더 내에 파일이 없다면
				// 실제 서버에 업로드된 폴더 삭제하기
				List<CloudStrgVO> CloudStrgList = cloudMapper.selectCloudPath(delVO.getFldrOrFileCd());	// 경로 가져오기
				String fldrPath = "";
				
				for (CloudStrgVO cloudStrgVO : CloudStrgList) {
					fldrPath +=  File.separator + cloudStrgVO.getCloudCd();
				}
				
				String locatePath = cloudPath + File.separator + empVO.getCoCd() + fldrPath;
				File file = new File(locatePath);
				
				if (file.exists()) {
					file.delete();
				}
				
				status += cloudMapper.cloudFldrDelete(delVO);
				CloudStrgFldrVO cloudStrgFldrVO = new CloudStrgFldrVO();
				cloudStrgFldrVO.setCloudStrgFldrCd(delVO.getFldrOrFileCd());
				status += cloudMapper.cloudFldrAuthrtListDelete(cloudStrgFldrVO);
			} else {	// 폴더 내에 파일이 있다면
				// 폴더 내부 파일 먼저 삭제하기
				for (CloudFileVO fileVO : fileList) {
					CloudFldrOrFileVO param = new CloudFldrOrFileVO();
					param.setFldrOrFileCd(fileVO.getCloudFileCd());
					
					cloudFileVO = cloudMapper.selectCloudFile(param);
					status += cloudMapper.cloudFileDelete(param);
					
					File files = new File(cloudFileVO.getCloudFilePathNm() + File.separator + cloudFileVO.getCloudFileStrgNm());
					
					if (files.exists()) {
						files.delete();
					}
					
					// 실제 서버에 업로드된 폴더 삭제하기
					List<CloudStrgVO> CloudStrgList = cloudMapper.selectCloudPath(delVO.getFldrOrFileCd());	// 경로 가져오기
					String fldrPath = "";
					
					for (CloudStrgVO cloudStrgVO : CloudStrgList) {
						fldrPath +=  File.separator + cloudStrgVO.getCloudCd();
					}
					
					String locatePath = cloudPath + File.separator + empVO.getCoCd() + fldrPath;
					File dir = new File(locatePath);
					
					if (dir.exists()) {
						dir.delete();
					}
					
					status += cloudMapper.cloudFldrDelete(delVO);
					CloudStrgFldrVO cloudStrgFldrVO = new CloudStrgFldrVO();
					cloudStrgFldrVO.setCloudStrgFldrCd(delVO.getFldrOrFileCd());
					status += cloudMapper.cloudFldrAuthrtListDelete(cloudStrgFldrVO);
				}
			}
			
		} else if (delVO.getFldrOrFileCd().contains("FIL")) {	// 파일이라면
			cloudFileVO = cloudMapper.selectCloudFile(delVO);
			status += cloudMapper.cloudFileDelete(delVO);
			
			File file = new File(cloudFileVO.getCloudFilePathNm() + File.separator + cloudFileVO.getCloudFileStrgNm());
			
			if (file.exists()) {
				file.delete();
			}
		}
		
		if (status > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}
		
		return result;
	}

	@Override
	public List<JobGradeVO> jobgradeSelectList(String coCd) {
		return cloudMapper.jobgradeSelectList(coCd);
	}

	@Override
	public int cloudNewFldrInsert(CloudStrgFldrVO cloudStrgFldrVO) {
		return cloudMapper.cloudNewFldrInsert(cloudStrgFldrVO);
	}

	@Override
	public ServiceResult cloudFldrAuthListInsert(List<CloudFldrAuthrtVO> cloudFldrAuthrtList) {
		ServiceResult result = null;
		int status = 0;
		
		for (CloudFldrAuthrtVO cloudFldrAuthrtVO : cloudFldrAuthrtList) {
			status += cloudMapper.cloudFldrAuthListInsert(cloudFldrAuthrtVO);
		}
		
		if (status > 0) {
			result = ServiceResult.OK;
		} else {
			result = ServiceResult.FAILED;
		}
		
		return result;
	}

	@Override
	public List<CloudFldrAuthrtVO> cloudFldrAuthrtListSelect(String cloudStrgFldrCd) {
		return cloudMapper.cloudFldrAuthrtListSelect(cloudStrgFldrCd);
	}

	@Override
	public int cloudFldrUpdate(CloudStrgFldrVO cloudStrgFldrVO) {
		return cloudMapper.cloudFldrUpdate(cloudStrgFldrVO);
	}

	@Override
	public int cloudFldrAuthrtListDelete(CloudStrgFldrVO cloudStrgFldrVO) {
		return cloudMapper.cloudFldrAuthrtListDelete(cloudStrgFldrVO);
	}

	@Override
	public int newCloudFldrNameCheck(CloudStrgFldrVO cloudStrgFldrVO) {
		return cloudMapper.newCloudFldrNameCheck(cloudStrgFldrVO);
	}
	
	@Override
	public int modifyCloudFldrNameCheck(CloudStrgFldrVO cloudStrgFldrVO) {
		return cloudMapper.modifyCloudFldrNameCheck(cloudStrgFldrVO);
	}

	@Override
	public List<CloudFldrAuthrtVO> fldrAuthrtSelectList(String cloudStrgFldrCd) {
		return cloudMapper.fldrAuthrtSelectList(cloudStrgFldrCd);
	}

	@Override
	public int cloudFldrAuthListUpdateY(CloudFldrAuthrtVO authrtVO) {
		return cloudMapper.cloudFldrAuthListUpdateY(authrtVO);
	}

	@Override
	public int cloudFldrAuthListUpdateN(CloudFldrAuthrtVO authrtVO) {
		return cloudMapper.cloudFldrAuthListUpdateN(authrtVO);
	}

	@Override
	public CloudFileVO selectCloudFile(CloudFldrOrFileVO cloudFile) {
		return cloudMapper.selectCloudFile(cloudFile);
	}

	@Override
	public CloudStrgVO selectCloudStrg(String cloudCd) {
		return cloudMapper.selectCloudStrg(cloudCd);
	}

	@Override
	public CloudStrgFldrVO selectCloudFldr(CloudFldrOrFileVO param) {
		return cloudMapper.selectCloudFldr(param);
	}

	@Override
	public long cloudStrgFileSizeSumSelect(String selectStrgCd) {
		return cloudMapper.cloudStrgFileSizeSumSelect(selectStrgCd);
	}

	@Override
	public ServiceResult cloudFileNameCheck(CloudFileVO param) {
		ServiceResult result = null;
		int status = cloudMapper.cloudFileNameCheck(param);
		
		if (status > 0) {
			result = ServiceResult.EXIST;
		} else {
			result = ServiceResult.OK;
		}
		return result;
	}

	@Override
	public String cloudFldrAuthCheckOne(Map<String, String> map) {
		return cloudMapper.cloudFldrAuthCheckOne(map);
	}

	
}

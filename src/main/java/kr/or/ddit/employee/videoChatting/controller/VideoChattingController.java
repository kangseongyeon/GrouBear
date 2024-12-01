package kr.or.ddit.employee.videoChatting.controller;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import kr.or.ddit.comm.paging.vo.PaginationInfoVO;
import kr.or.ddit.comm.security.vo.CustomUser;
import kr.or.ddit.comm.security.vo.EmployeeVO;
import kr.or.ddit.employee.videoChatting.service.IVideoChattingService;
import kr.or.ddit.employee.videoChatting.vo.VideoChattingVO;
import lombok.extern.slf4j.Slf4j;
import okhttp3.MediaType;
import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;

@Slf4j
@Controller
@RequestMapping("/employee")
public class VideoChattingController {


@Inject
private IVideoChattingService vcService;

 @GetMapping("/videochatting.do")
    public String videoHome(
    		@RequestParam(name="page", required = false, defaultValue = "1")int currentPage, 
    		@RequestParam(required = false, defaultValue = "title") String searchType,
    		@RequestParam(required = false) String searchWord,  Model model
    		){
	 	PaginationInfoVO<VideoChattingVO> pagingVO = new PaginationInfoVO<VideoChattingVO>(10, 5);
	 	
			CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
			EmployeeVO empVO = user.getMember();
			
	 	
	 // 검색 기능 추가
		if(StringUtils.isNotBlank(searchWord)) {
			pagingVO.setSearchWord(searchWord);
			pagingVO.setSearchType(searchType);
			model.addAttribute("searchWord", searchWord);
			model.addAttribute("searchType", searchType);
		}
		// startRow, endRow, startPage, endPage를 결정한다,.
		pagingVO.setCurrentPage(currentPage);
		
		// 총 게시글 수를 이용하여 총 페이지수를 결정하기 위해 총 게시글 수인 totalRecord를 얻어온다.
		int totalRecord = vcService.selectVcRoom(pagingVO);
		// totalPage를 결정한다.
		pagingVO.setTotalRecord(totalRecord);
		// 총 데시글 수 및 총 페이지수, startRow, endRow의 값들을 이용하여 초기 1페이지에 들어있는 총 screenSize 개수만큼의
		// 리스트 데이터를 가져온다
		List<VideoChattingVO> dataList = vcService.selectVcList(pagingVO);
		pagingVO.setDataList(dataList);
		
		model.addAttribute("empVO",empVO);
		model.addAttribute("pagingVO", pagingVO); 

	 
	 
	 
//	        OkHttpClient client = new OkHttpClient();
//
//			Request request = new Request.Builder()
//					.url("https://openapi.gooroomee.com/api/v1/room/list?page=1&limit=10&sortCurrJoinCnt=true")
//					.get()
//					.addHeader("accept", "application/json")
//					.addHeader("X-GRM-AuthToken", "12056163501988613cf51b7b51cdd8140bb172761d02211a8b")
//					.build();
//
//	        Response response = client.newCall(request).execute();
//
//	        JSONParser jsonParser = new JSONParser();
//	        Object obj = jsonParser.parse(response.body().string());
//	        JSONObject jsonObj = (JSONObject) obj;
//
//	        model.addAttribute("roomList", jsonObj);


        return "employee/videoChatting/videoChatting";
    }
 
 @PostMapping("/createroom")
 @ResponseBody
 public JSONObject createroom(@RequestBody Map<String, Object> value, Model model) throws Exception {
	 
	 CustomUser user = (CustomUser) SecurityContextHolder.getContext().getAuthentication().getPrincipal();
	 EmployeeVO empVO = user.getMember();
	 
	 String roomName = value.get("value").toString();
     String roomUrl = "http:biz.gooroomee.com/" + roomName; 
     
     // 비밀번호와 비밀번호 필요 여부 추가
     String videoChatPw = (String) value.get("videoChatPw");
     boolean passwordRequired = (boolean) value.get("passwordRequired");
     
     
     VideoChattingVO vcVO = new VideoChattingVO();
     vcVO.setVideoChatNm(roomName);
     vcVO.setVideoChatMas(empVO.getEmpNm());
     vcVO.setVideoChatCom(empVO.getCoCd());
     vcVO.setVideoChatId(empVO.getEmpId());
     vcVO.setVideoChatUrl(roomUrl);
     vcVO.setVideoChatPw(videoChatPw);; // 비밀번호 저장
     vcVO.setPasswordRequired(passwordRequired); // 비밀번호 필요 여부 저장
     vcService.vcInsert(vcVO);
     
     // 방생성
     OkHttpClient client = new OkHttpClient();
     MediaType mediaType = MediaType.parse("application/x-www-form-urlencoded");
     okhttp3.RequestBody body = okhttp3.RequestBody.create(mediaType, "callType=P2P&liveMode=false&maxJoinCount=48&liveMaxJoinCount=100&layoutType=4&roomTitle=" + roomName + "&durationMinutes=3000");

     Request request = new Request.Builder()
         .url("https://openapi.gooroomee.com/api/v1/room")
         .post(body)
         .addHeader("accept", "application/json")
         .addHeader("content-type", "application/x-www-form-urlencoded")
         .addHeader("X-GRM-AuthToken", "12056163501988613cf51b7b51cdd8140bb172761d02211a8b")
         .build();

     Response response = client.newCall(request).execute();

     
     
     // 방목록
     client = new OkHttpClient();
     request = new Request.Builder()
         .url("https://openapi.gooroomee.com/api/v1/room/list?page=1&limit=10&sortCurrJoinCnt=true")
         .get()
         .addHeader("accept", "application/json")
         .addHeader("X-GRM-AuthToken", "12056163501988613cf51b7b51cdd8140bb172761d02211a8b")
         .build();

     response = client.newCall(request).execute();

     JSONParser jsonParser = new JSONParser();
     Object obj = jsonParser.parse(response.body().string());
     JSONObject jsonObj = (JSONObject) obj;

     return jsonObj;
 }
 
 @PostMapping("/deleteroom/{id}")
 @ResponseBody
 public ResponseEntity<String> deleteRoom(@PathVariable String id) {
     try {
         // 데이터베이스에서 방 삭제
         vcService.vcDelete(id);
         return ResponseEntity.ok("방이 성공적으로 삭제되었습니다.");
     } catch (Exception e) {
         return ResponseEntity.status(500).body("방 삭제 실패: " + e.getMessage());
     }
 }
 

 @GetMapping("/getRoomList")
 public ResponseEntity<List<VideoChattingVO>> getRoomList(){
	 List<VideoChattingVO> rooms = vcService.getAllRooms();
	 
	 return ResponseEntity.ok().body(rooms);
 }
 
 
 
 

}
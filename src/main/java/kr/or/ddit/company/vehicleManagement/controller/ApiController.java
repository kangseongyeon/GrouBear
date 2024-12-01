package kr.or.ddit.company.vehicleManagement.controller;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

@Controller
@RequestMapping("/api")
public class ApiController {

    private final String KAKAO_API_URL = "https://apis-navi.kakaomobility.com/v1/directions";

    @RequestMapping("/api/directions")
    @ResponseBody
    public ResponseEntity<String> getDirections(@RequestParam String origin, @RequestParam String destination) {
        String apiKey = "17644fb9da903ca514386f792886c4d9"; // 발급받은 API 키로 변경

        RestTemplate restTemplate = new RestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", "KakaoAK " + apiKey);
        headers.set("Content-Type", "application/json");

        String url = KAKAO_API_URL + "?origin=" + origin + "&destination=" + destination;

        HttpEntity<String> entity = new HttpEntity<>(headers);
        ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.GET, entity, String.class);

        return ResponseEntity.status(response.getStatusCode()).body(response.getBody());
    }
}

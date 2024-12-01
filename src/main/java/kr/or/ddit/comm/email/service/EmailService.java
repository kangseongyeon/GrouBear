package kr.or.ddit.comm.email.service;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

@Service
public class EmailService {

    @Autowired
    protected JavaMailSender mailSender;

    public boolean sendMailFindId(String findId, String empEmail) {
        try {
            MimeMessage msg = mailSender.createMimeMessage();  
            
            MimeMessageHelper helper = new MimeMessageHelper(msg, true, "UTF-8");  

			//보내는 사람
            helper.setFrom("heuk0722@naver.com");
            
            //받는 사람
            helper.setTo(empEmail);
			
			//제목
            helper.setSubject("GrouBear 아이디 입니다.");
			
			//내용
            helper.setText("GrouBear 아이디 : " + findId, true);

			//전송
            mailSender.send(msg);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

	public boolean sendAuthNumMail(int authNum, String findemail) {
		try {
            MimeMessage msg = mailSender.createMimeMessage();  
            
            MimeMessageHelper helper = new MimeMessageHelper(msg, true, "UTF-8");  

			//보내는 사람
            helper.setFrom("heuk0722@naver.com");
            
            //받는 사람
            helper.setTo(findemail);
			
			//제목
            helper.setSubject("GrouBear 인증번호 입니다.");
			
			//내용
            helper.setText("GrouBear 인증번호 : " + authNum, true);

			//전송
            mailSender.send(msg);
            return true;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
	}
}

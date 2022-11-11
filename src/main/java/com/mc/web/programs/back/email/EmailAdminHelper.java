package com.mc.web.programs.back.email;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.concurrent.Future;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.mail.EmailException;
import org.apache.commons.mail.HtmlEmail;
import org.apache.log4j.Logger;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.AsyncResult;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.stereotype.Component;

import com.mc.web.MCMap;
import com.mc.web.service.Globals;

import egovframework.com.cmm.util.EgovHttpRequestHelper;

@EnableAsync
@Component
public class EmailAdminHelper{
	Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private EmailAdminDAO dao;
	
	private int sendmail_cnt = 0;

	public void send_result(Map params) throws Exception {
		params.put("status", "P");
		dao.send_result(params);
	}
	
	public String send_mail_cnt(Map params) throws Exception {
		return String.valueOf(sendmail_cnt);
	}
	
	@Async
	public Future<String> future_send_mail(Map params) throws Exception {
		return new AsyncResult<String>(run(params));
	}
	public String run(Map params) throws Exception {
		sendmail_cnt = 0;
		final int BLOCK_CNT = 20;//한번에 보낼 인원수
		int totalPage = 0;//총 페이지
		List list = dao.send_info_list(params);
		List<MCMap> smtp_list = dao.smtp_list_all();
		Iterator<MCMap> iter = smtp_list.iterator();
		totalPage = list.size()%BLOCK_CNT==0 ? list.size()/BLOCK_CNT : (list.size()/BLOCK_CNT+1);
		for (int i = 0; i < totalPage; i++) {
			List<MCMap> unit_list = null;
			if((i*BLOCK_CNT)+BLOCK_CNT>list.size()){
				unit_list = list.subList(i*BLOCK_CNT, list.size());
			}else{
				unit_list = list.subList(i*BLOCK_CNT, (i*BLOCK_CNT)+BLOCK_CNT);
			}
			sendmail_cnt = sendmail_cnt + unit_list.size();
			if(!iter.hasNext()){
				iter = smtp_list.iterator();
			}
			send_mail(iter.next(), unit_list, (String)params.get("home_url"));
		}
		params.put("status", "S");
		dao.send_result(params);
		return "S";
	}
	
	public void send_mail(MCMap smtp, List<MCMap> unit_list, String home_url){
		String hide_img = "";
		HtmlEmail email = null;
		for (MCMap map : unit_list) {
			String receive_url = home_url+"/email/receive.do?seq="+map.getStrNull("seq");
			hide_img = "<img src='"+receive_url+"' style='display:none;'>";
			
			try {
				email = new HtmlEmail();
				email.setCharset("utf-8");
				email.setHostName(smtp.getStrNull("host"));
				email.setSmtpPort(smtp.getIntNumber("port"));
				if(!"-".equals(smtp.getStrNull("auth_id"))){
					email.setAuthentication(smtp.getStrNull("auth_id"), smtp.getStrNull("auth_pw"));
				}
				if("Y".equals(smtp.getStrNull("tls_yn"))){
					email.setTLS(true);
				}
				if("Y".equals(smtp.getStrNull("ssl_yn"))){
					email.setSSL(true);
				}
				email.setSubject(map.getStrNull("title").replaceAll("\\{\\{name\\}\\}", map.getStrNull("user_name")));
				email.setHtmlMsg(map.getStrNull("conts").replaceAll("\\{\\{name\\}\\}", map.getStrNull("user_name"))+hide_img);
				email.setFrom(map.getStrNull("sender_mail"), map.getStrNull("sender_nm"));
				email.addTo(map.getStrNull("user_email"), map.getStrNull("user_name"));
				email.send();
				dao.send_success(map);
				logger.info(map.getStrNull("user_name") + "님 발송");
			}catch(EmailException ee){
				dao.send_fail(map);
				logger.info(map.getStrNull("user_name") + "님 발송실패");
			}
		}
	}

	public Map mail_test(MCMap params) {
		Map rst = new HashMap();
		HtmlEmail email = new HtmlEmail();
		try{
			email.setCharset("utf-8");
			email.setHostName(params.getStrNull("host"));
			email.setSmtpPort(params.getIntNumber("port"));
			if(!"-".equals(params.getStrNull("auth_id"))){
				email.setAuthentication(params.getStrNull("auth_id"), params.getStrNull("auth_pw"));
			}
			if("Y".equals(params.getStrNull("tls_yn"))){
				email.setTLS(true);
			}
			if("Y".equals(params.getStrNull("ssl_yn"))){
				email.setSSL(true);
			}
			email.setSubject("테스트발송("+Math.random()+")");
			email.setMsg("안녕하세요 이것은 테스트발송입니다.");
			email.setFrom("mediacore2014@daum.net", "이창기");
			email.addTo("sdlckdrl@gmail.com");
			email.send(); 
			rst.put("rst", "1");
		}catch(Exception e){
			logger.error(e.getMessage());
			rst.put("msg", e.getMessage());
		}
		return rst;
	}

	@Test
	public void sendMailTest(){
		
//		final int BLOCK_CNT = 3;//한번에 보낼 인원수
//		int totalPage = 0;//총 페이지
//		List list = new ArrayList();
//		for (int i = 1; i <= 17; i++) {
//			list.add("A"+i);
//		}
//		totalPage = list.size()%BLOCK_CNT==0 ? list.size()/BLOCK_CNT : (list.size()/BLOCK_CNT+1);
//		for (int i = 0; i < totalPage; i++) {
//			if((i*BLOCK_CNT)+BLOCK_CNT>list.size()){
//				System.out.println(list.subList(i*BLOCK_CNT, list.size()));
//			}else{
//				System.out.println(list.subList(i*BLOCK_CNT, (i*BLOCK_CNT)+BLOCK_CNT));
//			}
//		}
		
		
		HtmlEmail email = new HtmlEmail();
		email.setCharset("utf-8");
		email.setHostName("175.126.123.248");
		email.setSmtpPort(587);
		email.setAuthentication("mail", "mail");
//		email.setAuthentication("kcomwell@mediacore.cafe24.com", "ab2053!@");
		email.setTLS(true);
		try {
			email.setSubject("근로 테스트...");
			email.setMsg("<!DOCTYPE HTML><html lang='ko'><head><meta charset='UTF-8'><title>타이틀</title></head><body><div style='color:red;'>안녕하세요</div></body></html>");
			email.setFrom("sdlckdrl@gmail.com", "이창기");
			email.addTo("sdlckdrl@mediacore.kr", "이창기");
			email.send();
		} catch (EmailException e) {
			e.printStackTrace();
		}
	}
}

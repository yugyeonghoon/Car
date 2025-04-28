<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="jakarta.mail.MessagingException"%>
<%@page import="jakarta.mail.internet.AddressException"%>
<%@page import="jakarta.mail.Transport"%>
<%@page import="jakarta.mail.Message"%>
<%@page import="jakarta.mail.internet.InternetAddress"%>
<%@page import="jakarta.mail.internet.MimeMessage"%>
<%@page import="jakarta.mail.PasswordAuthentication"%>
<%@page import="jakarta.mail.Authenticator"%>
<%@page import="jakarta.mail.Session"%>
<%@page import="java.util.Properties"%>
<%
//../login/signUp.jsp에서 회원가입 하고자 하는 사용자가 이메일 입력창에 입력한 
	//메일 주소를 받는다.
	String to = request.getParameter("email");

	String code = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
	String mailCode = "";
	
	for(int i =0; i < 6; i++){
		int random = (int)(Math.random() * code.length());
		
		char text = code.charAt(random);
		mailCode += text;
	}
	String host = "smtp.naver.com";
	
	String user = "wistua003@naver.com";
	
	String password = "Y6HXEZB7RWW1";
	
	String title = "차량분석 회원가입 인증번호";
	
	String body = "";
	body += "<div>";
	body += " <span>이메일 인증번호는 </span>";
	body += " <span style ='color:red;'>"+mailCode+"</span>";
	body += "</div>";
	
	Properties props = new Properties();
	
	props.put("mail.smtp.host", host);
	props.put("mail.smtp.port", "465");
	props.put("mail.smtp.auth", "true");
	props.put("mail.smtp.ssl.enable", "true");
	props.put("mail.smtp.ssl.trust", host);
	
	Session mailSession = Session.getInstance(props, new Authenticator(){
		@Override
		protected PasswordAuthentication getPasswordAuthentication(){
			return new PasswordAuthentication(user, password);
		}
	});
	
	MimeMessage message = new MimeMessage(mailSession);
	
	try{
		message.setFrom(new InternetAddress(user));
		
		message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
		
		message.setSubject(title);
		
		message.setContent(body, "text/html; charset=utf-8");
		
		Transport.send(message);
		out.print(mailCode);
	} catch (AddressException e){
		e.printStackTrace();
		out.print("fail");
	} catch (MessagingException e){
		e.printStackTrace();
		out.print("fail");
	}
%>
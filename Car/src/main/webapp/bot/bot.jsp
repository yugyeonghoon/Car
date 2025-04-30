<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html lang="ko">
	<head>
	    <meta charset="UTF-8">
	    <title>차량 챗봇</title>
	    <style>
	        body {
	            margin: 0;
	            font-family: 'Apple SD Gothic Neo', Arial, sans-serif;
	            /* background-color: #f0f0f0; */
	        }
	        #chat-container {
	            width: 100%;
	            max-width: 400px;
	            height: 600px;
	            margin: auto;
	            display: flex;
	            flex-direction: column;
	            border-radius: 12px;
	            overflow: hidden;
	            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
	            background-color: white;
	        }
	        #chat-header {
	            background-color: #000;
	            color: #fff;
	            text-align: center;
	            padding: 12px;
	            font-weight: bold;
	            font-size: 16px;
	        }
	        #chat-messages {
	            flex: 1;
	            overflow-y: auto;
	            padding: 15px;
	            background-color: #f9f9f9;
	        }
	        .message {
			    max-width: 80%;
			    margin-bottom: 10px;
			    padding: 10px 14px;
			    border-radius: 20px;
			    font-size: 14px;
			    line-height: 1.4;
			    display: inline-block;
			    clear: both;
			}
			.message.user {
			    background-color: #1e88e5;
			    color: white;
			    float: right;
			    border-bottom-right-radius: 0;
			}
			.message.bot {
			    background-color: #eee;
			    color: black;
			    float: left;
			    border-bottom-left-radius: 0;
			}
	        #user-input {
	            display: flex;
	            border-top: 1px solid #ccc;
	            padding: 10px;
	            background-color: white;
	        }
	        #user-input input {
	            flex: 1;
	            padding: 10px 12px;
	            border: 1px solid #ccc;
	            border-radius: 20px;
	            outline: none;
	        }
	        #user-input button {
	            margin-left: 10px;
	            padding: 10px 16px;
	            background-color: black;
	            color: white;
	            border: none;
	            border-radius: 20px;
	            cursor: pointer;
	            font-weight: bold;
	        }
	        #user-input button:hover {
	            background-color: #333;
	        }
	    </style>
	</head>
	<body>
	    <div id="chat-container">
	        <div id="chat-header">차량생각 챗봇</div>
	        <div id="chat-messages"></div>
	        <div id="user-input">
	            <input type="text" id="message" placeholder="차량 관련 질문만 입력 가능합니다.">
	            <button onclick="sendMessage()">▶</button>
	        </div>
	    </div>
	
	    <script>
	        const chatMessages = document.getElementById("chat-messages");
	
	        function appendMessage(sender, text) {
	            const div = document.createElement("div");
	            div.className = "message " + (sender === "나" ? "user" : "bot");
	            div.innerHTML = text || "(빈 응답)";
	            chatMessages.appendChild(div);
	            chatMessages.scrollTop = chatMessages.scrollHeight;
	        }
	
	        function isCarRelated(message) {
	            const carKeywords = ['안녕', '차량', '자동차', '엔진', '연비', '브레이크', '타이어', '차종', 'SUV', '세단', '중고차', '신차', '주행', '마력', '남자', '여자'];
	            return carKeywords.some(keyword => message.includes(keyword));
	        }
	
	        async function sendMessage() {
	            const input = document.getElementById("message");
	            const message = input.value.trim();
	            if (!message) return;
	
	            if (!isCarRelated(message)) {
	                appendMessage("시스템", "⚠️ 차량 관련 질문만 받을 수 있습니다.");
	                input.value = "";
	                return;
	            }
	
	            appendMessage("나", message);
	            input.value = "";
	
	            try {
	                const res = await fetch("chat.jsp", {
	                    method: "POST",
	                    headers: { "Content-Type": "application/x-www-form-urlencoded" },
	                    body: "message=" + encodeURIComponent(message)
	                });
	                const data = await res.json();
	                appendMessage("챗봇", data.reply);
	            } catch (err) {
	                appendMessage("오류", "API 호출 실패");
	                console.error(err);
	            }
	        }
	
	        document.getElementById("message").addEventListener("keydown", (e) => {
	            if (e.key === "Enter") sendMessage();
	        });
	    </script>
	</body>
</html>

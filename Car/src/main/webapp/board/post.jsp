<%@page import="reply.ReplyVO"%>
<%@page import="java.util.List"%>
<%@page import="reply.ReplyDAO"%>
<%@page import="board.BoardVO"%>
<%@page import="board.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../header.jsp" %>    
<%
	String no = request.getParameter("no");
	
	if(no == null){
		response.sendRedirect("board.jsp");
		return;
	}
		
	BoardDAO dao = new BoardDAO();
	BoardVO vo = dao.view(no);
	dao.updateViews(no);
	String title = vo.getTitle();
	String author = vo.getAuthor();
	String content = vo.getContent();
	String createDate = vo.getCreateDate();
	
	ReplyDAO rdao = new ReplyDAO();
	List<ReplyVO> list = rdao.select(no); 
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><%=title %> | 자유게시판 | 차량생각</title>
<script src="./jquery-3.7.1.js"></script>
<style>
    body {
      font-family: 'Arial', sans-serif;
      background-color: #fff;
      margin: 0;
      padding: 0;
      color: #000;
    }

    h2 {
      text-align: center;
      padding: 30px 0 10px;
      font-size: 1.8rem;
    }

    .write-container {
      max-width: 1000px;
      margin: 0 auto;
      background: #fff;
      padding: 30px;
      border-radius: 10px;
      border: 2px solid #000;
    }

    .write-container h4 {
      font-size: 1.4rem;
      margin-bottom: 10px;
    }

    .write-container .meta {
      font-size: 0.9rem;
      color: #666;
      margin-bottom: 20px;
    }

    .content-container pre {
      white-space: pre-wrap;
      font-size: 1rem;
      line-height: 1.6;
      color: #333;
      padding: 20px;
      border: 1px solid #ddd;
      border-radius: 10px;
      background-color: #f9f9f9;
    }

    .post-actions {
      margin-top: 30px;
      text-align: right;
    }

    .post-actions button {
      background: #000;
      color: #fff;
      border: none;
      padding: 8px 16px;
      border-radius: 5px;
      font-size: 0.95rem;
      cursor: pointer;
      margin-left: 10px;
      transition: background 0.3s ease;
    }

    .post-actions button:hover {
      background: #333;
    }

    .reply-container {
      max-width: 1000px;
      margin: 50px auto 0;
    }

    .reply-container h5 {
      font-size: 1.4rem;
      margin-bottom: 20px;
      text-align: center;
    }

    .comment {
      background: #fff;
      border: 1px solid #ddd;
      border-radius: 10px;
      padding: 15px;
      margin-bottom: 15px;
    }

    .comment .meta {
      font-size: 0.85rem;
      color: #888;
      margin-bottom: 10px;
    }

    .comment p {
      font-size: 1rem;
      color: #333;
      line-height: 1.5;
    }

    .comment-actions {
      text-align: right;
      margin-top: 10px;
    }

    .comment-actions button {
      background: none;
      border: none;
      color: #000;
      cursor: pointer;
      font-size: 0.9rem;
      margin-left: 10px;
    }

    .comment-form {
      display: flex;
      gap: 10px;
      margin-top: 30px;
    }

    .comment-form input {
      flex: 1;
      padding: 10px;
      font-size: 1rem;
      border: 1px solid #000;
      border-radius: 5px;
    }

    .comment-form button {
      background: #000;
      color: #fff;
      padding: 10px 20px;
      font-size: 1rem;
      border: none;
      border-radius: 5px;
      cursor: pointer;
    }

    .comment-form button:hover {
      background: #333;
    }

    .dpnone {
      display: none;
    }
</style>	
</head>
<body>
  <h2>글 상세보기</h2>
  <div class="write-container">
    <h4><%= title %></h4>
    <div class="meta">작성자 : <%= author %> | 작성일 : <%= createDate %></div>
    <div class="content-container">
      <pre><%= content %></pre>
    </div>

    <%-- <% if(user != null && (user.getId().equals(author) || user.getUserType() == 0)){ %> --%>
    <div class="post-actions">
      <button onclick="location.href='modify.jsp?no=<%=no %>'">수정</button>
      <button onclick="deletePost(<%=no %>)">삭제</button>
      <button onclick="location.href='board.jsp'">목록으로</button>
    </div>
    <%-- <% } %> --%>
  </div>

  <div class="reply-container">
    <%-- <% if(user != null){ %> --%>
    <h5>댓글</h5>
    <div class="comment-form">
      <input id="rcontent" type="text" placeholder="댓글을 입력하세요...">
      <button type="button" id="replyBtn">댓글 작성</button>
    </div>
    <%-- <% } %> --%>

    <% for(int i = 0; i < list.size(); i++) {
      ReplyVO rvo = list.get(i);
      String rno = rvo.getRno();
      String rcontent = rvo.getReply_content();
      String rauthor = rvo.getReply_author();
      String rcreateDate = rvo.getReply_create_date();
    %>
    <div class="comment">
      <div class="meta">작성자: <%= rauthor %> | 작성일: <%= rcreateDate %></div>
      <p><%= rcontent %></p>
      <% if(user != null && (user.getId().equals(rauthor) || user.getUserType() == 0)){ %>
      <div class="comment-actions">
        <button onclick="replyBtn(this)">수정</button>
        <input type="hidden">
        <button class="dpnone" onclick="modifyReply(<%= rno %>, this)">확인</button>
        <button class="dpnone" onclick="cancelBtn(this, '<%= rcontent %>')">취소</button>
        <button onclick="deleteReply(<%= rno %>, this)">삭제</button>
      </div>
      <% } %>
    </div>
    <% } %>
  </div>
</body>
	<script>
	let userId = "<%= user != null ? user.getId() : "" %>";
	console.log(userId);
	
	function cancelBtn(obj, text){
		let input = $(obj).parent().parent().children("input");
		console.log(input);
		input.replaceWith("<p>"+text+"</p>");
		
		$(obj).prev().prev().prev().css("display", "inline");
		$(obj).parent().children(".dpnone").css("display", "none");
	}
	
	function replyBtn(obj){
		let el = $(".comment");
		for(let i = 0; i < el.length; i++){

			let value = el.eq(i).children().children("input").val();
			console.log(value);
			let input = el.eq(i).children("input");
			input.replaceWith("<p>"+value+"</p>")
			
			el.eq(i).children().children().eq(0).css("display", "inline");
			el.eq(i).children().children(".dpnone").css("display", "none");
		}
			
		let p = $(obj).parent().parent().children("p");
		$(obj).next().val(p.text());
		
		p.replaceWith("<input type='text' value='"+p.text()+"'>");
		
		$(obj).css("display", "none");
		$(obj).parent().children(".dpnone").css("display","inline");
	}
	
	$("#replyBtn").click(function(){
	    $.ajax({
	        url : "replyok.jsp",
	        type : "post",
	        data : {
	            no : "<%= no %>",
	            rauthor : userId,
	            rcontent : $("#rcontent").val()
	        },
	        success : function(result){
	            let time = getTime();
	            console.log(result);
	            if(result.trim() != "0"){
	                let rcontent = $("#rcontent");
	                
	                let html = "";
	                html += "<div class='comment'>";
	                html += 	"<div class='meta'>작성자: "+userId+" | 작성일: "+time+"</div>";
	                html += 	"<p>"+rcontent.val()+"</p>";
	                html += 	"<div class='comment-actions'>";
	                html += 		"<button onclick='replyBtn(this)'>수정</button>";
	                html +=			"<input type='hidden'>"
	                html +=			"<button class='dpnone' onclick='modifyReply("+result.trim()+", this)'>확인</button>"
	                html +=			"<button class='dpnone' onclick='cancelBtn(this, `"+rcontent.val()+"`)'>취소</button>"
	                html +=			"<button onclick='deleteReply("+result.trim()+", this)'>삭제</button>";
	                html += 	"</div>";
	                html += "</div>";
	                
	                $(".reply-container").append(html);
	                
	                rcontent.val("");
	            } else {
	                console.log("댓글 작성 실패");
	            }
	        },
	        error : function(){
	            console.log("에러 발생");
	        }
	    });
	});
	
	//댓글 수정
	function modifyReply(rno, obj){
		console.log(rno);
		let input = $(obj).parent().parent().children("input");
		
		
		let reply = input.val();
		if(reply != null && reply.trim() != ""){
			let cresult = confirm("댓글을 수정하시겠습니까?");
			//confirm("댓글을 수정하시겠습니까?");
			if(cresult == true){
				$.ajax({
					url : "replyModifyok.jsp",
					type : "post",
					data : {
						rno : rno,
						rcontent : reply
					},
					success : function(result){
						console.log(result);
						if(result.trim() == "success"){
							input.replaceWith("<p>"+reply+"</p>");
							$(obj).parent().children(".dpnone").css("display", "none");
							$(obj).prev().prev().css("display", "inline");
							$(obj).next().attr("onclick", "cancelBtn(this, '"+reply+"')");
						}
					},
					error : function(){
						console.log("에러 발생");
					}
				});
			}
		}		
	}
	
	//댓글 삭제
	function deleteReply(rno, obj){
		confirm("댓글을 삭제하시겠습니까?");
		$.ajax({
			url : "replyDeleteok.jsp",
			type : "post",
			data : {
				rno : rno
			},
			success : function(result){
				if(result.trim() == "success"){
					$(obj).parent().parent().remove();
				}
			},
			error : function(){
				console.log("에러 발생");
			}
		});
	}
	
	function getTime(){
		let date = new Date();
		console.log(date);
		
		let year = date.getFullYear();
		let month = (date.getMonth() + 1).toString().padStart(2,"0");
		let day = date.getDate().toString().padStart(2,"0");
		let hour = date.getHours().toString().padStart(2,"0");
		let minute = date.getMinutes().toString().padStart(2,"0");
		let second = date.getSeconds().toString().padStart(2,"0");
		
		let time = year + "-" + month + "-" + day + " " + hour + ":" + minute + ":" + second
		return time;
	}

	function deletePost(no){
		console.log(no);
		let result = confirm("삭제하시겠습니까?");
		if(result == true){
			location.href = "delete.jsp?no="+no;
		}
	}
	</script>
</html>
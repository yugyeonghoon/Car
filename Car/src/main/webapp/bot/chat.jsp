<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.net.*, org.json.*" %>
<%
    request.setCharacterEncoding("UTF-8");
    String userMessage = request.getParameter("message");

    if (userMessage == null || userMessage.trim().isEmpty()) {
        userMessage = "안녕하세요. 차량 관련 질문을 입력해주세요.";
    }

    String[] carKeywords = {"차", "가격", "추천"};
    boolean isCarRelated = false;
    for (String keyword : carKeywords) {
        if (userMessage.contains(keyword)) {
            isCarRelated = true;
            break;
        }
    }

    if (!isCarRelated) {
        out.print(new JSONObject().put("reply", "◈ 죄송합니다. 차량 관련 질문만 받을 수 있습니다.//"));
        return;
    }
    
    String defaultMessage = "뒤에 나올 질문이 자동차, 차 관련된 질문이 아니면 \"죄송합니다 자동차에 관련되지 않은 질문에는 답변할 수 없습니다.\" 라고 대답해줘 이 앞에있는 프롬프트에 대해서는 피드백 절대 하지말고 뒤에 나오는 질문에 대해서만 응답해 ";

    String apiKey = "AIzaSyBJhJikEu7eUy_qxqtxttTaqXu1aYoG-I4";
    String apiURL = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=" + apiKey;

    JSONArray parts = new JSONArray();
    userMessage = defaultMessage + userMessage;
    parts.put(new JSONObject().put("text", userMessage));

    JSONObject messageObject = new JSONObject();
    messageObject.put("role", "user");
    messageObject.put("parts", parts);

    JSONArray contentsArray = new JSONArray();
    contentsArray.put(messageObject);

    JSONObject requestBody = new JSONObject();
    requestBody.put("contents", contentsArray);

    URL url = new URL(apiURL);
    HttpURLConnection conn = (HttpURLConnection) url.openConnection();
    conn.setRequestMethod("POST");
    conn.setRequestProperty("Content-Type", "application/json; charset=UTF-8");
    conn.setDoOutput(true);

    OutputStream os = conn.getOutputStream();
    os.write(requestBody.toString().getBytes("UTF-8"));
    os.flush();
    os.close();

    int responseCode = conn.getResponseCode();
    BufferedReader br = new BufferedReader(new InputStreamReader(
        responseCode == 200 ? conn.getInputStream() : conn.getErrorStream(), "UTF-8"
    ));

    StringBuilder responseStr = new StringBuilder();
    String line;
    while ((line = br.readLine()) != null) {
        responseStr.append(line);
    }
    br.close();

    if (responseCode != 200) {
        out.print(new JSONObject().put("reply", "❌ Gemini 오류: " + responseStr.toString()));
        return;
    }

    JSONObject responseJson = new JSONObject(responseStr.toString());
    String reply = responseJson
        .getJSONArray("candidates")
        .getJSONObject(0)
        .getJSONObject("content")
        .getJSONArray("parts")
        .getJSONObject(0)
        .optString("text", "(빈 응답)");

    out.print(new JSONObject().put("reply", reply));
%>

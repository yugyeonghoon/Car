<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.net.*, org.json.*, java.util.*" %>
<%@ page import="carInfo.CarDAO, carInfo.CarVO" %>
<%@ page import="java.util.regex.Pattern" %>
<%
	ResourceBundle resource = ResourceBundle.getBundle("config");

    request.setCharacterEncoding("UTF-8");
    String userMessage = request.getParameter("message");

    if (userMessage == null || userMessage.trim().isEmpty()) {
        userMessage = "안녕하세요. 차량 관련 질문을 입력해주세요.";
    }

    // 차량 관련 키워드 확인
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

    // Gemini API 요청 전 고정 프롬프트 추가
    String defaultMessage = "뒤에 나올 질문이 자동차, 차 관련된 질문이 아니면 '죄송합니다 자동차에 관련되지 않은 질문에는 답변할 수 없습니다.' 라고 대답해줘. 이 앞에 있는 프롬프트에 대해서는 피드백 절대 하지 말고 뒤에 나오는 질문에 대해서만 응답해. ";

    String apiKey = resource.getString("api.key");
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

    // Gemini 응답 추출
    JSONObject responseJson = new JSONObject(responseStr.toString());
    String reply = responseJson
        .getJSONArray("candidates")
        .getJSONObject(0)
        .getJSONObject("content")
        .getJSONArray("parts")
        .getJSONObject(0)
        .optString("text", "(빈 응답)");

    // 차량 리스트 불러와서 이름 ↔ tno 매핑
    CarDAO dao = new CarDAO();
    List<CarVO> carList = dao.carList(); 
    Map<String, String> carMap = new HashMap<>();
    for (CarVO car : carList) {
        carMap.put(car.getCar_name(), String.valueOf(car.getTno()));
    }

    // 응답에서 차량명을 링크로 치환
    for (Map.Entry<String, String> entry : carMap.entrySet()) {
	    String carName = entry.getKey();
	    String tno = entry.getValue();
	    reply = reply.replaceAll(Pattern.quote(carName), "<a href='../car/carDetail.jsp?tno=" + tno + "' target='_blank'>" + carName + "</a>");
	}
	
	out.print(new JSONObject().put("reply", reply));
%>

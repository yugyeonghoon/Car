package carFeedback;

import java.util.ArrayList;
import java.util.List;

import db.DBManager;

public class CarFeedbackDAO extends DBManager{
	//피드백에서 장점 코멘트 가져오기
	public List<CarFeedbackVO> goodfeedback(String tno2){
		driverLoad();
		DBConnect();
		
		String sql = "select content from car_feedback where tno = "+tno2+" and type = '장점'";
		
		executeQuery(sql);
		
		List<CarFeedbackVO> list = new ArrayList<>();
		while(next()){
			String content = getString("content");
			
			CarFeedbackVO vo = new CarFeedbackVO();
			vo.setContent(content);
			list.add(vo);
			
		}
		DBDisConnect();
		return list;
				
	}
	//피드백에서 단점 코멘트 가져오기
		public List<CarFeedbackVO> badfeedback(String tno2){
			driverLoad();
			DBConnect();
			
			String sql = "select content from car_feedback where tno = "+tno2+" and type = '단점'";
			
			executeQuery(sql);
			
			List<CarFeedbackVO> list = new ArrayList<>();
			while(next()){
				String content = getString("content");
				
				CarFeedbackVO vo = new CarFeedbackVO();
				vo.setContent(content);
				list.add(vo);
				
			}
			DBDisConnect();
			return list;
					
		}
		
	//피드백에서 개선점 코멘트 가져오기
			public List<CarFeedbackVO> feedback(String tno2){
				driverLoad();
				DBConnect();
				
				String sql = "select content from car_feedback where tno = "+tno2+" and type = '개선점'";
				
				executeQuery(sql);
				
				List<CarFeedbackVO> list = new ArrayList<>();
				while(next()){
					String content = getString("content");
					
					CarFeedbackVO vo = new CarFeedbackVO();
					vo.setContent(content);
					list.add(vo);
					
				}
				DBDisConnect();
				return list;
						
			}
}

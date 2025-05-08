package rating;

import java.util.ArrayList;
import java.util.List;

import db.DBManager;

public class RatingDAO extends DBManager{
	//차량별 평점 가져오기
	public RatingVO selectRating(String tno) {
		driverLoad();
		DBConnect();
		
		String sql = "select ae.*, ci.tno from averageevaluation ae inner join car_info ci";
		sql += " on ae.title = ci.car_name where tno="+tno;
		executeQuery(sql);
		
		if(next()) {
			String rating = getString("rating");
			String ratingPeople = getString("rating_people");
			String drive = getString("drive");
			String price = getString("drive");
			String habitability = getString("habitability");
			String quality = getString("quality");
			String design = getString("design");
			String fuel = getString("fuel");
			
			RatingVO vo = new RatingVO();
			vo.setRating(rating);
			vo.setRating_people(ratingPeople);
			vo.setDrive(drive);
			vo.setPrice(price);
			vo.setHabitability(habitability);
			vo.setQuality(quality);
			vo.setDesign(design);
			vo.setFuel(fuel);
			vo.setTno(tno);
			DBDisConnect();
			return vo;
			
		}else {
			DBDisConnect();
			return null;
		}
		
	}
	
	//차량별 리뷰 가져오기
	public List<RatingVO> trimReply(String tno) {
		driverLoad();
		DBConnect();
		
		String sql = "select * from trim_reply where tno = "+tno+"";
		
		executeQuery(sql);
		
		List<RatingVO> list = new ArrayList<>();
		while(next()) {
			String title = getString("title");
			String trim = getString("trim");
			String reply = getString("reply");
			
			RatingVO vo = new RatingVO();
			vo.setTitle(title);
			vo.setTrim(trim);
			vo.setReply(reply);
			
			list.add(vo);
		}
		DBDisConnect();
		return list;
	}	
}

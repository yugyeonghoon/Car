package carView;

import java.util.ArrayList;
import java.util.List;

import db.DBManager;

public class carViewDAO extends DBManager {
	
	//차량 클릭했을 때 차량 본 목록 등록
	public void viewInsert(carViewVO vo) {
		String carTno = vo.getCarTno();
		String userId = vo.getUserId();
		String carName = vo.getCarName();
		
		driverLoad();
		DBConnect();
		
		String sql = "";
		sql += "insert into car_views(car_tno, user_id, car_name)";
		sql += " values('"+carTno+"', '"+userId+"', '"+carName+"')";
		
		executeUpdate(sql);
		DBDisConnect();
	}
	
	//차량 최근 목록 조회 3개 제한
	public List<carViewVO> viewList(String userId) {
		driverLoad();
		DBConnect();
		
		String sql = "";
		sql += "SELECT car_tno, car_name FROM car_views ";
		sql += "where user_id = '"+userId+"' ";
		sql += "GROUP BY car_tno, car_name ";
		sql += "ORDER BY max(car_view_date) desc limit 3";
		
		executeQuery(sql);
		
		List<carViewVO> list = new ArrayList<>();
		while(next()) {
			String carName = getString("car_name");
			String carTno = getString("car_tno");
			
			carViewVO cveo = new carViewVO();
			cveo.setCarName(carName);
			cveo.setCarTno(carTno);
			
			list.add(cveo);
		}
		DBDisConnect();
		return list;
	}
}

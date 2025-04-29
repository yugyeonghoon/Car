package carLike;

import db.DBManager;

public class carLikeDAO extends DBManager{
	
	//좋아요 등록
	public void like(carLikeVO vo) {
		String member = vo.getMember();
		int carNo = vo.getCarNo();
		
		driverLoad();
		DBConnect();
		
		String sql = "insert into car_like(member, carNo) values('"+member+"', '"+carNo+"')";
		executeQuery(sql);
		
		DBDisConnect();
	}
	
}

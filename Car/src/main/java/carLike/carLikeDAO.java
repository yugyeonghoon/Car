package carLike;

import db.DBManager;

public class carLikeDAO extends DBManager{
	
	//좋아요 등록
	public void like(carLikeVO vo) {
		String userId = vo.getUserId();
		String carTno = vo.getCarTno();
		int likeCheck = vo.getLikeCheck();
		
		driverLoad();
		DBConnect();
		
		String sql = "insert into car_like(user_id, car_tno, like_check) values('"+userId+"', '"+carTno+"', "+likeCheck+")";
		executeQuery(sql);
		
		DBDisConnect();
	}
	
	//좋아요 취소
	public void unlike(int likeNo) {
		driverLoad();
		DBConnect();
		
		String sql = "update car_like set like_check = 0, update_date = now() ";
		sql += "where like_no = " + likeNo;
		executeUpdate(sql);
		DBDisConnect();
	}
}

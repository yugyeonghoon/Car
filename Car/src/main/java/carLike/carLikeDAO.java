package carLike;
import java.util.ArrayList;
import java.util.List;
import db.DBManager;

public class carLikeDAO extends DBManager{
	
	//사용자가 차량에 좋아요 눌렀는지 확인(조회)
	public int likeFlag(String userId, String carTno) {
		driverLoad();
		DBConnect();
		
		String sql = "select count(*) as cnt from car_like where user_id = '"+userId+"' and car_tno = " + carTno;
		//select count(*) from car_like where user_id = 'hong' and car_tno = 490;
		
		executeQuery(sql);
		int count = 0;
		if(next()) {
			count = getInt("cnt");
		}
		DBDisConnect();
		return count;
	}
	
	//좋아요 등록
	public void like(carLikeVO vo) {
		String userId = vo.getUserId();
		String carTno = vo.getCarTno();
		
		driverLoad();
		DBConnect();
		
		//insert into car_like(user_id, car_tno) values('hong', 496)
		
		String sql = "insert into car_like(user_id, car_tno) values('"+userId+"', "+carTno+")";
		executeUpdate(sql);
		
		DBDisConnect();
	}
	
	//좋아요 취소
	public void unlike(carLikeVO vo) {
		String userId = vo.getUserId();
		String carTno = vo.getCarTno();
		
		driverLoad();
		DBConnect();
		
		//delete from car_like where car_tno = 1543 and user_id='hong';
		String sql = "delete from car_like where car_tno = "+carTno+" and user_id='"+userId+"'";
		executeUpdate(sql);
		DBDisConnect();
	}
	
	//마이페이지에서 유저가 좋아요 한 차량 목록 조회
		public List<carLikeVO> likeCar(String userId) {
			
			driverLoad();
			DBConnect();
			
			String sql = "";
			sql += "select ci.car_name, ci.car_img, ci.tno ";
			sql	+= " from car_like cl ";
			sql	+= "join car_info ci on cl.car_tno = ci.tno ";
			sql	+= "where cl.user_id = '"+userId+"'";
			executeQuery(sql);
			
			List<carLikeVO> list = new ArrayList<>();
			while(next()) {
				String tno = getString("tno");
				String carName = getString("car_name");
				String img = getString("car_img");
				
				carLikeVO vo = new carLikeVO();
				vo.setCarTno(tno);
				vo.setCar_name(carName);
				vo.setImg(img);
				
				list.add(vo);
			}
			DBDisConnect();
			return list;
		}
}

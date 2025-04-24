package carInfo;

import java.util.ArrayList;
import java.util.List;

import db.DBManager;

public class CarDAO extends DBManager{
	//차 조회
	public List<CarVO> carView() {
		driverLoad();
		DBConnect();
		
		String sql = "select * from car_info where car_img != '자료없음' order by rand() limit 30";
		
		executeQuery(sql);
		
		List<CarVO> list = new ArrayList<>();
		while(next()) {
			String company = getString("company");
			String carName = getString("car_name");
			String img = getString("car_img");
			
			CarVO vo = new CarVO();
			vo.setCompany(company);
			vo.setTitle(carName);
			vo.setImage(img);
			
			list.add(vo);
		}
		DBDisConnect();
		return list;
	}
}

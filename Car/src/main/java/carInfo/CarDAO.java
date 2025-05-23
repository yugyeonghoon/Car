package carInfo;

import java.util.ArrayList;
import java.util.List;

import db.DBManager;

public class CarDAO extends DBManager{
	//차 조회
	public List<CarVO> carView() {
		driverLoad();
		DBConnect();
		
		String sql = "select * from car_info where car_img != 'none_car.png' order by rand() limit 30";
		
		executeQuery(sql);
		
		List<CarVO> list = new ArrayList<>();
		while(next()) {
			String company = getString("company");
			String carName = getString("car_name");
			String img = getString("car_img");
			String tno = getString("tno");
			
			CarVO vo = new CarVO();
			vo.setCompany(company);
			vo.setCar_name(carName);
			vo.setCar_img(img);
			vo.setTno(tno);
			
			list.add(vo);
		}
		DBDisConnect();
		return list;
	}
	
	//차 조회 로그인 했을 때
	public List<CarVO> carView(String id, String carType) {
		driverLoad();
		DBConnect();
		
		String sql = "select * from car_info ci, user u where ci.car_img != 'none_car.png'"
				+ " and ci.car_type like '%"+carType+"%' order by rand() limit 30";
		
		executeQuery(sql);
		
		List<CarVO> list = new ArrayList<>();
		while(next()) {
			String company = getString("company");
			String carName = getString("car_name");
			String img = getString("car_img");
			String tno = getString("tno");
			
			CarVO vo = new CarVO();
			vo.setCompany(company);
			vo.setCar_name(carName);
			vo.setCar_img(img);
			vo.setTno(tno);
			
			list.add(vo);
		}
		DBDisConnect();
		return list;
	}
	//제조사 목록조회
	public List<CarVO> company(){
		driverLoad();
		DBConnect();
		
		String sql = "select * from manufacturer ";
		
		executeQuery(sql);
		
		List<CarVO> list = new ArrayList<>();
		while(next()) {
			String company = getString("manufacturer");
			String no = getString("no");
			CarVO vo = new CarVO();
			vo.setCompany(company);
			vo.setNo(no);
			
			list.add(vo);
		}
		DBDisConnect();
		return list;
	}
	
	//제조사별 차량 조회
	public List<CarVO> model(String no){
		driverLoad();
		DBConnect();
		
		String sql = "SELECT * FROM model m WHERE m.no = "+no+" AND EXISTS ( SELECT 1 FROM car_info c WHERE c.mno = m.mno AND c.car_img != 'none_car.png')" ;
		executeQuery(sql);
			
		List<CarVO> list = new ArrayList<>();
		while(next()) {
			String model1 = getString("model");
			String mno = getString("mno");
			CarVO cvo = new CarVO();
			cvo.setMno(mno);
			cvo.setCar_name(model1);
			
			list.add(cvo);
		}
		DBDisConnect();
		return list;
	}
	
	//모델 클릭시 트림 가져오는 쿼리
	public List<CarVO> trim(String mno){
		driverLoad();
		DBConnect();
		
		String sql = "select trim,tno from car_info where mno = " + mno;
		executeQuery(sql);
		
		List<CarVO> list = new ArrayList<CarVO>();
		while(next()) {
			String trim = getString("trim");
			String tno = getString("tno");
			CarVO vo = new CarVO();
			vo.setTno(tno);
			vo.setTrim(trim);
			list.add(vo);
		}
		DBDisConnect();
		return list;
	}
	
	//carDetail.jsp 에서 tno로 자동차 세부항목 조회
	public CarVO carDetail(String tno){
		driverLoad();
		DBConnect();
		
		String sql = "select * from car_info where tno =" + tno;
		executeQuery(sql);
		
		if(next()) {
			String tno2 = getString("tno");
			String carName = getString("car_name");
			String carType = getString("car_type");
			int year = getInt("year");
			String price = getString("price");
			String img = getString("car_img");
			String trim = getString("trim");
			String engine = getString("engine");
			String compressor = getString("compressor");
			String exhaust = getString("exhaust");
			String gas = getString("gas");
			String output = getString("output");
			String torque = getString("torque");
			String fuel = getString("fuel");
			String lengthWidth = getString("length_width");
			String weight = getString("weight");
			String shift = getString("shift");
			
			CarVO vo = new CarVO();
			vo.setTno(tno2);
			vo.setCar_name(carName);
			vo.setYear(year);
			vo.setCar_type(carType);
			vo.setPrice(price);
			vo.setCar_img(img);
			vo.setTrim(trim);
			vo.setEngine(engine);
			vo.setCompressor(compressor);
			vo.setExhaust(exhaust);
			vo.setGas(gas);
			vo.setOutput(output);
			vo.setTorque(torque);
			vo.setFuel(fuel);
			vo.setLength_width(lengthWidth);
			vo.setWeight(weight);
			vo.setShift(shift);
			
			DBDisConnect();
			return vo;
			}else {
				DBDisConnect();
				return null;
			}
		
	}
	
	//제조사 조회
			public List<CarVO> companyView() {
			    driverLoad();
			    DBConnect();

			    String sql = "select distinct company from car_info";

			    executeQuery(sql);

			    List<CarVO> list = new ArrayList<>();
			    while(next()) {
			        String company = getString("company");
			        
			        CarVO vo = new CarVO();
			        vo.setCompany(company);
			        list.add(vo);
			    }

			    DBDisConnect();
			    return list;
			}
			
	//모델 조회
	public List<CarVO> modelView(String company) {
	    driverLoad();
	    DBConnect();

	    String sql = "select distinct car_name, car_img from car_info where company = '"+company+"'";


	    executeQuery(sql);

	    List<CarVO> list = new ArrayList<>();
	    while(next()) {
	        String model = getString("car_name");
	        String img = getString("car_img");
	        
	        CarVO vo = new CarVO();
	        vo.setCar_name(model);
	        vo.setCar_img(img);
	        list.add(vo);
	    }
	    DBDisConnect();
	    return list;
	}		
			//트림 조회
			public List<CarVO> trimView(String carName) {
			    driverLoad();
			    DBConnect();

			    String sql = "select trim from car_info where car_name = '"+carName+"'";


			    executeQuery(sql);

			    List<CarVO> list = new ArrayList<>();
			    while(next()) {
			        String trim = getString("trim");
			        
			        CarVO vo = new CarVO();
			        vo.setCar_name(trim);
			        list.add(vo);
			    }

			    DBDisConnect();
			    return list;
			}
			
			public List<CarVO> carBigyo(String car, String trim) {
				driverLoad();
				DBConnect();
				
				String sql = "select * from car_info where car_name = '"+car+"' and trim = '"+trim+"'";
				
				executeQuery(sql);
				
				List<CarVO> list = new ArrayList<>();
				while(next()) {
					String company = getString("company");
					String carName = getString("car_name");
					String img = getString("car_img");
					String price = getString("price");
					String gas = getString("gas");
					String output = getString("output");
					String engine = getString("engine");
					String fuel = getString("fuel");
					String carType = getString("car_type");
					String exhaust = getString("exhaust");
					String torque = getString("torque");
					String length_width = getString("length_width");
					String weight = getString("weight");
					String shift = getString("shift");
					String trim2 = getString("trim");
					
					CarVO vo = new CarVO();
					vo.setCompany(company);
					vo.setCar_name(carName);
					vo.setCar_img(img);
					vo.setPrice(price);
					vo.setGas(gas);
					vo.setOutput(output);
					vo.setEngine(engine);
					vo.setFuel(fuel);
					vo.setCar_type(carType);
					vo.setExhaust(exhaust);
					vo.setTorque(torque);
					vo.setLength_width(length_width);
					vo.setWeight(weight);
					vo.setShift(shift);
					vo.setTrim(trim2);
					
					list.add(vo);
				}
				DBDisConnect();
				return list;
			}
			
			
			//헤더 검색어에 입력했을 때 나오는 차량 목록
			public List<CarVO> searchCars(String title) {
				driverLoad();
				DBConnect();
				
				String sql = "SELECT mno, car_name, car_type, tno, car_img, exhaust, fuel, year "
						+ "FROM ("
						+ "    SELECT "
						+ "        m.mno,"
						+ "        ci.car_name,"
						+ "        ci.car_type,"
						+ "        ci.tno,"
						+ "        ci.car_img,"
						+ "        ci.exhaust,"
						+ "        ci.fuel,"
						+ "        ci.year,"
						+ "        ROW_NUMBER() OVER (PARTITION BY ci.car_name ORDER BY ci.tno) AS rn"
						+ "    FROM model m"
						+ "    JOIN car_info ci ON m.mno = ci.mno"
						+ "    WHERE ci.car_img != 'none_car.png'"
						+ "      AND ci.car_name LIKE '%"+title+"%'"
						+ ") AS sub "
						+ "WHERE rn = 1 "
						+ " ORDER BY mno";
				
				executeQuery(sql);

				List<CarVO> list = new ArrayList<>();
				while (next()) {
					String carName = getString("car_name");
					String carType = getString("car_type");
					String img = getString("car_img");
					String tno = getString("tno");
					String exhaust = getString("exhaust");
					String fuel = getString("fuel");
					int year = getInt("year");

					CarVO vo = new CarVO();
					vo.setCar_name(carName);
					vo.setCar_type(carType);
					vo.setCar_img(img);
					vo.setTno(tno);
					vo.setExhaust(exhaust);
					vo.setFuel(fuel);
					vo.setYear(year);
					
					list.add(vo);
				}
				DBDisConnect();
				return list;
			}
			
	//상세 쿼리 조회
	public List<CarVO> trimTno(String no){
		driverLoad();
		DBConnect();
		
		String sql = "select trim, tno from car_info where car_name = (select car_name from car_info where tno = "+no+")";
		
		executeQuery(sql);
		
		List<CarVO> list = new ArrayList<CarVO>();
		while(next()) {
			String trim = getString("trim");
			String tno = getString("tno");
			
			CarVO vo = new CarVO();
			vo.setTrim(trim);
			vo.setTno(tno);
			
			list.add(vo);
		}
		DBDisConnect();
		return list;
	}
	
	public List<CarVO> carList() {
	    driverLoad();
	    DBConnect();

	    String sql = "select tno, car_name from car_info"; 
	    executeQuery(sql);

	    List<CarVO> list = new ArrayList<CarVO>();
	    while (next()) {
	        String tno = getString("tno");
	        String carName = getString("car_name");

	        CarVO vo = new CarVO();
	        vo.setTno(tno);
	        vo.setCar_name(carName);

	        list.add(vo);
	    }

	    DBDisConnect();
	    return list;
	}

}

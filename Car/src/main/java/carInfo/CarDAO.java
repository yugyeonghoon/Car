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
			vo.setCar_name(carName);
			vo.setCar_img(img);
			
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
		
		String sql = "select * from model where no = " + no;
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
			String weidgt = getString("weidgt");
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
			vo.setWeidgt(weidgt);
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

			    String sql = "select distinct car_name from car_info where company = '"+company+"'";


			    executeQuery(sql);

			    List<CarVO> list = new ArrayList<>();
			    while(next()) {
			        String model = getString("car_name");
			        
			        CarVO vo = new CarVO();
			        vo.setCar_name(model);;
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
					String trims = getString("trim");
					
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
					vo.setTrim(trims);
					
					list.add(vo);
				}
				DBDisConnect();
				return list;
			}
<<<<<<< HEAD
=======
			
			//헤더 검색어에 입력했을 때 나오는 차량 목록
			public List<CarVO> searchCars(String title) {
				driverLoad();
				DBConnect();
				
				String sql = "SELECT mno, car_name, car_type, tno, car_img\r\n"
						+ "FROM (\r\n"
						+ "    SELECT \r\n"
						+ "        m.mno,\r\n"
						+ "        ci.car_name,\r\n"
						+ "        ci.car_type,\r\n"
						+ "        ci.tno,\r\n"
						+ "        ci.car_img,\r\n"
						+ "        ROW_NUMBER() OVER (PARTITION BY ci.car_name ORDER BY ci.tno) AS rn\r\n"
						+ "    FROM model m\r\n"
						+ "    INNER JOIN car_info ci ON m.mno = ci.mno\r\n"
						+ "    WHERE ci.car_img != 'none_car.png'\r\n"
						+ "      AND ci.car_name LIKE '%"+title+"%'\r\n"
						+ ") AS sub\r\n"
						+ "WHERE rn = 1\r\n"
						+ "ORDER BY mno";
				
				executeQuery(sql);

				List<CarVO> list = new ArrayList<>();
				while (next()) {
					String carName = getString("car_name");
					String carType = getString("car_type");
					String img = getString("car_img");
					String tno = getString("tno");

					CarVO vo = new CarVO();
					vo.setCar_name(carName);
					vo.setCar_type(carType);
					vo.setCar_img(img);
					vo.setTno(tno);
					
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
>>>>>>> 8043696ea76af4e1a27797b6e7d97cc86f72c6a5
}

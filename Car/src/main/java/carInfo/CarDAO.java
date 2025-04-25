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
}

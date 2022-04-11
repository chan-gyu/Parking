package com.cg.parking.car.controller;

import java.time.LocalTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.cg.parking.car.service.CarService;
import com.cg.parking.car.vo.Car;
import com.cg.parking.car.vo.CarRecord;

@SessionAttributes({"loginMember"})
@Controller
public class CarController {

	@Autowired
	private CarService service;
	
	@RequestMapping("/car/inputCar.do")
	public String inputCar(
			@RequestParam(value="InCarNum1") String inCarNum1,
			@RequestParam(value="InCarNum2") String inCarNum2,
			@RequestParam(value="InCarNum3") String inCarNum3,
			@RequestParam(value="InCarNum4") String inCarNum4,
			@RequestParam(value="state", required = false) String state,
			@RequestParam(value="loginMember", required=false) String name) {
		
		if (state==null) {
			state="일반";
		}
		if (name=="") {
			name="비로그인";
		}
		System.out.println(name);
		Car c = new Car();
		String CarNum=inCarNum1+inCarNum2+inCarNum3+inCarNum4;
		c.setCarNum(CarNum);
		c.setState(state);
		c.setName(name);
		
		int result = service.insertCar(c);
		
		if(result>0) {
			System.out.println("입차 성공");
		}else {
			System.out.println("입차 실패");
		}
		
		return "redirect:/";
	}
	
	@RequestMapping("/car/selectAllCar.do")
	@ResponseBody
	public List<Car> carlist(){
		List<Car> carList = service.selectAllCar();
		return carList;
	}
	
	@RequestMapping("/car/outCar.do")
	public String outCar(Model model,
			@RequestParam(value="carNum") String carNum,
			@RequestParam(value="inDate") String inDate,
			@RequestParam(value="state") String state,
			@RequestParam(value="name") String name) {
		
		CarRecord carR = new CarRecord();
		
		LocalTime now = LocalTime.now();
		int nowhour = now.getHour(); //현재 시
		int nowminute =now.getMinute(); //현재 분
		int inDatehh= Integer.parseInt(inDate.substring(0,2)); //입차 시
		int inDatemm=Integer.parseInt(inDate.substring(4,6)); //입차 분
		
		double calc = ((nowhour*60+nowminute)-(inDatehh*60+inDatemm))-120;
		String addminute = Integer.toString((int)calc); //초과 시간
		int price=0; //요금
		
		if(calc<=0||!state.equals(state)) {
			price=0;
		}else {
			price=(int) Math.ceil(calc/10);
			price*=1000;
		}
		
		carR.setCarRNum(carNum);
		carR.setInRDate(inDate);
		carR.setOutRDate(Integer.toString(nowhour)+"시 "+Integer.toString(nowminute)+"분");
		carR.setRState(state);
		carR.setCarRPrice(price);
		carR.setRName(name);
		
		int result=service.insertCarR(carR);
		System.out.println(state);
		String msg = "실패";
		if(result>0) {
			if(state.equals("일반")) {
				msg="초과 시간 : " + addminute + "분 주차 요금 : "+ price+"원";
			}else {
				price=0;
				msg="초과 시간 : " + addminute + "분 주차 요금 : "+ price+"원";
			}
		}
		
		model.addAttribute("msg", msg);
		model.addAttribute("loc","/");
		
		return "common/msg";
	}
	
	@RequestMapping("/car/kakaoLoginCheck.do")
	public String kakaoLoginCheck(Model model,
			@RequestParam(value="kakao_name") String kakaoName) {
		
		model.addAttribute("loginMember", kakaoName);
		
		return "redirect:/";
	}
	
	@RequestMapping("/car/home.do")
	public String home() {
		return "redirect:/";
	}
	
	@RequestMapping("/car/carRecordList.do")
	@ResponseBody
	public List<CarRecord> carRecordList(){
		List<CarRecord> list = service.selectAllCarRecord();
		return list;
	}
	
	@RequestMapping("/car/backCar.do")
	public String backCar(
			@RequestParam(value="carRNum") String carRNum,
			@RequestParam(value="inRDate") String inRDate,
			@RequestParam(value="rState") String rState,
			@RequestParam(value="rName") String rName) {
		
//		System.out.println("carRNum : " + carRNum + " inRDate" + inRDate + " rState : " + rState + " rName : " + rName);
		CarRecord carR = new CarRecord();
		carR.setCarRNum(carRNum);
		carR.setInRDate(inRDate);
		carR.setRState(rState);
		carR.setRName(rName);
		
		service.reInsertCar(carR);
		
		return "redirect:/";
	}
}

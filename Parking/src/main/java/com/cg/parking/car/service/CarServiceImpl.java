package com.cg.parking.car.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cg.parking.car.dao.CarDao;
import com.cg.parking.car.vo.Car;
import com.cg.parking.car.vo.CarRecord;

@Service
public class CarServiceImpl implements CarService {
	
	@Autowired
	private SqlSessionTemplate session;
	
	@Autowired
	private CarDao dao;
	
	@Override
	public int insertCar(Car c) {
		return dao.insertCar(session, c);
	}
	
	@Override
	public List<Car> selectAllCar() {
		return dao.selectAllCar(session);
	}
	
	@Override
	public int insertCarR(CarRecord cR) {
		int result=dao.insertCarR(session, cR);
		if(result>0) {
			result=dao.deleteCar(session, cR);
		}
		return result;
	}
	
	@Override
	public List<CarRecord> selectAllCarRecord() {
		return dao.selectAllCarRecord(session);
	}
	
	@Override
	public int reInsertCar(CarRecord carR) {
		int result=dao.reInsertCar(session, carR);
		if(result>0) {
			result+=dao.deleteCarR(session, carR);
		}
		return result;
	}
}

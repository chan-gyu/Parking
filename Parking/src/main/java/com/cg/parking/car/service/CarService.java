package com.cg.parking.car.service;

import java.util.List;

import com.cg.parking.car.vo.Car;
import com.cg.parking.car.vo.CarRecord;

public interface CarService {
	
	int insertCar(Car c); //입차
	List<Car> selectAllCar();
	int insertCarR(CarRecord cR); //기록입력
	List<CarRecord> selectAllCarRecord();
	int reInsertCar(CarRecord carR);
	
}

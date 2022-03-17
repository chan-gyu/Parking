package com.cg.parking.car.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;

import com.cg.parking.car.vo.Car;
import com.cg.parking.car.vo.CarRecord;

public interface CarDao {
	int insertCar(SqlSessionTemplate session, Car c ); //입차
	List<Car> selectAllCar(SqlSessionTemplate session); //입차리스트 출력
	int insertCarR(SqlSessionTemplate session, CarRecord cR); //기록입력
	int deleteCar(SqlSessionTemplate session, CarRecord cR); //입차기록 삭제
	List<CarRecord> selectAllCarRecord(SqlSessionTemplate session); //입차기록리스트 출력
	int reInsertCar(SqlSessionTemplate session, CarRecord carR);
	int deleteCarR(SqlSessionTemplate session, CarRecord carR);
}

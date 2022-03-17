package com.cg.parking.car.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.cg.parking.car.vo.Car;
import com.cg.parking.car.vo.CarRecord;

@Repository
public class CarDaoImpl implements CarDao {
	
	@Override
	public int insertCar(SqlSessionTemplate session, Car c) {
		return session.insert("car.insertCar", c);
	}
	
	@Override
	public List<Car> selectAllCar(SqlSessionTemplate session) {
		return session.selectList("car.selectAllCar");
	}
	
	@Override
	public int insertCarR(SqlSessionTemplate session, CarRecord cR) {
		return session.insert("car.insertCarR", cR);
	}
	
	@Override
	public int deleteCar(SqlSessionTemplate session, CarRecord cR) {
		return session.delete("car.deleteCar", cR);
	}
	
	@Override
	public List<CarRecord> selectAllCarRecord(SqlSessionTemplate session) {
		return session.selectList("car.selectAllCarRecord");
	}
	
	@Override
	public int reInsertCar(SqlSessionTemplate session, CarRecord carR) {
		return session.insert("car.reInsertCar", carR);
	}
	
	@Override
	public int deleteCarR(SqlSessionTemplate session, CarRecord carR) {
		return session.delete("car.deleteCarR", carR);
	}
}

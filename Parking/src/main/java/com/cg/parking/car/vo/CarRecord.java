package com.cg.parking.car.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@ToString
public class CarRecord {
	
	private String carRNum;
	private String inRDate;
	private String outRDate;
	private String rState;
	private int carRPrice;
	private String rName;
	
}

package com.ideabinder.yizhi.base.api.model.db.medicine;


import com.ideabinder.yizhi.base.api.model.db.BaseDbEntity;

public class MedicineManufacturerDb extends BaseDbEntity {

	/**
	 * 
	 */
	private static final long serialVersionUID = -6967456349910646912L;
	private int medicineId;
	private int manufacturerId;

	public int getMedicineId() {
		return medicineId;
	}

	public void setMedicineId(int medicineId) {
		this.medicineId = medicineId;
	}

	public int getManufacturerId() {
		return manufacturerId;
	}

	public void setManufacturerId(int manufacturerId) {
		this.manufacturerId = manufacturerId;
	}
}

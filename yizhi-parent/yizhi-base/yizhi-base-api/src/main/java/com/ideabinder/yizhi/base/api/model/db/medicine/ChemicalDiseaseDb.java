package com.ideabinder.yizhi.base.api.model.db.medicine;


import com.ideabinder.yizhi.base.api.model.db.BaseDbEntity;

public class ChemicalDiseaseDb extends BaseDbEntity {

	/**
	 * 
	 */
	private static final long serialVersionUID = 6054252427989449717L;
	private Integer chemicalId;
	private Integer diseaseId;

	public Integer getChemicalId() {
		return chemicalId;
	}

	public void setChemicalId(Integer chemicalId) {
		this.chemicalId = chemicalId;
	}

	public Integer getDiseaseId() {
		return diseaseId;
	}

	public void setDiseaseId(Integer diseaseId) {
		this.diseaseId = diseaseId;
	}
}

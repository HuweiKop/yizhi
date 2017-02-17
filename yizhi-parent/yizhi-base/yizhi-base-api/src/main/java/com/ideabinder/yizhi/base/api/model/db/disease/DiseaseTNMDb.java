package com.ideabinder.yizhi.base.api.model.db.disease;


import com.ideabinder.yizhi.base.api.model.db.BaseDbEntity;

public class DiseaseTNMDb extends BaseDbEntity {

	private static final long serialVersionUID = 5261867158089919931L;
	private String name;
	private int diseaseId;
	private String notes;
	private int type;
	private int sequence;

	public int getSequence() {
		return sequence;
	}

	public void setSequence(int sequence) {
		this.sequence = sequence;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getDiseaseId() {
		return diseaseId;
	}

	public void setDiseaseId(int diseaseId) {
		this.diseaseId = diseaseId;
	}

	public String getNotes() {
		return notes;
	}

	public void setNotes(String notes) {
		this.notes = notes;
	}

	public int getType() {
		return type;
	}

	public void setType(int type) {
		this.type = type;
	}
}

package com.ideabinder.yizhi.base.api.model.db.medicine;


import com.ideabinder.yizhi.base.api.model.db.BaseDbEntity;

public class MedicineQAndADb extends BaseDbEntity {

	/**
	 * 
	 */
	private static final long serialVersionUID = 5495452444219804392L;
	private int medicineId;
	private String questionContent;
	private String questionWriter;
	private Long questionTime;
	private String answerContent;
	private String answerWriter;
	private Long answerTime;

	public int getMedicineId() {
		return medicineId;
	}

	public void setMedicineId(int medicineId) {
		this.medicineId = medicineId;
	}

	public String getQuestionContent() {
		return questionContent;
	}

	public void setQuestionContent(String questionContent) {
		this.questionContent = questionContent;
	}

	public String getQuestionWriter() {
		return questionWriter;
	}

	public void setQuestionWriter(String questionWriter) {
		this.questionWriter = questionWriter;
	}

	public Long getQuestionTime() {
		return questionTime;
	}

	public void setQuestionTime(Long questionTime) {
		this.questionTime = questionTime;
	}

	public String getAnswerContent() {
		return answerContent;
	}

	public void setAnswerContent(String answerContent) {
		this.answerContent = answerContent;
	}

	public String getAnswerWriter() {
		return answerWriter;
	}

	public void setAnswerWriter(String answerWriter) {
		this.answerWriter = answerWriter;
	}

	public Long getAnswerTime() {
		return answerTime;
	}

	public void setAnswerTime(Long answerTime) {
		this.answerTime = answerTime;
	}
}

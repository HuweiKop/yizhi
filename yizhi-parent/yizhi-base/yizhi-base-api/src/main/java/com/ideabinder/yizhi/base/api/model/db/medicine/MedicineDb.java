package com.ideabinder.yizhi.base.api.model.db.medicine;


import com.ideabinder.yizhi.base.api.model.db.BaseDbEntity;

import java.math.BigDecimal;

public class MedicineDb extends BaseDbEntity {

	/**
	 * 
	 */
	private static final long serialVersionUID = -4626314071554882852L;
	private String name;
	private String pinyinName;
	private String showName;
	private String pinyinShowName;
	private int chemicalId;
	private Integer prescription;
	private Integer classify;
	private Integer insurance;
	private Integer special;
	private Integer imports;
	private BigDecimal priceMin;
	private BigDecimal priceMax;
	private String useInfo;
	private String taboo;
	private String sideEffect;

	private String Announcements;
	private Integer type;
	private Integer status;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPinyinName() {
		return pinyinName;
	}

	public void setPinyinName(String pinyinName) {
		this.pinyinName = pinyinName;
	}

	public String getPinyinShowName() {
		return pinyinShowName;
	}

	public void setPinyinShowName(String pinyinShowName) {
		this.pinyinShowName = pinyinShowName;
	}

	public String getShowName() {
		return showName;
	}

	public void setShowName(String showName) {
		this.showName = showName;
	}

	public int getChemicalId() {
		return chemicalId;
	}

	public void setChemicalId(int chemicalId) {
		this.chemicalId = chemicalId;
	}

	public Integer getPrescription() {
		return prescription;
	}

	public void setPrescription(Integer prescription) {
		this.prescription = prescription;
	}

	public Integer getClassify() {
		return classify;
	}

	public void setClassify(Integer classify) {
		this.classify = classify;
	}

	public Integer getInsurance() {
		return insurance;
	}

	public void setInsurance(Integer insurance) {
		this.insurance = insurance;
	}

	public Integer getSpecial() {
		return special;
	}

	public void setSpecial(Integer special) {
		this.special = special;
	}

	public Integer getImports() {
		return imports;
	}

	public void setImports(Integer imports) {
		this.imports = imports;
	}

	public BigDecimal getPriceMin() {
		return priceMin;
	}

	public void setPriceMin(BigDecimal priceMin) {
		this.priceMin = priceMin;
	}

	public BigDecimal getPriceMax() {
		return priceMax;
	}

	public void setPriceMax(BigDecimal priceMax) {
		this.priceMax = priceMax;
	}

	public String getUseInfo() {
		return useInfo;
	}

	public void setUseInfo(String useInfo) {
		this.useInfo = useInfo;
	}

	public String getTaboo() {
		return taboo;
	}

	public void setTaboo(String taboo) {
		this.taboo = taboo;
	}

	public String getSideEffect() {
		return sideEffect;
	}

	public void setSideEffect(String sideEffect) {
		this.sideEffect = sideEffect;
	}

	public String getAnnouncements() {
		return Announcements;
	}

	public void setAnnouncements(String announcements) {
		Announcements = announcements;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

}

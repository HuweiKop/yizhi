package com.ideabinder.yizhi.base.api.model.db.disease;


import com.ideabinder.yizhi.base.api.model.db.BaseDbEntity;

/**
 * Created by Wei Hu (J) on 2017/1/4.
 */
public class DiseaseDb extends BaseDbEntity {

    private static final long serialVersionUID = 277441379392364021L;
    private String name;
    private String pinyinName;
    private String diseasePosition;
    private String notes;

    private String feature;

    /*
     * 器官功能
     */
    private String organFunction;
    /*
     * 疾病讲解
     */
    private String diseaseExplain;
    /*
     * 症状
     */
    private String Symptom;
    /*
     * 分型分类
     */
    private String modeType;

    private String earlyStage;
    private String interimStage;
    private String laterStage;

    private String tNotes;
    private String nNotes;
    private String mNotes;

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

    public String getDiseasePosition() {
        return diseasePosition;
    }

    public void setDiseasePosition(String diseasePosition) {
        this.diseasePosition = diseasePosition;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public String getFeature() {
        return feature;
    }

    public void setFeature(String feature) {
        this.feature = feature;
    }

    public String getOrganFunction() {
        return organFunction;
    }

    public void setOrganFunction(String organFunction) {
        this.organFunction = organFunction;
    }

    public String getDiseaseExplain() {
        return diseaseExplain;
    }

    public void setDiseaseExplain(String diseaseExplain) {
        this.diseaseExplain = diseaseExplain;
    }

    public String getSymptom() {
        return Symptom;
    }

    public void setSymptom(String symptom) {
        Symptom = symptom;
    }

    public String getModeType() {
        return modeType;
    }

    public void setModeType(String modeType) {
        this.modeType = modeType;
    }

    public String getEarlyStage() {
        return earlyStage;
    }

    public void setEarlyStage(String earlyStage) {
        this.earlyStage = earlyStage;
    }

    public String getInterimStage() {
        return interimStage;
    }

    public void setInterimStage(String interimStage) {
        this.interimStage = interimStage;
    }

    public String getLaterStage() {
        return laterStage;
    }

    public void setLaterStage(String laterStage) {
        this.laterStage = laterStage;
    }

    public String gettNotes() {
        return tNotes;
    }

    public void settNotes(String tNotes) {
        this.tNotes = tNotes;
    }

    public String getnNotes() {
        return nNotes;
    }

    public void setnNotes(String nNotes) {
        this.nNotes = nNotes;
    }

    public String getmNotes() {
        return mNotes;
    }

    public void setmNotes(String mNotes) {
        this.mNotes = mNotes;
    }
}

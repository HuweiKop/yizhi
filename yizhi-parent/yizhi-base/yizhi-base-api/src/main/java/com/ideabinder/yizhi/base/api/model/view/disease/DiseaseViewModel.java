package com.ideabinder.yizhi.base.api.model.view.disease;



import com.ideabinder.yizhi.base.api.model.db.disease.DiseaseDb;
import com.ideabinder.yizhi.base.api.model.db.disease.DiseaseTNMDb;
import com.ideabinder.yizhi.base.api.model.view.ViewModel;

import java.util.List;

public class DiseaseViewModel extends ViewModel {

	private static final long serialVersionUID = 7076708620515398387L;
	private DiseaseDb disease;
	private List<DiseaseTNMDb> tnms;
	private List<Integer> categorys;

	public List<Integer> getCategorys() {
		return categorys;
	}

	public void setCategorys(List<Integer> categorys) {
		this.categorys = categorys;
	}

	public DiseaseDb getDisease() {
		return disease;
	}

	public void setDisease(DiseaseDb disease) {
		this.disease = disease;
	}

	public List<DiseaseTNMDb> getTnms() {
		return tnms;
	}

	public void setTnms(List<DiseaseTNMDb> tnms) {
		this.tnms = tnms;
	}
}

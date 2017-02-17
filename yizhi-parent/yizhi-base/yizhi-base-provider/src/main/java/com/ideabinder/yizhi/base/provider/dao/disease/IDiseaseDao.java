package com.ideabinder.yizhi.base.provider.dao.disease;


import com.ideabinder.yizhi.base.api.model.db.disease.DiseaseDb;
import com.ideabinder.yizhi.base.api.model.query.disease.DiseasePageQueryModel;

import java.util.List;

/**
 * Created by Wei Hu (J) on 2017/1/5.
 */
public interface IDiseaseDao {

    public int selectCount(DiseasePageQueryModel queryModel);

    public List<DiseaseDb> selectDiseasePage(DiseasePageQueryModel queryModel);


    public List<DiseaseDb> selectDiseaseList();

    public DiseaseDb selectDiseaseById(int id);

    public boolean insertDisease(DiseaseDb disease);

    public boolean updateDisease(DiseaseDb disease);

    public boolean updateDiseaseStatus(DiseaseDb disease);

    public List<Integer> selectDiseaseIdsByInspectionId(Integer inspectionId);

    public List<Integer> selectCategoryIdsByDiseaseId(int diseaseId);

//    public boolean insertDiseaseCategory(DiseaseTherapeuticCategoryDb dtc);
//
//    public boolean updateDiseaseCategoryActive(DiseaseTherapeuticCategoryDb dtc);
}

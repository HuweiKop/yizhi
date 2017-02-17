package com.ideabinder.yizhi.base.api.service.disease;


import com.ideabinder.yizhi.base.api.model.db.PageModel;
import com.ideabinder.yizhi.base.api.model.db.disease.DiseaseDb;
import com.ideabinder.yizhi.base.api.model.query.disease.DiseasePageQueryModel;
import com.ideabinder.yizhi.base.api.model.response.BaseQueryResponseModel;
import com.ideabinder.yizhi.base.api.model.view.disease.DiseaseViewModel;

import java.util.List;

/**
 * Created by Wei Hu (J) on 2017/1/4.
 */
public interface IDiseaseService {

    BaseQueryResponseModel<PageModel<DiseaseDb>> getDiseasePage(DiseasePageQueryModel queryModel);

    BaseQueryResponseModel<List<DiseaseDb>> getDiseaseList();

    BaseQueryResponseModel<DiseaseViewModel> getDiseaseDetail(int diseaseId);
}

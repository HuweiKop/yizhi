package com.ideabinder.yizhi.base.provider.service.impl.disease;

import com.ideabinder.yizhi.base.api.model.db.PageModel;
import com.ideabinder.yizhi.base.api.model.db.disease.DiseaseDb;
import com.ideabinder.yizhi.base.api.model.query.disease.DiseasePageQueryModel;
import com.ideabinder.yizhi.base.api.model.response.BaseQueryResponseModel;
import com.ideabinder.yizhi.base.api.model.view.disease.DiseaseViewModel;
import com.ideabinder.yizhi.base.api.service.disease.IDiseaseService;
import com.ideabinder.yizhi.base.provider.dao.disease.IDiseaseDao;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Wei Hu (J) on 2017/1/4.
 */
@Service("diseaseServiceImpl")
public class DiseaseServiceImpl implements IDiseaseService {

    @Resource
    IDiseaseDao diseaseDao;

    @Override
    public BaseQueryResponseModel<PageModel<DiseaseDb>> getDiseasePage(DiseasePageQueryModel queryModel) {
        queryModel.init();
        int count = this.diseaseDao.selectCount(queryModel);
        List<DiseaseDb> diseaseDbList = this.diseaseDao.selectDiseasePage(queryModel);
        PageModel<DiseaseDb> result = new PageModel<>(diseaseDbList,count,queryModel);
        return new BaseQueryResponseModel(result);
    }

    @Override
    public BaseQueryResponseModel<List<DiseaseDb>> getDiseaseList() {
        List<DiseaseDb> result = this.diseaseDao.selectDiseaseList();
        return new BaseQueryResponseModel<>(result);
    }

    @Override
    public BaseQueryResponseModel<DiseaseViewModel> getDiseaseDetail(int diseaseId) {
        DiseaseViewModel diseasevm = new DiseaseViewModel();

        DiseaseDb disease = this.diseaseDao.selectDiseaseById(diseaseId);
        diseasevm.setDisease(disease);

//        diseasevm.setTnms(super.getDao(IDiseaseTNMDao.class).selectByDiseaseId(this.diseaseId));
//
//        diseasevm.setCategorys(super.getDao(IDiseaseDao.class).selectCategoryIdsByDiseaseId(this.diseaseId));

        return new BaseQueryResponseModel<>(diseasevm);
    }
}

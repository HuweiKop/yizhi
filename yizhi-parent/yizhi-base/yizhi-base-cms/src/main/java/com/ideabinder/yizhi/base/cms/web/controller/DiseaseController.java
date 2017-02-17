package com.ideabinder.yizhi.base.cms.web.controller;

import com.ideabinder.yizhi.base.api.model.db.PageModel;
import com.ideabinder.yizhi.base.api.model.db.disease.DiseaseDb;
import com.ideabinder.yizhi.base.api.model.query.disease.DiseasePageQueryModel;
import com.ideabinder.yizhi.base.api.model.response.BaseQueryResponseModel;
import com.ideabinder.yizhi.base.api.model.view.disease.DiseaseViewModel;
import com.ideabinder.yizhi.base.api.service.disease.IDiseaseService;
import com.ideabinder.yizhi.base.cms.web.Operator;
import com.ideabinder.yizhi.base.cms.web.authority.FunctionAuth;
import com.ideabinder.yizhi.base.cms.web.authority.FunctionName;
import com.ideabinder.yizhi.base.cms.web.authority.MoudleAuth;
import com.ideabinder.yizhi.base.cms.web.authority.MoudleName;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Wei Hu (J) on 2017/1/4.
 */
@MoudleAuth(MoudleName.Disease)
@Controller
@RequestMapping("/web/disease")
public class DiseaseController {

    @Resource
    IDiseaseService diseaseService;

    // Disease

    @FunctionAuth(FunctionName.DiseaseList)
    @RequestMapping("/diseaseList")
    public String diseaseList() {
        return "/disease/diseaseList";
    }

    @FunctionAuth(FunctionName.DiseaseDetail)
    @RequestMapping("/diseaseEdit")
    public ModelAndView diseaseEdit(Integer diseaseId) {
        ModelAndView mav = new ModelAndView();
        mav.setViewName("/disease/diseaseEdit");
        mav.addObject("diseaseId", diseaseId);
//        mav.addObject("zhongmebanBucket",ConfigHelper.getInstance().getZhongmebanBucket());
//        mav.addObject("endPoint",ConfigHelper.getInstance().getEndpoint());
        return mav;
    }

    @FunctionAuth(FunctionName.DiseaseList)
    @RequestMapping("/getDiseaseList")
    public @ResponseBody
    BaseQueryResponseModel<List<DiseaseDb>> getDiseaseList(){

        Operator op = new Operator(diseaseService);
        IDiseaseService diseaseService1 = (IDiseaseService) op.createProxy();
        return diseaseService.getDiseaseList();
    }

    @FunctionAuth(FunctionName.DiseaseList)
    @ResponseBody
    @RequestMapping("/getDiseasePage")
    public BaseQueryResponseModel<PageModel<DiseaseDb>> getDiseasePage(DiseasePageQueryModel queryModel) {
        return diseaseService.getDiseasePage(queryModel);
    }

    @FunctionAuth(FunctionName.DiseaseDetail)
    @ResponseBody
    @RequestMapping("/getDiseaseDetail")
    public BaseQueryResponseModel<DiseaseViewModel> getDiseaseDetail(@RequestParam int diseaseId) {
        return diseaseService.getDiseaseDetail(diseaseId);
    }
}

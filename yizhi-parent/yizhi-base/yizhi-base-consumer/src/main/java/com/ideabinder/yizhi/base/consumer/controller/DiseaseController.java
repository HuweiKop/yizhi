package com.ideabinder.yizhi.base.consumer.controller;

import com.ideabinder.yizhi.base.api.model.db.disease.DiseaseDb;
import com.ideabinder.yizhi.base.api.model.response.BaseQueryResponseModel;
import com.ideabinder.yizhi.base.api.service.disease.IDiseaseService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;

/**
 * Created by Wei Hu (J) on 2017/1/4.
 */
@Controller
@RequestMapping("/disease")
public class DiseaseController {

    @Resource
    IDiseaseService diseaseService;

    @RequestMapping("/getDiseaseAll")
    public @ResponseBody
    BaseQueryResponseModel<List<DiseaseDb>> getDiseaseAll(){
        return diseaseService.getDiseaseList();
    }
}

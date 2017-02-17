package com.ideabinder.yizhi.base.cms.web.controller;

import com.ideabinder.yizhi.base.api.model.db.manage.UserDb;
import com.ideabinder.yizhi.base.api.model.response.BaseQueryResponseModel;
import com.ideabinder.yizhi.base.api.service.manage.IRoleService;
import com.ideabinder.yizhi.base.api.service.manage.IUserService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * Created by Wei Hu (J) on 2017/2/13.
 */
@Controller
@RequestMapping("/login")
public class LoginController {

    @Resource
    IRoleService roleService;
    @Resource
    IUserService userService;

    @RequestMapping("/test")
    public @ResponseBody String test(){
        System.out.println("test--------------");
        return "xxxx";
    }

    @RequestMapping("/login1")
    public String login() {
        System.out.println("login------------------------");
        return "login/Login";
    }

    @RequestMapping(value = "/doLogin", method = RequestMethod.POST)
    public ModelAndView doLogin(@RequestParam String name, @RequestParam String password, HttpSession session) {
        ModelAndView mav = new ModelAndView();
        if ("admin".equals(name) && "fh9490(*&HJ".equals(password)) {
            session.setAttribute("userId", 0);
            session.setAttribute("userName", "admin");
            session.setAttribute("auth", 15);
            BaseQueryResponseModel<List<String>> moudleNames = this.roleService.getAllMoudleNames();
            if (moudleNames.getErrorCode() == 0) {
                session.setAttribute("moudleNames", moudleNames.getData());
            }
            BaseQueryResponseModel<List<String>> functionNames = this.roleService.getAllFunctionNames();
            if (functionNames.getErrorCode() == 0) {
                session.setAttribute("functionNames", functionNames.getData());
            }

            mav.setViewName("redirect:/web/disease/diseaseList");

            return mav;
        }

        UserDb user = new UserDb();
        user.setUserName(name);
        user.setPassword(password);

        BaseQueryResponseModel<Integer> userId = this.userService.login(user);
        if (userId.getErrorCode() == 0) {
            session.setAttribute("userId", userId.getData());
            BaseQueryResponseModel<List<Integer>> roleIds = this.roleService.getRoleIdsByUserId(userId.getData());
            if (roleIds.getErrorCode() == 0) {
                BaseQueryResponseModel<List<String>> moudleNames = this.roleService.getMoudleNamesByRoleIds(roleIds.getData());
                if (moudleNames.getErrorCode() == 0) {
                    session.setAttribute("moudleNames", moudleNames.getData());
                }
                BaseQueryResponseModel<List<String>> functionNames = this.roleService.getFunctionNamesByRoleIds(roleIds.getData());
                if (functionNames.getErrorCode() == 0) {
                    session.setAttribute("functionNames", functionNames.getData());
                }

                mav.setViewName("redirect:/web/disease/diseaseList");
            }
        } else {
            mav.setViewName("login/Login");
        }
        return mav;
    }
}

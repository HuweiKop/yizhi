package com.ideabinder.yizhi.base.cms.web.interceptor;

import com.ideabinder.yizhi.base.api.model.response.BaseQueryResponseModel;
import com.ideabinder.yizhi.base.api.service.manage.IRoleService;
import com.ideabinder.yizhi.base.cms.web.SpringContextUtil;
import com.ideabinder.yizhi.base.cms.web.authority.FunctionAuth;
import com.ideabinder.yizhi.base.cms.web.authority.MoudleAuth;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;

public class CommonInterceptor extends HandlerInterceptorAdapter {

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		System.out.println("common interceptor=========");

//		IRoleService service = (IRoleService) SpringContextUtil.getBean("roleServiceImpl");
//		System.out.println(service);
//		List<Integer> roleIds = new ArrayList<>();
//		roleIds.add(1);
//		roleIds.add(2);
//		BaseQueryResponseModel<List<String>> listMoudleName = service.getMoudleNamesByRoleIds(roleIds);

		HttpSession session = request.getSession();
		System.out.println(session.getAttribute("userId"));
		System.out.println(session.getAttribute("userName"));

		HandlerMethod hm = (HandlerMethod) handler;
		Object controller = hm.getBean();
		Method method = hm.getMethod();
		FunctionAuth fa = method.getAnnotation(FunctionAuth.class);
		MoudleAuth ma = controller.getClass().getAnnotation(MoudleAuth.class);
		if(ma!=null){
			System.out.println(ma.value());
			List<String> moudles = (List<String>)session.getAttribute("moudleNames");
			moudles.forEach(System.out::println);
			if(!moudles.contains(ma.value()))
				return false;
		}
		if(fa!=null){
			System.out.println(fa.value());
			List<String> functions = (List<String>) session.getAttribute("functionNames");
			functions.forEach(System.out::println);
			if(!functions.contains(fa.value()))
				return false;
		}
		return true;
	} 
  
    @Override  
    public void postHandle(HttpServletRequest request, HttpServletResponse response,  
            Object obj, ModelAndView mav) throws Exception {  
    } 


	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
		response.setHeader("Access-Control-Allow-Origin", "*");
	}
}

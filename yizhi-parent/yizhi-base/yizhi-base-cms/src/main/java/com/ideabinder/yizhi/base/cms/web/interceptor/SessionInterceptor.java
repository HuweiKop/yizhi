package com.ideabinder.yizhi.base.cms.web.interceptor;

import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

public class SessionInterceptor extends HandlerInterceptorAdapter {

	private int userId;
	private String userName;
	private int auth;

//	@Override
//	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
//			throws Exception {
//
//		String sessionId = "";
//		Cookie[] cookies = request.getCookies();
//
//		if (cookies == null)
//			return reLogin(request, response);
//
//		Cookie cookie=null;
//		for (Cookie c : cookies) {
//			if (c.getName().equals("sessionId")) {
//				sessionId = c.getValue();
//				cookie = c;
//			}
//		}
//
//		ISessionDao sessionDao = MyBeanFactory.getFactory().getBean(ISessionDao.class);
//		SessionDb session = sessionDao.selectSession(sessionId);
//
//		if (session == null)
//			return reLogin(request, response);
//
//		this.userId = session.getUserId();
//		this.userName = session.getUserName();
//		this.auth = session.getAuth();
//
//		request.setAttribute("userId", userId);
//		request.setAttribute("userName", userName);
//		request.setAttribute("auth", auth);
//
//		session.setExpirationTime(DateTimeUtility.newTimeLong() + 30 * 60 * 1000);
//		sessionDao.updateExpirationTime(session);
//
//		cookie.setMaxAge(60 * 60);
//		cookie.setPath("/");
//		response.addCookie(cookie);
//
//		if (this.userId == 0)
//			return true;
//
//		Integer auth = session.getAuth();
//		Pattern patternCreate = Pattern.compile("(.+)create(.+)");
//		Matcher matcherCreate = patternCreate.matcher(request.getServletPath());
//		Pattern patternUpdate = Pattern.compile("(.+)update(.+)");
//		Matcher matcherUpdate = patternUpdate.matcher(request.getServletPath());
//		Pattern patternPublish = Pattern.compile("(.+)update(.+)Status$");
//		Matcher matcherPublish = patternPublish.matcher(request.getServletPath());
//
//		if (matcherPublish.matches()) {
//			if (auth == null || (auth & 8) == 0) {
//				response.setContentType("application/json; charset=UTF-8");
//				PrintWriter out = response.getWriter();
//				JSONObject jsonObj = new JSONObject(new BaseResponseModel(ErrorCode.NoAuth, "无发布权限"));
//				out.print(jsonObj.toString());
//				out.close();
//				return false;
//			}
//		} else if (matcherUpdate.matches()) {
//			if (auth == null || (auth & 4) == 0) {
//				response.setContentType("application/json; charset=UTF-8");
//				PrintWriter out = response.getWriter();
//				JSONObject jsonObj = new JSONObject(new BaseResponseModel(ErrorCode.NoAuth, "无编辑权限"));
//				out.print(jsonObj.toString());
//				out.close();
//				return false;
//			}
//		} else if (matcherCreate.matches()) {
//			if (auth == null || (auth & 1) == 0) {
//				response.setContentType("application/json; charset=UTF-8");
//				PrintWriter out = response.getWriter();
//				JSONObject jsonObj = new JSONObject(new BaseResponseModel(ErrorCode.NoAuth, "无创建权限"));
//				out.print(jsonObj.toString());
//				out.close();
//				return false;
//			}
//		}
//
//		return true;
//	}

	private boolean reLogin(HttpServletRequest request, HttpServletResponse response) throws IOException {
		{
			PrintWriter out = response.getWriter();
			StringBuilder builder = new StringBuilder();
			builder.append("<script type=\"text/javascript\" charset=\"UTF-8\">");
			builder.append("alert(\"session time out\");");
			builder.append("window.top.location.href=\"");
			builder.append(request.getContextPath());
			builder.append("/login/login\";</script>");
			out.print(builder.toString());
			out.close();
			return false;
		}
	}

	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object obj, ModelAndView mav)
			throws Exception {
		if (mav != null) {
			System.out.println(mav.getViewName());
			mav.addObject("userName", this.userName);
			mav.addObject("userId", this.userId);
			mav.addObject("userAuth", this.auth);
		}
	}

	@Override
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex)
			throws Exception {
	}
}

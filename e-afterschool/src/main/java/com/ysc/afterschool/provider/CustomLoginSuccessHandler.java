package com.ysc.afterschool.provider;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;

public class CustomLoginSuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler {
	
	private final String COOKIE_NAME = "cityId";
	private final int DEFAULT_MAX_AGE = 60 * 60 * 24 * 7;

	private int maxAge = DEFAULT_MAX_AGE;
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {
		
		String cityId = request.getParameter(COOKIE_NAME);
		
		Cookie cookie = new Cookie(COOKIE_NAME, cityId);
		cookie.setMaxAge(maxAge);
		response.addCookie(cookie);
		
		super.setDefaultTargetUrl("/info/" + cityId);
		
		super.onAuthenticationSuccess(request, response, authentication);
	}
}

package com.ysc.afterschool.provider;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

public class CustomAuthenticationFailHandler implements AuthenticationFailureHandler {

	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException exception) throws IOException, ServletException {
		
		String cityId = request.getParameter("cityId");
		String defaultFailureUrl = request.getContextPath() + "/login/" + cityId + "?error";
		
		response.sendRedirect(defaultFailureUrl);
	}
}

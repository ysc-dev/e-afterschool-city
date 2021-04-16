package com.ysc.afterschool.provider;

import java.util.ArrayList;
import java.util.Collection;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.stereotype.Component;

import com.ysc.afterschool.domain.db.Student;
import com.ysc.afterschool.service.StudentService;

/**
 * 로그인 관리
 * 
 * @author hgko
 *
 */
@Component
public class UserAuthenticationProvider implements AuthenticationProvider {

	@Autowired
	private StudentService studentService;
	
	@Override
	public Authentication authenticate(Authentication authentication) throws AuthenticationException {
		String username = (String) authentication.getPrincipal();
        String password = (String) authentication.getCredentials();
        
        Student student = studentService.login(username.trim(), password);
        if (student != null) {
        	Collection<SimpleGrantedAuthority> roles = new ArrayList<SimpleGrantedAuthority>();
        	roles.add(new SimpleGrantedAuthority("ROLE_USER"));
  
            return new UsernamePasswordAuthenticationToken(student, password, roles);   
        } else {
            throw new BadCredentialsException("Login Error !!");
        }
	}

	@Override
	public boolean supports(Class<?> authentication) {
		return authentication.equals(UsernamePasswordAuthenticationToken.class);
	}

}

package com.ysc.afterschool.exceptoion;

public class LoginFailedException extends RuntimeException {

	public LoginFailedException() {
		super("로그인을 실패하였습니다.");
	}
}

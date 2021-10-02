package com.ysc.afterschool.controller;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ysc.afterschool.service.common.SmsService;

/**
 * 문자 서비스 관리
 * 
 * @author hgko
 *
 */
@Controller
@RequestMapping("sms")
public class SmsController {

	@Autowired
	private SmsService smsService;

	@GetMapping("send")
	public String send() throws IOException {

		int site = 8; // 8: 창원, 9: 진주

		smsService.send("010-4613-1202", site);

		return "home";
	}
}

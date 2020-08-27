package com.ysc.afterschool.controller;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ysc.afterschool.domain.db.Apply;
import com.ysc.afterschool.domain.db.ApplyWait;
import com.ysc.afterschool.service.ApplyService;
import com.ysc.afterschool.service.ApplyWaitService;
import com.ysc.afterschool.service.common.SmsService;

@Controller
@RequestMapping("sms")
public class SmsController {
	
	@Autowired
	private SmsService smsService;
	
	@Autowired
	private ApplyService applyService;
	
	@Autowired
	private ApplyWaitService applyWaitService;
	
	@GetMapping("send")
	public String send() throws IOException {
		int site = 8; // 8: 창원, 9: 진주
		
		smsService.send("010-4613-1202", site);
//		for (Apply apply : applyService.getList(site)) {
//			smsService.send(apply.getStudent().getTel(), site);
//		}
//		for (ApplyWait wait : applyWaitService.getGroupList(site)) {
//			smsService.send(wait.getStudent().getTel(), site);
//		}
		return "home";
	}
}

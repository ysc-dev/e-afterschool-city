package com.ysc.afterschool.controller;

import java.io.IOException;

import javax.servlet.http.Cookie;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import com.ysc.afterschool.domain.db.City;
import com.ysc.afterschool.service.CityService;
import com.ysc.afterschool.service.SmsService;

/**
 * 인트로 화면 및 홈 화면
 * 
 * @author hgko
 *
 */
@Controller
public class HomeController {
	
	@Autowired
	private CityService cityService;
	
	@Autowired
	private SmsService smsService;
	
	@GetMapping("/")
	public String index() {
		return "redirect:cw";
	}
	
	@GetMapping("/{link}")
	public String link(@PathVariable String link) {
		City city = cityService.get(link);
		if (city != null) {
			return "redirect:home/" + city.getId();
		}
		return "fail";
	}

	@GetMapping("home")
	public String home(@CookieValue(value = "cityId", required = false) Cookie cookie) {
		return "redirect:home/" + cookie.getValue();
	}
	
	@GetMapping("home/{cityId}")
	public String home(Model model, @PathVariable int cityId) {
		City city = cityService.get(cityId);
		model.addAttribute("city", city);
		return "home";
	}
	
	@GetMapping("login")
	public String login(@CookieValue(value = "cityId", required = false) Cookie cookie) {
		return "redirect:login/" + cookie.getValue();
	}
	
	@GetMapping("login/{cityId}")
	public String login(Model model, @PathVariable int cityId, @RequestParam(value = "error", required = false) String error) {
		if (error != null) {
			model.addAttribute("error", "falied");
		}
		model.addAttribute("cityId", cityId);
		
		return "login";
	}
	
	@GetMapping("send")
	public String send() throws IOException {
		smsService.send("010-4613-1202");
//		for (Apply apply : applyService.getList(9)) {
//			smsService.send(apply.getStudent().getTel());
////			System.err.println(apply.getStudent().getTel());
//		}
		return "home";
	}
}

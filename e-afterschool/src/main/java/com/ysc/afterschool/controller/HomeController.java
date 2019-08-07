package com.ysc.afterschool.controller;

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
	
	@GetMapping("/{link}")
	public String index(@PathVariable String link) {
		City city = cityService.get(link);
		if (city != null) {
			return "redirect:home/" + city.getId();
		}
		return "fail";
	}

	@GetMapping("home")
	public String home(@CookieValue(value = "cityId", required = false) Cookie cookie) {
		return "home/" + cookie.getValue();
	}
	
	@GetMapping("home/{cityId}")
	public String home(Model model, @PathVariable int cityId) {
		model.addAttribute("cityId", cityId);
		return "home";
	}
	
	@GetMapping("login/{cityId}")
	public String login(Model model, @PathVariable int cityId, @RequestParam(value = "error", required = false) String error) {
		if (error != null) {
			model.addAttribute("error", "falied");
		}
		model.addAttribute("cityId", cityId);
		return "login";
	}
}

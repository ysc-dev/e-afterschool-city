package com.ysc.afterschool.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import com.ysc.afterschool.domain.db.City;
import com.ysc.afterschool.service.CityService;

/**
 * 인트로 화면 및 홈 화면 컨트롤러
 * 
 * @author hgko
 *
 */
@Controller
public class HomeController {

	@Autowired
	private CityService cityService;

	@GetMapping("/")
	public String index() {
		return "redirect:jin-ro";
	}

	@GetMapping("/{link}")
	public String link(@PathVariable String link) {

		City city = cityService.get(link);
		if (city != null) {
			return "redirect:home/" + city.getId();
		}

		return "fail";
	}

	/**
	 * 홈 화면
	 * 
	 * @param model
	 * @param cityId
	 * @return
	 */
	@GetMapping("home/{cityId}")
	public String home(Model model, @PathVariable int cityId) {

		model.addAttribute("city", cityService.get(cityId));

		return "home";
	}

	/**
	 * 로그인 시
	 * 
	 * @param model
	 * @param cityId
	 * @param error
	 * @return
	 */
	@GetMapping("user/login/{cityId}")
	public String login(Model model, @PathVariable int cityId,
			@RequestParam(value = "error", required = false) String error) {
		
		if (error != null) {
			model.addAttribute("error", "falied");
		}

		City city = cityService.get(cityId);
		model.addAttribute("city", city);

		return "user/login";
	}
}

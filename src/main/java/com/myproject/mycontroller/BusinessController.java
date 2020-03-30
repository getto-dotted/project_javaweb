package com.myproject.mycontroller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class BusinessController {

	@RequestMapping("/business/sub01")
	public String sub01() {
		return "/business/sub01";
	}	
	@RequestMapping("/business/sub02")
	public String sub02() {
		return "/business/sub02";
	}	
	@RequestMapping("/business/sub03")
	public String sub03() {
		return "/business/sub03";
	}	
	@RequestMapping("/business/sub04")
	public String sub04() {
		return "/business/sub04";
	}	
	@RequestMapping("/business/sub05")
	public String sub05() {
		return "/business/sub05";
	}	
	@RequestMapping("/business/sub06")
	public String sub06() {
		return "/business/sub06";
	}	
}

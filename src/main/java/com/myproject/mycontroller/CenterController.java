package com.myproject.mycontroller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class CenterController {

	@RequestMapping("/center/sub01")
	public String sub01() {
		return "/center/sub01";
	}
	@RequestMapping("/center/sub02")
	public String sub02() {
		return "/center/sub02";
	}	
	@RequestMapping("/center/sub03")
	public String sub03() {
		return "/center/sub03";
	}	
	@RequestMapping("/center/sub04")
	public String sub04() {
		return "/center/sub04";
	}	
	@RequestMapping("/center/sub05")
	public String sub05() {
		return "/center/sub05";
	}	
	@RequestMapping("/center/sub06")
	public String sub06() {
		return "/center/sub06";
	}	
}

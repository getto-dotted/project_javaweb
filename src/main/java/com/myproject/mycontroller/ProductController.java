package com.myproject.mycontroller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ProductController {

	@RequestMapping("/product/sub01")
	public String sub01() {
		return "/product/sub01";
	}
	@RequestMapping("/product/sub02")
	public String sub02() {
		return "/product/sub02";
	}	
	@RequestMapping("/product/sub01_02")
	public String sub01_02() {
		return "/product/sub01_02";
	}	
	@RequestMapping("/product/sub01_03")
	public String sub01_03() {
		return "/product/sub01_03";
	}	
	
}

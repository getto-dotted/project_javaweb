package com.myproject.mycontroller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class VolunteerController {

	@RequestMapping("/volunteer/sponsor")
	public String sub01() {
		return "/volunteer/sponsor";
	}
	@RequestMapping("/volunteer/volunteer")
	public String sub02() {
		return "/volunteer/volunteer";
	}
	
}

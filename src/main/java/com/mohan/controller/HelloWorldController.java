package com.mohan.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;


@RestController
public class HelloWorldController {

	@GetMapping("/hello")
	public String greeting() {
		return "Hello World!";
	}
	
}

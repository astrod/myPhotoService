package org.nhnnext.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HomeController {
	@RequestMapping("/")
	public String index() {
		return "index";
	}
}
// Java를 이용하여 컨트롤러를 코딩함. 컨트롤러는 MVC모델에서 처음으로 사용자의 요청을 받는 곳임. 사용자가 컨트롤러로 요청을 함
// 이 경우에는 "매핑을 /로 했으니, /가 나오면 index를 값으로 줘!"
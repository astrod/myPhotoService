package org.nhnnext.web;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.nhnnext.repository.SignRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class SignController {
		@Autowired
		private SignRepository signRepository;
		@RequestMapping("/board/signPage")
		public String joinPage() {
			return "signPage";
		}
		
@RequestMapping(value="/board/signPage", method=RequestMethod.POST)
public String signPage(Sign sign) {
	signRepository.save(sign);
	
	//	Sign tempSign = new Sign();
//	tempSign.setUserid(sign.getUserid());
//	tempSign.setUserpsd(sign.getUserpsd());
//	
	return "redirect:/";
}

@RequestMapping(value="/board/loginPage", method=RequestMethod.POST)
public String loginPage(Sign sign, HttpSession session) {
	String tempId = sign.getUserid();
	String tempPswd = sign.getUserpsd();
	List<Sign> signItems = (List<Sign>) signRepository.findAll();
	for(int i=0; i<signItems.size(); i++) {
		if(signItems.get(i).getUserid().equals(tempId) && signItems.get(i).getUserpsd().equals(tempPswd)) {
			session.setAttribute("userid", sign.getUserid());
			return "redirect:/board";
		}

		}
		
		return "redirect:/";
	}
	



@RequestMapping(value="/board/logout", method=RequestMethod.GET)
public String logout(HttpSession session) {
	session.removeAttribute("userid");
	return "redirect:/";
	
}
				
}

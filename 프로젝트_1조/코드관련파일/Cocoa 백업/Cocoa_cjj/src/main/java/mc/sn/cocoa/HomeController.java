package mc.sn.cocoa;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class HomeController {

	// 프로젝트, 코치 글 전체 조회
	@RequestMapping(value = "/", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView home() throws Exception {
		ModelAndView mav = new ModelAndView();
		String url = "/home";
		mav.setViewName(url);
		return mav;
	}
}
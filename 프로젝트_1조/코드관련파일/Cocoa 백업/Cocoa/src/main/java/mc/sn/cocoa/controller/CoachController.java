package mc.sn.cocoa.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import mc.sn.cocoa.vo.Criteria;

public interface CoachController {

	public ModelAndView view_CoachCate(HttpServletRequest request, HttpServletResponse response, Criteria cri)
			throws Exception;

	public ModelAndView view_coachWrite(HttpServletRequest request, HttpServletResponse response) throws Exception;

	public ResponseEntity addNewCoach(MultipartHttpServletRequest multipartRequest, HttpServletResponse response)
			throws Exception;

	public void download(@RequestParam("cImg") String cImg, @RequestParam("coach") String coach,
			@RequestParam("coachNO") int coachNO, HttpServletResponse response) throws Exception;

	public ModelAndView coachInfo(@RequestParam("coachNO") int coachNO, HttpServletRequest request,
			HttpServletResponse response) throws Exception;

	public ResponseEntity removeCoach(@RequestParam("coachNO") int coachNO, @RequestParam("coach") String coach,
			HttpServletRequest request, HttpServletResponse response) throws Exception;
}

package mc.sn.cocoa.controller;

import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import mc.sn.cocoa.vo.MemberVO;

public interface MemberController {

	public ModelAndView view_join(HttpServletRequest request, HttpServletResponse response);

	public int join(@ModelAttribute("member") MemberVO memberVO, HttpServletRequest request,
			HttpServletResponse response) throws UnsupportedEncodingException;

	public ModelAndView view_login(@RequestParam(value = "result", required = false) String result,
			@RequestParam("view") String view, HttpServletRequest request, HttpServletResponse response);

	public ModelAndView login(@ModelAttribute("member") MemberVO member, RedirectAttributes rAttr,
			HttpServletRequest request, HttpServletResponse response);

	public ModelAndView logout(HttpServletRequest request, HttpServletResponse response);

	public ModelAndView view_myPageProfile(HttpServletRequest request, HttpServletResponse response) throws Exception;

	public ModelAndView view_memberInfo(HttpServletRequest request, HttpServletResponse response);
	
	public ModelAndView view_proFileInfo(@RequestParam("profileId") String id, HttpServletRequest request,
			HttpServletResponse response) throws Exception;
	
	public int idChk(MemberVO vo) throws Exception;
	
	public ResponseEntity modProfile(MultipartHttpServletRequest multipartRequest, HttpServletResponse response)
			throws Exception;
	
	public ResponseEntity updateMember(@ModelAttribute("member") MemberVO memberVO, HttpServletRequest request,
			HttpServletResponse response) throws UnsupportedEncodingException;
	
	public ResponseEntity dropMember(@RequestParam("id") String id, HttpServletRequest request,
			HttpServletResponse response) throws Exception;

}
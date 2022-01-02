package mc.sn.cocoa.controller;

import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import mc.sn.cocoa.vo.Criteria;
import mc.sn.cocoa.vo.RequestVO;

public interface RequestController {

	public ModelAndView view_reqWriteForm(@RequestParam("coachId") String res,
			@RequestParam("basicPrice") int basicPrice, HttpServletRequest request, HttpServletResponse response);

	public ResponseEntity sendRequest(MultipartHttpServletRequest multipartRequest, HttpServletResponse response)
			throws Exception;

	public ModelAndView view_sendReq(HttpServletRequest request, HttpServletResponse response, Criteria cri)
			throws Exception;

	public ModelAndView view_receiveReq(HttpServletRequest request, HttpServletResponse response, Criteria cri)
			throws Exception;

	public ModelAndView view_gotReqWait(@RequestParam("reqNO") int reqNO, HttpServletRequest request,
			HttpServletResponse response) throws UnsupportedEncodingException;

	public ModelAndView view_sentReqWait(@RequestParam("reqNO") int reqNO, HttpServletRequest request,
			HttpServletResponse response) throws UnsupportedEncodingException;

	public ResponseEntity removeRequest(@RequestParam("reqNO") int reqNO, HttpServletRequest request,
			HttpServletResponse response);

	public void downloadGotImg(@RequestParam("reqNO") int reqNO, HttpServletResponse response) throws Exception;

	public ModelAndView view_gotReqYes(@RequestParam("reqNO") int reqNO, HttpServletRequest request,
			HttpServletResponse response) throws UnsupportedEncodingException;

	public ModelAndView view_gotReqNo(@RequestParam("reqNO") int reqNO, HttpServletRequest request,
			HttpServletResponse response) throws UnsupportedEncodingException;

	public ResponseEntity submitNoReason(@ModelAttribute("request") RequestVO requestVO, HttpServletRequest request,
			HttpServletResponse response) throws UnsupportedEncodingException;

	public ResponseEntity submitReqYes(@ModelAttribute("request") RequestVO requestVO, HttpServletRequest request,
			HttpServletResponse response) throws UnsupportedEncodingException;
}
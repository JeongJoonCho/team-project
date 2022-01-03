package mc.sn.cocoa.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import mc.sn.cocoa.vo.Criteria;

public interface ProjectController {

	public ModelAndView view_projectCate(HttpServletRequest request, HttpServletResponse response, Criteria cri)
			throws Exception;

	public ModelAndView view_projectWrite(HttpServletRequest request, HttpServletResponse response) throws Exception;

	public ResponseEntity addNewProject(MultipartHttpServletRequest multipartRequest, HttpServletResponse response)
			throws Exception;

	public ModelAndView projectInfo(@RequestParam("id") String id, @RequestParam("projectNO") int projectNO,
			HttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException;

	public ResponseEntity removeProject(@RequestParam("projectNO") int projectNO, @RequestParam("leader") String id,
			HttpServletRequest request, HttpServletResponse response);

	public ResponseEntity modProject(MultipartHttpServletRequest multipartRequest, HttpServletResponse response)
			throws Exception;

	public void getGeo(HttpServletRequest req, HttpServletResponse res) throws IOException;

}
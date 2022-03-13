package mc.sn.cocoa.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import mc.sn.cocoa.service.MemberService;
import mc.sn.cocoa.service.RequestService;
import mc.sn.cocoa.vo.MemberVO;

@Controller("memberController")
public class MemberControllerImpl implements MemberController {

	// 프로필 이미지 저장 경로
	private static final String profile_IMAGE_REPO = "/opt/cocoa/image/profile_img";
	@Autowired
	private MemberService memberService;
	@Autowired
	private RequestService requestService;

	// 회원가입 화면으로 이동
	@Override
	@RequestMapping(value = "/view_join", method = RequestMethod.GET)
	public ModelAndView view_join(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();
		String url = "/account/joinForm";
		mav.setViewName(url);
		return mav;
	}

	// 로그인 화면으로 이동
	@Override
	@RequestMapping(value = "/view_login", method = RequestMethod.GET)
	public ModelAndView view_login(@RequestParam(value = "result", required = false) String result,
			@RequestParam("view") String view, HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();
		String url = "/account/loginForm";
		mav.addObject("result", result);
		mav.addObject("view", view);
		mav.setViewName(url);
		return mav;
	}

	// 타인 프로필 화면 이동
	@Override
	@RequestMapping(value = "/view_profileInfo", method = RequestMethod.GET)
	public ModelAndView view_proFileInfo(@RequestParam("profileId") String id, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		MemberVO memberVO = memberService.searchMember(id);
		mav.addObject("profileId", memberVO);
		String url = "/account/profileInfo";
		mav.setViewName(url);
		return mav;
	}
	
	// 마이페이지 이동
	@Override
	@RequestMapping(value = "/view_myPageProfile", method = RequestMethod.GET)
	public ModelAndView view_myPageProfile(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		// session에 저장된 로그인한 아이디 정보 불러오기
		HttpSession session = request.getSession();
		MemberVO vo = (MemberVO) session.getAttribute("member");
		String id = vo.getId();

		// 프로필 정보 가져오기
		MemberVO memberVO = memberService.searchMember(id);
		mav.addObject("profileId", memberVO);

		String url = "/myPage/myPageProfile";
		mav.setViewName(url);
		return mav;
	}
	
	// 회원정보 수정 이동
	@Override
	@RequestMapping(value = "/view_memberInfo", method = RequestMethod.GET)
	public ModelAndView view_memberInfo(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();
		String url = "/myPage/myPageInfo";
		mav.setViewName(url);
		return mav;
	}
	
	// 회원가입
	@Override
	@ResponseBody
	@RequestMapping(value = "/join", method = RequestMethod.POST)
	public int join(@ModelAttribute("member") MemberVO memberVO, HttpServletRequest request,
			HttpServletResponse response) throws UnsupportedEncodingException {
		request.setCharacterEncoding("utf-8");
		int result = 0;
		result = memberService.joinMember(memberVO);
		return result;
	}

	// 로그인
	@Override
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public ModelAndView login(@ModelAttribute("member") MemberVO member, RedirectAttributes rAttr,
			HttpServletRequest request, HttpServletResponse response) {
		ModelAndView mav = new ModelAndView();
		// POST로 받아온 정보 "member"로 데이터를 불러와 memberVO로 저장 
		MemberVO memberVO = memberService.login(member);
		// 로그인 이전 화면의 값을 가져오기위한 view
		String view = request.getParameter("view");
		if (memberVO != null) {
			//session에 member와 isLogOn을 저장
			HttpSession session = request.getSession();
			session.setAttribute("member", memberVO);
			session.setAttribute("isLogOn", true);
			mav.setViewName("redirect:/" + view);
		} else {
			rAttr.addAttribute("result", "loginFailed");
			mav.setViewName("redirect:/view_login?view=" + view);
		}
		return mav;
	}

	// 로그아웃
	@Override
	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public ModelAndView logout(HttpServletRequest request, HttpServletResponse response) {
		// session에 member와 isLogOn을 제거
		HttpSession session = request.getSession();
		session.removeAttribute("member");
		session.removeAttribute("isLogOn");
		ModelAndView mav = new ModelAndView();
		// 로그아웃 시 홈화면으로 이동
		mav.setViewName("redirect:/");
		return mav;
	}

	// 회원가입 시 아이디 중복 체크
	@Override
	@ResponseBody
	@RequestMapping(value = "/idChk", method = RequestMethod.POST)
	public int idChk(MemberVO vo) throws Exception {
		int result = 0;
		result = memberService.idChk(vo);
		return result;
	}

	// 파일 업로드 (프로필사진)
	// private 메소드
	private String upload(MultipartHttpServletRequest multipartRequest) throws Exception {

		String proImg = null;
		Iterator<String> fileNames = multipartRequest.getFileNames();

		while (fileNames.hasNext()) {

			String fileName = fileNames.next();
			MultipartFile mFile = multipartRequest.getFile(fileName);
			proImg = mFile.getOriginalFilename();

			File file = new File(profile_IMAGE_REPO + "/" + "temp" + "/" + fileName);

			if (mFile.getSize() != 0) {
				if (!file.exists()) {
					if (file.getParentFile().mkdirs()) {
						file.createNewFile();
					}
				}
				mFile.transferTo(new File(profile_IMAGE_REPO + "/" + "temp" + "/" + proImg));
			}
		}
		return proImg;
	}

	// 프로필 이미지 가져오기
	@RequestMapping("/downProfileImg")
	protected void download(@RequestParam("id") String id, HttpServletResponse response) throws Exception {
		OutputStream out = response.getOutputStream();
		MemberVO vo = memberService.searchMember(id);
		String proImg = vo.getproImg();
		String filePath = profile_IMAGE_REPO + "/" + id + "/" + proImg;
		File image = new File(filePath);

		response.setHeader("Cache-Control", "no-cache");
		response.addHeader("Content-disposition", "attachment; fileName=" + proImg);
		FileInputStream in = new FileInputStream(image);
		byte[] buffer = new byte[1024 * 8];
		while (true) {
			int count = in.read(buffer);
			if (count == -1)
				break;
			out.write(buffer, 0, count);
		}
		in.close();
		out.close();
	}

	// 프로필 수정
	@Override
	@ResponseBody
	@RequestMapping(value = "/modProfile", method = RequestMethod.POST)
	public ResponseEntity modProfile(MultipartHttpServletRequest multipartRequest, HttpServletResponse response)
			throws Exception {
		multipartRequest.setCharacterEncoding("utf-8");
		// profileMap 설정
		Map<String, Object> profileMap = new HashMap<String, Object>();
		// 파라메타 key 값들을 설정
		Enumeration enu = multipartRequest.getParameterNames();
		// 파라메타 key & value를 profileMap에 저장
		while (enu.hasMoreElements()) {
			String name = (String) enu.nextElement();
			String value = multipartRequest.getParameter(name);
			profileMap.put(name, value);
		}
		// upload 메소드로 proImg 값 가져오고 profileMap에 저장
		String proImg = upload(multipartRequest);
		profileMap.put("proImg", proImg);
		// 저장경로에 사용할 id 값 설정
		String id = (String) profileMap.get("id");
		String message;
		ResponseEntity resEnt = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		try {
			memberService.modProfile(profileMap);
			if (proImg != null && proImg.length() != 0) {
				// 이미지를 변경했다면 이전 파일 삭제
				String originalFileName = (String) profileMap.get("originalFileName");
				File oldFile = new File(profile_IMAGE_REPO + "/" + id + "/" + originalFileName);
				oldFile.delete();
				// 이미지를 변경했다면 새롭게 파일경로 설정
				File srcFile = new File(profile_IMAGE_REPO + "/" + "temp" + "/" + proImg);
				File destDir = new File(profile_IMAGE_REPO + "/" + id);
				FileUtils.moveFileToDirectory(srcFile, destDir, true);
			}
			message = "<script>";
			message += " alert('수정이 완료되었습니다.');";
			message += " location.href='" + multipartRequest.getContextPath() + "/view_myPageProfile'; ";
			message += " </script>";
			resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
		} catch (Exception e) {
			// 예외발생시 취소 및 삭제
			File srcFile = new File(profile_IMAGE_REPO + "/" + "temp" + "/" + proImg);
			srcFile.delete();

			message = " <script>";
			message += " alert('오류가 발생했습니다. 다시 시도해주세요.');');";
			message += " location.href='" + multipartRequest.getContextPath() + "/'; ";
			message += " </script>";
			resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
		}
		return resEnt;
	}

	// 회원정보 수정
	@Override
	@ResponseBody
	@RequestMapping(value = "/updateInfo", method = RequestMethod.POST)
	public ResponseEntity updateMember(@ModelAttribute("member") MemberVO memberVO, HttpServletRequest request,
			HttpServletResponse response) throws UnsupportedEncodingException {
		request.setCharacterEncoding("utf-8");
		int result = 0;
		// 회원정보 수정
		result = memberService.modifyMember(memberVO);
		String message;
		ResponseEntity resEnt = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		// 수정 성공 시
		if (result != 0) {
			message = "<script>";
			message += " alert('수정이 완료되었습니다.');";
			message += " location.href='" + request.getContextPath() + "/view_memberInfo'; ";
			message += " </script>";
			resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
		} 
		// 수정 실패시 
		else {

			message = " <script>";
			message += " alert('오류가 발생했습니다. 다시 시도해주세요.');');";
			message += " location.href='" + request.getContextPath() + "/view_memberInfo'; ";
			message += " </script>";
			resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
		}
		return resEnt;
	}

	// 회원 탈퇴
	@Override
	@ResponseBody
	@RequestMapping(value = "/dropMember", method = RequestMethod.GET)
	public ResponseEntity dropMember(@RequestParam("id") String id, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		request.setCharacterEncoding("utf-8");
		int result = 0;
		// 회원 정보 search 하고
		MemberVO vo = memberService.searchMember(id);
		// search 한 것을 바탕으로 proImg 값 가져오기
		String proImg = vo.getproImg();
		// 회원 정보 삭제
		result = memberService.dropMember(id);
		String message;
		ResponseEntity resEnt = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		if (result != 0) {
			// 프로필 이미지 파일 삭제
			File destDir = new File(profile_IMAGE_REPO + "/" + id + "/" + proImg);
			FileUtils.deleteDirectory(destDir);
			HttpSession session = request.getSession();
			session.removeAttribute("member");
			session.removeAttribute("isLogOn"); // 삭제하고 isLogOn과 member를 세션에서 삭제
			message = "<script>";
			message += " alert('회원탈퇴가 완료되었습니다.');";
			message += " location.href='" + request.getContextPath() + "/'; ";
			message += " </script>";
			resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
		} else {

			message = " <script>";
			message += " alert('오류가 발생했습니다. 다시 시도해주세요.');');";
			message += " location.href='" + request.getContextPath() + "/view_memberInfo'; ";
			message += " </script>";
			resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
		}
		return resEnt;
	}
}
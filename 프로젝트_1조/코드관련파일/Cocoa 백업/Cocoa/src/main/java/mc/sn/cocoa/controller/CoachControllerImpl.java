package mc.sn.cocoa.controller;

import java.io.File;
import java.io.OutputStream;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
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
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import mc.sn.cocoa.service.CoachService;
import mc.sn.cocoa.service.ReviewService;
import mc.sn.cocoa.vo.CoachVO;
import mc.sn.cocoa.vo.Criteria;
import mc.sn.cocoa.vo.MemberVO;
import mc.sn.cocoa.vo.PageMaker;
import net.coobird.thumbnailator.Thumbnails;

@Controller("coachController")
public class CoachControllerImpl implements CoachController {

	// 업로드, 다운로드되는 경로
	private static final String COACH_IMAGE_REPO = "/opt/cocoa/image/coach_img";
	@Autowired
	private CoachService coachService;
	@Autowired
	private CoachVO coachVO;
	@Autowired
	private ReviewService reviewService;

	// 코치 글 조회
	@Override
	@RequestMapping(value = "/view_coachCate", method = { RequestMethod.GET, RequestMethod.POST })
	public ModelAndView view_CoachCate(HttpServletRequest request, HttpServletResponse response, Criteria cri)
			throws Exception {
		ModelAndView mav = new ModelAndView();

		// 내가 쓴 글을 선택시 실행해서 coachOrder 설정
		String coachOrder = cri.getCoachOrder();
		if (coachOrder.equals("and coach like")) {
			HttpSession session = request.getSession();
			MemberVO vo = (MemberVO) session.getAttribute("member");
			String id = vo.getId();
			String coach = coachOrder + "'" + id + "'";
			cri.setCoachOrder(coach);
		}

		// 쪽 번호 생성 메서드 객체 생성
		PageMaker pageMaker = new PageMaker();

		// 쪽 번호와 한 페이지에 게시할 글의 수 세팅
		pageMaker.setCri(cri);

		// 총 게시글의 수
		pageMaker.setTotalCount(coachService.countCoach(cri));

		// 서비스에서 listCoaches() 메소드 실행하여 리턴 값을 List타입의 coachesList에 저장
		List coachesList = coachService.listCoaches(cri);

		// 맵 생성
		Map<String, Object> reCountMap = new HashMap<String, Object>();

		// 리스트 생성해서 target들을 불러오고 불러온 값들로 for문을 돌려서 리뷰 갯수를 불러옴->맵에 저장
		List target = reviewService.targetsReview();

		for (int i = 0; i < target.size(); i++) {
			String key = (String) target.get(i);
			int value = reviewService.targetReviewCount(key);
			reCountMap.put(key, value);
		}

		// 맵 생성
		Map<String, Object> reAvgMap = new HashMap<String, Object>();

		// target들을 불러오고 불러온 값들로 for문을 돌려서 평균점수를 불러옴->맵에 저장
		for (int i = 0; i < target.size(); i++) {
			String key = (String) target.get(i);
			float value = reviewService.targetReviewAvg(key);
			reAvgMap.put(key, value);
		}

		// mav에 reAvg 키값으로 reAvgMap 밸류 값을 저장
		mav.addObject("reAvg", reAvgMap);
		// mav에 reCount 키값으로 reCountMap 밸류 값을 저장
		mav.addObject("reCount", reCountMap);
		// mav에 "coachesList" 키값으로 coachesList 밸류 값을 저장
		mav.addObject("coachesList", coachesList);

		mav.addObject("pageMaker", pageMaker);

		mav.addObject("cri", cri);

		String url = "/coachCate";
		mav.setViewName(url);
		return mav;
	}

	// 코치 글 작성 창으로 이동
	@Override
	@RequestMapping(value = "/view_coachWrite", method = RequestMethod.GET)
	public ModelAndView view_coachWrite(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		String url = "/coach/coachWriteForm";
		mav.setViewName(url);
		return mav;
	}

	// 코치 글 작성
	@Override
	@RequestMapping(value = "/coachWrite", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity addNewCoach(MultipartHttpServletRequest multipartRequest, HttpServletResponse response)
			throws Exception {

		multipartRequest.setCharacterEncoding("utf-8");

		// DB에 담을 코치 글 정보
		Map<String, Object> coachMap = new HashMap<String, Object>();

		// 받아온 정보들을 coachMap에 [key & value]로 설정
		Enumeration enu = multipartRequest.getParameterNames();
		while (enu.hasMoreElements()) {
			String name = (String) enu.nextElement();
			String value = multipartRequest.getParameter(name);
			coachMap.put(name, value);
		}

		// 세션 불러오기
		HttpSession session = multipartRequest.getSession();

		// memberVO로 세션에 저장된 로그인한 회원의 정보를 저장
		MemberVO memberVO = (MemberVO) session.getAttribute("member");

		// coachWriteForm에 존재하지 않는 id 직접 입력
		String id = memberVO.getId();
		coachMap.put("coach", id);
		// coachWriteForm에 불러온 파일(이미지) 직접 입력
		String cImg = this.upload(multipartRequest);
		coachMap.put("cImg", cImg);

		// 성공, 실패 시 알림
		String message;
		ResponseEntity resEnt = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");

		try {
			// 다운로드 파일을 작성하는 회원의 id(coach)로 폴더 생성
			// 삭제가 되어도 그 후에 해당 회원이 업로드를 하면 같은 폴더에 생성이 됌
			// 삭제 로직 짤때 고려해야함
			int coachNO = coachService.addNewCoach(coachMap);
			if (cImg != null && cImg.length() != 0) {
				File srcFile = new File(COACH_IMAGE_REPO + "/" + "temp" + "/" + cImg);
				File destDir = new File(COACH_IMAGE_REPO + "/" + id + "/" + coachNO);
				FileUtils.moveFileToDirectory(srcFile, destDir, true);
			}

			message = "<script>";
			message += " alert('등록이 완료되었습니다.');";
			message += " location.href='" + multipartRequest.getContextPath() + "/view_coachCate'; ";
			message += " </script>";
			resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);

		} catch (Exception e) {

			// 예외발생시 취소 및 삭제
			File srcFile = new File(COACH_IMAGE_REPO + "/" + "temp" + "/" + cImg);
			srcFile.delete();

			message = " <script>";
			message += " alert('오류가 발생했습니다. 다시 시도해주세요.');');";
			message += " location.href='" + multipartRequest.getContextPath() + "/view_coachCate'; ";
			message += " </script>";
			resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);

		}
		return resEnt;
	}

	// 파일 업로드
	private String upload(MultipartHttpServletRequest multipartRequest) throws Exception {
		String cImg = null;
		Iterator<String> fileNames = multipartRequest.getFileNames();

		while (fileNames.hasNext()) {
			String fileName = fileNames.next();
			MultipartFile mFile = multipartRequest.getFile(fileName);
			cImg = mFile.getOriginalFilename();
			File file = new File(COACH_IMAGE_REPO + "/" + "temp" + "/" + fileName);
			if (mFile.getSize() != 0) {
				if (!file.exists()) {
					if (file.getParentFile().mkdirs()) {
						file.createNewFile();
					}
				}
				mFile.transferTo(new File(COACH_IMAGE_REPO + "/" + "temp" + "/" + cImg));
			}
		}
		return cImg;
	}

	// 파일 다운로드
	@Override
	@RequestMapping("/coachImgDownload")
	public void download(@RequestParam("cImg") String cImg, @RequestParam("coach") String coach,
			@RequestParam("coachNO") int coachNO, HttpServletResponse response) throws Exception {
		OutputStream out = response.getOutputStream();
		String downFile = COACH_IMAGE_REPO + "/" + coach + "/" + coachNO + "/" + cImg;
		File file = new File(downFile);

		if (file.exists()) {
			// 원본 이미지에 대한 썸네일 이미지를 생성한 후 OutputStream 객체에 할당
			Thumbnails.of(file).size(1024, 1024).outputFormat("png").toOutputStream(out);
		}
		// 썸네일 이미지를 OutputStream 객체를 이용해 브라우저로 전송
		byte[] buffer = new byte[1024 * 8];
		out.write(buffer);
		out.close();
	}

	// 전달된 글 번호를 이용해서 해당 글 정보 조회
	@RequestMapping(value = "/view_coachInfo", method = RequestMethod.GET)
	public ModelAndView coachInfo(@RequestParam("coachNO") int coachNO, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		ModelAndView mav = new ModelAndView();
		String url = "/coach/coachInfo";
		mav.setViewName(url);

		coachVO = coachService.viewCoach(coachNO);
		mav.addObject("coach", coachVO);
		return mav;
	}

	// 이미지파일 썸네일로 다운로드
	@RequestMapping("/cthumbnails")
	// RequestParam으로 key&value 값을 가져와 변수에 저장
	protected void cthumbnails(@RequestParam("cImg") String cImg, @RequestParam("coach") String coach,
			@RequestParam("coachNO") String coachNO, HttpServletResponse response) throws Exception {
		OutputStream out = response.getOutputStream();
		// 파일 경로
		String filePath = COACH_IMAGE_REPO + "/" + coach + "/" + coachNO + "/" + cImg;
		File image = new File(filePath);

		if (image.exists()) {
			// 원본 이미지에 대한 썸네일 이미지를 생성한 후 OutputStream 객체에 할당
			Thumbnails.of(image).size(1024, 1024).outputFormat("png").toOutputStream(out);
		}
		// 썸네일 이미지를 OutputStream 객체를 이용해 브라우저로 전송
		byte[] buffer = new byte[1024 * 8];
		out.write(buffer);
		out.close();
	}

	// 코칭 글 수정
	@RequestMapping(value = "/modCoach", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity modCoach(MultipartHttpServletRequest multipartRequest, HttpServletResponse response)
			throws Exception {
		multipartRequest.setCharacterEncoding("utf-8");
		Map<String, Object> coachMap = new HashMap<String, Object>();
		Enumeration enu = multipartRequest.getParameterNames();
		while (enu.hasMoreElements()) {
			String name = (String) enu.nextElement();
			String value = multipartRequest.getParameter(name);
			coachMap.put(name, value);
		}

		// 세션 불러오기
		HttpSession session = multipartRequest.getSession();

		String cImg = upload(multipartRequest);
		coachMap.put("cImg", cImg);

		String coachNO = (String) coachMap.get("coachNO");
		String coach = (String) coachMap.get("coach");
		String message;
		ResponseEntity resEnt = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		try {
			coachService.modCoach(coachMap);
			if (cImg != null && cImg.length() != 0) {

				String originalFileName = (String) coachMap.get("originalFileName");
				File oldFile = new File(COACH_IMAGE_REPO + "/" + coach + "/" + coachNO + "/" + originalFileName);
				oldFile.delete();

				File srcFile = new File(COACH_IMAGE_REPO + "/" + "temp" + "/" + cImg);
				File destDir = new File(COACH_IMAGE_REPO + "/" + coach + "/" + coachNO);
				FileUtils.moveFileToDirectory(srcFile, destDir, true);
			}
			message = "<script>";
			message += " alert('수정이 완료되었습니다.');";
			message += " location.href='" + multipartRequest.getContextPath() + "/view_coachCate'; ";
			message += " </script>";
			resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);

		} catch (Exception e) {
			// 예외발생시 취소 및 삭제
			File srcFile = new File(COACH_IMAGE_REPO + "/" + "temp" + "/" + cImg);
			srcFile.delete();

			message = " <script>";
			message += " alert('오류가 발생했습니다. 다시 시도해주세요.');');";
			message += " location.href='" + multipartRequest.getContextPath() + "/'; ";
			message += " </script>";
			resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
		}
		return resEnt;
	}

	// 코치 글 삭제
	@Override
	@RequestMapping(value = "/removeCoach", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity removeCoach(@RequestParam("coachNO") int coachNO, @RequestParam("coach") String coach,
			HttpServletRequest request, HttpServletResponse response) throws Exception {
		response.setContentType("text/html; charset=UTF-8");
		String message;
		ResponseEntity resEnt = null;
		HttpHeaders responseHeaders = new HttpHeaders();
		responseHeaders.add("Content-Type", "text/html; charset=utf-8");
		try {
			coachService.removeCoach(coachNO);
			File destDir = new File(COACH_IMAGE_REPO + "/" + coach + "/" + coachNO);
			FileUtils.deleteDirectory(destDir);

			message = "<script>";
			message += " alert('삭제가 완료되었습니다.');";
			message += " location.href='" + request.getContextPath() + "/view_coachCate';";
			message += " </script>";
			resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
		} catch (Exception e) {
			message = "<script>";
			message += " alert('다시 시도해주세요.');";
			message += " location.href='" + request.getContextPath() + "/';";
			message += " </script>";
			resEnt = new ResponseEntity(message, responseHeaders, HttpStatus.CREATED);
			e.printStackTrace();
		}
		return resEnt;
	}
}

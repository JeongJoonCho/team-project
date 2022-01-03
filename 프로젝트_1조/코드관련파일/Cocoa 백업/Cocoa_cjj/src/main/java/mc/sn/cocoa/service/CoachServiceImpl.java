package mc.sn.cocoa.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import mc.sn.cocoa.dao.CoachDAO;
import mc.sn.cocoa.vo.CoachVO;
import mc.sn.cocoa.vo.Criteria;

@Service("coachService")
@Transactional(propagation = Propagation.REQUIRED)
public class CoachServiceImpl implements CoachService {
	@Autowired
	private CoachDAO coachDAO;

	// 새 코칭 글 삽입
	@Override
	public int addNewCoach(Map coachMap) {
		return coachDAO.insertNewCoach(coachMap);
	}

	// 코칭 글 전체 조회
	public List<CoachVO> listCoaches(Criteria cri) throws Exception {
		List<CoachVO> coachesList = coachDAO.selectAllCoachesList(cri);
		return coachesList;
	}

	// 코칭 글 상세 조회 창 호출
	@Override
	public CoachVO viewCoach(int coachNO) throws Exception {
		CoachVO coachVO = coachDAO.selectCoach(coachNO);
		return coachVO;
	}

	// 코칭 글 수정
	@Override
	public void modCoach(Map coachMap) throws Exception {
		coachDAO.updateCoach(coachMap);
	}

	// 코칭 글 삭제
	@Override
	public void removeCoach(int coachNO) throws Exception {
		coachDAO.deleteCoach(coachNO);
	}

	// 코칭 글 개수
	@Override
	public int countCoach(Criteria cri) throws Exception {
		return coachDAO.countCoach(cri);
	}
}
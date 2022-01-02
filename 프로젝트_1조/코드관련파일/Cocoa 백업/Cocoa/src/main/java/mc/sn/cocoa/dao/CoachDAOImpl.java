package mc.sn.cocoa.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import mc.sn.cocoa.vo.CoachVO;
import mc.sn.cocoa.vo.Criteria;

@Repository("coachDAO")
public class CoachDAOImpl implements CoachDAO {
	@Autowired
	private SqlSession sqlSession;

	// 새 코칭 글 삽입
	@Override
	public int insertNewCoach(Map coachMap) {
		int coachNO = this.selectNewCoachNO();
		coachMap.put("coachNO", coachNO);
		sqlSession.insert("mapper.coach.insertNewCoach", coachMap);
		return coachNO;
	}

	// 코칭 글 넘버링
	private int selectNewCoachNO() {
		return sqlSession.selectOne("mapper.coach.selectNewCoachNO");
	}

	// 코칭 글 전체 조회
	@Override
	public List selectAllCoachesList(Criteria cri) throws DataAccessException {
		List<CoachVO> coachesList = sqlSession.selectList("mapper.coach.selectAllCoachesList", cri);
		return coachesList;
	}

	// 코칭 글 상세 정보 조회
	@Override
	public CoachVO selectCoach(int coachNO) throws DataAccessException {
		return sqlSession.selectOne("mapper.coach.selectCoach", coachNO);
	}

	// 코칭 글 수정
	@Override
	public void updateCoach(Map coachMap) throws DataAccessException {
		sqlSession.update("mapper.coach.updateCoach", coachMap);
	}

	// 코칭 글 삭제
	@Override
	public void deleteCoach(int coachNO) throws DataAccessException {
		sqlSession.delete("mapper.coach.deleteCoach", coachNO);
	}

	// 코칭 글 개수
	@Override
	public int countCoach(Criteria cri) throws DataAccessException {
		return (Integer) sqlSession.selectOne("mapper.coach.countCoach", cri);
	}

}
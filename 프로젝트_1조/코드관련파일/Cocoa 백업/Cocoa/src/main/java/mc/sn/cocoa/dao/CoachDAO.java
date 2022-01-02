package mc.sn.cocoa.dao;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import mc.sn.cocoa.vo.CoachVO;
import mc.sn.cocoa.vo.Criteria;

public interface CoachDAO {

	public int insertNewCoach(Map coachMap);

	public List selectAllCoachesList(Criteria cri) throws DataAccessException;

	public CoachVO selectCoach(int coachNO) throws DataAccessException;

	public void updateCoach(Map coachMap) throws DataAccessException;

	public void deleteCoach(int coachNO) throws DataAccessException;

	public int countCoach(Criteria cri) throws DataAccessException;
}
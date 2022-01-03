package mc.sn.cocoa.service;

import java.util.List;
import java.util.Map;

import mc.sn.cocoa.vo.CoachVO;
import mc.sn.cocoa.vo.Criteria;

public interface CoachService {

	public int addNewCoach(Map coachMap);

	public List<CoachVO> listCoaches(Criteria cri) throws Exception;

	public CoachVO viewCoach(int coachNO) throws Exception;

	public void modCoach(Map coachMap) throws Exception;

	public void removeCoach(int coachNO) throws Exception;

	public int countCoach(Criteria cri) throws Exception;

}
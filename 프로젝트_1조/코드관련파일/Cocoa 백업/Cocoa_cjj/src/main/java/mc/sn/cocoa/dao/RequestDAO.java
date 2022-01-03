package mc.sn.cocoa.dao;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import mc.sn.cocoa.vo.Criteria;
import mc.sn.cocoa.vo.RequestVO;

public interface RequestDAO {

	public int insertRequest(Map reqMap);

	public List selectAllReqGot(Criteria cri);

	public List selectAllReqSent(Criteria cri);

	public RequestVO selectByReqNO(int reqNO);

	public void updateRequest(Map requestMap);

	public void deleteRequest(int reqNO);

	public int updateReason(RequestVO requestVO);

	public int updateYes(RequestVO requestVO);

	public int countSendRequest(Criteria cri) throws DataAccessException;

	public int countReceiveRequest(Criteria cri) throws DataAccessException;

	public void updateReqFin(RequestVO vo);
}
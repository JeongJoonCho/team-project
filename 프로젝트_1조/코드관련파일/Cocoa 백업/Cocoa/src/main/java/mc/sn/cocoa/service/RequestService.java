package mc.sn.cocoa.service;

import java.util.List;
import java.util.Map;

import mc.sn.cocoa.vo.Criteria;
import mc.sn.cocoa.vo.RequestVO;

public interface RequestService {

	public int sendRequest(Map reqMap);

	public List listReqGot(Criteria cri);

	public List listReqSent(Criteria cri);

	public RequestVO searchRequest(int reqNO);

	public void modRequest(Map requestMap);

	public void removeRequest(int reqNO);

	public int submitReason(RequestVO requestVO);

	public int submitReqYes(RequestVO requestVO);

	public int countSendRequest(Criteria cri) throws Exception;

	public int countReceiveRequest(Criteria cri) throws Exception;

	public void finishRequest(RequestVO vo);
}
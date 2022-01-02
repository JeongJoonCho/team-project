package mc.sn.cocoa.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import mc.sn.cocoa.vo.Criteria;
import mc.sn.cocoa.vo.RequestVO;

@Repository("requestDAO")
public class RequestDAOImpl implements RequestDAO {
	@Autowired
	private SqlSession sqlSession;

	// 요청글 넘버링
	private int selectNewProjectNO() {
		return sqlSession.selectOne("mapper.request.selectNewReqNO");
	}

	// selectNewProjectNO 메소드를 통해 얻은 reqNO를 reqMap에 put해서 sql 실행하여 insert실행
	// reqNO를 리턴
	@Override
	public int insertRequest(Map reqMap) {
		int reqNO = this.selectNewProjectNO();
		reqMap.put("reqNO", reqNO);
		sqlSession.insert("mapper.request.insertRequest", reqMap);
		return reqNO;
	}

	// 받은 요청 리스트 가져와서 리턴
	@Override
	public List selectAllReqGot(Criteria cri) {
		List<RequestVO> reqGotList = null;
		reqGotList = sqlSession.selectList("mapper.request.selectAllReqGot", cri);
		return reqGotList;
	}

	// 보낸 요청 리스트 가져와서 리턴
	@Override
	public List selectAllReqSent(Criteria cri) {
		List<RequestVO> reqSentList = null;
		reqSentList = sqlSession.selectList("mapper.request.selectAllReqSent", cri);
		return reqSentList;
	}

	// 보낸 & 받은 요청서 조회
	@Override
	public RequestVO selectByReqNO(int reqNO) {
		RequestVO vo = null;
		vo = sqlSession.selectOne("mapper.request.selectByReqNO", reqNO);
		return vo;
	}

	// 보낸 요청글 수정
	@Override
	public void updateRequest(Map requestMap) {
		sqlSession.update("mapper.request.updateRequest", requestMap);
	}

	// 보낸 요청글 삭제
	@Override
	public void deleteRequest(int reqNO) {
		sqlSession.delete("mapper.request.deleteRequest", reqNO);
	}

	// 거절 사유 전송(업데이트)
	@Override
	public int updateReason(RequestVO requestVO) {
		int result = 0;
		result = sqlSession.update("mapper.request.updateReason", requestVO);
		return result;
	}

	// 수락 정보 전송(업데이트)
	@Override
	public int updateYes(RequestVO requestVO) {
		int result = 0;
		result = sqlSession.update("mapper.request.updateYes", requestVO);
		return result;
	}

	// 보낸 요청글 개수
	@Override
	public int countSendRequest(Criteria cri) throws DataAccessException {
		return (Integer) sqlSession.selectOne("mapper.request.countSendRequest", cri);
	}

	// 빋은 요청글 개수
	@Override
	public int countReceiveRequest(Criteria cri) throws DataAccessException {
		return (Integer) sqlSession.selectOne("mapper.request.countReceiveRequest", cri);
	}

	// 후기작성 후 완료 상태 변환
	@Override
	public void updateReqFin(RequestVO vo) {
		sqlSession.update("mapper.request.updateReqFin", vo);
	}
}
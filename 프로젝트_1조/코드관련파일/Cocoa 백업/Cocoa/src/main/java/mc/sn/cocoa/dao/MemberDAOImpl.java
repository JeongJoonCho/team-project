package mc.sn.cocoa.dao;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import mc.sn.cocoa.vo.MemberVO;

@Repository("memberDAO")
public class MemberDAOImpl implements MemberDAO {
	@Autowired
	private SqlSession sqlSession;

	@Override
	public int insertMember(MemberVO memberVO) {
		int result = 0;
		result = sqlSession.insert("mapper.member.insertMember", memberVO);
		return result;
	}

	@Override
	public MemberVO loginById(MemberVO memberVO) {
		MemberVO vo = sqlSession.selectOne("mapper.member.loginById", memberVO);
		return vo;
	}

	@Override
	public int idChk(MemberVO vo) throws Exception {
		int result = sqlSession.selectOne("mapper.member.idChk", vo);
		return result;
	}

	@Override
	public MemberVO selectMemberById(String id) throws Exception {
		MemberVO vo = sqlSession.selectOne("mapper.member.selectById", id);
		return vo;
	}

	@Override
	public void updateProfile(Map profileMap) throws Exception {
		sqlSession.update("mapper.member.updateProfile", profileMap);
	}

	@Override
	public int updateMember(MemberVO memberVO) {
		int result = 0;
		result = sqlSession.update("mapper.member.updateMember", memberVO);
		return result;
	}

	@Override
	public int deleteMember(String id) {
		int result = 0;
		result = sqlSession.delete("mapper.member.deleteMember", id);
		sqlSession.insert("mapper.member.preserveId", id);
		return result;
	}
}
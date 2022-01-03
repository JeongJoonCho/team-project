package mc.sn.cocoa.dao;

import java.util.Map;

import mc.sn.cocoa.vo.MemberVO;

public interface MemberDAO {

	public int insertMember(MemberVO memberVO);

	public MemberVO loginById(MemberVO memberVO);

	public int idChk(MemberVO vo) throws Exception;

	public MemberVO selectMemberById(String id) throws Exception;

	public void updateProfile(Map profileMap) throws Exception;

	public int updateMember(MemberVO memberVO);

	public int deleteMember(String id);
}

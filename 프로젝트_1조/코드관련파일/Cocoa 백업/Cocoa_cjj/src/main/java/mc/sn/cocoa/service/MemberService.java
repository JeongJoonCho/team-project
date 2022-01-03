package mc.sn.cocoa.service;

import java.util.Map;

import mc.sn.cocoa.vo.MemberVO;

public interface MemberService {

	public int joinMember(MemberVO member);

	public MemberVO login(MemberVO memberVO);

	public int idChk(MemberVO vo) throws Exception;

	public MemberVO searchMember(String id) throws Exception;

	public void modProfile(Map profileMap) throws Exception;

	public int modifyMember(MemberVO member);

	public int dropMember(String id);
}

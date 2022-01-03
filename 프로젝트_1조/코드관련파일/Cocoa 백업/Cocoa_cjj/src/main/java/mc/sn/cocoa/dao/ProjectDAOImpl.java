package mc.sn.cocoa.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import mc.sn.cocoa.vo.Criteria;
import mc.sn.cocoa.vo.ProjectVO;

@Repository("projectDAO")
public class ProjectDAOImpl implements ProjectDAO {
	@Autowired
	private SqlSession sqlSession;

	// 새 프로젝트 글 삽입
	@Override
	public int insertNewProject(Map projectMap) {
		int projectNO = this.selectNewProjectNO();
		projectMap.put("projectNO", projectNO);
		sqlSession.insert("mapper.project.insertNewProject", projectMap);
		return projectNO;
	}

	// 프로젝트 글 넘버링
	private int selectNewProjectNO() {
		return sqlSession.selectOne("mapper.project.selectNewProjectNO");
	}

	// 프로젝트 전체 & 조건 조회
	@Override
	public List selectAllProjectList(Criteria cri) throws DataAccessException {
		List<ProjectVO> projectsList = null;
		projectsList = sqlSession.selectList("mapper.project.selectAllProjectList", cri);
		return projectsList;
	}

	// 프로젝트 글 상세 조회
	@Override
	public ProjectVO selectProjectById(ProjectVO projectVO) {
		ProjectVO vo = null;
		vo = sqlSession.selectOne("mapper.project.selectById", projectVO);
		return vo;
	}

	// 프로젝트 삭제
	@Override
	public void deleteProject(int projectNO) {
		sqlSession.delete("mapper.project.deleteProject", projectNO);
	}

	// 프로젝트 수정
	@Override
	public void updateProject(Map projectMap) {
		sqlSession.update("mapper.project.updateProject", projectMap);
	}

	// 프로젝트 글 개수
	@Override
	public int countProject(Criteria cri) throws DataAccessException {
		return (Integer) sqlSession.selectOne("mapper.project.countProject", cri);
	}

}
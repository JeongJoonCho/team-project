package mc.sn.cocoa.dao;

import java.util.List;
import java.util.Map;

import org.springframework.dao.DataAccessException;

import mc.sn.cocoa.vo.Criteria;
import mc.sn.cocoa.vo.ProjectVO;

public interface ProjectDAO {

	public int insertNewProject(Map projectMap);

	public List selectAllProjectList(Criteria cri) throws DataAccessException;

	public ProjectVO selectProjectById(ProjectVO projectVO);

	public void deleteProject(int projectNO);

	public void updateProject(Map projectMap);

	public int countProject(Criteria cri) throws DataAccessException;

}
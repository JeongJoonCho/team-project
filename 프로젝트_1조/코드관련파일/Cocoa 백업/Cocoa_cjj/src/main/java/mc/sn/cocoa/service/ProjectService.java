package mc.sn.cocoa.service;

import java.util.List;
import java.util.Map;

import mc.sn.cocoa.vo.Criteria;
import mc.sn.cocoa.vo.ProjectVO;

public interface ProjectService {

	public int addNewProject(Map projectMap);

	public List<ProjectVO> listProjects(Criteria cri) throws Exception;

	public ProjectVO searchProject(ProjectVO projectVO);

	public void removeProject(int projectNO);

	public void modProject(Map projectMap) throws Exception;

	public int countProject(Criteria cri) throws Exception;

	public String geocode(String words);

}
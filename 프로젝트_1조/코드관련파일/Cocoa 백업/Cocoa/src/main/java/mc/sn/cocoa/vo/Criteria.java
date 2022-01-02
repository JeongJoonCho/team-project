package mc.sn.cocoa.vo;

public class Criteria {

	private int page; // 현재 페이지 번호
	private int perPageNum; // 한 페이지에 게시할 글의 수
	private String cField = "cField";
	private String tool = "tool";
	private String pField = "pField";
	private String level = "level";
	private String reqId;
	private String resId;
	private String status = "status";
	private String target;
	private String coachOrder = "order by reviewRate desc";
	private String projectOrder = "order by reviewRate desc";

	// 특정 페이지의 게시글 시작 번호, 게시글 시작 행 번호
	// 현재 페이지의 게시글 시작 번호 = (현재 페이지 번호 - 1) * 페이지 당 게시할 글의 수
	public int getPageStart() {
		return (this.page - 1) * perPageNum;
	}

	public Criteria() {
		this.page = 1;
		this.perPageNum = 8;
	}

	public int getPage() {
		return page;
	}

	public void setPage(int page) {
		// 페이지가 음수가 되면 1페이지를 나타냄
		if (page <= 0) {
			this.page = 1;
		} else {
			this.page = page;
		}
	}

	public int getPerPageNum() {
		return perPageNum;
	}

	public void setPerPageNum(int pageCount) {
		this.perPageNum = pageCount;
	}

	public String getcField() {
		return cField;
	}

	public void setcField(String cField) {
		this.cField = cField;
	}

	public String getTool() {
		return tool;
	}

	public void setTool(String tool) {
		this.tool = tool;
	}

	public String getpField() {
		return pField;
	}

	public void setpField(String pField) {
		this.pField = pField;
	}

	public String getLevel() {
		return level;
	}

	public void setLevel(String level) {
		this.level = level;
	}

	public String getReqId() {
		return reqId;
	}

	public void setReqId(String reqId) {
		this.reqId = reqId;
	}

	public String getResId() {
		return resId;
	}

	public void setResId(String resId) {
		this.resId = resId;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getTarget() {
		return target;
	}

	public void setTarget(String target) {
		this.target = target;
	}

	public String getCoachOrder() {
		return coachOrder;
	}

	public void setCoachOrder(String coachOrder) {
		this.coachOrder = coachOrder;
	}

	public String getProjectOrder() {
		return projectOrder;
	}

	public void setProjectOrder(String projectOrder) {
		this.projectOrder = projectOrder;
	}

}
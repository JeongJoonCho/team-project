package mc.sn.cocoa.service;

import java.util.List;

import mc.sn.cocoa.vo.Criteria;
import mc.sn.cocoa.vo.ReviewVO;

public interface ReviewService {

	public int addReview(ReviewVO reviewVO);

	public List searchReviewByTarget(Criteria cri);

	public ReviewVO viewReview(int reviewNO) throws Exception;

	public void modReview(ReviewVO reviewVO);

	public void deleteReview(ReviewVO reviewVO);

	public int countReview(String target);

	public List targetsReview();

	public int targetReviewCount(String key);

	public float targetReviewAvg(String key);
}
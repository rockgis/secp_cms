package com.mc.web.programs.front.poll;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.mc.web.service.CmsAbstractDAO;

@Repository
public class UserPollDAO extends CmsAbstractDAO {
	
	public List<Map> getList(Map<String, String> params) {
		return selectList("poll.list",params);
	}

	public Map getPageInfo(Map<String, String> params) {
		return selectOne("poll.pageinfo", params);
	}
		
	public Map article(Map<String, String> params) {
		return selectOne("poll.article", params);
	}
	
	public List<Map> questionList(Map<String, String> params) {
		return selectList("poll.questionlist",params);
	}
	
	public Map joinCheck(Map<String, String> params) {
		return selectOne("poll.joinCheck",params);
	}
	
	public List<Map> resultQuestionList(Map<String, String> params) {
		return selectList("poll.result_question_list",params);
	}
	
	public List<Map> resultAnswerList(Map<String, String> params) {
		return selectList("poll.result_answer_list",params);
	}
	
	public List<Map> resultDetailList(Map<String, String> params) {
		return selectList("poll.result_detail_list",params);
	}
	
	public List<Map> joinCheckList(Map<String, String> params) {
		return selectList("poll.join_check_list",params);
	}
	
	public Map jumpTypeCheck(Map<String, String> params) {
		return selectOne("poll.join_mixtype_check",params);
	}
	
	public Map insertSEQ(Map<String, String> params) {
		return selectOne("poll.insert_seq",params);
	}
	
	public void insertResult(Map<String, Object> params) {
		insert("poll.insert_result", params);
	}
	
	public List<Map> userAuthCheck(Map<String, String> params){
		return selectList("Group.userAuthCheck",params);
	}
}
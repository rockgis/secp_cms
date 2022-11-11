package com.mc.web.programs.back.poll;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import com.mc.web.MCMap;
import com.mc.web.service.CmsAbstractDAO;

@Repository
public class PollDAO extends CmsAbstractDAO {
	
	public List<MCMap> getList(Map<String, String> params) {
		return selectList("poll.list",params);
	}

	public MCMap getPageInfo(Map<String, String> params) {
		return selectOne("poll.pageinfo", params);
	}
	
	public void pollWrite(Map<String, Object> params) {
		insert("poll.pollWrite", params);
	}

	public void pollWriteQuestion(Map<String, Object> params) {
		insert("poll.pollWriteQuestion", params);
	}

	public void pollWriteAnwser(Map<String, Object> params) {
		insert("poll.pollWriteAnwser", params);
	}
	
	public MCMap article(Map<String, String> params) {
		return selectOne("poll.article", params);
	}
	
	public List<MCMap> questionList(Map<String, String> params) {
		return selectList("poll.questionlist",params);
	}
	
	public void pollUpdate(Map<String, Object> params) {
		update("poll.pollUpdate", params);
	}
	
	public void deleteQuestion(Map<String, Object> params) {
		delete("poll.deleteQuestion", params);
	}

	public void deleteAnswer(Map<String, Object> params) {
		delete("poll.deleteAnswer", params);
	}
	
	public void resultInit(Map<String, String> params){
		delete("poll.resultInit", params);
	}
	
	public List<MCMap> resultQuestionList(Map<String, String> params) {
		return selectList("poll.result_question_list",params);
	}
	
	public List<MCMap> resultAnswerList(Map<String, String> params) {
		return selectList("poll.result_answer_list",params);
	}
	
	public List<MCMap> resultDetailList(Map<String, String> params) {
		return selectList("poll.result_detail_list",params);
	}
	
	public List<MCMap> select_poll_list(Map<String, String> params) {
		return selectList("poll.select_poll_list",params);
	}
	
	public int mc_poll_update(Map params){
		return update("poll.mc_poll_update", params);
	}
	
	public int mc_poll_answer_update(Map params){
		return update("poll.mc_poll_answer_update", params);
	}
	
	public int mc_poll_question_update(Map params){
		return update("poll.mc_poll_question_update", params);
	}
	
	public int mc_poll_result_update(Map params){
		return delete("poll.mc_poll_result_update", params);
	}
	
	public List<MCMap> resultGroup(Map<String, String> params) {
		return selectList("poll.resultGroup",params);
	}
	
	public List<MCMap> resultList(Map<String, String> params) {
		return selectList("poll.resultList",params);
	}
	
	public List<MCMap> resultListSeq(Map<String, String> params) {
		return selectList("poll.resultListSeq",params);
	}
}
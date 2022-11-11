package com.mc.web.programs.front.comments;

import java.util.Map;

public interface CommentsService{

	String sns_box(Map params) throws Exception;
	String list(Map params) throws Exception;
	Map comment_reg(Map params) throws Exception;
	Map re_comment_reg(Map params) throws Exception;
	Map comment_mod(Map params) throws Exception;
	Map del(Map params) throws Exception;
}
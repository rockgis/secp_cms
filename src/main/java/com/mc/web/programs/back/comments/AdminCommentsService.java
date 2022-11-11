package com.mc.web.programs.back.comments;

import java.util.Map;

public interface AdminCommentsService{

	Map list(Map params) throws Exception;
	Map comment_reg(Map params) throws Exception;
	Map re_comment_reg(Map params) throws Exception;
	Map del(Map params) throws Exception;
}
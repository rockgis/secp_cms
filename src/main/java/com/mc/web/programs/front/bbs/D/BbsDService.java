package com.mc.web.programs.front.bbs.D;

import java.util.List;
import java.util.Map;

import org.springframework.web.multipart.MultipartFile;

import com.mc.web.programs.front.bbs.BbsService;

public interface BbsDService extends BbsService{
	public String replyForm(Map params) throws Exception;
	public String reply(Map params, List<MultipartFile> attachList) throws Exception;
}

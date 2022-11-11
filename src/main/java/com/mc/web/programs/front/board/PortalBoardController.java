package com.mc.web.programs.front.board;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.mc.web.programs.front.board.Pager.Criteria;
import com.mc.web.programs.front.board.Pager.PageMaker;

/**
*
* @Description : 게시판 컨트롤러
* @ClassName   : com.mc.web.programs.front.board.impl.BoardController.java
* @Modification Information
*
* @author 이재우
* @since 2022. 10. 24.
* @version 1.0 *  
* Copyright (C)  All right reserved.
*/

@Controller
@RequestMapping(value="/board")
public class PortalBoardController {

	@Autowired
	private PortalBoardService service;

	/**
	 * 게시판 목록 & 페이징 처리
	 * @param cri
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/boardIndex.do")
	public ModelAndView boardList(Criteria cri) throws Exception{
		ModelAndView mav = new ModelAndView();
		
		switch(cri.getType()) {
			case 1 : mav.setViewName("/programs/board/boardList"); break;
			case 2 : mav.setViewName("/programs/board/boardQuestion"); break;
			case 3 : mav.setViewName("/programs/board/boardInquiry"); break;
		}
		
        cri.setStPageVol();

	    PageMaker pageMaker = new PageMaker();
	    pageMaker.setCri(cri);
	    
	    int cnt = service.getTotalCnt(cri);
	    pageMaker.setTotalCount(cnt);
	        
	    List<Map<String,Object>> boardList = service.boardList(cri);
	    
	    mav.addObject("boardList", boardList);
	    mav.addObject("CNT", cnt);
	    mav.addObject("pageMaker", pageMaker);
	    mav.addObject("cri", cri);
	        
	    return mav;
	}
	
	/**
	 * 게시판 상세화면
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value="/boardDetail.do", method=RequestMethod.GET)
	public ModelAndView boardDetail(@RequestParam Map<String, Object> params) throws Exception{
		ModelAndView mav = new ModelAndView();
		
		switch(params.get("type").toString()) {
			case "1" : mav.setViewName("/programs/board/boardDetail"); break;
			case "3" : mav.setViewName("/programs/board/boardInquiryDetail"); break;
		}
		
		List<Map<String, Object>> list = service.boardDetail(params);
		mav.addObject("list", list);
	        
	    return mav;
	}
	
	/* 1:1 문의 글쓰기 화면 */
	@RequestMapping(value="/boardInquiryRegisterForm.do", method=RequestMethod.GET)
	public String boardInquiryRegisterForm(HttpServletRequest request, @RequestParam Map<String, String> params) throws Exception{
		return "programs/board/boardInquiryRegisterForm";
	}
	
	/* 1:1 문의 글쓰기 저장 */
	@RequestMapping(value="/boardInquiryRegister.do", method=RequestMethod.POST)
	@ResponseBody
	public String boardInquiryRegister(HttpServletRequest request, @RequestParam Map<String, String> params, MultipartHttpServletRequest mpr) throws Exception{
		return service.boardInquiryRegister(params);
	}
	
}

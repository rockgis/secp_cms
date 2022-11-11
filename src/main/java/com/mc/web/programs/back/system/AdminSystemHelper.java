package com.mc.web.programs.back.system;

import java.util.HashMap;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import com.mc.common.util.DateUtil;

/**
 * 
 * @Class Name : MainHelper.java
 * @Description : 화면구성에 필요한 계산식이나 html가공시 이 클래스사용
 * @Modification Information
 *
 *    수정일         수정자         수정내용
 *    -------        -------     -------------------
 *    
 * @author LCK
 * @since 2015. 5. 21.
 * @version 1.0
 * @see 
 * <pre>
 * </pre>
 */
@Service
public class AdminSystemHelper {
	Logger logger = Logger.getLogger(this.getClass());
	
	@Autowired
	private AdminSystemDAO dao;

	/**
	 * Comment  : 대시보드 데이터 캐시메모리에 담기위해 헬퍼쪽으로 이동 
	 * @version : 1.0
	 * @tags    : @param params
	 * @tags    : @return
	 * @tags    : @throws Exception
	 * @date    : 2017. 5. 10.
	 *
	 */
	@Cacheable(value="dashboardCache", keyGenerator="defaultKeyGenerator")
	public Map dashboardData(Map params) throws Exception {
		Map rstMap = new HashMap();

		Map p = new HashMap();
		
		//관리자 접속통계
		//전체
		rstMap.put("admin_total_cnt", dao.admin_connection_count(p));
		//어제
		p.put("start_dt", DateUtil.subtract(DateUtil.getTime("yyyy-MM-dd"), "yyMMdd", -1));
		p.put("end_dt", DateUtil.subtract(DateUtil.getTime("yyyy-MM-dd"), "yyMMdd", -1));
		rstMap.put("admin_yesterday_cnt", dao.admin_connection_count(p));
		//이번주
		p.put("start_dt", DateUtil.getFirstWeekDay(DateUtil.getTime("yyyy-MM-dd"), "yyMMdd"));
		p.put("end_dt", DateUtil.getLastWeekDay(DateUtil.getTime("yyyy-MM-dd"), "yyMMdd"));
		rstMap.put("admin_week_cnt", dao.admin_connection_count(p));
		//이번달
		p.put("start_dt", DateUtil.getTime("yyMM01"));
		p.put("end_dt", DateUtil.getLastMonthDay(DateUtil.getTime("yyyy-MM-dd"), "yyMMdd"));
		rstMap.put("admin_month_cnt", dao.admin_connection_count(p));
		
		//회원현황
		rstMap.put("users_status", dao.users_status(params));
		
		//보안설정 현황
		rstMap.put("security_status", dao.security_status(params));
		
		//게시판 사용현황
		rstMap.put("board_count", dao.board_count(params));
		
		//시스템 현황
		rstMap.put("system_status", dao.system_status(params));
		
		//필터링 건수
		rstMap.put("filter_row", dao.filter_row(params));
		
		//필터링 갯수
		rstMap.put("filter_count", dao.filter_count(params));
		
		//기준시간
		rstMap.put("standard_time", DateUtil.getTime("HH:mm"));
		
		return rstMap;
	}
	
}
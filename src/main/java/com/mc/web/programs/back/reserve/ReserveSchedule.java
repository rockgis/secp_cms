package com.mc.web.programs.back.reserve;

import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Timer;
import java.util.TimerTask;

import javax.annotation.PostConstruct;
import javax.annotation.PreDestroy;
import javax.annotation.Resource;

import org.apache.log4j.Logger;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Component;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.mc.common.util.DateUtil;
import com.mc.web.MCMap;
import com.mc.web.programs.back.bbs.AdminBbsDAO;
import com.mc.web.programs.back.bbs.AdminBbsHelper;
import com.mc.web.programs.back.board.BoardDAO;
import com.mc.web.programs.back.homepage.HomepageDAO;
import com.mc.web.programs.back.homepage.HomepageHelper;
import com.mc.web.attach.AttachDAO;
import com.mc.web.schedule.JobSchedule;

/**
 * 
 * @Description : 메뉴 예약 변경건 처리 
 * @ClassName   : com.mc.web.programs.back.homepage.HomepageSchedule.java
 * @author 이창기
 * @since 2015. 6. 15.
 * @version 1.0 *
 * @see
 *
 * <pre>
 * << 개정이력(Modification Information) >>
 *   
 *   수정일        수정자       수정내용
 *  -------       --------    ---------------------------
 * </pre>
 */
@Component
public class ReserveSchedule {
	Logger logger = Logger.getLogger(this.getClass());
	
	Map<String, Timer> list = null;
	
	@Autowired
	private HomepageDAO dao;
	
	@Autowired
	private ReserveDAO reserveDAO;
	
	@Autowired
	private HomepageHelper helper;
	
	@Autowired
	private AdminBbsDAO bbsDao;
	
	@Autowired
	private AttachDAO attachDAO;

	@Resource(name="mc.txManager")
	protected DataSourceTransactionManager txManager;
	
	protected TransactionStatus getTransaction() {
		/*
		 * [PROPAGATION]
		 * REQUIRED : 이미 tx가 존재할 경우, 해당 tx에 참여 / tx가 없을 경우, 신규 tx를 생성하고 실행
		 * SUPPORTS : 이미 tx가 존재할 경우, 해당 tx에 참여 / tx가 없을 경우, 그냥 실행
		 * MANDATORY : 이미 tx가 존재할 경우, 해당 tx에 참여 / tx가 없을 경우, Exception 발생
		 * REQUIRES_NEW : 이미 tx가 존재할 경우, 해당 tx를 suspend 시키고 신규 tx를 생성 / tx가 없을 경우, 신규 tx를 생성
		 * NOT_SUPPORTED : 이미 tx가 존재할 경우, 해당 tx를 suspend 시키고 tx 없이 실행 / tx가 없을 경우, 그냥 실행
		 * NEVER : 이미 tx가 존재할 경우, Exception 발생 / tx가 없을 경우, tx 없이 실행
		 * NESTED : 이미 tx가 존재할 경우, 해당 tx에 참여 / tx가 없을 경우, nested tx 실행
		 * 
		 * [ISOLATION]
		 * DEFAULT : datastore에 의존
		 * READ_UNCOMMITED : Dirty Reads, Non-Repeatable Reads, Phantom Reads 발생
		 * READ_COMMITED : Dirty Reads 방지, Non-Repeatable Reads, Phantom Reads 발생
		 * REPEATABLE_READ : Non-Repeatable Read 방지, Phantom Reads 발생
		 * SERIALIZABLE : Phantom Read 방지
		 */
	    DefaultTransactionDefinition definition = new DefaultTransactionDefinition();
	    definition.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
	    return txManager.getTransaction(definition);
	}
	
	public void addTimer(String key, Timer timer){
		list.put(key, timer);
	}
	
	public void removeTimer(String key){
		Timer t = list.remove(key);
		if(t!=null){
			t.cancel();
		}
	}
	
	@PreDestroy
	public void exit(){
		for (Entry<String, Timer> entry : list.entrySet()) {
			String key = entry.getKey();
			Timer timer = entry.getValue();
			timer.cancel();
			logger.info(key+"번 타이머 종료시켰습니다.");
			
		}
	}

	@PostConstruct
	public void reserve_queue() throws Exception {
		if(JobSchedule.isMyJob()){
			list = Collections.synchronizedMap(new HashMap());
			
			List<MCMap> list = reserveDAO.reserve_list();
			for (MCMap map : list) {
				if("M".equals(map.get("gubun"))){	//메뉴
					if("REG".equals(map.get("type"))){
						writeSchedule(map);
					}else{
						modifySchedule(map);
					}
				}else if("B".equals(map.get("gubun"))){	//게시판
					if("REG".equals(map.get("type"))){
						writeBbsSchedule(map);
					}else{
						//TODO 게시판 수정
	//					modifyBbsSchedule(map);//미구현
					}
				}
			}
		}
	}

	public void writeSchedule(final Map p) {
		Date dt = DateUtil.toDate((String) p.get("reserve_dt"), "yyyy/MM/dd HH:mm");
		Timer timer = new Timer(false);
	    timer.schedule(new TimerTask() {
	        @Override
	        public void run() {
	        	TransactionStatus txStatus = getTransaction();
	            try {
	            	MCMap map = reserveDAO.view(p);
	            	Map params = (JSONObject) JSONValue.parse(String.valueOf(map.get("params")));
	            	
	        		dao.write(params);
	        		params.put("menu_url", helper.createMenuUrl(params));
	        		dao.updateMenuUrl(params);
	        		
	        		List list = (List) params.get("staffs");
	        		if(list != null){
	        			for (int i = 0; i < list.size(); i++) {
	        				Map m = (Map) list.get(i);
	        				m.put("order_seq", i+1);
	        				m.put("cms_menu_seq", params.get("cms_menu_seq"));
	        				m.put("session_member_id", params.get("session_member_id"));
	        				m.put("session_member_nm", params.get("session_member_nm"));
	        				dao.insertStaff(m);
	        			}
	        		}
	        		
	        		list = (List) params.get("staff_group");
	        		if(list != null){
	        			for (int i = 0; i < list.size(); i++) {
	        				Map m = (Map) list.get(i);
	        				m.put("order_seq", i+1);
	        				m.put("cms_menu_seq", params.get("cms_menu_seq"));
	        				m.put("session_member_id", params.get("session_member_id"));
	        				m.put("session_member_nm", params.get("session_member_nm"));
	        				dao.insertStaffGroup(m);
	        			}
	        		}
	        		
	        		reserveDAO.reserve_ok(p);
		    		txManager.commit(txStatus);
	            } catch(Exception ex) {
	            	ex.printStackTrace();
	            	txManager.rollback(txStatus);
	            	reserveDAO.reserve_fail(p);
	            } finally{
	            	removeTimer(p.get("reserve_seq").toString());
	            }
	        }
	    }, dt);
	    addTimer(p.get("reserve_seq").toString(), timer);
	}

	public void modifySchedule(final Map p) {
		Date dt = DateUtil.toDate((String) p.get("reserve_dt"), "yyyy/MM/dd HH:mm");
		Timer timer = new Timer(false);
	    timer.schedule(new TimerTask() {
	        @Override
	        public void run() {
	        	TransactionStatus txStatus = getTransaction();
	            try {
	            	MCMap map = reserveDAO.view(p);
	            	Map params = (JSONObject) JSONValue.parse(String.valueOf(map.get("params")));
		    		dao.contentBackup(params);
		    		dao.contentSave(params);
		    		reserveDAO.reserve_ok(p);
		    		txManager.commit(txStatus);
	            } catch(Exception ex) {
	            	ex.printStackTrace();
	            	txManager.rollback(txStatus);
	            	reserveDAO.reserve_fail(p);
	            } finally{
	            	removeTimer(p.get("reserve_seq").toString());
	            }
	        }
	    }, dt);
	    addTimer(p.get("reserve_seq").toString(), timer);
	}
	
	//게시물 예약 등록
	public void writeBbsSchedule(final Map p) {
		Date dt = DateUtil.toDate((String) p.get("reserve_dt"), "yyyy/MM/dd HH:mm");
		Timer timer = new Timer(false);
	    timer.schedule(new TimerTask() {
	        @Override
	        public void run() {
	        	TransactionStatus txStatus = getTransaction();
	            try {
	            	MCMap map = reserveDAO.view(p);
	            	Map params = (JSONObject) JSONValue.parse(String.valueOf(map.get("params")));
	            	
	            	bbsDao.write(params);
	            	
	            	//article_seq없이 등록된 첨부파일에 article_seq 업데이트
	        		List list = (List) params.get("files");
	        		if(list != null){
	        			for (int i = 0; i < list.size(); i++) {
	        				Map m = (Map) list.get(i);
	        				m.put("table_seq", params.get("article_seq"));
	        				attachDAO.updateTemp(m);
	        			}
	        		}	        		
	        		p.put("article_seq", params.get("article_seq"));
	        		reserveDAO.reserve_ok(p);
		    		txManager.commit(txStatus);
	            } catch(Exception ex) {
	            	ex.printStackTrace();
	            	txManager.rollback(txStatus);
	            	reserveDAO.reserve_fail(p);
	            } finally{
	            	removeTimer(p.get("reserve_seq").toString());
	            }
	        }
	    }, dt);
	    addTimer(p.get("reserve_seq").toString(), timer);
	}
	
/*	public void modifySchedule(final Map params) {
		Date dt = DateUtil.toDate((String) params.get("reserve_dt"), "yyyy/MM/dd HH:mm");
		Timer timer = new Timer(false);
		timer.schedule(new TimerTask() {
			@Override
			public void run() {
				TransactionStatus txStatus = getTransaction();
				try {
					params.put("menu_url", helper.createMenuUrl(params));
					Map rstMap = new HashMap();
					dao.backup(params);
					rstMap.put("rst", dao.modify(params));
					dao.staff_del(params);
					List list = (List) params.get("staffs");
					if(list != null){
						for (int i = 0; i < list.size(); i++) {
							Map m = (Map) list.get(i);
							m.put("order_seq", i+1);
							m.put("cms_menu_seq", params.get("cms_menu_seq"));
							m.put("session_member_id", params.get("session_member_id"));
							m.put("session_member_nm", params.get("session_member_nm"));
							dao.insertStaff(m);
						}
					}
					reserveDAO.reserve_ok(params);
					txManager.commit(txStatus);
				} catch(Exception ex) {
					ex.printStackTrace();
					txManager.rollback(txStatus);
					reserveDAO.reserve_fail(params);
				} finally{
					removeTimer(params.get("reserve_seq").toString());
				}
			}
		}, dt);
		addTimer(params.get("reserve_seq").toString(), timer);
	}
*/	
	
	
}

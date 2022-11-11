package com.mc.web.programs.back.biz002;

import com.mc.web.MCMap;
import org.springframework.stereotype.Repository;

import com.mc.web.service.CmsAbstractDAO;

import java.util.List;
import java.util.Map;

/**
 *
 * @Description : 소상공인사업정리(재기장려 지원) 프로그램 DAO
 * @ClassName   : com.mc.web.programs.back.biz002.AdminBiz002DAO.java
 * @Modification Information
 *
 * @author MSLK_JJS
 * @since 2018. 3. 29.
 * @version 1.0 *  
 * Copyright (C)  All right reserved.
 */
@Repository
public class AdminBiz002DAO extends CmsAbstractDAO {

    public List<MCMap> list(Map<String, String> params) {
        return selectList("biz001.list", params);
    }
    public MCMap pagination(Map<String, String> params) {
        return selectOne("biz001.pageinfo", params);
    }

    public Map<String,Object> selectGridHeader() throws Exception{
        return selectOne("biz001.selectGridHeader");
    }

    public List<MCMap> selectGridData(Map<String, String> params) throws Exception{
        return selectList("biz001.selectGridData",params);
    }


    public Map<String,Object> selectBizInfo(Map<String, Object> params) {
        return selectOne("bizmaster.selectBizDetail",params);
    }

}

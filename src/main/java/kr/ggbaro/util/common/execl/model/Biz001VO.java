package kr.ggbaro.util.common.execl.model;

public class Biz001VO {

    //접수정보
    private String sn;//순번
    private String rcept_no; //접수번호
    //소득원 연번
    private String rcept_se; //접수구분
    private String dstrct; //권역
    private String rcept_dt; //접수일시
    private String change_dt; //변경일시
    //진행상태
    private String step; //단계
    private String sttus; //상태
    //사업체 신청 정보
    private String reqst_realm; //신청분야
    private String area;//지역
    private String entrps_nm;//업체명
    private String bsnm_no; //사업자 번호
    private String taxt_ty; //과세유형
    private String bizcnd; //업태
    private String item; //종목
    private String opbiz_de; //개업일자
    private String bplc_adres; //사업장 주소
    private String emply_co; //종업원 수
    //대표자 정보
    private String rprsntv; //대표자명
    private String lifyea; //생년월일
    private String sexdstn; //성별
    private String cttpc; //연락처
    //필수 서류
    private String sport_reqstdoc; //지원신청서
    private String indvdlinfo_wrtcns; //개인정보 동의서
    private String nfirm_proms_papers; //확약서
    private String prtn_actpln; //추진계획서
    private String bsnm_ceregrt; //사업자 등록증
    private String vat_crtf; //부가세 증명
    private String cpr_adit_papers; //법인추가 서류
    //2021년 부가세과세 증명
    private String frhfyr_1; //상반기
    private String shyy_1; //하반기
    private String yy_sm_1; //1년 계
    private String selng_mt_1; //매출월
    private String rm_1; //비고
    //2022년 부가세과세 증명
    private String frhfyr_2; //상반기
    private String shyy_2; //하반기
    private String yy_sm_2; //1년 계
    private String selng_mt_2; //매출월
    private String rm_2; //비고
    //(월환산) 매출액
    private String yy_selng_21; //21년 매출
    private String yy_selng_22; //22년 매출
    //신청 및 지원 한도
    private String reqst_realm_1; //신청분야
    private String sport_lmt; //지원한도
    //견적서 1
    private String cnstrct_entrps_1; //시공업체
    private String bsnm_no_1; //사업자 번호
    private String tel_1; //전화
    private String reqst_realm_detail_1; //신청분야 세부내역
    private String splpc_1; //공급가
    private String vat_1; //부가세
    private String subsum_1; //소계
    //견적서 2
    private String cnstrct_entrps_2; //시공업체
    private String bsnm_no_2; //사업자 번호
    private String tel_2; //전화
    private String reqst_realm_detail_2; //신청분야 세부내역
    private String splpc_2; //공급가
    private String vat_2; //부가세
    private String subsum_2; //소계
    //견적합계
    private String estmt_tot_sm; // 견적 총 합계
    //지원결정액
    private String sport_decsn_am; //지원결정액<br/>(공급가 90%)
    private String self_am; //자담액<br/>(부가세포함)
    //서류메모
    private String jdgmn_refer; //심사참고
    private String input_memo; //입력메모
    private String uprpd_papers; //추가,미비서류
    private String wlsbm_input; //검수입력
    //①교육, 컨설팅
    private String edc_cnsl; //내용
    //②사회 배려자
    private String socty_wksn; //내용
    //③4대보험 고용
    private String feinsr_emplym; //인원
    //④탄소포인트
    private String carbon_pnt; //내용
    //데이터 확인
    private String opbiz_de_result; //개업일자
    private String bsn_daycnt; //영업일수
    //정량점수(60)
    private String bsn_day; //업력
    private String selng; //매출
    private String dcrs_rt; //감소율
    // 가산점(촤대 10, 각 2 ~5점)
    private String edc_cnsl_cnt; // 교육, 컨설팅
    private String socty_wksn_cnt; //사회배려
    private String carbon_pnt_cnt; //탄소점수
    //합계(정량+가산)
    private String feinsr_emplym_cnt; //종업원
    private String fdqnt_cnt; //정량
    private String addi_cnt; //가산점
    //적격여부
    private String proper_ym; //적격여부
    //합계점수
    private String sum_score;//합계점수
    //정성평가
    private String jdgmm1; //심사1
    private String jdgmm2; //심사2
    private String jdgmm3; //심사3
    private String avrg; //평균
    //최종
    private String score; //점수
    private String rank; //순위
    //최종선정
    private String decsn; //결정
    //비고
    private String slctn_excl; //선정제외\
    private String requst;//보안요청
    private String etc; //기타

    public String getSn() {
        return sn;
    }

    public void setSn(String sn) {
        this.sn = sn;
    }

    public String getRcept_no() {
        return rcept_no;
    }

    public void setRcept_no(String rcept_no) {
        this.rcept_no = rcept_no;
    }

    public String getRcept_se() {
        return rcept_se;
    }

    public void setRcept_se(String rcept_se) {
        this.rcept_se = rcept_se;
    }

    public String getDstrct() {
        return dstrct;
    }

    public void setDstrct(String dstrct) {
        this.dstrct = dstrct;
    }

    public String getRcept_dt() {
        return rcept_dt;
    }

    public void setRcept_dt(String rcept_dt) {
        this.rcept_dt = rcept_dt;
    }

    public String getChange_dt() {
        return change_dt;
    }

    public void setChange_dt(String change_dt) {
        this.change_dt = change_dt;
    }

    public String getStep() {
        return step;
    }

    public void setStep(String step) {
        this.step = step;
    }

    public String getSttus() {
        return sttus;
    }

    public void setSttus(String sttus) {
        this.sttus = sttus;
    }

    public String getReqst_realm() {
        return reqst_realm;
    }

    public void setReqst_realm(String reqst_realm) {
        this.reqst_realm = reqst_realm;
    }

    public String getArea() {
        return area;
    }

    public void setArea(String area) {
        this.area = area;
    }

    public String getEntrps_nm() {
        return entrps_nm;
    }

    public void setEntrps_nm(String entrps_nm) {
        this.entrps_nm = entrps_nm;
    }

    public String getBsnm_no() {
        return bsnm_no;
    }

    public void setBsnm_no(String bsnm_no) {
        this.bsnm_no = bsnm_no;
    }

    public String getTaxt_ty() {
        return taxt_ty;
    }

    public void setTaxt_ty(String taxt_ty) {
        this.taxt_ty = taxt_ty;
    }

    public String getBizcnd() {
        return bizcnd;
    }

    public void setBizcnd(String bizcnd) {
        this.bizcnd = bizcnd;
    }

    public String getItem() {
        return item;
    }

    public void setItem(String item) {
        this.item = item;
    }

    public String getOpbiz_de() {
        return opbiz_de;
    }

    public void setOpbiz_de(String opbiz_de) {
        this.opbiz_de = opbiz_de;
    }

    public String getBplc_adres() {
        return bplc_adres;
    }

    public void setBplc_adres(String bplc_adres) {
        this.bplc_adres = bplc_adres;
    }

    public String getEmply_co() {
        return emply_co;
    }

    public void setEmply_co(String emply_co) {
        this.emply_co = emply_co;
    }

    public String getRprsntv() {
        return rprsntv;
    }

    public void setRprsntv(String rprsntv) {
        this.rprsntv = rprsntv;
    }

    public String getLifyea() {
        return lifyea;
    }

    public void setLifyea(String lifyea) {
        this.lifyea = lifyea;
    }

    public String getSexdstn() {
        return sexdstn;
    }

    public void setSexdstn(String sexdstn) {
        this.sexdstn = sexdstn;
    }

    public String getCttpc() {
        return cttpc;
    }

    public void setCttpc(String cttpc) {
        this.cttpc = cttpc;
    }

    public String getSport_reqstdoc() {
        return sport_reqstdoc;
    }

    public void setSport_reqstdoc(String sport_reqstdoc) {
        this.sport_reqstdoc = sport_reqstdoc;
    }

    public String getIndvdlinfo_wrtcns() {
        return indvdlinfo_wrtcns;
    }

    public void setIndvdlinfo_wrtcns(String indvdlinfo_wrtcns) {
        this.indvdlinfo_wrtcns = indvdlinfo_wrtcns;
    }

    public String getNfirm_proms_papers() {
        return nfirm_proms_papers;
    }

    public void setNfirm_proms_papers(String nfirm_proms_papers) {
        this.nfirm_proms_papers = nfirm_proms_papers;
    }

    public String getPrtn_actpln() {
        return prtn_actpln;
    }

    public void setPrtn_actpln(String prtn_actpln) {
        this.prtn_actpln = prtn_actpln;
    }

    public String getBsnm_ceregrt() {
        return bsnm_ceregrt;
    }

    public void setBsnm_ceregrt(String bsnm_ceregrt) {
        this.bsnm_ceregrt = bsnm_ceregrt;
    }

    public String getVat_crtf() {
        return vat_crtf;
    }

    public void setVat_crtf(String vat_crtf) {
        this.vat_crtf = vat_crtf;
    }

    public String getCpr_adit_papers() {
        return cpr_adit_papers;
    }

    public void setCpr_adit_papers(String cpr_adit_papers) {
        this.cpr_adit_papers = cpr_adit_papers;
    }

    public String getFrhfyr_1() {
        return frhfyr_1;
    }

    public void setFrhfyr_1(String frhfyr_1) {
        this.frhfyr_1 = frhfyr_1;
    }

    public String getShyy_1() {
        return shyy_1;
    }

    public void setShyy_1(String shyy_1) {
        this.shyy_1 = shyy_1;
    }

    public String getYy_sm_1() {
        return yy_sm_1;
    }

    public void setYy_sm_1(String yy_sm_1) {
        this.yy_sm_1 = yy_sm_1;
    }

    public String getSelng_mt_1() {
        return selng_mt_1;
    }

    public void setSelng_mt_1(String selng_mt_1) {
        this.selng_mt_1 = selng_mt_1;
    }

    public String getRm_1() {
        return rm_1;
    }

    public void setRm_1(String rm_1) {
        this.rm_1 = rm_1;
    }

    public String getFrhfyr_2() {
        return frhfyr_2;
    }

    public void setFrhfyr_2(String frhfyr_2) {
        this.frhfyr_2 = frhfyr_2;
    }

    public String getShyy_2() {
        return shyy_2;
    }

    public void setShyy_2(String shyy_2) {
        this.shyy_2 = shyy_2;
    }

    public String getYy_sm_2() {
        return yy_sm_2;
    }

    public void setYy_sm_2(String yy_sm_2) {
        this.yy_sm_2 = yy_sm_2;
    }

    public String getSelng_mt_2() {
        return selng_mt_2;
    }

    public void setSelng_mt_2(String selng_mt_2) {
        this.selng_mt_2 = selng_mt_2;
    }

    public String getRm_2() {
        return rm_2;
    }

    public void setRm_2(String rm_2) {
        this.rm_2 = rm_2;
    }

    public String getYy_selng_21() {
        return yy_selng_21;
    }

    public void setYy_selng_21(String yy_selng_21) {
        this.yy_selng_21 = yy_selng_21;
    }

    public String getYy_selng_22() {
        return yy_selng_22;
    }

    public void setYy_selng_22(String yy_selng_22) {
        this.yy_selng_22 = yy_selng_22;
    }

    public String getReqst_realm_1() {
        return reqst_realm_1;
    }

    public void setReqst_realm_1(String reqst_realm_1) {
        this.reqst_realm_1 = reqst_realm_1;
    }

    public String getSport_lmt() {
        return sport_lmt;
    }

    public void setSport_lmt(String sport_lmt) {
        this.sport_lmt = sport_lmt;
    }

    public String getCnstrct_entrps_1() {
        return cnstrct_entrps_1;
    }

    public void setCnstrct_entrps_1(String cnstrct_entrps_1) {
        this.cnstrct_entrps_1 = cnstrct_entrps_1;
    }

    public String getBsnm_no_1() {
        return bsnm_no_1;
    }

    public void setBsnm_no_1(String bsnm_no_1) {
        this.bsnm_no_1 = bsnm_no_1;
    }

    public String getTel_1() {
        return tel_1;
    }

    public void setTel_1(String tel_1) {
        this.tel_1 = tel_1;
    }

    public String getReqst_realm_detail_1() {
        return reqst_realm_detail_1;
    }

    public void setReqst_realm_detail_1(String reqst_realm_detail_1) {
        this.reqst_realm_detail_1 = reqst_realm_detail_1;
    }

    public String getSplpc_1() {
        return splpc_1;
    }

    public void setSplpc_1(String splpc_1) {
        this.splpc_1 = splpc_1;
    }

    public String getVat_1() {
        return vat_1;
    }

    public void setVat_1(String vat_1) {
        this.vat_1 = vat_1;
    }

    public String getSubsum_1() {
        return subsum_1;
    }

    public void setSubsum_1(String subsum_1) {
        this.subsum_1 = subsum_1;
    }

    public String getCnstrct_entrps_2() {
        return cnstrct_entrps_2;
    }

    public void setCnstrct_entrps_2(String cnstrct_entrps_2) {
        this.cnstrct_entrps_2 = cnstrct_entrps_2;
    }

    public String getBsnm_no_2() {
        return bsnm_no_2;
    }

    public void setBsnm_no_2(String bsnm_no_2) {
        this.bsnm_no_2 = bsnm_no_2;
    }

    public String getTel_2() {
        return tel_2;
    }

    public void setTel_2(String tel_2) {
        this.tel_2 = tel_2;
    }

    public String getReqst_realm_detail_2() {
        return reqst_realm_detail_2;
    }

    public void setReqst_realm_detail_2(String reqst_realm_detail_2) {
        this.reqst_realm_detail_2 = reqst_realm_detail_2;
    }

    public String getSplpc_2() {
        return splpc_2;
    }

    public void setSplpc_2(String splpc_2) {
        this.splpc_2 = splpc_2;
    }

    public String getVat_2() {
        return vat_2;
    }

    public void setVat_2(String vat_2) {
        this.vat_2 = vat_2;
    }

    public String getSubsum_2() {
        return subsum_2;
    }

    public void setSubsum_2(String subsum_2) {
        this.subsum_2 = subsum_2;
    }

    public String getEstmt_tot_sm() {
        return estmt_tot_sm;
    }

    public void setEstmt_tot_sm(String estmt_tot_sm) {
        this.estmt_tot_sm = estmt_tot_sm;
    }

    public String getSport_decsn_am() {
        return sport_decsn_am;
    }

    public void setSport_decsn_am(String sport_decsn_am) {
        this.sport_decsn_am = sport_decsn_am;
    }

    public String getSelf_am() {
        return self_am;
    }

    public void setSelf_am(String self_am) {
        this.self_am = self_am;
    }

    public String getJdgmn_refer() {
        return jdgmn_refer;
    }

    public void setJdgmn_refer(String jdgmn_refer) {
        this.jdgmn_refer = jdgmn_refer;
    }

    public String getInput_memo() {
        return input_memo;
    }

    public void setInput_memo(String input_memo) {
        this.input_memo = input_memo;
    }

    public String getUprpd_papers() {
        return uprpd_papers;
    }

    public void setUprpd_papers(String uprpd_papers) {
        this.uprpd_papers = uprpd_papers;
    }

    public String getWlsbm_input() {
        return wlsbm_input;
    }

    public void setWlsbm_input(String wlsbm_input) {
        this.wlsbm_input = wlsbm_input;
    }

    public String getEdc_cnsl() {
        return edc_cnsl;
    }

    public void setEdc_cnsl(String edc_cnsl) {
        this.edc_cnsl = edc_cnsl;
    }

    public String getSocty_wksn() {
        return socty_wksn;
    }

    public void setSocty_wksn(String socty_wksn) {
        this.socty_wksn = socty_wksn;
    }

    public String getFeinsr_emplym() {
        return feinsr_emplym;
    }

    public void setFeinsr_emplym(String feinsr_emplym) {
        this.feinsr_emplym = feinsr_emplym;
    }

    public String getCarbon_pnt() {
        return carbon_pnt;
    }

    public void setCarbon_pnt(String carbon_pnt) {
        this.carbon_pnt = carbon_pnt;
    }

    public String getOpbiz_de_result() {
        return opbiz_de_result;
    }

    public void setOpbiz_de_result(String opbiz_de_result) {
        this.opbiz_de_result = opbiz_de_result;
    }

    public String getBsn_daycnt() {
        return bsn_daycnt;
    }

    public void setBsn_daycnt(String bsn_daycnt) {
        this.bsn_daycnt = bsn_daycnt;
    }

    public String getBsn_day() {
        return bsn_day;
    }

    public void setBsn_day(String bsn_day) {
        this.bsn_day = bsn_day;
    }

    public String getSelng() {
        return selng;
    }

    public void setSelng(String selng) {
        this.selng = selng;
    }

    public String getDcrs_rt() {
        return dcrs_rt;
    }

    public void setDcrs_rt(String dcrs_rt) {
        this.dcrs_rt = dcrs_rt;
    }

    public String getEdc_cnsl_cnt() {
        return edc_cnsl_cnt;
    }

    public void setEdc_cnsl_cnt(String edc_cnsl_cnt) {
        this.edc_cnsl_cnt = edc_cnsl_cnt;
    }

    public String getSocty_wksn_cnt() {
        return socty_wksn_cnt;
    }

    public void setSocty_wksn_cnt(String socty_wksn_cnt) {
        this.socty_wksn_cnt = socty_wksn_cnt;
    }

    public String getCarbon_pnt_cnt() {
        return carbon_pnt_cnt;
    }

    public void setCarbon_pnt_cnt(String carbon_pnt_cnt) {
        this.carbon_pnt_cnt = carbon_pnt_cnt;
    }

    public String getFeinsr_emplym_cnt() {
        return feinsr_emplym_cnt;
    }

    public void setFeinsr_emplym_cnt(String feinsr_emplym_cnt) {
        this.feinsr_emplym_cnt = feinsr_emplym_cnt;
    }

    public String getFdqnt_cnt() {
        return fdqnt_cnt;
    }

    public void setFdqnt_cnt(String fdqnt_cnt) {
        this.fdqnt_cnt = fdqnt_cnt;
    }

    public String getAddi_cnt() {
        return addi_cnt;
    }

    public void setAddi_cnt(String addi_cnt) {
        this.addi_cnt = addi_cnt;
    }

    public String getProper_ym() {
        return proper_ym;
    }

    public void setProper_ym(String proper_ym) {
        this.proper_ym = proper_ym;
    }

    public String getSum_score() {
        return sum_score;
    }

    public void setSum_score(String sum_score) {
        this.sum_score = sum_score;
    }

    public String getJdgmm1() {
        return jdgmm1;
    }

    public void setJdgmm1(String jdgmm1) {
        this.jdgmm1 = jdgmm1;
    }

    public String getJdgmm2() {
        return jdgmm2;
    }

    public void setJdgmm2(String jdgmm2) {
        this.jdgmm2 = jdgmm2;
    }

    public String getJdgmm3() {
        return jdgmm3;
    }

    public void setJdgmm3(String jdgmm3) {
        this.jdgmm3 = jdgmm3;
    }

    public String getAvrg() {
        return avrg;
    }

    public void setAvrg(String avrg) {
        this.avrg = avrg;
    }

    public String getScore() {
        return score;
    }

    public void setScore(String score) {
        this.score = score;
    }

    public String getRank() {
        return rank;
    }

    public void setRank(String rank) {
        this.rank = rank;
    }

    public String getDecsn() {
        return decsn;
    }

    public void setDecsn(String decsn) {
        this.decsn = decsn;
    }

    public String getSlctn_excl() {
        return slctn_excl;
    }

    public void setSlctn_excl(String slctn_excl) {
        this.slctn_excl = slctn_excl;
    }

    public String getRequst() {
        return requst;
    }

    public void setRequst(String requst) {
        this.requst = requst;
    }

    public String getEtc() {
        return etc;
    }

    public void setEtc(String etc) {
        this.etc = etc;
    }
}

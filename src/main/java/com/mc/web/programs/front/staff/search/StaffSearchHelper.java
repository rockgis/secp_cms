package com.mc.web.programs.front.staff.search;

import java.util.List;

import org.apache.log4j.Logger;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.springframework.stereotype.Service;

import com.mc.web.MCMap;

/**
 * 
 * @Description : 리스트 표현 
 * @ClassName   : com.mc.web.staff.search.StaffSearchHelper.java
 * @author 이창기
 * @since 2015. 12. 10.
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
@Service
public class StaffSearchHelper {
	Logger logger = Logger.getLogger(this.getClass());
	
	/**
	 * 
	 * Comment  : 상단메뉴 html 생성
	 * @version : 1.0
	 * @tags    : @param list
	 * @tags    : @return
	 * @date    : 2015. 6. 3.
	 *
	 */
	public String makeList(List<MCMap> list) {
		Document doc = Jsoup.parse("<div class='wrap'></div>");
		String current_group_seq = "";
		for (MCMap map : list) {
			if(!current_group_seq.equals(map.getStrNull("group_seq"))){//새로 테이블 생성
				current_group_seq = map.getStrNull("group_seq");
				doc.select(".wrap").append(makeTable(map));
			}else{//기존 테이블에 추가
				doc.select("table").last().select("tbody").append(makeTr(map));
			}
		}
		return doc.select(".wrap").html();
	}

	private String makeTable(MCMap map) {
		String sb = "";
		sb += "		<h5>"+map.getStrNull("group_nm")+"</h5>";
		sb += "		<table class='sub_style_1'>";
		sb += "			<caption>부서명 명시</caption>";
		sb += "			<colgroup>";
		sb += "				<col width='12%'>";
		sb += "				<col width='10%'>";
		sb += "				<col width='*'>";
		sb += "				<col width='25%'>";
		sb += "			</colgroup>";
		sb += "			<thead>";
		sb += "				<tr>";
		sb += "					<th scope='col'>직책</th>";
		sb += "					<th scope='col'>이름</th>";
		sb += "					<th scope='col'>업무내용</th>";
		sb += "					<th scope='col'>전화번호</th>";
		sb += "				</tr>";
		sb += "			</thead>";
		sb += "			<tbody>";
		sb += "				<tr>";
		sb += "					<td class='type_cen'>"+map.getStrNull("positions")+"</td>";
		sb += "					<td class='type_cen'>"+map.getStrNull("member_nm")+"</td>";
		sb += "					<td>"+ map.getStrNull("responsibility").replaceAll("\n", "<br />") +"</td>";
		sb += "					<td class='type_cen'>"+map.getStrNull("tel").replaceAll("^0-", "")+"</td>";
		sb += "				</tr>";
		sb += "			</tbody>";
		sb += "		  </table>";
		return sb;
	}

	private String makeTr(MCMap map) {
		String sb = "";
		sb += "				<tr>";
		sb += "					<td class='type_cen'>"+map.getStrNull("positions")+"</td>";
		sb += "					<td class='type_cen'>"+map.getStrNull("member_nm")+"</td>";
		sb += "					<td>"+ map.getStrNull("responsibility").replaceAll("\n", "<br />") +"</td>";
		sb += "					<td class='type_cen'>"+map.getStrNull("tel").replaceAll("^0-", "")+"</td>";
		sb += "				</tr>";
		return sb;
	}

	
}
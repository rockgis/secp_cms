package com.mc.web.programs.back.biz001;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.mc.web.service.Globals;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.mc.web.MCMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import kr.ggbaro.util.common.file.FileUtils;

/**
 *
 * @Description : bizmanage 프로그램 컨트롤러
 * @ClassName   : com.mc.web.programs.back.bizmanage.AdminBizmanageController.java
 * @Modification Information
 *
 * @author MSLK_JJS
 * @since 2018. 3. 29.
 * @version 1.0 *  
 * Copyright (C)  All right reserved.
 */

@Controller
public class AdminBiz001Controller {

	private static final Logger logger = LoggerFactory.getLogger(AdminBiz001Controller.class);


	@Value("#{config['bizUpload.common']}")
	private String common_path;
	
	@Autowired
	private AdminBiz001Service service;
	
	
	@RequestMapping("/super/bizmanage/getHeader.do")
	public ResponseEntity<String> gridDataList() throws Exception {

		//Map jsonHeader = service.selectGridHeader();
		Map<String,Object> list = service.selectGridHeader();
		
		//System.out.println("##############################################");
		//System.out.println(list);
		//list.remove("hder_data");
		//String out = list.toString().replace("{\"hder_data\":\"", "").replace(""}]", "]").replace("},", ",");
		//String out = list.toString().replace("{jsonData=", "").replace("}]", "]").replace("},", ",");
		//String out = jsonHeader.toString();
		//Map<String,Object> out = jsonHeader;
		//String out = "[{\"id\": \"633e6efcf3f1f00485508322\",\"date\": \"2022-03-15 04:58:22\",\"name1\": \"Bradford Sanford\",\"name2\": \"Whitney Huff\",\"name3\": \"Irma Ray\",\"name4\": \"Trisha Webb\",\"name5\": \"Hernandez Hinton\",\"name6\": \"Susana Richardson\",\"name7\": \"Terra Lara\",\"name8\": \"Fowler Holmes\",\"name9\": \"Clarissa Combs\",\"name10\": \"Erica Aguilar\",\"name11\": \"Fern Fuentes\",\"name12\": \"Swanson Morse\",\"name13\": \"Howe Fields\",\"name14\": \"Cooke Gilmore\",\"name15\": \"Pat Alvarez\",\"name16\": \"Jane Frost\",\"name17\": \"Nicholson Brown\",\"name18\": \"Glass Hogan\",\"name19\": \"Colon Peters\",\"name20\": \"Leslie Porter\",\"name21\": \"Battle Workman\",\"name22\": \"Rene Hyde\",\"name23\": \"Effie Rojas\",\"name24\": \"Kimberly Christian\",\"name25\": \"Johnston Meyer\",\"name26\": \"Cross Hardin\",\"name27\": \"Sutton Tate\",\"name28\": \"Johnnie Sanders\",\"name29\": \"Rosalind Knowles\",\"name30\": \"Rosemarie Jennings\",\"name31\": \"Solomon Mckinney\",\"name32\": \"Kathryn Bond\",\"name33\": \"Myrtle Tanner\",\"name34\": \"Rasmussen Compton\",\"name35\": \"Marian Coffey\",\"name36\": \"Church Garrett\",\"name37\": \"Corrine Lloyd\",\"name38\": \"Sawyer Berger\",\"name39\": \"Hood Reid\",\"name40\": \"Ayala Day\",\"name41\": \"Sheryl Kirkland\",\"name42\": \"Clara Wall\",\"name43\": \"Mcneil Pittman\",\"name44\": \"Martin Berry\",\"name45\": \"Page Holman\",\"name46\": \"Estes Russell\",\"name47\": \"Ebony Nieves\",\"name48\": \"Graham Dean\",\"name49\": \"Harmon Roth\",\"name50\": \"Zamora Vance\",\"name51\": \"Flynn Bell\",\"name52\": \"Candace Kane\",\"name53\": \"Benita Floyd\",\"name54\": \"Joy Burton\",\"name55\": \"Wise Barry\",\"name56\": \"Dillon Cohen\",\"name57\": \"Erin Williamson\",\"name58\": \"Santos Church\",\"name59\": \"Louella Lott\",\"name60\": \"Gould Gutierrez\",\"name61\": \"Kristin Navarro\",\"name62\": \"Suzette Moody\",\"name63\": \"Lisa Ayala\",\"name64\": \"Juliana Hendricks\",\"name65\": \"Sargent Olson\",\"name66\": \"Velma Little\",\"name67\": \"Mamie Winters\",\"name68\": \"Park Paul\",\"name69\": \"Sexton Jenkins\",\"name70\": \"Graciela Mckee\",\"name71\": \"Baxter Osborne\",\"name72\": \"Douglas Cash\",\"name73\": \"Lolita Baker\",\"name74\": \"Oneal Welch\",\"name75\": \"Terry Woodward\",\"name76\": \"Maura Pacheco\",\"name77\": \"Misty Chapman\",\"name78\": \"Amparo Rose\",\"name79\": \"Vanessa Dunlap\",\"name80\": \"Foley Gibbs\",\"name81\": \"Bowman Herman\",\"name82\": \"Jimenez Wynn\",\"name83\": \"Best Lester\",\"name84\": \"Karin Robertson\",\"name85\": \"Helena Garner\",\"name86\": \"Bolton Montoya\",\"country\": \"Korea\",\"product\": \"Bainbridge\",\"color\": \"brown\",\"quantity\": 29,\"price\": 30061  }]";
		HttpHeaders header = new HttpHeaders();
		header.add("Content-Type", "application/json; charset=UTF-8");
		
		//System.out.println(list.get("hder_data"));
		
		return new ResponseEntity<>(list.get("hder_data").toString(),header,HttpStatus.OK);
		//return list.get("hder_data").toString();
	}
	
	
	
	@RequestMapping("/super/bizmanage/gridData.do")
	public ResponseEntity<String> gridData(Map<String, String> params) throws Exception {

		//Map jsonHeader = service.selectGridHeader();
//		AND BIZ_YR=#{bizYr}
//		AND BIZ_NO=#{bizNo}
//		AND BIZ_CYCL = #{bizCycl}
//		AND BIZ_SN=#{bizSn}
		params.put("bizYr", "2023");
		params.put("bizNo", "01");
		params.put("bizCycl", "01");
		//params.put("bizSn", "1");
		
		List<MCMap> list = service.selectGridData(params);
		
		System.out.println("##############################################");
		//System.out.println(list);
		//list.remove("hder_data");
		//String out = list.toString().replace("{\"hder_data\":\"", "").replace(""}]", "]").replace("},", ",");
		String out = list.toString().replace("{rcpt_data=", "").replace("}]", "]").replace("},", ",");
		//String out = jsonHeader.toString();
		//Map<String,Object> out = jsonHeader;
		//String out = "[{\"id\": \"633e6efcf3f1f00485508322\",\"date\": \"2022-03-15 04:58:22\",\"name1\": \"Bradford Sanford\",\"name2\": \"Whitney Huff\",\"name3\": \"Irma Ray\",\"name4\": \"Trisha Webb\",\"name5\": \"Hernandez Hinton\",\"name6\": \"Susana Richardson\",\"name7\": \"Terra Lara\",\"name8\": \"Fowler Holmes\",\"name9\": \"Clarissa Combs\",\"name10\": \"Erica Aguilar\",\"name11\": \"Fern Fuentes\",\"name12\": \"Swanson Morse\",\"name13\": \"Howe Fields\",\"name14\": \"Cooke Gilmore\",\"name15\": \"Pat Alvarez\",\"name16\": \"Jane Frost\",\"name17\": \"Nicholson Brown\",\"name18\": \"Glass Hogan\",\"name19\": \"Colon Peters\",\"name20\": \"Leslie Porter\",\"name21\": \"Battle Workman\",\"name22\": \"Rene Hyde\",\"name23\": \"Effie Rojas\",\"name24\": \"Kimberly Christian\",\"name25\": \"Johnston Meyer\",\"name26\": \"Cross Hardin\",\"name27\": \"Sutton Tate\",\"name28\": \"Johnnie Sanders\",\"name29\": \"Rosalind Knowles\",\"name30\": \"Rosemarie Jennings\",\"name31\": \"Solomon Mckinney\",\"name32\": \"Kathryn Bond\",\"name33\": \"Myrtle Tanner\",\"name34\": \"Rasmussen Compton\",\"name35\": \"Marian Coffey\",\"name36\": \"Church Garrett\",\"name37\": \"Corrine Lloyd\",\"name38\": \"Sawyer Berger\",\"name39\": \"Hood Reid\",\"name40\": \"Ayala Day\",\"name41\": \"Sheryl Kirkland\",\"name42\": \"Clara Wall\",\"name43\": \"Mcneil Pittman\",\"name44\": \"Martin Berry\",\"name45\": \"Page Holman\",\"name46\": \"Estes Russell\",\"name47\": \"Ebony Nieves\",\"name48\": \"Graham Dean\",\"name49\": \"Harmon Roth\",\"name50\": \"Zamora Vance\",\"name51\": \"Flynn Bell\",\"name52\": \"Candace Kane\",\"name53\": \"Benita Floyd\",\"name54\": \"Joy Burton\",\"name55\": \"Wise Barry\",\"name56\": \"Dillon Cohen\",\"name57\": \"Erin Williamson\",\"name58\": \"Santos Church\",\"name59\": \"Louella Lott\",\"name60\": \"Gould Gutierrez\",\"name61\": \"Kristin Navarro\",\"name62\": \"Suzette Moody\",\"name63\": \"Lisa Ayala\",\"name64\": \"Juliana Hendricks\",\"name65\": \"Sargent Olson\",\"name66\": \"Velma Little\",\"name67\": \"Mamie Winters\",\"name68\": \"Park Paul\",\"name69\": \"Sexton Jenkins\",\"name70\": \"Graciela Mckee\",\"name71\": \"Baxter Osborne\",\"name72\": \"Douglas Cash\",\"name73\": \"Lolita Baker\",\"name74\": \"Oneal Welch\",\"name75\": \"Terry Woodward\",\"name76\": \"Maura Pacheco\",\"name77\": \"Misty Chapman\",\"name78\": \"Amparo Rose\",\"name79\": \"Vanessa Dunlap\",\"name80\": \"Foley Gibbs\",\"name81\": \"Bowman Herman\",\"name82\": \"Jimenez Wynn\",\"name83\": \"Best Lester\",\"name84\": \"Karin Robertson\",\"name85\": \"Helena Garner\",\"name86\": \"Bolton Montoya\",\"country\": \"Korea\",\"product\": \"Bainbridge\",\"color\": \"brown\",\"quantity\": 29,\"price\": 30061  }]";
		HttpHeaders header = new HttpHeaders();
		header.add("Content-Type", "application/json; charset=UTF-8");
		
		//System.out.println(list.get("REPC_DATA"));
		System.out.println(out);
		
		return new ResponseEntity<>(out.toString(),header,HttpStatus.OK);
		//return list.get("hder_data").toString();
	}


//	@RequestMapping(value="/super/homepage/biz001/indexA01.do")
//	public String indexA01(@RequestParam Map<String, String> params, ModelMap model) throws Exception{
//		//return service.test(params);
//		//model.addAttribute("list", service.list(params));
//		return "super/homepage/biz001/indexA01";
//	}
	
	
	@RequestMapping(value="/super/homepage/biz001/indexA01.do")
	public ModelAndView  list(@RequestParam Map<String, String> params, ModelAndView  mav) throws Exception{
		//return service.test(params);
		params.put("BIZ_YR", "2023");
		params.put("BIZ_NO", "01");
		params.put("BIZ_CYCL", "01");
		
		ModelMap model = mav.getModelMap();
		
		model.addAttribute("bizInfo", service.selectBizInfo(params));
		
		System.out.println("######### BIZ_NM ##### :"+model.get("bizInfo"));
		
		return new ModelAndView("/super/homepage/biz001/indexA01",model);
	}
	
	
	@RequestMapping(value="/super/homepage/biz001/indexA02.do")
	public String indexA02(@RequestParam Map<String, String> params, ModelMap model) throws Exception{
		//return service.test(params);
		//model.addAttribute("list", service.list(params));
		return "super/homepage/biz001/indexA02";
	}
	
	@RequestMapping(value="/super/homepage/biz001/indexA03.do")
	public String indexA03(@RequestParam Map<String, String> params, ModelMap model) throws Exception{
		//return service.test(params);
		//model.addAttribute("list", service.list(params));
		return "super/homepage/biz001/indexA03";
	}

	@RequestMapping(value="/super/homepage/biz001/indexB01.do")
	public String indexB01(@RequestParam Map<String, String> params, ModelMap model) throws Exception{
		//return service.test(params);
		//model.addAttribute("list", service.list(params));
		return "super/homepage/biz001/indexB01";
	}

	@RequestMapping(value="/super/homepage/biz001/indexB02.do")
	public String indexB02(@RequestParam Map<String, String> params, ModelMap model) throws Exception{
		//return service.test(params);
		//model.addAttribute("list", service.list(params));
		return "super/homepage/biz001/indexB02";
	}


	@RequestMapping(value="/super/homepage/biz001/indexC01.do")
	public String indexC01(@RequestParam Map<String, String> params, ModelMap model) throws Exception{
		//return service.test(params);
		//model.addAttribute("list", service.list(params));
		return "super/homepage/biz001/indexC01";
	}

	@RequestMapping(value="/super/homepage/biz001/indexC02.do")
	public String indexC02(@RequestParam Map<String, String> params, ModelMap model) throws Exception{
		//return service.test(params);
		//model.addAttribute("list", service.list(params));
		return "super/homepage/biz001/indexC02";
	}

	@RequestMapping(value="/super/homepage/biz001/indexC03.do")
	public String indexC03(@RequestParam Map<String, String> params, ModelMap model) throws Exception{
		//return service.test(params);
		//model.addAttribute("list", service.list(params));
		return "super/homepage/biz001/indexC03";
	}


	@RequestMapping(value="/super/homepage/biz001/indexC04.do")
	public String indexC04(@RequestParam Map<String, String> params, ModelMap model) throws Exception{
		//return service.test(params);
		//model.addAttribute("list", service.list(params));
		return "super/homepage/biz001/indexC04";
	}


	@RequestMapping(value="/super/homepage/biz001/indexD01.do")
	public String indexD01(@RequestParam Map<String, String> params, ModelMap model) throws Exception{
		//return service.test(params);
		//model.addAttribute("list", service.list(params));
		return "super/homepage/biz001/indexD01";
	}

	@RequestMapping(value="/biz001/fileDown.do") //글 리스트 페이지
	public void fileDown(@RequestParam("originalFileName")String originalFileName, HttpServletRequest request, HttpServletResponse response) throws Exception {

		String originalDir = request.getSession().getServletContext().getRealPath(common_path)+"biz001";

		FileUtils.fileDownload(originalFileName, originalDir, request, response);
	}

	@RequestMapping(value="/biz001/fileUpload.do") //글 리스트 페이지
	public void fileUpload(@RequestParam("originalFileName")String originalFileName, HttpServletRequest request, HttpServletResponse response) throws Exception {

		String originalDir = request.getSession().getServletContext().getRealPath(common_path)+"biz001";

		FileUtils.fileDownload(originalFileName, originalDir, request, response);
	}

	/**
	 * JS 에서 JSON 을 POST 요청 할 때, 응답 값으로 받는 param 을 Domain(VO, DTO) 작성하지 않고,
	 * HashMap 으로 처리하는 예제입니다.
	 * 이 방법은 걍 간편하게 만드는 예제로, 추천 드리진 않습니다.
	 * (체계적이고 구조화된 개발법이 아님. 그러나 Domain 만드는 수고를 덜 수 있음)
	 * @param param JSON 정보를 HashMap 으로 변경된 파라메터
	 * @return JSON 정보 리턴
	 */
	@ResponseBody
	@RequestMapping(value = "/super/biz001/gridSave.do", method = RequestMethod.POST, consumes="application/json;")
	public HashMap<String, Object> gridSave(@RequestBody HashMap<String, ArrayList<Object>> param) throws Exception {
		HashMap hm = null;

		ArrayList<Object> updateList = param.get("update"); // 수정 리스트 얻기
		ArrayList<Object> addList = param.get("add"); // 추가 리스트 얻기
		ArrayList<Object> removeList = param.get("remove"); // 제거 리스트 얻기

		// 여기서 비지니스 로직을 작성하거나, 서비스 로직을 실행하세요.

		logger.info("=========================================================");
		/// 콘솔로 찍어보기
		logger.info("수정 : " + updateList.toString());
		logger.info("추가 : " + addList.toString());
		logger.info("삭제 : " + removeList.toString());
		logger.info("=========================================================");

		Map<String, Object> params = new HashMap<>();
		params.put("addList", addList);
		params.put("updateList", updateList);
		params.put("removeList", removeList);


				//if ("I".equals(params.get("saveType"))) {
		service.indvdlInsert(params);
		//} else {
		//	return service.indvdlUpdate(params);
		//}



		// 결과 만들기
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("success", "OK");

		return map;
	}


	@ResponseBody
	@RequestMapping(value = "/super/biz001/gridToPdf", method = RequestMethod.POST)
	public HashMap<String, Object> gridToPdf(@RequestBody HashMap<String, ArrayList<Object>> param) {
		HashMap hm = null;

		ArrayList<Object> addList = param.get("add"); // 추가 리스트 얻기

		// 여기서 비지니스 로직을 작성하거나, 서비스 로직을 실행하세요.

		// 콘솔로 찍어보기
		logger.info("추가 : " + addList.toString());

		// 결과 만들기
		HashMap<String, Object> map = new HashMap<String, Object>();
		map.put("success", "OK");

		return map;
	}


}

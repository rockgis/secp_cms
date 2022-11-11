package com.mc.web.programs.back.filter;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.stereotype.Service;

@Service
public class FilterHelper {
	
	//컨텐츠 필터링
	public void textFilter(List list, String filter, String conts){
		String[] token = filter.split(",");
		for (String item : token) {
			if(conts.indexOf(item)>-1){
				list.add(item);
			}
		}
	}
	
	//정상적인 주민번호/외국인번호 체크
	public void juminFilter(List list, String conts){
		if(conts=="")return;
		String regExp = "\\d{6}-\\d{7}";
		Pattern pattern = Pattern.compile(regExp);
		Matcher match = pattern.matcher(conts);
		jumin(match,list);
		
		String regExp1 = "\\d{13}";
		Pattern pattern1 = Pattern.compile(regExp1);
		Matcher match1 = pattern1.matcher(conts);
		jumin(match1,list);
	}
	private List<String> jumin(Matcher match,List<String> tempList){
		while(match.find()){
			String orgMatchStr = match.group();
			boolean startMethod = true;
			for(String val : tempList){
				if(val.equals(orgMatchStr)){
					startMethod = false;
				}
			}
			if(startMethod){
				String matchStr = orgMatchStr.replaceAll("-", "");
				int sum=0;
	            for(int i=0; i<matchStr.length()-1; i++){
	                sum += (matchStr.charAt(i)-'0') * (i<8 ? i+2 : i-6); 
	            }
	            sum = (11 - sum%11)%10;
	            if(matchStr.charAt(12)-'0' == sum){
	            	tempList.add(orgMatchStr);
	            }
			}
		}
		return tempList;
	}
	
	//정상적인 사업자 번호 체크
	public void businoFilter(List list, String conts){
		String regExp = "\\d{3}-\\d{2}-\\d{5}";
		Pattern pattern = Pattern.compile(regExp);
		Matcher match = pattern.matcher(conts);
		busino(match,list);
		
		String regExp1 = "\\d{10}";
		Pattern pattern1 = Pattern.compile(regExp1);
		Matcher match1 = pattern1.matcher(conts);
		busino(match1,list);
	}
	private List<String> busino(Matcher match,List<String> tempList){
		List<Integer> chkvalue = Arrays.asList(1,3,7,1,3,7,1,3,5);//기본계산숫자셋팅
		while(match.find()){
			String orgMatchStr = match.group();
			boolean startMethod = true;
			for(String val : tempList){
				if(val.equals(orgMatchStr)){
					startMethod = false;
				}
			}
			if(startMethod){
				String matchStr = orgMatchStr.replaceAll("-", "");
				int sum = 0;
				List<Integer> getList = new ArrayList<Integer>();
				for(int z = 0; z < 10 ; z++){
					getList.add(Integer.parseInt(matchStr.substring(z, z+1)));
				}
				for(int z = 0; z < 9 ; z++){
					sum += getList.get(z) * chkvalue.get(z);
				}
				sum += (getList.get(8) * 5) / 10;
				int sidliy = sum % 10;
				int sidchk = 0;
		        if(sidliy != 0){
		        	sidchk = 10 - sidliy;
		        }else{
		        	sidchk = 0;
		        }
		        if(sidchk == getList.get(9)){
		        	tempList.add(orgMatchStr);
		        }
			}
		}
		return tempList;
	}
	
	//정상적인 휴대전화 번호 체크
	public void cellFilter(List list, String conts){
		String regExp = "01([0|1|6|7|8|9]?)-\\d{3,4}-\\d{4}";
		Pattern pattern = Pattern.compile(regExp);
		Matcher match = pattern.matcher(conts);
		metchWhile(match,list);
		
		String regExp1 = "01([0|1|6|7|8|9]?)\\d{7,8}";
		Pattern pattern1 = Pattern.compile(regExp1);
		Matcher match1 = pattern1.matcher(conts);
		metchWhile(match1,list);
	}
	
	//정상적인 일반전화 번호 체크
	public void telFilter(List list, String conts){
		
		String regExp = "0\\d{1,2}-\\d{3,4}-\\d{4}";
		Pattern pattern = Pattern.compile(regExp);
		Matcher match = pattern.matcher(conts);
		tel(match,list);
		
		String regExp1 = "0\\d{8}|0\\d{9}|0\\d{10}";
		Pattern pattern1 = Pattern.compile(regExp1);
		Matcher match1 = pattern1.matcher(conts);
		tel(match1,list);
	}
	private List<String> tel(Matcher match,List<String> tempList){
		while(match.find()){
			String orgMatchStr = match.group();
			if(!orgMatchStr.startsWith("01")){
				boolean startMethod = true;
				for(String val : tempList){
					if(val.equals(orgMatchStr)){
						startMethod = false;
					}
				}
				if(startMethod){
					tempList.add(orgMatchStr);
				}
			}
		}
		return tempList;
	}
	
	//법인번호 체크
	public void bubinoFilter(List list, String conts) {
		
		String regExp = "\\d{6}-\\d{7}";
		Pattern pattern = Pattern.compile(regExp);
		Matcher match = pattern.matcher(conts);
		bubino(match,list);
		
		String regExp1 = "\\d{6}-\\d{7}";
		Pattern pattern1 = Pattern.compile(regExp1);
		Matcher match1 = pattern1.matcher(conts);
		bubino(match1,list);
   	}
	private List<String> bubino(Matcher match,List<String> tempList){
		while(match.find()){
			String orgMatchStr = match.group();
			boolean startMethod = true;
			for(String val : tempList){
				if(val.equals(orgMatchStr)){
					startMethod = false;
				}
			}
			if(startMethod){
				String matchStr = orgMatchStr.replaceAll("-", "");
		    	int hap = 0;
		    	int temp = 1;	//유효검증식에 사용하기 위한 변수
		    	
		    	// 맨끝 자리 수는 전산시스템으로 오류를 검증하기 위해 부여되는 검증번호임
		    	for ( int i=0; i<12; i++){
		    		if(temp ==3) temp = 1;    		
		    		hap = hap + (Character.getNumericValue(matchStr.charAt(i)) * temp);
		    		temp++;
		    	}	//검증을 위한 식의 계산
		    				
		    	if ((10 - (hap%10))%10 == Character.getNumericValue(matchStr.charAt(12))){//마지막 유효숫자와 검증식을 통한 값의 비교
		    		tempList.add(orgMatchStr);
		    	}
			}
		}
		return tempList;
	}
	
	//이메일 체크
	public void emailFilter(List list, String conts){
		List<String> tempList = new ArrayList<String>();
		
		String regExp = "[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})";
		Pattern pattern = Pattern.compile(regExp);
		Matcher match = pattern.matcher(conts);
		metchWhile(match,list);
	}
	
	//카드번호 체크
	public void cardFilter(List list, String conts){
		String regExp = "\\d{4}-\\d{4}-\\d{4}-\\d{4}";
		Pattern pattern = Pattern.compile(regExp);
		Matcher match = pattern.matcher(conts);
		metchWhile(match,list);
		
		String regExp1 = "\\d{16}";
		Pattern pattern1 = Pattern.compile(regExp1);
		Matcher match1 = pattern1.matcher(conts);
		metchWhile(match1,list);
	}
	
	private List<String> metchWhile(Matcher match,List<String> tempList){
		while(match.find()){
			String orgMatchStr = match.group();
			boolean startMethod = true;
			for(String val : tempList){
				if(val.equals(orgMatchStr)){
					startMethod = false;
				}
			}
			if(startMethod){
				tempList.add(orgMatchStr);
			}
		}
		return tempList;
	}
}
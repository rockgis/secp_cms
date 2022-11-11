package kr.ggbaro.util.common;
import java.io.FileInputStream;
import java.io.StringReader;
import java.net.URLEncoder;
import java.security.cert.CertificateException;
import java.security.cert.X509Certificate;
import java.sql.Clob;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.Map.Entry;
import javax.net.ssl.SSLContext;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.apache.commons.collections.bag.SynchronizedSortedBag;
import org.apache.commons.io.IOUtils;
import org.apache.http.conn.ssl.NoopHostnameVerifier; 
import org.apache.http.conn.ssl.SSLConnectionSocketFactory; 
import org.apache.http.conn.ssl.TrustStrategy;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.http.client.HttpComponentsClientHttpRequestFactory;
import org.springframework.web.client.RestTemplate;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

import go.mdds.sdk.util.CipherUtil;  
import go.mdds.sdk.util.TimeUtil;

public class MydataRun {

	// RestTemplate 객체 선언
	public static RestTemplate restTemplate;

	
	public static void main(String[] args) throws Exception {
		Map<String,Object> params = new HashMap();
		
		//if(args[0].equals("MDS0003181")) {
// ########################################################################################		
//			params.put("serviceId", "MDS0003181");
//			params.put("userName", "정지석");
//			params.put("userSexdstn", "M");
//			params.put("userBrthdy", "19721013");
//			params.put("userRrn", "7210131067514");
//			params.put("userTelNo", "01024109738");
//			params.put("L001K001", "정지석");
//			params.put("L001K002", "721013");
//			params.put("L001K003", "1067514");
//			params.put("L006K001", "정지석");
//			params.put("L006K002", "721013");
//			params.put("L006K003", "1067514");
//			params.put("L022K001", "623");
//			params.put("L022K002", "82");
//			params.put("L022K003", "00226");
//			params.put("L022K004", "01");
//			params.put("L030K001", "6238200226");
//			params.put("L031K001", "6238200226");
//			params.put("L031K002", "6238200226");
//			params.put("L031K003", "경상원");
//			params.put("L100K001", "정지석");
//			params.put("L100K002", "721013");
//			params.put("L100K003", "1067514");
			

		
// ########################################################################################			
//			params.put("serviceId", "MDS0003223");
//			params.put("userName", "정지석");
//			params.put("userSexdstn", "M");
//			params.put("userBrthdy", "19721013");
//			params.put("userRrn", "7210131067514");
//			params.put("userTelNo", "01024109738");
//			params.put("L007K001", "정지석");
//			params.put("L007K002", "721013");
//			params.put("L007K003", "1067514");
//			params.put("L008K001", "정지석");
//			params.put("L008K002","721013");
//			params.put("L008K003","1067514");
//			params.put("L008K004","2021");
//			params.put("L008K005","2");
//			params.put("L008K006","01");
//			params.put("L010K001","정지석");
//			params.put("L010K002","721013");
//			params.put("L010K003","1067514");
//			params.put("L010K004","2021");
//			params.put("L010K005","2");
//			params.put("L010K006","01");
			
			
// ########################################################################################			
//			params.put("serviceId", "MDS0003210");
//			params.put("userName", "정지석");
//			params.put("userSexdstn", "M");
//			params.put("userBrthdy", "19721013");
//			params.put("userRrn", "7210131067514");
//			params.put("userTelNo", "01024109738");
//			params.put("L015K001", "721013");
//			params.put("L015K002", "1067514");
//			params.put("L015K003", "정지석");
//			params.put("L016K001", "정지석");
//			params.put("L016K002","721013");
//			params.put("L016K003","1067514");
//			params.put("L020K001","");
//			params.put("L020K002","");
//			params.put("L020K003","정지석");
//			params.put("L020K004","721013");
//			params.put("L020K005","1067514");
			
			
// ########################################################################################			
//			params.put("serviceId", "MDS0003206");
//			params.put("userName", "정지석");
//			params.put("userSexdstn", "M");
//			params.put("userBrthdy", "19721013");
//			params.put("userRrn", "7210131067514");
//			params.put("userTelNo", "01024109738");
//			params.put("L014K001", "01");
//			params.put("L014K002", "01");
//			params.put("L014K003", "");
//			params.put("L014K004", "정지석");
//			params.put("L014K005","721013");
//			params.put("L014K006","1067514");
//			params.put("L014K007","");
//			params.put("L014K008","");
//			params.put("L014K009","");
//			params.put("L014K010","7210131067514");
//			params.put("L021K001","개인");
//			params.put("L021K002","1");
//			params.put("L021K003","정지석");
//			params.put("L021K004","721013");
//			params.put("L021K005","1067514");
//			params.put("L021K006","");
//			params.put("L021K007","");
//			params.put("L021K007","");
//			params.put("L021K009","0");
//			params.put("L021K010","개인식별자");
			
			
			
// ########################################################################################			
			params.put("serviceId", "MDS0003194");
			params.put("userName", "정지석");
			params.put("userSexdstn", "M");
			params.put("userBrthdy", "19721013");
			params.put("userRrn", "7210131067514");
			params.put("userTelNo", "01024109738");
			params.put("L023K001", "751");
			params.put("L023K002", "43");
			params.put("L023K003", "00430");
			params.put("L023K004", "터치카페남양주다산점");
			params.put("L023K005", "01");
			params.put("L024K001","751");
			params.put("L024K002","43");
			params.put("L024K003","00430");
			params.put("L024K004","01");
			params.put("L025K001","7514300430");
			params.put("L025K002","20190101");
			params.put("L025K003","20210101");
			params.put("L025K004","20211231");
			params.put("L026K002","7514300430");
			params.put("L026K003","202112");
			params.put("L026K005","40");
			params.put("L028K001","7514300430");
			params.put("L028K002","20190101");
			params.put("L028K003","2019");
			params.put("L028K004","2021");
			
			System.out.println("1.##### "+params);
			
			getMydata(params);
		//}
	}
	
	
	public static void getMydata(Map<String,Object> param) throws Exception {
	//public static void main(String[] args) throws Exception {
		// URL 및 HTTP Method는 활용가이드의 [API 목록] 참조
		String url = "";
		// GET 방식 uurl 셈플 :
		String urlGet = "https://116.67.75.163/provdapis/issuerequest"; // 개발
		
		//String urlGet = "http://211.114.154.232:9090/api/issuerequest?isBase64=true"; 
		// POST 방식 uurl 셈플
		String urlPost = "https://116.67.75.163/provdapis/issuerequest"; //개발
		//String urlPost = "http://211.114.154.232:9090/api/issuerequest?isBase64=true";
		
		
		

		String httpMethod = "get"; // 1 : GET 방식 테스트 , 2 : POST 방식 테스트

		if ("get".contains(httpMethod) == true) { // GET 방식일 경우
			url = urlGet;
		}

		if ("post".contains(httpMethod) == true) { // POST 방식일 경우
			url = urlPost;
		}
		String encXML = "";
		String params = "";

		// API key
		//String apiKey = "3d60f3c9-37cf-46ed-8bc2-e95c1446c05a"; // 개발
		String apiKey = "fed3c5b7-9e79-473f-a365-f9b420b42669"; // 운영
		// API key hash value
		String apiKeyHashcd = "";
		// 이용시스템코드 (이용기관코드)(16자리)
		String apiUtlinsttCode = "B554058000000019";
		// API이용기관 전문번호(25자리)
		String apiUtlinsttTrnsmisNo = TimeUtil.getApiUtlinsttTrnsmisNo();
		// [STEP-1] XML 파일의 문자열 추출 ================
		//String reqXML = MydataRun.getXmlByFile();
		String reqXML = getServiceXml(param);
		
		System.out.println("reqXML : " + reqXML);
		
		// XML 파일의 공통 헤더 항목 apiKeyHashCode 값 삽입
		reqXML = getApiKeyHashCode(reqXML, apiKey, param);
		// [STEP-2] XML 압호화 ================
		encXML = CipherUtil.encryptAria(reqXML, apiKey, apiUtlinsttCode);
		// [STEP-3] API Key로 요청 전문을 해시한 코드 추출 ==========================
		params = "encData=" + URLEncoder.encode(encXML, "utf-8");
		
		System.out.println("params : " + params);

		apiKeyHashcd = CipherUtil.getHmacHashValue(params, apiKey);
		// [STEP-4] HTTP 공통 Header 항목 설정 ===========================
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON_UTF8);
		// API key hash value
		headers.set("apiKeyHashcd", apiKeyHashcd);
		// 이용시스템코드 (이용기관코드)(16자리)
		headers.set("apiUtlinsttCode", apiUtlinsttCode);
		// API이용기관 전문번호(25자리)
		headers.set("apiUtlinsttTrnsmisNo", apiUtlinsttTrnsmisNo);
		// 신용정보원 이용기관 발급 API 인 경우
		if ("/provdapis/issuerequest".contains(url) == true) {
			String chargerName = "홍길동"; // 업무담당자명
			String usePurps = "묶음정보발급"; // 사용목적
			String chargerPsitn = "묶음정보관리"; // 담장자소속
			String chargerTelno = "01012345678"; // 담당자 연락처
			chargerName = URLEncoder.encode(chargerName, "utf-8");
			usePurps = URLEncoder.encode(usePurps, "utf-8");
			chargerPsitn = URLEncoder.encode(chargerPsitn, "utf-8");
			chargerTelno = URLEncoder.encode(chargerTelno, "utf-8");
			headers.set("chargerName", chargerName);
			headers.set("usePurps", usePurps);
			headers.set("chargerPsitn", chargerPsitn);
			headers.set("chargerTelno", chargerTelno);
		}
		// [STEP-5] RestTemplate 생성 ====================================
		MydataRun.restTemplate = MydataRun.getRestTemplate();
		HttpEntity<?> request = null;
		ResponseEntity<String> response = null;
		HttpMethod method = null;

		if ("get".contains(httpMethod) == true) {
			// url에 request param 추가
			url += "?" + params;
			// request 생성
			request = new HttpEntity<>(null, headers);
			method = HttpMethod.GET;
		}

		if ("post".contains(httpMethod) == true) {
			// request body 생성
			JSONObject jsonBody = new JSONObject();
			jsonBody.put("encData", URLEncoder.encode(encXML, "utf-8"));
			// request 생성
			request = new HttpEntity<>(jsonBody.toString(), headers);
			method = HttpMethod.POST;
		}
		// [STEP-6] 전송 ====================================
		response = restTemplate.exchange(url, method, request, String.class);
		// [STEP-7] Response HTTP Header 추출 ================
		HttpHeaders resHeaders = response.getHeaders();
		Set<Entry<String, List<String>>> set = resHeaders.entrySet();
		String key = "";
		List<?> valueList = null;
		for (Entry<String, List<String>> entry : set) {
			key = entry.getKey();
			valueList = entry.getValue();
			System.out.println("@@@ key / value : " + key + " / " + valueList.toString());
		}
		// [STEP-8] response body 추출 ==================================
		if (response.hasBody()) {
			String body = response.getBody();
			JSONParser parser = new JSONParser();
			Object obj = parser.parse(body);
			JSONObject jsonBody = (JSONObject) obj;
			String rspnsCode = (String) jsonBody.get("rspnsCode");
			String rspnsMssage = (String) jsonBody.get("rspnsMssage");
			String encData = (String) jsonBody.get("encData");

			System.out.println("@@@ rspnsCode : " + rspnsCode);
			System.out.println("@@@ rspnsMssage : " + rspnsMssage);
			if ("100".contains(rspnsCode) == false) {
				// 실패
				return;
			}
			// [STEP-8] Response Body 복호화 ================
			String decData = CipherUtil.decryptAria(encData, apiKey, apiUtlinsttCode);
			System.out.println("@@@ encData : " + encData);
			
			
			System.out.println("@@@ decData : " + decData);
			
			StringBuffer sb      =  new StringBuffer();
			sb.append(decData);
			
			
			DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
            DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
            Document doc = dBuilder.parse(new InputSource(new StringReader(sb.toString())));
            doc.getDocumentElement().normalize();
            
            
         // 읽어들인 파일 불러오기
            NodeList nodes = doc.getElementsByTagName("response");
//            for (int k = 0; k < nodes.getLength(); k++) {
//                Node node = nodes.item(k);
//                
//                if (node.getNodeType() == Node.ELEMENT_NODE) {
//                    Element element = (Element) node;
//                    System.out.println("response: " + getValue("response", element));
//                }
//            }
            Node node = nodes.item(0);
            Node textNode      =  nodes.item(0).getChildNodes().item(0);
            
            System.out.println("response: " + textNode.getNodeValue());
            
			MydataRun2 next = new MydataRun2();
			
			param.put("seqNo", textNode.getNodeValue());
			
            next.getMydata2(param);
			
		}
		System.out.println("END ================");
	}
	
	private static String getValue(String tag, Element element) {
        NodeList nodes = element.getElementsByTagName(tag).item(0).getChildNodes();
        Node node = (Node) nodes.item(0);
        return node.getNodeValue();
    }

	/** XML 파일의 문자열 추출 */
	public static String getXmlByFile() throws Exception {
		String resusltStr = "";
		String root = System.getProperty("user.dir");
		FileInputStream fis = null;
		//fis = new FileInputStream(root + "/src/main/java/sample_1.xml");
		//fis = new FileInputStream("/home1/ncloud/secp/MDS0003181.xml");
		fis = new FileInputStream("/home1/ncloud/secp/MDS0003223.xml");
		
		//fis = new FileInputStream("/home1/ncloud/secp/MASTER.xml");
		resusltStr = IOUtils.toString(fis);
		resusltStr = resusltStr.replaceAll("\r", "");
		return resusltStr;
	}

	/** XML 파일의 공통 헤더 항목 apiKeyHashCode 값 삽입 */
	public static String getApiKeyHashCode(String xmlString, String apiKey, Map<String,Object> param) throws Exception {
		//xmlString = MydataRun.getXmlByFile();
		xmlString = getServiceXml(param);
		int xmlStartIdx = 0;
		int xmlEndIdx = 0;
		// XML 문자열에서 Body Tag 문자열을 추출
		xmlStartIdx = xmlString.indexOf("<Body>");
		xmlEndIdx = xmlString.indexOf("</Body>") + 7;
		String xmlBody = xmlString.substring(xmlStartIdx, xmlEndIdx);
		// API Key를 사용하여 HMAC Hash 코드를 추출
		String apiKeyHashCode = CipherUtil.getHmacHashValue(xmlBody, apiKey);
		xmlEndIdx = xmlString.indexOf("<apiKeyHashCode>") + 16;
		xmlStartIdx = xmlString.indexOf("</apiKeyHashCode>");
		String xml1 = xmlString.substring(0, xmlEndIdx);
		String xml2 = xmlString.substring(xmlStartIdx);
		String returnXml = xml1 + apiKeyHashCode + xml2;
		return returnXml;
	}

	/** RestTemplate 생성 */
	public static RestTemplate getRestTemplate() throws Exception {
		if (MydataRun.restTemplate != null) {
			return MydataRun.restTemplate;
		}
		// SSL key 없이 우회하는 방식 =====================
		TrustStrategy acceptingTrustStrategy = new TrustStrategy() {
			@Override
			public boolean isTrusted(X509Certificate[] x509Certificates, String s) throws CertificateException {
				return true;
			}
		};
		
		SSLContext sslContext = org.apache.http.ssl.SSLContexts.custom().loadTrustMaterial(null, acceptingTrustStrategy).build();
		SSLConnectionSocketFactory csf = new SSLConnectionSocketFactory(sslContext, new NoopHostnameVerifier());
		CloseableHttpClient httpClient = HttpClients.custom()
											.setMaxConnTotal(100) // [TODO 설정 필요]커넥션풀 적용(최대 오픈되는 커넥션 수)
											.setMaxConnPerRoute(10) // [TODO 설정 필요]커넥션풀 적용(IP:포트 1쌍에 대해 수행 할 연결 수 제한)
											.setSSLSocketFactory(csf)
											.build();
		 HttpComponentsClientHttpRequestFactory requestFactory = new HttpComponentsClientHttpRequestFactory();
		 requestFactory.setReadTimeout(500 * 1000); // [TODO 설정 필요] 읽기 시간 초과 타임아웃
		 requestFactory.setConnectTimeout(120 * 1000); // [TODO 설정 필요] 연결 시간 초과 타임아웃
		 requestFactory.setHttpClient(httpClient);
		 MydataRun.restTemplate = new RestTemplate(requestFactory);
		 
		 return MydataRun.restTemplate;
	}
	
	
	
	
	
	public static String getServiceXml(Map<String,Object> params) throws Exception {
		
		StringBuffer sb      =  new StringBuffer();
		
		if(params.get("serviceId").equals("MDS0003181")) {
			sb.append("<?xml version='1.1' encoding='UTF-8'?>");
			sb.append("<Envelope>");
			sb.append("  <Header>");
			sb.append("    <commonHeader>");
			sb.append("      <apiKeyHashCode>Dk+snCMZ+NtYr2Ug06oTVMBVForKrysQYpuiB7SDH4A=</apiKeyHashCode>");
			sb.append("      <useSystemCode>B554058000000019</useSystemCode>");
			sb.append("      <serviceId>MDS0003181</serviceId>");
			sb.append("      <transactionUniqueId>2022090113555278836025609</transactionUniqueId>");
			sb.append("      <agreementYn>Y</agreementYn>");
			sb.append("      <timeStmapToken>2022090113555278896343246</timeStmapToken>");
			sb.append("    </commonHeader>");
			sb.append("  </Header>");
			sb.append("	<Body>");
			sb.append("	  <request>");
			sb.append("		<userVerifyInfo>");
			sb.append("			<userCid>JPEvjmAGTx7ti/bCnlSrOSP79YjeEuNmsLu70neV1QwvRp3Uifiy9ejGD1mpbLXGtf6GgpggvvDoIeCAJ369Pw==</userCid>");
			sb.append("			<userName>"+params.get("userName")+"</userName>");
			sb.append("			<userSexdstn>"+params.get("userSexdstn")+"</userSexdstn>");
			sb.append("			<userBrthdy>"+params.get("userBrthdy")+"</userBrthdy>");
			sb.append("			<userEmail></userEmail>");
			sb.append("			<userRrn>"+params.get("userRrn")+"</userRrn>");
			sb.append("			<userTelno>"+params.get("userTelNo")+"</userTelno>");
			sb.append("			<ntvfrnrSe>L</ntvfrnrSe>");
			sb.append("		</userVerifyInfo>");
			sb.append("		<reqstInfo>");
			sb.append("			<utlinsttCode>B554058000000019</utlinsttCode>");
			sb.append("			<bundleId>MDS0003181</bundleId>");
			sb.append("		</reqstInfo>");
			sb.append("		<bundleInfo>");
			sb.append("			<L001K001>"+params.get("L001K001")+"</L001K001>");     //  <L001K001>성명 [ex 홍길동]</L001K001>
			sb.append("			<L001K002>"+params.get("L001K002")+"</L001K002>");     //  <L001K002>주민등록번호앞번호 [ex 200101]</L001K002>
			sb.append("			<L001K003>"+params.get("L001K003")+"</L001K003>");     //  <L001K003>주민등록번호뒷번호 [ex 1234567]</L001K003>
			sb.append("			<L006K001>"+params.get("L006K001")+"</L006K001>");     //  <L006K001>성명 [ex 홍길동]</L006K001>
			sb.append("			<L006K002>"+params.get("L006K002")+"</L006K002>");     //  <L006K002>주민등록번호앞번호 [ex 200101]</L006K002>
			sb.append("			<L006K003>"+params.get("L006K003")+"</L006K003>");     //  <L006K003>주민등록번호뒷번호 [ex 1234567]</L006K003>
			sb.append("			<L022K001>"+params.get("L022K001")+"</L022K001>");     //  <L022K001>사업자등록번호앞번호 [ex 123]</L022K001>
			sb.append("			<L022K002>"+params.get("L022K002")+"</L022K002>");     //  <L022K002>사업자등록번호중간번호 [ex 12]</L022K002>
			sb.append("			<L022K003>"+params.get("L022K003")+"</L022K003>");     //  <L022K003>사업자등록번호뒷번호 [ex 12345]</L022K003>
			sb.append("			<L022K004>"+params.get("L022K004")+"</L022K004>");     //  <L022K004>내외국인구분코드 [ex 01:내국인, 02:외국인]</L022K004>
			sb.append("			<L030K001>"+params.get("L030K001")+"</L030K001>");     //  <L030K001>신청자사업자등록번호 [ex 1231212345]</L030K001>
			sb.append("			<L031K001>"+params.get("L031K001")+"</L031K001>");     //  <L031K001>신청사업자등록번호 [ex 1231212345]</L031K001>
			sb.append("			<L031K002>"+params.get("L031K002")+"</L031K002>");     //  <L031K002>신청사업장관리번호 [ex 12312123450]</L031K002>
			sb.append("			<L031K003>"+params.get("L031K003")+"</L031K003>");     //  <L031K003>신청사업장명 [ex 홍길동회사]</L031K003>
			sb.append("			<L100K001>"+params.get("L100K001")+"</L100K001>");     //  <L100K001>성명 [ex 홍길동]</L100K001>
			sb.append("			<L100K002>"+params.get("L100K002")+"</L100K002>");     //  <L100K002>주민등록번호앞번호 [ex 200101]</L100K002>
			sb.append("			<L100K003>"+params.get("L100K003")+"</L100K003>");     //  <L100K003>주민등록번호뒷번호 [ex 1234567]</L100K003>
			sb.append("		</bundleInfo>");
			sb.append("		</request>");
			sb.append("	</Body>");
			sb.append("</Envelope>");
		}
		
		if(params.get("serviceId").equals("MDS0003223")) {
			sb.append("<?xml version='1.1' encoding='UTF-8'?>");
			sb.append("<Envelope>");
			sb.append("  <Header>");
			sb.append("    <commonHeader>");
			sb.append("      <apiKeyHashCode>Dk+snCMZ+NtYr2Ug06oTVMBVForKrysQYpuiB7SDH4A=</apiKeyHashCode>");
			sb.append("      <useSystemCode>B554058000000019</useSystemCode>");
			sb.append("      <serviceId>MDS0003223</serviceId>");
			sb.append("      <transactionUniqueId>2022090113555278836025609</transactionUniqueId>");
			sb.append("      <agreementYn>Y</agreementYn>");
			sb.append("      <timeStmapToken>2022090113555278896343246</timeStmapToken>");
			sb.append("    </commonHeader>");
			sb.append("  </Header>");
			sb.append("	<Body>");
			sb.append("	  <request>");
			sb.append("		<userVerifyInfo>");
			sb.append("			<userCid>JPEvjmAGTx7ti/bCnlSrOSP79YjeEuNmsLu70neV1QwvRp3Uifiy9ejGD1mpbLXGtf6GgpggvvDoIeCAJ369Pw==</userCid>");
			sb.append("			<userName>"+params.get("userName")+"</userName>");
			sb.append("			<userSexdstn>"+params.get("userSexdstn")+"</userSexdstn>");
			sb.append("			<userBrthdy>"+params.get("userBrthdy")+"</userBrthdy>");
			sb.append("			<userEmail></userEmail>");
			sb.append("			<userRrn>"+params.get("userRrn")+"</userRrn>");
			sb.append("			<userTelno>"+params.get("userTelNo")+"</userTelno>");
			sb.append("			<ntvfrnrSe>L</ntvfrnrSe>");
			sb.append("		</userVerifyInfo>");
			sb.append("		<reqstInfo>");
			sb.append("			<utlinsttCode>B554058000000019</utlinsttCode>");
			sb.append("			<bundleId>MDS0003223</bundleId>");
			sb.append("		</reqstInfo>");
			sb.append("		<bundleInfo>");
			sb.append("			<L007K001>"+params.get("L007K001")+"</L007K001>");       //<L007K001>성명 [ex 홍길동]</L007K001>
			sb.append("			<L007K002>"+params.get("L007K002")+"</L007K002>");       //<L007K002>주민등록번호앞번호 [ex 200101]</L007K002>
			sb.append("			<L007K003>"+params.get("L007K003")+"</L007K003>");     	 //<L007K003>주민등록번호뒷번호 [ex 1234567]</L007K003>
			sb.append("			<L008K001>"+params.get("L008K001")+"</L008K001>");       //<L008K001>성명 [ex 홍길동]</L008K001>
			sb.append("			<L008K002>"+params.get("L008K002")+"</L008K002>");       //<L008K002>주민등록번호앞번호 [ex 200101]</L008K002>
			sb.append("			<L008K003>"+params.get("L008K003")+"</L008K003>");       //<L008K003>주민등록번호뒷번호 [ex 1234567]</L008K003>
			sb.append("			<L008K004>"+params.get("L008K004")+"</L008K004>");       //<L008K004>조회년도 [ex 2020]</L008K004>
			sb.append("			<L008K005>"+params.get("L008K005")+"</L008K005>");       //<L008K005>업무구분 [ex 1:종합소득세 신고용 2:납부확인용 3:학교제출용 4:연말정산용]</L008K005>
			sb.append("			<L008K006>"+params.get("L008K006")+"</L008K006>");       //<L008K006>보험구분 [ex 00:건강+요양 01:건강 02:요양]</L008K006>
			sb.append("			<L010K001>"+params.get("L010K001")+"</L010K001>");       //<L010K001>성명 [ex 홍길동]</L010K001>
			sb.append("			<L010K002>"+params.get("L010K002")+"</L010K002>");       //<L010K002>주민등록번호앞번호 [ex 200101]</L010K002>
			sb.append("			<L010K003>"+params.get("L010K003")+"</L010K003>");       //<L010K003>주민등록번호뒷번호 [ex 1031613]</L010K003>
			sb.append("			<L010K004>"+params.get("L010K004")+"</L010K004>");       //<L010K004>조회년도 [ex 2020]</L010K004>
			sb.append("			<L010K005>"+params.get("L010K005")+"</L010K005>");       //<L010K005>업무구분 [ex 1:종합소득세 신고용 2:납부확인용 3:학교제출용 4:연말정산용]</L010K005>
			sb.append("			<L010K006>"+params.get("L010K006")+"</L010K006>");       //<L010K006>보험구분 [ex 00:건강+요양 01:건강 02:요양]</L010K006>


			sb.append("		</bundleInfo>");
			sb.append("		</request>");
			sb.append("	</Body>");
			sb.append("</Envelope>");
		}
		
		
		if(params.get("serviceId").equals("MDS0003210")) {
			sb.append("<?xml version='1.1' encoding='UTF-8'?>");
			sb.append("<Envelope>");
			sb.append("  <Header>");
			sb.append("    <commonHeader>");
			sb.append("      <apiKeyHashCode>Dk+snCMZ+NtYr2Ug06oTVMBVForKrysQYpuiB7SDH4A=</apiKeyHashCode>");
			sb.append("      <useSystemCode>B554058000000019</useSystemCode>");
			sb.append("      <serviceId>MDS0003210</serviceId>");
			sb.append("      <transactionUniqueId>2022090113555278836025609</transactionUniqueId>");
			sb.append("      <agreementYn>Y</agreementYn>");
			sb.append("      <timeStmapToken>2022090113555278896343246</timeStmapToken>");
			sb.append("    </commonHeader>");
			sb.append("  </Header>");
			sb.append("	<Body>");
			sb.append("	  <request>");
			sb.append("		<userVerifyInfo>");
			sb.append("			<userCid>JPEvjmAGTx7ti/bCnlSrOSP79YjeEuNmsLu70neV1QwvRp3Uifiy9ejGD1mpbLXGtf6GgpggvvDoIeCAJ369Pw==</userCid>");
			sb.append("			<userName>"+params.get("userName")+"</userName>");
			sb.append("			<userSexdstn>"+params.get("userSexdstn")+"</userSexdstn>");
			sb.append("			<userBrthdy>"+params.get("userBrthdy")+"</userBrthdy>");
			sb.append("			<userEmail></userEmail>");
			sb.append("			<userRrn>"+params.get("userRrn")+"</userRrn>");
			sb.append("			<userTelno>"+params.get("userTelNo")+"</userTelno>");
			sb.append("			<ntvfrnrSe>L</ntvfrnrSe>");
			sb.append("		</userVerifyInfo>");
			sb.append("		<reqstInfo>");
			sb.append("			<utlinsttCode>B554058000000019</utlinsttCode>");
			sb.append("			<bundleId>MDS0003210</bundleId>");
			sb.append("		</reqstInfo>");
			sb.append("		<bundleInfo>");
			sb.append("			<L015K001>"+params.get("L015K001")+"</L015K001>");       //<L015K001>주민등록번호앞번호 [ex 200101]</L015K001>
			sb.append("			<L015K002>"+params.get("L015K002")+"</L015K002>");       //  <L015K002>주민등록번호뒷번호 [ex 1234567]</L015K002>
			sb.append("			<L015K003>"+params.get("L015K003")+"</L015K003>");     	 //  <L015K003>성명 [ex 홍길동]</L015K003>
			sb.append("			<L016K001>"+params.get("L016K001")+"</L016K001>");       //  <L016K001>성명 [ex 홍길동]</L016K001>
			sb.append("			<L016K002>"+params.get("L016K002")+"</L016K002>");       //  <L016K002>주민등록번호앞번호 [ex 200101]</L016K002>
			sb.append("			<L016K003>"+params.get("L016K003")+"</L016K003>");       //  <L016K003>주민등록번호뒷번호 [ex 1234567]</L016K003>
			sb.append("			<L020K001>"+params.get("L020K001")+"</L020K001>");       //  <L020K001>보훈번호앞번호 [ex 보훈번호 미입력 시 개인별 전체 보훈번호 제공]</L020K001>
			sb.append("			<L020K002>"+params.get("L020K002")+"</L020K002>");       //  <L020K002>보훈번호뒷번호 [ex 보훈번호 미입력 시 개인별 전체 보훈번호 제공]</L020K002>
			sb.append("			<L020K003>"+params.get("L020K003")+"</L020K003>");       //  <L020K003>성명 [ex 홍길동]</L020K003>
			sb.append("			<L020K004>"+params.get("L020K004")+"</L020K004>");       //  <L020K004>주민등록번호앞번호 [ex 200101]</L020K004>
			sb.append("			<L020K005>"+params.get("L020K005")+"</L020K005>");       //  <L020K005>주민등록번호뒷번호 [ex 1234567]</L020K005>
			sb.append("		</bundleInfo>");
			sb.append("		</request>");
			sb.append("	</Body>");
			sb.append("</Envelope>");
		}
		
		
		if(params.get("serviceId").equals("MDS0003206")) {
			sb.append("<?xml version='1.1' encoding='UTF-8'?>");
			sb.append("<Envelope>");
			sb.append("  <Header>");
			sb.append("    <commonHeader>");
			sb.append("      <apiKeyHashCode>Dk+snCMZ+NtYr2Ug06oTVMBVForKrysQYpuiB7SDH4A=</apiKeyHashCode>");
			sb.append("      <useSystemCode>B554058000000019</useSystemCode>");
			sb.append("      <serviceId>MDS0003206</serviceId>");
			sb.append("      <transactionUniqueId>2022090113555278836025609</transactionUniqueId>");
			sb.append("      <agreementYn>Y</agreementYn>");
			sb.append("      <timeStmapToken>2022090113555278896343246</timeStmapToken>");
			sb.append("    </commonHeader>");
			sb.append("  </Header>");
			sb.append("	<Body>");
			sb.append("	  <request>");
			sb.append("		<userVerifyInfo>");
			sb.append("			<userCid>JPEvjmAGTx7ti/bCnlSrOSP79YjeEuNmsLu70neV1QwvRp3Uifiy9ejGD1mpbLXGtf6GgpggvvDoIeCAJ369Pw==</userCid>");
			sb.append("			<userName>"+params.get("userName")+"</userName>");
			sb.append("			<userSexdstn>"+params.get("userSexdstn")+"</userSexdstn>");
			sb.append("			<userBrthdy>"+params.get("userBrthdy")+"</userBrthdy>");
			sb.append("			<userEmail></userEmail>");
			sb.append("			<userRrn>"+params.get("userRrn")+"</userRrn>");
			sb.append("			<userTelno>"+params.get("userTelNo")+"</userTelno>");
			sb.append("			<ntvfrnrSe>L</ntvfrnrSe>");
			sb.append("		</userVerifyInfo>");
			sb.append("		<reqstInfo>");
			sb.append("			<utlinsttCode>B554058000000019</utlinsttCode>");
			sb.append("			<bundleId>MDS0003206</bundleId>");
			sb.append("		</reqstInfo>");
			sb.append("		<bundleInfo>");
			sb.append("			<L014K001>"+params.get("L014K001")+"</L014K001>");       //   <L014K001>신청자구분코드 [ex 01:개인, 02.법인]</L014K001>
			sb.append("			<L014K002>"+params.get("L014K002")+"</L014K002>");       //    <L014K002>내외국인구분코드 [ex 01:내국인, 02:외국인]</L014K002>
			sb.append("			<L014K003>"+params.get("L014K003")+"</L014K003>");     	 //    <L014K003>법인명 [ex 신청자 구분이 02:법인일 경우 필수]</L014K003>
			sb.append("			<L014K004>"+params.get("L014K004")+"</L014K004>");       //    <L014K004>성명 [ex 신청자 구분이 01:개인일 경우 필수]</L014K004>
			sb.append("			<L014K005>"+params.get("L014K005")+"</L014K005>");       //    <L014K005>주민등록번호앞번호 [ex 200101]</L014K005>
			sb.append("			<L014K006>"+params.get("L014K006")+"</L014K006>");       //    <L014K006>주민등록번호뒷번호 [ex 1031613]</L014K006>
			sb.append("			<L014K007>"+params.get("L014K007")+"</L014K007>");       //    <L014K007>법인번호앞번호 [ex 신청자 구분이 02:법인일 경우 필수]</L014K007>
			sb.append("			<L014K008>"+params.get("L014K008")+"</L014K008>");       //    <L014K008>법인번호뒷번호 [ex 신청자 구분이 02:법인일 경우 필수]</L014K008>
			sb.append("			<L014K009>"+params.get("L014K009")+"</L014K009>");       //    <L014K009>외국인등록번호 [ex 내외국인 구분이 02:외국인일 경우 등록번호 필수]</L014K009>
			sb.append("			<L014K010>"+params.get("L014K010")+"</L014K010>");       //    <L014K010>등록번호 [ex 주민13자리 or 법인 13자리 or 외국인등록번호 필수]</L014K010>
			sb.append("			<L021K001>"+params.get("L021K001")+"</L021K001>");       //    <L021K001>신청인정보사업자구분 [ex 개인, 법인]</L021K001>
			sb.append("			<L021K002>"+params.get("L021K002")+"</L021K002>");       //    <L021K002>내외국인구분코드 [ex 1:내국인, 9:외국인]</L021K002>
			sb.append("			<L021K003>"+params.get("L021K003")+"</L021K003>");       //    <L021K003>성명 [ex 홍길동]</L021K003>
			sb.append("			<L021K004>"+params.get("L021K004")+"</L021K004>");       //    <L021K004>주민등록번호번호1 [ex 사업자구분이 개인 일경우 필수]</L021K004>
			sb.append("			<L021K005>"+params.get("L021K005")+"</L021K005>");       //    <L021K005>주민등록번호번호2 [ex 사업자구분이 개인 일경우 필수]</L021K005>
			sb.append("			<L021K006>"+params.get("L021K006")+"</L021K006>");       //    <L021K006>사업자등록번호번호1 [ex 사업자구분이 법인 일경우 필수]</L021K006>
			sb.append("			<L021K007>"+params.get("L021K007")+"</L021K007>");       //    <L021K007>사업자등록번호번호2 [ex 사업자구분이 법인 일경우 필수]</L021K007>
			sb.append("			<L021K008>"+params.get("L021K008")+"</L021K008>");       //    <L021K008>사업자등록번호번호3 [ex 사업자구분이 법인 일경우 필수]</L021K008>
			sb.append("			<L021K009>"+params.get("L021K009")+"</L021K009>");       //    <L021K009>식별번호구분 [ex 0:주민등록번호, 1:개인식별자(CI), 2:사업자등록번호]</L021K009>
			sb.append("			<L021K010>"+params.get("L021K010")+"</L021K010>");       //    <L021K010>개인식별자</L021K010>
			sb.append("		</bundleInfo>");
			sb.append("		</request>");
			sb.append("	</Body>");
			sb.append("</Envelope>");
		}
		
		
		
		
		if(params.get("serviceId").equals("MDS0003194")) {
			sb.append("<?xml version='1.1' encoding='UTF-8'?>");
			sb.append("<Envelope>");
			sb.append("  <Header>");
			sb.append("    <commonHeader>");
			sb.append("      <apiKeyHashCode>Dk+snCMZ+NtYr2Ug06oTVMBVForKrysQYpuiB7SDH4A=</apiKeyHashCode>");
			sb.append("      <useSystemCode>B554058000000019</useSystemCode>");
			sb.append("      <serviceId>MDS0003194</serviceId>");
			sb.append("      <transactionUniqueId>2022090113555278836025609</transactionUniqueId>");
			sb.append("      <agreementYn>Y</agreementYn>");
			sb.append("      <timeStmapToken>2022090113555278896343246</timeStmapToken>");
			sb.append("    </commonHeader>");
			sb.append("  </Header>");
			sb.append("	<Body>");
			sb.append("	  <request>");
			sb.append("		<userVerifyInfo>");
			sb.append("			<userCid>JPEvjmAGTx7ti/bCnlSrOSP79YjeEuNmsLu70neV1QwvRp3Uifiy9ejGD1mpbLXGtf6GgpggvvDoIeCAJ369Pw==</userCid>");
			sb.append("			<userName>"+params.get("userName")+"</userName>");
			sb.append("			<userSexdstn>"+params.get("userSexdstn")+"</userSexdstn>");
			sb.append("			<userBrthdy>"+params.get("userBrthdy")+"</userBrthdy>");
			sb.append("			<userEmail></userEmail>");
			sb.append("			<userRrn>"+params.get("userRrn")+"</userRrn>");
			sb.append("			<userTelno>"+params.get("userTelNo")+"</userTelno>");
			sb.append("			<ntvfrnrSe>L</ntvfrnrSe>");
			sb.append("		</userVerifyInfo>");
			sb.append("		<reqstInfo>");
			sb.append("			<utlinsttCode>B554058000000019</utlinsttCode>");
			sb.append("			<bundleId>MDS0003194</bundleId>");
			sb.append("		</reqstInfo>");
			sb.append("		<bundleInfo>");
			sb.append("			<L023K001>"+params.get("L023K001")+"</L023K001>");       //   <L023K001>사업자등록번호앞번호 [ex 123]</L023K001>
			sb.append("			<L023K002>"+params.get("L023K002")+"</L023K002>");       //     <L023K002>사업자등록번호중간번호 [ex 12]</L023K002>
			sb.append("			<L023K003>"+params.get("L023K003")+"</L023K003>");     	 //     <L023K003>사업자등록번호뒷번호 [ex 12345]</L023K003>
			sb.append("			<L023K004>"+params.get("L023K004")+"</L023K004>");       //     <L023K004>상호 [ex 상호]</L023K004>
			sb.append("			<L023K005>"+params.get("L023K005")+"</L023K005>");       //     <L023K005>내외국인구분코드 [ex 01 : 내국인, 02:외국인]</L023K005>
			sb.append("			<L024K001>"+params.get("L024K001")+"</L024K001>");       //     <L024K001>사업자등록번호앞번호 [ex 123]</L024K001>
			sb.append("			<L024K002>"+params.get("L024K002")+"</L024K002>");       //     <L024K002>사업자등록번호중간번호 [ex 12]</L024K002>
			sb.append("			<L024K003>"+params.get("L024K003")+"</L024K003>");       //     <L024K003>사업자등록번호뒷번호 [ex 12345]</L024K003>
			sb.append("			<L024K004>"+params.get("L024K004")+"</L024K004>");       //     <L024K004>내외국인구분코드 [ex 01 : 내국인, 02:외국인]</L024K004>
			sb.append("			<L025K001>"+params.get("L025K001")+"</L025K001>");       //     <L025K001>신청사업자등록번호 [ex 1231212345]</L025K001>
			sb.append("			<L025K002>"+params.get("L025K002")+"</L025K002>");       //     <L025K002>신청개업일자 [ex 20190101]</L025K002>
			sb.append("			<L025K003>"+params.get("L025K003")+"</L025K003>");       //     <L025K003>신청과세시작년월 [ex 202001]</L025K003>
			sb.append("			<L025K004>"+params.get("L025K004")+"</L025K004>");       //     <L025K004>신청과세종료년월 [ex 202010]</L025K004>
			sb.append("			<L026K002>"+params.get("L026K002")+"</L026K002>");       //     <L026K002>신청사업자등록번호 [ex 1231212345]</L026K002>
			sb.append("			<L026K003>"+params.get("L026K003")+"</L026K003>");       //     <L026K003>신청귀속연월 [ex 201601]</L026K003>
			sb.append("			<L026K005>"+params.get("L026K005")+"</L026K005>");       //     <L026K005>신청소득구분 [ex 30:부동산임대소득, 40:사업소득]</L026K005>
			sb.append("			<L028K001>"+params.get("L028K001")+"</L028K001>");       //     <L028K001>신청사업자등록번호 [ex 12312123456]</L028K001>
			sb.append("			<L028K002>"+params.get("L028K002")+"</L028K002>");       //     <L028K002>신청개업일자 [ex 201501]</L028K002>
			sb.append("			<L028K003>"+params.get("L028K003")+"</L028K003>");       //     <L028K003>신청과세시작년월 [ex 2015]</L028K003>
			sb.append("			<L028K004>"+params.get("L028K004")+"</L028K004>");       //     <L028K004>신청과세종료년월 [ex 2019]</L028K004>
			sb.append("		</bundleInfo>");
			sb.append("		</request>");
			sb.append("	</Body>");
			sb.append("</Envelope>");
		}
		
		System.out.println(sb.toString());
		return sb.toString();
	}

}

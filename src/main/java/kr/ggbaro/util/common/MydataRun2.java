package kr.ggbaro.util.common;
import java.io.FileInputStream;
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
import go.mdds.sdk.util.CipherUtil;  
import go.mdds.sdk.util.TimeUtil;

public class MydataRun2 {

	// RestTemplate 객체 선언
	public static RestTemplate restTemplate;

	public static void main(String[] args) throws Exception {
		Map<String,Object> param = new HashMap();
		getMydata2(param);
	}
	
	//public static void main(String[] args) throws Exception {
	public static void getMydata2(Map<String,Object> param)  throws Exception {
		// URL 및 HTTP Method는 활용가이드의 [API 목록] 참조
		String url = "";
		// GET 방식 uurl 셈플 :
		String urlGet = "https://116.67.75.163/provdapis/issue"; // 개발
		
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
		//String reqXML = MydataRun2.getXmlByFile();
		String reqXML = getServiceXml(param);
		
		System.out.println("reqXML : " + reqXML);
		
		// XML 파일의 공통 헤더 항목 apiKeyHashCode 값 삽입
		reqXML = getApiKeyHashCode(reqXML, apiKey,param);
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
			String chargerName = "정지석"; // 업무담당자명
			String usePurps = "묶음정보발급"; // 사용목적
			String chargerPsitn = "묶음정보관리"; // 담장자소속
			String chargerTelno = "01024109738"; // 담당자 연락처
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
		MydataRun2.restTemplate = MydataRun2.getRestTemplate();
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
			
			
		}
		
		System.out.println("END ================");
		
	}

	/** XML 파일의 문자열 추출 */
	public static String getXmlByFile() throws Exception {
		String resusltStr = "";
		String root = System.getProperty("user.dir");
		FileInputStream fis = null;
		//fis = new FileInputStream(root + "/src/main/java/sample_1.xml");
		//fis = new FileInputStream("/home1/ncloud/secp/MDS0003181.xml");
		fis = new FileInputStream("/home1/ncloud/secp/MASTER.xml");
		resusltStr = IOUtils.toString(fis);
		resusltStr = resusltStr.replaceAll("\r", "");
		return resusltStr;
	}

	/** XML 파일의 공통 헤더 항목 apiKeyHashCode 값 삽입 */
	public static String getApiKeyHashCode(String xmlString, String apiKey, Map<String, Object> param) throws Exception {
		//xmlString = MydataRun2.getXmlByFile();
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
		if (MydataRun2.restTemplate != null) {
			return MydataRun2.restTemplate;
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
		 MydataRun2.restTemplate = new RestTemplate(requestFactory);
		 
		 return MydataRun2.restTemplate;
	}
	
	
	public static String getServiceXml(Map<String,Object> params) throws Exception {
		
		StringBuffer sb      =  new StringBuffer();
		
		
			sb.append("<?xml version='1.1' encoding='UTF-8'?>");
			sb.append("<Envelope>");
			sb.append("  <Header>");
			sb.append("    <commonHeader>");
			sb.append("      <apiKeyHashCode>Dk+snCMZ+NtYr2Ug06oTVMBVForKrysQYpuiB7SDH4A=</apiKeyHashCode>");
			sb.append("      <useSystemCode>B554058000000019</useSystemCode>");
			sb.append("      <serviceId>"+params.get("serviceId")+"</serviceId>");
			sb.append("      <transactionUniqueId>2022090113555278836025609</transactionUniqueId>");
			sb.append("      <agreementYn>Y</agreementYn>");
			sb.append("      <timeStmapToken>2022090113555278896343246</timeStmapToken>");
			sb.append("    </commonHeader>");
			sb.append("  </Header>");
			sb.append("  <Body>");
			sb.append("  	<request>");
			sb.append("		<utlinsttCode>B554058000000019</utlinsttCode>");
			sb.append("		<delngSeqno>"+params.get("seqNo")+"</delngSeqno>");
			sb.append("		<chargerName>정지석</chargerName>");
			sb.append("		<chargerId></chargerId>");
			sb.append("		<chargerPsitn>묶음정보관리</chargerPsitn>");
			sb.append("		<chargerTelno>01024109738</chargerTelno>");
			sb.append("		<usePurps>묶음정보 발급</usePurps>");
			sb.append("	</request>");
			sb.append("</Body>");
			sb.append("</Envelope>");
		
		System.out.println(sb.toString());
		return sb.toString();
	}

}

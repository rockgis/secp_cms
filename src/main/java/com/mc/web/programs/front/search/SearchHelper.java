package com.mc.web.programs.front.search;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.junit.Test;
import org.springframework.stereotype.Service;

import com.twitter.penguin.korean.TwitterKoreanProcessorJava;
import com.twitter.penguin.korean.phrase_extractor.KoreanPhraseExtractor;
import com.twitter.penguin.korean.phrase_extractor.KoreanPhraseExtractor.KoreanPhrase;
import com.twitter.penguin.korean.tokenizer.KoreanTokenizer;

import egovframework.com.cmm.util.EgovHttpRequestHelper;
import scala.collection.Seq;

/**
 * 
 * @Description : 
 * @ClassName   : com.mc.web.search.SearchHelper.java
 * @author 이창기
 * @since 2016. 3. 9.
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
public class SearchHelper {
	Logger logger = Logger.getLogger(this.getClass());

	public void keywordSet(Map params) {
		HttpServletRequest request = EgovHttpRequestHelper.getCurrentRequest();
		List list = new ArrayList();
		if("Y".equals(params.get("in_keyword_yn"))){
			String keyword = (String) params.get("in_keyword");
			keyword = keyword.replaceAll("\t+|  +", " ");
			List<String> keyword_list = keywordList(keyword);
			params.put("keyword_list", keyword_list);
			
			keyword = (String) params.get("total_keyword");
			keyword = keyword.replaceAll("\t+|  +", " ");
			List<String> in_keyword_list = keywordList(keyword);
			params.put("in_keyword_list", in_keyword_list);
			list.addAll(keyword_list);
			list.addAll(in_keyword_list);
			request.setAttribute("in_keyword", params.get("in_keyword"));
		}else{
			String keyword = (String) params.get("total_keyword");
			keyword = keyword.replaceAll("\t+|  +", " ");
			List<String> keyword_list = keywordList(keyword);
			params.put("keyword_list", keyword_list);
			list.addAll(keyword_list);			
			request.setAttribute("in_keyword", params.get("total_keyword"));
		}
		
		request.setAttribute("hilight_list", new ArrayList<String>(new HashSet<String>(list)));
	}

	public List<String> keywordList(String keyword){
		// Normalize
	    CharSequence normalized = TwitterKoreanProcessorJava.normalize(keyword);
	    Seq<KoreanTokenizer.KoreanToken> tokens = TwitterKoreanProcessorJava.tokenize(normalized);
	    // Phrase extraction
	    List<KoreanPhraseExtractor.KoreanPhrase> phrases = TwitterKoreanProcessorJava.extractPhrases(tokens, true, true);
	    List<String> returnList = new ArrayList<String>();
	    if(phrases.size() < 1){
	    	returnList.add(keyword);
	    }else{
		    for(KoreanPhrase v : phrases){
		    	returnList.add(v.text());
		    	//System.out.println(v.text()+":"+v.pos().toString());
		    }	    	
	    }
	    return returnList;
	}

	public void putCookie(HttpServletResponse response, String keyword, String cookie_str) {
		cookie_str = cookie_str.replaceAll(keyword.concat(";"), "");
		cookie_str = keyword+";"+cookie_str;
		try {
			cookie_str = URLEncoder.encode(cookie_str, "utf-8");
			cookie_str = cookie_str.replaceAll("\r", "").replaceAll("\n", "");
			Cookie cookie = new Cookie("searchkeyword", cookie_str);
			cookie.setPath("/");
			cookie.setMaxAge(60*60*24*15);
			response.addCookie(cookie);
		} catch (UnsupportedEncodingException e) {
		}
	}
	
	@Test
	public void test(){
		String text = "한국어를 처리하는 예시입d니닼ㅋㅋㅋㅋㅋ #한국어";
	    // Normalize
	    CharSequence normalized = TwitterKoreanProcessorJava.normalize(text);
	    System.out.println(normalized);
	    // 한국어를 처리하는 예시입니다ㅋㅋ #한국어

	    // Tokenize
	    Seq<KoreanTokenizer.KoreanToken> tokens = TwitterKoreanProcessorJava.tokenize(normalized);
	    System.out.println(TwitterKoreanProcessorJava.tokensToJavaStringList(tokens));
	    // [한국어, 를, 처리, 하는, 예시, 입니, 다, ㅋㅋ, #한국어]
	    System.out.println(TwitterKoreanProcessorJava.tokensToJavaKoreanTokenList(tokens));
	    // [한국어(Noun: 0, 3), 를(Josa: 3, 1),  (Space: 4, 1), 처리(Noun: 5, 2), 하는(Verb: 7, 2),  (Space: 9, 1), 예시(Noun: 10, 2), 입니(Adjective: 12, 2), 다(Eomi: 14, 1), ㅋㅋ(KoreanParticle: 15, 2),  (Space: 17, 1), #한국어(Hashtag: 18, 4)]

	    // Stemming
	    Seq<KoreanTokenizer.KoreanToken> stemmed = TwitterKoreanProcessorJava.stem(tokens);
	    System.out.println(TwitterKoreanProcessorJava.tokensToJavaStringList(stemmed));
	    // [한국어, 를, 처리, 하다, 예시, 이다, ㅋㅋ, #한국어]
	    System.out.println(TwitterKoreanProcessorJava.tokensToJavaKoreanTokenList(stemmed));
	    // [한국어(Noun: 0, 3), 를(Josa: 3, 1),  (Space: 4, 1), 처리(Noun: 5, 2), 하다(Verb: 7, 2),  (Space: 9, 1), 예시(Noun: 10, 2), 이다(Adjective: 12, 3), ㅋㅋ(KoreanParticle: 15, 2),  (Space: 17, 1), #한국어(Hashtag: 18, 4)]

	    // Phrase extraction
	    List<KoreanPhraseExtractor.KoreanPhrase> phrases = TwitterKoreanProcessorJava.extractPhrases(tokens, true, true);
	    System.out.println(phrases);
	    // [한국어(Noun: 0, 3), 처리(Noun: 5, 2), 처리하는 예시(Noun: 5, 7), 예시(Noun: 10, 2), #한국어(Hashtag: 18, 4)]	
	    
	    
	    List<String> returnList = new ArrayList<String>();
	    returnList.add(normalized.toString());
    	System.out.println(returnList.get(0));
	    for(KoreanPhrase v : phrases){
	    	returnList.add(v.text());
	    	System.out.println(v.text()+":"+v.pos().toString());
	    }
	}

	
}
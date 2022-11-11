(function($){
	var pgwBrowser;
	try{
		if(location.href.indexOf("#currentview")>0)
			return;
		pgwBrowser = $.pgwBrowser();
		var params = {
				url:location.href
				,title : $("title").text()
				,query_string : location.search
				,referer : document.referrer
				,browser : pgwBrowser.browser.name
				,os : pgwBrowser.os.name
				,site_id : $("meta[name='SiteID']").attr("content")
			};
		/*alert(
			"url : " + params.url + "\n" + 
			"title : " + $("title").text() +  
			"query_string : " + location.search + "\n" + 
			"referer : " + document.referrer + "\n" + 
			"browser : " + pgwBrowser.browser.name + "\n" + 
			"os : " + pgwBrowser.os.name + "\n" + 
			"site_id : " + $("meta[name='SiteID']").attr("content") 
		);*/
		$.ajax("/analytics/history.do", {
			type : 'POST',
			data : params
		});	
	}catch(e){}
	
})(jQuery);
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>Insert title here</title>
<script type="text/javascript" src="/lib/js/jquery-3.5.1.min.js"></script>
<script type="text/javascript" src="/lib/js/jquery-migrate-1.4.1.min.js"></script>
<script type="text/javascript" src="/lib/js/sockjs.min.js"></script>
<script type="text/javascript" src="/lib/js/stomp.min.js"></script>
<script type="text/javascript">
var stompClient = null;
var ws = new SockJS("/websock",null, {protocols_whitelist : ['websocket','xhr-streaming','xdr-streaming','eventsource','iframe-eventsource','htmlfile', 'xhr-polling', 'xdr-polling', 'iframe-xhr-polling', 'jsonp-polling']});
stompClient = Stomp.over(ws);
stompClient.connect({}, function(frame){
    stompClient.subscribe("/topic/echo", function(data){
    	var item = $.parseJSON(data.body);
    	var sflag = false;
    	var el = $("#chat_conts")[0]; 
    	if($("#chat_conts").innerHeight()+el.scrollTop == el.scrollHeight){
    		sflag = true;
    	} 
    	$("#chat_conts").append("<p>"+item.name+":"+item.msg+"</p>");
    	if(sflag){
    		el.scrollTop = el.scrollHeight;
    	}
    });
});

var send = function() {
    if (ws != null) {
        var name = $("#name").val();
        var msg = $("#msg").val();
        if (msg.length > 0) {
            stompClient.send('/topic/echo', {}, JSON.stringify({name: name, msg: msg}));
            $("#msg").val("");
        }
    } else {
        alert('연결되어 있지 않음.');
    }
}

var closeConnect = function() {
    if (stompClient != null) {
        stompClient.disconnect(function(){
            ws = null;
        });
    } else {
        alert('연결되어 있지 않음.');
    }
}
$(function(){
	$("#msg").on("keyup", function(e){
		if(e.keyCode==13){
			send();
		}
	});
});
</script>
</head>
<body>
	<table class="write_style_1">
		<colgroup>
			<col style="width:120px;">
			<col style="width:100%;">
			<col style="width:80px;">
			<col style="width:80px;">
		</colgroup>
		<tbody>
			<tr>
				<td colspan="4"><div id="chat_conts" style="overflow: auto; padding:5px;width:100%;height:200px;border: 1px solid #eee"></div></td>
			</tr>
			<tr>
				<td><input type="text" id="name" value="사용자"></td>
				<td><input type="text" id="msg"></td>
				<td><input type="button" value="보내기" onclick="send();"></td>
				<td><input type="button" value="접속끊기" onclick="closeConnect();"></td>
			</tr>
		</tbody>
	</table>
</body>
</html>

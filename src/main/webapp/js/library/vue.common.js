Vue.prototype.$ajaxPost = function(url, json) {
    var deferred = $.Deferred();
    var token = $("meta[name='_csrf']").attr("content");
    var header = $("meta[name='_csrf_header']").attr("content");
    $.ajax({
        method: "POST",
        contentType: "application/json",
        url: url,
        data: JSON.stringify(json),
        beforeSend: function (xhr) {
            xhr.setRequestHeader(header, token)
        },
        success: function (data) {
            deferred.resolve(data);
        },
        error: function (error) {
            deferred.reject(error);
        }
    });
    return deferred.promise();
};
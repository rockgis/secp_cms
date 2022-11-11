/*!
 * Pretty Date v0.1.0
 * https://github.com/fengyuanchen/prettydate
 *
 * Copyright 2014 Fengyuan Chen
 * Released under the MIT license
 */

 (function (factory) {
    if (typeof define === "function" && define.amd) {
        // AMD. Register as anonymous module.
        define(["jquery"], factory);
    } else {
        // Browser globals.
        factory(jQuery);
    }
})(function ($) {

    "use strict";

    $.fn.prettydate.setDefaults({
        afterSuffix: "후",
        beforeSuffix: "전",
        dateFormat: "YYYY-MM-DD hh:mm:ss",
        messages: {
            second: "방금",
            seconds: "%s초%s",
            minute: "1분%s",
            minutes: "%s분%s",
            hour: "1시간%s",
            hours: "%s시간%s",
            day: "하루%s",
            days: "%s일%s",
            week: "일주일%s",
            weeks: "%s주%s",
            month: "한달%s",
            months: "%s달%s",
            year: "일년%s",
            years: "%s년%s",
            yesterday: "어제",
            beforeYesterday: "그저께",
            tomorrow: "내일",
            afterTomorrow: "모레"
        }
    });
});

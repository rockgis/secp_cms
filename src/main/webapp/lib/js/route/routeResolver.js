/**
 * 공용 라우터
 */
(function(ang, $){
    var servicesApp = angular.module('routeResolverServices', []);
    var routeResolver = function () {

        this.$get = function () {
            return this;
        };

        this.routeConfig = function () {
            var viewsDirectory = '/super/homepage/views/',
                controllersDirectory = '/super/homepage/controllers/',

            setBaseDirectories = function (viewsDir, controllersDir) {
                viewsDirectory = viewsDir;
                controllersDirectory = controllersDir;
            },

            getViewsDirectory = function () {
                return "/st_exclude"+viewsDirectory;
            },

            getControllersDirectory = function () {
                return "/st_exclude"+controllersDirectory;
            };

            return {
                setBaseDirectories: setBaseDirectories,
                getControllersDirectory: getControllersDirectory,
                getViewsDirectory: getViewsDirectory
            };
        }();

        this.route = function (routeConfig) {

            var resolve = function (baseName, secure) {
                var routeDef = {};
                routeDef.templateUrl = function(param){
                	return routeConfig.getViewsDirectory()+"/"+baseName+'.do';
                };
                routeDef.controller = baseName+'Ctrl';
                routeDef.secure = (secure) ? secure : false;
                routeDef.resolve = {
                    load: ['$q', '$rootScope', function ($q, $rootScope) {
                        var dependencies = [routeConfig.getControllersDirectory()+"/"+baseName+'Ctrl.do'];
                        return resolveDependencies($q, $rootScope, dependencies);
                    }]
                };
                return routeDef;
            },
            resolveDependencies = function ($q, $rootScope, dependencies) {
                var defer = $q.defer();
                require(dependencies, function () {
                    defer.resolve();
                    $rootScope.$apply()
                });

                return defer.promise;
            };

            return {
                resolve: resolve
            }
        }(this.routeConfig);

    };

    //Must be a provider since it will be injected into module.config()    
    servicesApp.provider('routeResolver', routeResolver);
	
})(angular, jQuery=(typeof window.jQuery=='undefined'?(function(){alert("jQuery 를 import 하세요."); return "";})():jQuery));
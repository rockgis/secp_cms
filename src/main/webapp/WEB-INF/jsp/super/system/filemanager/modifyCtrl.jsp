<%@ page language="java" contentType="text/javascript; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
app.register.controller("modifyCtrl", function($rootScope, $scope, $timeout, $window, $routeParams, $location, ajaxService, dialogService) {
	ajaxService.getJSON("/super/system/filemanager/list.do", {path:"/"}, function(data){
		$scope.current_path = "/";
		var $treeview = $('#filetree').jstree({
			'core' : {
				'data' : data.list,
				"check_callback" : true
			},
			//"plugins" : ["contextmenu"],
			"contextmenu": {
	            "items": function ($node) {
	            	var tree = $("#filetree").jstree(true);
	                return {
	                    "Create": {
	                        "label": "폴더생성",
	                        "action": function (data) {
	                        console.log(data.reference);
	                       		node = tree.create_node($node, {"icon":"/images/super/folder.png", "path":$node.original.path});
                    			tree.edit(node, null, function(o){
                    				ajaxService.getJSON("/super/system/filemanager/createFolder.do", {path : o.original.path+"/"+o.text}, function(data){
										if(data.rst=="1"){
											var obj = tree.get_node(node);
											obj.original.path = obj.original.path+"/"+obj.text;
										}else{
											alert("실패");
										}
									});
                    			});
	                        }
	                    },
	                    "Rename": {
	                        "label": "이름변경",
	                        "action": function (data) {
	                        	var inst = $.jstree.reference(data.reference),
                                obj = inst.get_node(data.reference);
	                        	var old = obj.text;
                    			inst.edit(obj, null, function(o){
                    				var $parent = tree.get_node(inst.get_parent(data.reference));
                    				ajaxService.getJSON("/super/system/filemanager/renameTo.do", {old : old, new : o.text, dir: $parent.original.path}, function(data){
										if(data.rst=="1"){
											obj.original.path = $parent.original.path+"/"+o.text;
										}else{
											alert("실패");
										}
									});
                    			});
	                        }
	                    },
	                    "Delete": {
	                        "label": "삭제",
	                        "action": function (data) {
	                        	var ref = $.jstree.reference(data.reference),
	                        		obj = ref.get_node(data.reference),
                                    sel = ref.get_selected();
                                if(!sel.length) { return false; }
                                if(obj.original.path=="" || obj.original.path==null){
                                	return false;
                                }
		                        if(!confirm("하위폴더 포함 모두삭제 됩니다. 삭제하시겠습니까?")){
		                        	return false;
		                        }
		                        if(!confirm("정말 삭제하시겠습니까?")){
		                        	return false;
		                        }
                                ajaxService.getJSON("/super/system/filemanager/delete.do", {path : obj.original.path}, function(data){
									if(data.rst=="1"){
                                		ref.delete_node(sel);
									}else{
										alert("실패");
									}
								});
	                        }
	                    }
	                }
	            }
	        }
		}).on("loaded.jstree", function(){
            $treeview.jstree("open_node", '.jstree-anchor:first');
            $treeview.jstree("select_node", '.jstree-anchor:first');
        }).on('changed.jstree', function (e, data) {
	        if(data.action=="select_node"){
		      	$scope.getFileList(data.node.original.path);
	        }
		});
	});
	
	$scope.getFileList = function(path){
       	if(path=="" || path==null){
       		path="/";
       	}
       	$scope.current_path = path;
		ajaxService.getJSON("/super/system/filemanager/filelist.do", {path: path}, function(data){
			$scope.file_list = data.list;
      	});
	}
	
	$scope.openFileModify = function(path){
		var options = {
			autoOpen: false,
			modal: true,
			width: "1000",
			height: "569",
			close: function(event, ui) {}
		};
			
		dialogService.open("FileModifyDialog","FileModify.html", {file_path : path}, options).then(
			function(result) {
			},
			function(error) {}
		);
	}
	
	$scope.openUploadForm = function(){
		var options = {
			autoOpen: false,
			modal: true,
			width: "400",
			height: "350",
			close: function(event, ui) {}
		};
			
		dialogService.open("UploadFormDialog","UploadForm.html", {path : $scope.current_path}, options).then(
			function(result) {
				if(result.rst=="1"){
					$scope.getFileList($scope.current_path);
				}
			},
			function(error) {}
		);
	}
});

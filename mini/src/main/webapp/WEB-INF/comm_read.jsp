<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<jsp:include page="/defult/def.jsp"></jsp:include>
	<title>커뮤니티 게시판</title>
</head>
<style>
	.card1{
		width: 50%;
		margin: auto;
		padding: 20px 0 20px 0;
	}
	.card2{
		position: relative; 
		display: flex; 
		flex-direction: column; 
		min-width: 0; 
		word-wrap: break-word; 
		background-clip: border-box;
    	border: 1px solid rgba(0, 0, 0, 0.125); 
    	border-radius: 0.25rem; 
    	margin-bottom: 10px;
    }
    .card-header{
    	padding: 0.75rem 1.25rem; 
    	margin-bottom: 0; 
    	background-color: rgba(0, 0, 0, 0.03); 
    	border-bottom: 1px solid rgba(0, 0, 0, 0.125);
    }
    .btns {
		text-align: right;
		margin-right: 5px;
	}
</style>
<body>
	<div id="app">
		<div class="container">
			<div class="card1">
				<div class="card2">
					<h3 class="card-header">
						{{info.ctitle}}
						<span class="badge badge-pill badge-dark pull-right" style="float: right;">{{info.cdate}}</span>
					</h3>
					<div class="card-body">
					   	<div style="margin: 10px 10px 10px 10px;">
					   		<pre>{{info.ccont}}</pre>
					   	</div>
				   	</div>
				</div>
				<div class="btns">
					<button v-if="info.id == sessionId || sessionAdminflg == 'Y'" @click="fnUpdate()" >수정</button>
					<button v-if="info.id == sessionId || sessionAdminflg == 'Y'" @click="fnRemoveBoard()" >삭제</button>
					<button target="_blank" @click="fnReportBoard()" >신고</button>
					<button @click="fnList()" class="btn" >목록으로</button>
				</div>
				
				<h4 style="margin-top : 30px;">댓글</h4>
				<div style="clear : both; border-top : 1px solid #000"></div>
				
				<div style="margin-top : 10px;">
					<div style="margin-bottom : 10px;">
						<span>첨부파일</span>
						<input type="file" id="file1" name="file1" >
					</div>
						<textarea v-model="comment" rows="3" cols="100" style="width : 90%; resize: none;"></textarea>
						<button @click="fnComment()" class="btn">등록</button>
						<div style="text-align: right"><input type="checkbox" value="">비밀댓글 설정</div>
				</div>
				
				<div v-for="(item, index) in commentList" style="font-size : 1em; margin : 10px;">
					<div v-if="item.delYn == 'N'">
						<span>
							{{item.id}}({{item.cdate}}) : <pre>{{item.content}}</pre> 
							<button v-if="info.id == sessionId || sessionAdminflg == 'Y'" @click="fnEditComment(item)" style="float: right;">수정</button>
							<button v-if="info.id == sessionId || sessionAdminflg == 'Y'" @click="fnRemoveComment(item)" style="float: right;">삭제</button>
							<button v-else target="_blank" @click="fnReportComment()" style="float: right;">신고</button>
						</span>
						<span v-if="item.delYn == 'Y'">
						삭제된 댓글 입니다.
						</span>
					</div>
					<div v-if="cInfo.commentNo == item.commentNo" style="margin-top : 10px;">
						<textarea v-model="comment" rows="3" cols="100" style="width : 90%; resize: none;"></textarea>
						<button @click="" class="btn" style="margin-bottom : 30px;">수정</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>

<script type="text/javascript">
var app = new Vue({ 
    el: '#app',
    data: {
       list : [] 
       , info : {}
       , cbno : "${map.cbno}"
       , sessionId : "${sessionId}"
       , sessionAdminflg : "${sessionAdminflg}"
 	   , comment : ""
 	   , commentList : []
 	   , cInfo : {}
    }   
    , methods: {
    	fnGetBoard : function(){
            var self = this;
            var nparmap = {cbno : self.cbno};
            $.ajax({
                url:"/comm/read.dox",
                dataType:"json",	
                type : "POST", 
                data : nparmap,
                success : function(data) {
                	console.log(data);
	                self.info = data.info;
	                /*self.commentList = data.commentList;*/
                }
            }); 
        }

    	, fnUpdate : function(){
    		var self = this;
    		self.pageChange("/commedit.do", {cbno : self.cbno});
    	}
    	
    	, pageChange : function(url, param) {
    		var target = "_self";
    		if(param == undefined){
    		//	this.linkCall(url);
    			return;
    		}
    		var form = document.createElement("form"); 
    		form.name = "dataform";
    		form.action = url;
    		form.method = "post";
    		form.target = target;
    		for(var name in param){
				var item = name;
				var val = "";
				if(param[name] instanceof Object){
					val = JSON.stringify(param[name]);
				} else {
					val = param[name];
				}
				var input = document.createElement("input");
	    		input.type = "hidden";
	    		input.name = item;
	    		input.value = val;
	    		form.insertBefore(input, null);
			}
    		document.body.appendChild(form);
    		form.submit();
    		document.body.removeChild(form);
    	}
    	
        //게시글 목록 이동
    	, fnList : function(){
    		location.href="/comm.do";
    	}
    	
    	//게시글 신고 팝업
    	, fnReportBoard : function() {
    		let popUrl = "/reportboard.do";
    		let popOption = "width = 650px, height=550px, top=300px, left=300px, scrollbars=yes";
    		window.open(popUrl,"게시글 신고",popOption);	
    	}
    	
    	//댓글 신고 팝업
    	, fnReportComment : function() {
    		let popUrl = "/reportcomment.do";
    		let popOption = "width = 650px, height=550px, top=300px, left=300px, scrollbars=yes";
    		window.open(popUrl,"댓글 신고",popOption);	
    	}
    	
    	
    	/*
    	, fnComment : function(){
    		var self = this;
            var nparmap = {cbno : self.cbno, comment : self.comment, id : self.id};
            $.ajax({
                url:"/comm/comment.dox",
                dataType:"json",	
                type : "POST", 
                data : nparmap,
                success : function(data) {
                	self.comment = "";
	                alert("성공");
	                self.fnGetBoard();
                }
            }); 
    	}
    	
    	, fnRemoveComment : function(item){
    		var self = this;
            var nparmap = item;
            $.ajax({
                url:"/comment/remove.dox",
                dataType:"json",	
                type : "POST", 
                data : nparmap,
                success : function(data) {
	                alert("성공");
	                self.fnGetBoard();
                }
            }); 
    	}
    	
    	, fnEditComment : function(){
    		var self = this;
            var nparmap = self.cInfo;
            $.ajax({
                url:"/comment/edit.dox",
                dataType:"json",	
                type : "POST", 
                data : nparmap,
                success : function(data) {
	                alert("성공");
	                self.cInfo = {};
	                self.fnGetBoard();
                }
            }); 
    	} 
    	
    	, fnEdit : function(item){
    		var self = this;
    		self.cInfo = item;
    	}
    	*/
    	
    }   
    , created: function () {
    	var self = this;
    	self.fnGetBoard();
	}
});
</script>
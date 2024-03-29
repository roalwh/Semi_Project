<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<jsp:include page="/defult/def.jsp"></jsp:include>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/vue/2.5.3/vue.min.js"></script>
	<script src="https://unpkg.com/vue2-editor@2.3.11/dist/index.js"></script>
	<title>커뮤니티 글 수정</title>
</head>
<style>
	.card{
		width: 1080px;
		margin: 1px auto;
	}
	.board_title {
		padding-left: 20px;
		margin-bottom: 20px;
	}
    #cate{
        margin: 5px;
        width: 20%;
    }
	.btns {
		padding: 15px 0;
		text-align: right;
		margin-right: 5px;
	}
	select {
		padding: 3px;
		width: 30%;
		appearance: none;
	}
	input {
		padding: 3px;
		width: 70%;
	}
</style>
<body>
	<div id="app">
		<div class="container">
			<div class="card">
				<h3 class="board_title">커뮤니티 글 수정</h3>
				<table class="board_detail">
					<colgroup>
						<col width="10%"/>
						<col width="*"/>
					</colgroup>
					<tr>  
						<select v-model="info.cate1" id="cate" disabled>
							<option v-for="(cate1, index) in listcate" :value="cate1.cnum" >{{cate1.cinfo}}</option>
						</select>
						
						<select v-model="info.cate2" id="cate" disabled>
							<option v-for="(cate2, index) in listcate" :value="cate2.cnum">{{cate2.cinfo}}</option>
						</select>
					</tr>
					
					
					<tr>
						<td style="text-align : center;" >제목</td>
						<td><input type="text" id="ctitle" name="ctitle" v-model="info.ctitle"></td>
					</tr>
					<tr>
						<td style="text-align : center;" >첨부파일</td>
						<td>
							<div>
							    <input type="file" id="file1" name="file1" > 
							</div>
						</td>
					</tr>
					<tr>
						<td colspan="2">
						  <vue-editor v-model="info.ccont"></vue-editor> 
						</td>
					</tr>
				</table>
				<div class="btns">
					<button @click="fnEditCbrd()" class="btn">저장</button>
					<button @click="fnList()" class="btn" >목록으로</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>

<script type="text/javascript">
console.log(Vue);
Vue.use(Vue2Editor);
const VueEditor = Vue2Editor.VueEditor;
var app = new Vue({ 
    el: '#app',
    data: {
		info : {}, 
		cbno : "${map.cbno}",
		listcate : {}
				
    }
    
    , components: {VueEditor}
    
    , methods: {
    	//게시글 수정
    	fnEditCbrd : function(){
            var self = this;
            var nparmap = {ctitle : self.info.ctitle
            				, ccont : self.info.ccont
            				, cate1 : self.info.cate1
            				, cate2 : self.info.cate2           				
            				, cbno : self.info.cbno};
            /* var nparmap = self.info;
            nparmap.cbno = self.cbno; */
            $.ajax({
                url:"/comm/edit.dox",
                dataType:"json",	
                type : "POST", 
                data : nparmap,
                success : function(data) { 
                	console.log(data);
                	alert("저장되었습니다.");
                	location.href="comm.do";
                }
            }); 
        }
    	
	    , fnGetBoard : function(){
	        var self = this;
	        var nparmap = {cbno : self.cbno};
	        $.ajax({
	            url:"/comm/read.dox",
	            dataType:"json",	
	            type : "POST", 
	            data : nparmap,
	            success : function(data) {
	                self.info = data.info;
	                console.log(self.info);
	            }
	        }); 
	    }
    	
    	// 파일 업로드
	    , upload : function(){
			var form = new FormData();
	        form.append( "file1", $("#file1")[0].files[0] );
	        
	         $.ajax({
	             url : "/upload.do"
	           , type : "POST"
	           , processData : false
	           , contentType : false
	           , data : form
	           , success:function(response) { 
	        	   
	           }
	           
	       });
		}
    	
    	// 목록으로 이동
    	, fnList : function(){
    		var result = confirm("작성을 취소하고 목록으로 돌아가시겠습니까?");
    		
    		if(result) {
    			location.href="/comm.do";
    		}
    	}

    	
    	, cateList : function(){
			var self = this;
			var nparmap = {};
			$.ajax({
				url:"/comm/cate.dox", 
				dataType:"json",	
				type : "POST", 
				data : nparmap,
				success : function(data) { 
					console.log(data);
					self.listcate = data.listcate;
				}
			});
    	}
    	

		
    	
    	
    }   
    , created: function () {
    	var self = this;
    	self.fnGetBoard();
    	self.cateList();
	}
});
</script>
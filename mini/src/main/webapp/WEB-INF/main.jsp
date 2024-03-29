<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<jsp:include page="/defult/def.jsp"></jsp:include>
	<link rel="stylesheet" href="css/main.css">
	<script src="https://ssense.github.io/vue-carousel/js/vue-carousel.min.js"></script>
	<title>메인</title>
</head>
<style>
	
</style>
<body>
	<div id="app">
		<carousel :per-page="1" :autoplay="true" :loop="true">
            <slide>
                <a class="label" href="javascript:;"><div style="background-image : url('../assets/banner/11729.jpg')" alt="banner1"></div></a>
            </slide>
            <slide>
                <a class="label" href="javascript:;"><div style="background-image : url('../assets/banner/11730.jpg')" alt="banner2"></div></a>
           	</slide>
            <slide>
                <a class="label" href="javascript:;"><div style="background-image : url('../assets/banner/11732.jpg')" alt="banner3"></div></a>
            </slide>
        </carousel>
        <div id="container">
            <a><h2>상품거래 카테고리</h2></a>
            <div id="sellCategory">
                <div class="sellCateList">
                    <a @click="fnCateSelect(1, 'SPO', '스포츠')" href="javascript:;">
	                    <div>
	                    	<img src="img/main/sport.jpg" alt="cate1">
	                    </div>
	                    <p>스포츠</p>
                    </a>
                </div>
                <div class="sellCateList">
                    <a @click="fnCateSelect(1, 'CEL', '연예인')" href="javascript:;">
	                    <div>
	                    	<img src="img/main/talent.jpg" alt="cate1">
	                    </div>
	                    <p>연예인</p>
                    </a>
                </div>
                <div class="sellCateList">
                    <a @click="fnCateSelect(1, 'MOV', '영화')" href="javascript:;">
	                    <div>
	                    	<img src="img/main/movie.jpg" alt="cate1">
	                    </div>
	                    <p>영화</p>
                    </a>
                </div>
                <div class="sellCateList">
                    <a @click="fnCateSelect(1, 'ANI', '애니메이션')" href="javascript:;">
	                    <div>
	                    	<img src="img/main/anime.jpg" alt="cate1">
	                    </div>
	                    <p>애니메이션</p>
                    </a>
                </div>
                <div class="sellCateList">
                    <a @click="fnCateSelect(1, 'GAM', '게임')" href="javascript:;">
	                    <div>
	                    	<img src="img/main/game.jpg" alt="cate1">
	                    </div>
	                    <p>게임</p>
                    </a>
                </div>
                
            </div>
            <a><h2>오늘의 팔아요</h2></a>
            <div id="sellRc">
                <div v-for="item in sellRcmd" @click="fnView(item.tbNo)" class="itembox">
                	<a href="javascript:;">
                		<div class="imgbox">
                			<img :src="item.path" alt="itemImg">
                		</div>
	                    <p>{{item.bTitle}}</p>
	                    <p>가격 : {{item.bPrice}}원</p>
	                    <p>찜 : {{item.likes}}</p>
                	</a>
                </div>
            </div>
            <a><h2>오늘의 구해요</h2></a>
            <div id="buyRc">
                <div v-for="item in buyRcmd" @click="fnView(item.tbNo)" class="itembox">
                    <a href="javascript:;">
	                	<div class="imgbox">
                			<img :src="item.path" alt="itemImg">
                		</div>
	                    <p>{{item.bTitle}}</p>
	                    <p>가격 : {{item.bPrice}}원</p>
	                    <p>찜 : {{item.likes}}</p>
                	</a>
                </div>
            </div>
            <a><h2>의뢰 카테고리</h2></a>
            <div id="commCategory">
                <div class="commCateList">
                    <a @click="fnCateSelect(2, 'BM1', '조립')" href="javascript:;">
	                    <img src="img/main/plamodel.jpg" alt="cate1">
	                    <p>조립</p>
                    </a>
                </div>
                <div class="commCateList">
                    <a @click="fnCateSelect(2, 'BM2', '도색')" href="javascript:;">
	                    <img src="img/main/paint.jpg" alt="cate1">
	                    <p>도색</p>
                    </a>
                </div>
                <div class="commCateList">
                    <a @click="fnCateSelect(2, 'BM3', '수리')" href="javascript:;">
	                    <img src="img/main/rapair.jpg" alt="cate1">
	                    <p>수리</p>
                    </a>
                </div>
                <div class="commCateList">
                   <a @click="fnCateSelect(2, 'BM4', '커미션')" href="javascript:;">
	                   <img src="img/board/160628_7.png" alt="cate1">
	                   <p>커미션</p>
                   </a>
                </div>
            </div>
            <a><h2>오늘의 의뢰</h2></a>
            <div id="commRc">
                <div v-for="item in commRcmd" @click="fnView(item.tbNo)" class="itembox">
                    <a href="javascript:;">
	                	<div class="imgbox">
                			<img :src="item.path" alt="itemImg">
                		</div>
	                    <p>{{item.bTitle}}</p>
	                    <p>가격 : {{item.bPrice}}원</p>
	                    <p>찜 : {{item.likes}}</p>
                	</a>
                </div>
            </div>
        </div>
	</div>
</body>
</html>
<script>
	var app = new Vue({ 
	    el: '#app',
	    data: {
	    	rcm : [],
	    	sellRcmd : [],
	    	buyRcmd : [],
	    	commRcmd : []
	    }   
		, components : {
			'carousel' : VueCarousel.Carousel,
			'slide' : VueCarousel.Slide
		}
	    , methods: {
	    	fnGetList : function(){
	            var self = this;
	            var nparmap = {};
	            $.ajax({
	                url:"/main/rcmd.dox",
	                dataType:"json",	
	                type : "POST", 
	                data : nparmap,
	                success : function(data) {
	                	self.rcm = data.rec;
		           		self.sellRcmd = self.rcm.sell;
		           		self.buyRcmd = self.rcm.buy;
		           		self.commRcmd = self.rcm.comm;
		           		for(var i = 0; i < 5; i++) {
	 	         			if(self.sellRcmd[i].bTitle.length > 9) {
	 	         				self.sellRcmd[i].bTitle = self.sellRcmd[i].bTitle.slice(0, 8) + "...";
	 	         			}
	 	         		}
		           		for(var i = 0; i < 5; i++) {
	 	         			if(self.sellRcmd[i].bTitle.length > 9) {
	 	         				self.sellRcmd[i].bTitle = self.sellRcmd[i].bTitle.slice(0, 8) + "...";
	 	         			}
	 	         			if(self.buyRcmd[i].bTitle.length > 9) {
	 	         				self.buyRcmd[i].bTitle = self.buyRcmd[i].bTitle.slice(0, 8) + "...";
	 	         			}
	 	         			if(self.commRcmd[i].bTitle.length > 9) {
	 	         				self.commRcmd[i].bTitle = self.commRcmd[i].bTitle.slice(0, 8) + "...";
	 	         			}
	 	         		}
	                }
	            }); 
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
	    	, fnCateSelect : function(i, item, item2) {
        		var self = this;
        		self.pageChange("/trade.do", {brdflg : i, cnum : item, cinfo : item2});       		 
        	}
	    	, fnView(tbNo){
				var self = this;
				self.pageChange("./tradeview.do", {tbno : tbNo});
			}
	    }   
	    , created: function () {
	    	var self = this;
	    	self.$nextTick(self.fnGetList());
	    }
	});
</script>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath }"/>    
<jsp:include page="/WEB-INF/views/common/header.jsp">
	<jsp:param name="title" value=""/>
</jsp:include>

<section id="container">
	<div>
		<button id="greenbtn" onclick="home();">입차</button>
		<span id="span_date"></span>
		<button id="redbtn" onclick="carRecordListAjax();">출차</button>
	</div>
	<div id="carList-wraper">
	</div>
</section>

<script>
	$(function(){
		$.ajax({
			url:"${path}/car/selectAllCar.do",
			type:"GET",
			success: ajaxHtml,
			error:function(){
				console.log("error!");
			}
		});
	});
	
	function ajaxHtml(data){
		var html="<table class='table'>";
		html+="<tr>";
		html+="<td>차량번호</td>";
		html+="<td>입차시간</td>";
		html+="<td>상태</td>";
		html+="<td>이름</td>";
		html+="<td>출차</td>"
		html+="</tr>";
		
		$.each(data, (index, obj)=>{
			html+="<tr>";
			html+="<td>"+obj.carNum+"</td>";
			html+="<td>"+obj.inDate+"</td>";
			html+="<td>"+obj.state+"</td>";
			html+="<td>"+obj.name+"</td>";
			html+="<td><a class='btn btn-primary' style='font-size:20px;' href='${path}/car/outCar.do?carNum="+obj.carNum+"&inDate="+obj.inDate+"&state="+obj.state+"&name="+obj.name+"'>출차</a></td>"
			html+="</td>";
			
			
		});
		html+="</table>";
		
		$("#carList-wraper").html(html);
	}
	
	//home btn Green
	function home(){
		location.href="${path}/car/home.do";
	}
	
	//carRecordList btn Red
	
	function carRecordListAjax(){
		$.ajax({
			url:"${path}/car/carRecordList.do",
			type:"GET",
			success: ajaxHtml2,
			error:function(){
				console.log("error!");
			}
		});
	}
	
	function ajaxHtml2(data){
		var html2="<table class='table'>";
		html2+="<tr>";
		html2+="<td>차량번호</td>";
		html2+="<td>입차시간</td>";
		html2+="<td>출차시간</td>";
		html2+="<td>상태</td>";
		html2+="<td>이름</td>"
		html2+="<td>요금</td>"
		html2+="<td></td>"
		html2+="</tr>";
		
		$.each(data, (index, obj)=>{
			html2+="<tr>";
			html2+="<td>"+obj.carRNum+"</td>";
			html2+="<td>"+obj.inRDate+"</td>";
			html2+="<td>"+obj.outRDate+"</td>";
			html2+="<td>"+obj.rstate+"</td>";
			html2+="<td>"+obj.rname+"</td>";
			html2+="<td>"+obj.carRPrice+"</td>";
			html2+="<td><a class='btn btn-primary' style='font-size:20px;' href='${path}/car/backCar.do?carRNum="+obj.carRNum+"&inRDate="+obj.inRDate+"&rState="+obj.rstate+"&rName="+obj.rname+"'>←</a></td>";
			html2+="</td>";
			
			
		});
		html2+="</table>";
		
		$("#carList-wraper").html(html2);
	}
	
	var Target = document.getElementById("span_date");
	function clock(){
		var time = new Date();
		var year = time.getFullYear();
		var month = time.getMonth();
		var date = time.getDate();
		var week = ['일','월','화','수','목','금','토'];
		
		Target.innerText=year+'-'+(month+1)+'-'+date+' '+week[time.getDay()]+'요일';
	}
	clock();
</script>

<jsp:include page="/WEB-INF/views/common/footer.jsp"/>
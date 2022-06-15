<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>
function ch(){
	var doc=document.form;
	doc.submit();
}
function ch1(){
	var doc=document.form;
	doc.submit();
}


function check() {
	var doc=document.form;
	if(doc.orderDate.value==""){
		alert("주문일자를 입력하세요.");
		doc.orderDate.focus();
	}
	else if(doc.orderName.value==""){
		alert("상품명을 입력하세요.");
		doc.orderName.focus();
	}
	else if(doc.productId.value==""){
		alert("상품코드를 입력하세요.");
		doc.productId.focus();
	}
	 else if(doc.orderAddress.value==""){
		 alert("주문주소를 입력하세요.");
			doc.orderAddress.focus();

    }else{
     form.action="addOrderProcess.jsp";
      alert("완료되었습니다");
    }
}


</script>
</head>
<body>
<%@ include file="header.jsp" %>
<%@ include file="nav.jsp" %>
<section id="sec1">
<%@ include file="DBConn.jsp" %>
<%
ResultSet rs=null;
PreparedStatement pstmt=null;
int qty=0;
String orderName=request.getParameter("orderName");
if(orderName==null){
	orderName="";
}
String name="";
String orderDate=request.getParameter("orderDate");
if(orderDate==null){
	orderDate="";
}
String productId=request.getParameter("productId");
String orderAddress=request.getParameter("orderAddress");
if(orderAddress==null){
	orderAddress="";
}
String orderQty=request.getParameter("orderQty");
if(orderQty==null){
	orderQty="";
}else{
	try{
		qty=Integer.parseInt(orderQty);
		if(qty<0){
%>
			<script>
				alert("[주문수량]\n음수 입력불가.")
			</script>
			<% 			qty=0;
			
		}
	
}catch(NumberFormatException e){
	e.printStackTrace();
	%>
	alert("[주문수량]\n숫자만 입력가능합니다.");
	<% 
}
}
 int unitprice=0;

try{
	String sql="select name,unitprice,unitsInstock from product0614 where productId=? ";
			pstmt=conn.prepareStatement(sql);
	pstmt.setString(1, productId);
	rs=pstmt.executeQuery();
	if(rs.next()){
		name=rs.getString(1);
		unitprice=rs.getInt(2);
		int unitsInstock=rs.getInt(3);
		if(qty>unitsInstock){
			%>
			<script>
			alert("주문수량이 재고수량보다 많습니다.");
			</script>
			<% 
			qty=0;
		}
	}else if(productId==null){
		productId="";
	}else{
		%>
		<script>
		alert("등록되어 있지 않은 코드입니다.");
		</script>
		<% 
		productId=""; 
	}
	%>
	
	      
<h2>주문정보 등록</h2>
<hr>
<form name="form" method="post" action="addOrder.jsp">
<table border="1" id="tab1">
<tr>
<th id="th1">주문일자</th>
<td>
<input type="text" name="orderDate" value="<%=orderDate %>">
</td>
<th id="th1">주문자 이름</th>
<td>
<input type="text" name="orderName" value="<%=orderName %>">
</tr>
<tr>
<th id="th1">상품코드</th>
<td>
<input type="text" name="productId" value="<%=productId %>" onchange="ch()"></td>
<th id="th1">상 품 명</th>
<td>
<input type="text" name="name" value="<%=name %>"></td>
</tr>
<tr>
<th id="th1">단가</th>
<td>
<input type="text" name="unitprice" value="<%=unitprice %>">
</td>
<th id="th1">주문수량</th>
<td>
<input type="text" name="orderQty" value="<%=qty %>"onchange="ch1()">
</td>
</tr>
<tr>
<th id="th1">주문금액</th>
<td>
<input type="text" name="total" value="<%=unitprice*qty %>">
</td>
<th id="th1">주문주소</th>
<td>
<input type="text" name="orderAddress">
</td>
</tr>
<tr>
<td colspan="4" id="td1">
<input type="submit" value="등록" onclick="check()" id="bt1">
<input type="button" value="취소" onclick="history.back(-1)" id="bt1">
</td>
</tr>
<%		
	}catch(Exception e){
		e.printStackTrace();
	}
%>
</table>
</form>
<hr>
</section>
<%@ include file="footer.jsp" %>
</body>
</html>
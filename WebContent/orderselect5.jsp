<%@ page import="java.text.DecimalFormat" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ include file="header.jsp" %>
<%@ include file="nav.jsp" %>
<section id="sec1">
<%@ include file="DBConn.jsp" %>
<br>
<h2>주문 목록(주문일자/상품별)</h2>
<table border="1" id="tab1">
<tr>
<th id="th1">no</th>
<th id="th1">상품번호</th>
<th id="th1">상품명</th>
<th id="th1">주문일자</th>
<th id="th1">주문수량</th>
<th id="th1">주문금액</th>
</tr>
<%
DecimalFormat fo=new DecimalFormat("###,###");
ResultSet rs=null;
PreparedStatement pstmt=null;
int no=0;
int orderQtysum=0;
int totalsum=0;
try{
	String sql="select p.productId,p.name,to_char(o.orderDate,'YYYY-MM-DD'),sum(o.orderQty),sum(o.unitPrice*orderQty) from order0614 o,product0614 p where o.productId=p.productId group by p.productId,p.name,o.orderDate order by p.productId ";
	pstmt=conn.prepareStatement(sql);
	rs=pstmt.executeQuery();
	while(rs.next()){
		String productId=rs.getString(1);
		String name=rs.getString(2);
		String orderDate=rs.getString(3);
		int orderQty=rs.getInt(4);
		int total=rs.getInt(5);
		orderQtysum+=orderQty;
		totalsum+=total;
		no++;
		
%>
<tr>
<td id="td1"><%=no%></td>
<td id="td1"><%=productId %></td>
<td id="td1"><%=name %></td>
<td id="td1"><%=orderDate %></td>
<td id="td1"><%=fo.format(orderQty) %></td>
<td id="td1"><%=fo.format(total) %></td>
</tr>
	<%
	
	}
}catch(SQLException e){
	e.printStackTrace();
}
%>

<tr>
<th colspan="4">합계</th>
<td id="td1"><%=fo.format(orderQtysum) %></td>
<td id="td1"><%=fo.format(totalsum) %></td>
</tr>
</table>
<div style="text-align: center;">
<input type="button" value="작성" onclick="location.href='addOrder.jsp'" id="bt1">
</div>
</section>

<%@ include file="footer.jsp" %>

</body>
</html>
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
<h2>주문 목록(주문자별 수량 및 금액 합계)</h2>
<table border="1" id="tab1">
<tr>
<th id="th1">no</th>
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
	String sql="select orderName,sum(orderQty),sum(unitPrice*orderQty) from order0614 group by orderName order by orderName";
	pstmt=conn.prepareStatement(sql);
	rs=pstmt.executeQuery();
	while(rs.next()){
		String orderName=rs.getString(1);
		int orderQty=rs.getInt(2);
		int total=rs.getInt(3);
		orderQtysum+=orderQty;
		totalsum+=total;
		no++;
		
%>
<tr>
<td id="td1"><%=no%></td>
<td id="td1"><%=orderName %></td>
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
<th colspan="2">합계</th>
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
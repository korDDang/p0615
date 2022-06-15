<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="DBConn.jsp" %>    
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@include file="header.jsp" %>
<%@include file="nav.jsp" %>
<section id="sec1">
<h2>주문 목록</h2>

<%
PreparedStatement pstmt=null;
ResultSet rs=null;
	try{
		String sql="select count(*) from order0614";
		pstmt=conn.prepareStatement(sql);
		rs=pstmt.executeQuery(); rs.next();
		int cnt=rs.getInt(1);
%>
<p>총 <%=cnt %>개의 주문정보가 있습니다.</p><hr>
<table id="tab1" border="1">
<tr>
<th id="th1">no</th>
<th id="th1">주문일자</th>
<th id="th1">주문자 성명</th>
<th id="th1">상품번호</th>
<th id="th1">상품명</th>
<th id="th1">단가</th>
<th id="th1">주문수량</th>
<th id="th1">주문자주소</th>
<th id="th1">구분</th>
</tr>
<%
		sql="select to_char(a.orderDate,'yyyy-mm-dd'),a.orderName,a.productId,b.name,b.unitprice,a.orderQty,a.orderAddress from order0614 a join product0614 b on a.productId=b.productId";
		pstmt=conn.prepareStatement(sql);
		rs=pstmt.executeQuery();
		int no=0;
		while(rs.next()){
			no++;
			String orderDate=rs.getString(1);
			String orderName=rs.getString(2);
			String productId=rs.getString(3);
			String name=rs.getString(4);
			String unitprice=rs.getString(5);
			String orderQty=rs.getString(6);
			String orderAddress=rs.getString(7);
%>
<tr>
<td><%=no %></td>
<td><%=orderDate %></td>
<td><%=orderName %></td>
<td><%=productId %></td>
<td><%=name %></td>
<td><%=unitprice %></td>
<td><%=orderQty %></td>
<td><%=orderAddress %></td>
<td>
<a href="updateorder1.jsp?orderDate=<%=orderDate%>&&orderName=<%=orderName %>">수정</a>/
<a href="deleteorder.jsp?orderDate=<%=orderDate%>&&orderName=<%=orderName %>" onclick="if(!confirm('정말로 삭제하시겠습니까?'))return false">삭제</a>
</td>
</tr>
<%
		}
	}catch(Exception e){
		e.printStackTrace();
	}
%>
</table>
<div style="text-align: center;">
<input type="button" value="작성" onclick="location.href='addOrder.jsp'" id="bt1">
</div>
</section>
<%@include file="footer.jsp" %>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
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
<h3>상품 목록</h3>
<%
ResultSet rs=null;
PreparedStatement pstmt=null;
int cnt=0;
try{
	String sql="select count(productId) from product0614";
	pstmt=conn.prepareStatement(sql);
	rs=pstmt.executeQuery();
	if(rs.next()){
		cnt=rs.getInt(1);
	}else{
		cnt=0;
	}
}catch(SQLException e){
	e.printStackTrace();
}
%>
<div style="margin: 0 20%;">총 <%=cnt %>개의 상품이 있습니다.</div>
<hr>
<table border="1" id="tab1">
<tr>
<th id="th1">상품코드</th>
<th id="th1">상품명</th>
<th id="th1">단가</th>
<th id="th1">상세정보</th>
<th id="th1">제조사</th>
<th id="th1">분류</th>
<th id="th1">재고수</th>
<th id="th1">상태</th>
<th id="th1">구분</th>
</tr>
<%
try{
	String sql="select * from product0614";
	pstmt=conn.prepareStatement(sql);
	rs=pstmt.executeQuery();
	while(rs.next()){
		String productId=rs.getString("productId");
		String name=rs.getString("name");
		String unitprice=rs.getString("unitprice");
		String description=rs.getString("description");
		String category=rs.getString("category");
		switch(category){
		case "10": category="it 제품";
				break;
		case "20": category="주방제품";
				break;
		case "30": category="전자제품";
				break;
		case "40": category="일반제품";
				break;
		}
		String manufacturer=rs.getString("manufacturer");
		String unitsInstock=rs.getString("unitsInstock");
		String condition=rs.getString("condition");

%>



<tr>
<td id="td1"><a href="productupdate.jsp?productId=<%=productId %>"><%=productId %></a></td>
<td id="td1"><%=name %></td>
<td id="td1"><%=unitprice %></td>
<td id="td1"><%=description %></td>
<td id="td1"><%=manufacturer %></td>
<td id="td1"><%=category %></td>
<td id="td1"><%=unitsInstock %></td>
<td id="td1"><%=condition%></td>
<td id="td1"><a href="deleteproduct.jsp?productId=<%=productId %>" onclick="if(!confirm('정말로 삭제하시겠습니까?'))return false;">삭제</a></td>
<% 
	}
}catch(SQLException e){
	e.printStackTrace();
	System.out.println("조회실패");
}
%>
</tr>
</table>
<div style="text-align: center;"><input type="button" value="작성" onclick="location.href='addProduct.jsp'" id="bt1"></div>



</section>
<%@ include file="footer.jsp" %>

</body>
</html>
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
<h2>거래처 목록</h2>
<% 
int cnt=0;
ResultSet rs=null;
PreparedStatement pstmt=null;
try{
	String sql="select count(*) from store0614";
	pstmt=conn.prepareStatement(sql);
	rs=pstmt.executeQuery(); 
	rs.next();
	cnt=rs.getInt(1);
}catch(SQLException e){
	e.printStackTrace();
}
%>
<div style="margin: 0 23%;">총 <%=cnt %>개의 거래처가 있습니다.</div>
<hr>
<table border="1" id="tab1">
<tr>
<th id="th1">no</th>
<th id="th1">거래처 코드</th>
<th id="th1">거래처 이름</th>
<th id="th1">거래처 전화번호</th>
<th id="th1">거래처 주소</th>
<th id="th1">구분</th>
</tr>
<%
int no=0;

try{
	String sql="select * from store0614";
	pstmt=conn.prepareStatement(sql);
	rs=pstmt.executeQuery();
	while(rs.next()){
		String StoreNo=rs.getString(1);
		String StoreName=rs.getString(2);
		String StoreTel=rs.getString(3);
		String StoreAddress=rs.getString(4);
		no++;
%>
<tr>
<td id="td1" style="background:lightgray;"><%=no%></td>
<td id="td1" style="background:lightgray;"><a href="updatestore.jsp?storeNo=<%=StoreNo%>"style="color: white;"><%=StoreNo %></a></td>
<td id="td1" style="background:lightgray;"><%=StoreName  %></td>
<td id="td1" style="background:lightgray;"><%=StoreTel  %></td>
<td id="td1" style="background:lightgray;"><%=StoreAddress  %></td>
<td id="td1" style="background:lightgray;"><a href="deletestore.jsp?storeNo=<%=StoreNo%>" onclick="if(!confirm('정말로 삭제하시겠습니까?'))return false">삭제</a></td>
</tr>
	<%
	
	}
}catch(SQLException e){
	e.printStackTrace();
}
%>

</table>
<div style="text-align: center;">
<input type="button" value="작성" onclick="location.href='addStore.jsp'" id="bt1">
</div>
</section>

<%@ include file="footer.jsp" %>

</body>
</html>
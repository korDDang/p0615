<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%@ include file="DBConn.jsp" %>
<%
PreparedStatement pstmt=null;
String storeNo=request.getParameter("storeNo");
String storeName=request.getParameter("storeName");
String storeTel=request.getParameter("storeTel")+"-"+request.getParameter("storeTel1")+"-"+request.getParameter("storeTel2");
String storeAddress=request.getParameter("storeAddress");
try{
	String sql="update store0614 set storeName=?,storeTel=?,storeAddress=? where storeNo=?";
	pstmt=conn.prepareStatement(sql);
	pstmt.setString(4, storeNo);
	pstmt.setString(1, storeName);
	pstmt.setString(2, storeTel);
	pstmt.setString(3, storeAddress);
	
	pstmt.executeUpdate();
	%>
	<script>
	alert("거래처 수정 성공");
	history.back(-1);
	</script>
	<% 
}catch(SQLException e){
	e.printStackTrace();
}

%>
</body>
</html>
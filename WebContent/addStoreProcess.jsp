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
	String sql="insert into store0614 values(?,?,?,?)";
	pstmt=conn.prepareStatement(sql);
	pstmt.setString(1, storeNo);
	pstmt.setString(2, storeName);
	pstmt.setString(3, storeTel);
	pstmt.setString(4, storeAddress);
	
	pstmt.executeUpdate();
	%>
	<script>
	alert("거래처 등록 성공");
	history.back(-1);
	</script>
	<% 
}catch(SQLException e){
	e.printStackTrace();
}

%>
</body>
</html>
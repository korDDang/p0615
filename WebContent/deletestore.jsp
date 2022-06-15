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
try{
	String sql="delete from store0614 where storeNo=?";
	pstmt=conn.prepareStatement(sql);
	pstmt.setString(1, request.getParameter("storeNo"));
	pstmt.executeUpdate();
	%>   <script>
	   
	alert("거래처 삭제 성공");
	history.back(-1);
	    </script>
	<% 
}catch(SQLException e){
	e.printStackTrace();
}
%>
</body>
</html>
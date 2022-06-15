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
	String sql="delete from order0614 where orderDate=? and orderName=?";
	pstmt=conn.prepareStatement(sql);
	pstmt.setString(1, request.getParameter("orderDate"));
	pstmt.setString(2, request.getParameter("orderName"));
	pstmt.executeUpdate();
	%>   <script>
	   
	alert("주문 삭제 성공");
	history.back(-1);
	    </script>
	<% 
}catch(SQLException e){
	e.printStackTrace();
}
%>
</body>
</html>
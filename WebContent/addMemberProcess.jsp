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
String id=request.getParameter("id");
String password=request.getParameter("password");
String name=request.getParameter("name");
String gender=request.getParameter("gender");
String birth=request.getParameter("birth1")+"-"+request.getParameter("birth2")+"-"+request.getParameter("birth3");
String email=request.getParameter("email1")+"@"+request.getParameter("email2");
String phone=request.getParameter("phone");
String address=request.getParameter("address");
String interest[]=request.getParameterValues("interest");
String interestsum="";
String timestamp=request.getParameter("timestamp");
try{
	String sql="insert into member0614 values(?,?,?,?,?,?,?,?,?,sysdate)";
	pstmt=conn.prepareStatement(sql);
	pstmt.setString(1, id);
	pstmt.setString(2, password);
	pstmt.setString(3, name);
	pstmt.setString(4, gender);
	pstmt.setString(5, birth);
	pstmt.setString(6, email);
	pstmt.setString(7, phone);
	pstmt.setString(8, address);
	System.out.println(address);
	for(int i=0;i<interest.length;i++){
		if(i==0){
		  interestsum=interest[i];
		}else{
			 interestsum+=","+interest[i];
		}
	}
	pstmt.setString(9, interestsum);
	pstmt.executeUpdate();
	%>
	<script>
	alert("등록이 완료되었습니다");
	history.back(-1);
	</script>
	<% 
}catch(SQLException e){
	e.printStackTrace();
}

%>
</body>
</html>
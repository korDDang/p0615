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
<h3>회원 목록</h3>
<%
ResultSet rs=null;
PreparedStatement pstmt=null;
int cnt=0;
try{
	String sql="select count(id) from member0614";
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
<div style="margin: 0 20%;">총 <%=cnt %>명의 회원이 있습니다.</div>
<hr>
<table border="1" id="tab1">
<tr>
<th id="th1">id</th>
<th id="th1">성명</th>
<th id="th1">비밀번호</th>
<th id="th1">성별</th>
<th id="th1">생년월일</th>
<th id="th1">이메일</th>
<th id="th1">연락처</th>
<th id="th1">주소</th>
<th id="th1">관심분야</th>
<th id="th1">구분</th>
</tr>
<%
try{
	String sql="select * from member0614";
	pstmt=conn.prepareStatement(sql);
	rs=pstmt.executeQuery();
	while(rs.next()){
		String id=rs.getString("id");
		String password=rs.getString("password");
		String name=rs.getString("name");
		String email=rs.getString("email");
		String phone=rs.getString("phone");
		String address=rs.getString("address");
		String interest=rs.getString("interest");
		String gender=rs.getString("gender");
		switch(gender){
		case "1":gender="남성";
		          break;
		case "2":gender="여성";
		           break;
		}
		String birth=rs.getString("birth");

%>



<tr>
<td id="td1"><%=id %></td>
<td id="td1"><%=name %></td>
<td id="td1"><%=password %></td>
<td id="td1"><%=gender %></td>
<td id="td1"><%=birth %></td>
<td id="td1"><%=email %></td>
<td id="td1"><%=phone %></td>
<td id="td1"><%=address %></td>
<td id="td1"><%=interest %></td>
<td id="td1"><a href="updatemember.jsp?id=<%=id %>">수정</a>/<a href="deletemember.jsp?id=<%=id %>" onclick="if(!confirm('정말로 삭제하시겠습니까?'))return false;">삭제</a></td>
<% 
	}
}catch(SQLException e){
	e.printStackTrace();
	System.out.println("조회실패");
}
%>
</tr>
</table>
<div style="text-align: center;"><input type="button" value="작성" onclick="location.href='addMember.jsp'" id="bt1"></div>



</section>
<%@ include file="footer.jsp" %>

</body>
</html>
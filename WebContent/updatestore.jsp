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
<h2>거래처 수정 화면</h2>
<%
ResultSet rs=null;
PreparedStatement pstmt=null;
int sq=0;
try{
	String sql="select * from store0614 where storeNo=?";
	pstmt=conn.prepareStatement(sql);
	pstmt.setString(1, request.getParameter("storeNo"));
	rs=pstmt.executeQuery();
	if(rs.next()){
	 String storeNo=rs.getString(1);
	 String storeName=rs.getString(2);
	 String storeTel=rs.getString(3);
	 String st[]=storeTel.split("-");
	 String storeAddress=rs.getString(4);

%>
<hr>
<form name="form" method="post" action="updatestoreProcess.jsp">
<table border="1" id="tab1">
<tr>
<th id="th1">거래처코드</th>
<td>
<input type="text" name="storeNo" value="<%=storeNo %>"></td>
</tr>
<tr>
<th id="th1">거래처 이름</th>
<td>
<input type="text" name="storeName" value="<%=storeName %>"></td>
</tr>
<tr>
<th id="th1">거래처전화번호</th>
<td>
<select name="storeTel">
<option value="02" <%=st[0].equals("02")?"selected":"" %>>서울(02)</option>
<option value="031" <%=st[0].equals("031")?"selected":"" %>>경기(031)</option>
<option value="032" <%=st[0].equals("032")?"selected":"" %>>인천(032)</option>
<option value="033" <%=st[0].equals("033")?"selected":"" %>>강원(033)</option>
<option value="041" <%=st[0].equals("041")?"selected":"" %>>충남(041)</option>
<option value="042" <%=st[0].equals("042")?"selected":"" %>>대전(042)</option>
<option value="043" <%=st[0].equals("043")?"selected":"" %>>충북(043)</option>
<option value="044" <%=st[0].equals("044")?"selected":"" %>>세종(044)</option>
<option value="051" <%=st[0].equals("051")?"selected":"" %>>부산(051)</option>
<option value="052" <%=st[0].equals("052")?"selected":"" %>>울산(052)</option>
<option value="053" <%=st[0].equals("053")?"selected":"" %>>대구(053)</option>
<option value="054" <%=st[0].equals("054")?"selected":"" %>>경북(054)</option>
<option value="055" <%=st[0].equals("055")?"selected":"" %>>경남(055)</option>
<option value="061" <%=st[0].equals("061")?"selected":"" %>>전남(061)</option>
<option value="062" <%=st[0].equals("062")?"selected":"" %>>광주(062)</option>
<option value="063" <%=st[0].equals("063")?"selected":"" %>>전북(063)</option>
<option value="064" <%=st[0].equals("064")?"selected":"" %>>제주(064)</option>
</select>-
<input type="text" name="storeTel1" value="<%=st[1] %>">-<input type="text" name="storeTel2" value="<%=st[2] %>">
</td>
</tr>
<tr>
<th id="th1">거래처주소</th>
<td>
<input type="text" name="storeAddress" value="<%=storeAddress %>">
</td>
<tr style="height:60px;">
<td colspan="2" id="td1">
<input type="submit" value="수정" onclick="check()" id="bt1">
<input type="button" value="취소" onclick="history.back(-1)" id="bt1">
</td>
</tr>
<% 
	}
}catch(SQLException e){
	e.printStackTrace();
}
%>
</table>
</form>
<hr>
</section>
<%@ include file="footer.jsp" %>
</body>
</html>
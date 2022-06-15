<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>
function email_change(){
	var doc=document.form;
	if(doc.email.options[doc.email.selectedIndex].value=='0'){
		doc.email2.disabled=true;
		doc.email2.value="";
	}else if(doc.email.options[doc.email.selectedIndex].value=='9'){
		doc.email2.disabled=false;
		doc.email2.value="";
		doc.email2.focus();
	}else{
		doc.email2.disabled=false;
		doc.email2.value=doc.email.options[doc.email.selectedIndex].value;
	}
}
function check() {
	var doc=document.form;
	if(doc.name.value==""){
		alert("이름을 입력하세요.");
		doc.name.focus();
	}else if(doc.password.value==""){
		alert("비밀번호를 입력하세요.");
		doc.password.focus();
	}else if(doc.password1.value==""){
		alert("확인비밀번호를 입력하세요.");
		doc.password1.focus();
	}else if(doc.password.value!=doc.password1.value){
		alert("비밀번호와 확인비밀번호가 일치하지 않습니다.");
	     doc.password.focus();
    }else{
      form.action="updatememberProcess.jsp";
    }
    }
</script>
</head>
<body>
<%@ include file="header.jsp" %>
<%@ include file="nav.jsp" %>
<section id="sec1">
<%@ include file="DBConn.jsp" %>
<% 
ResultSet rs=null;
PreparedStatement pstmt=null;
int ma=0;
try{
	String sql="select max(id) from member0614";
	pstmt=conn.prepareStatement(sql);
	rs=pstmt.executeQuery();
	if(rs.next()){
		ma=rs.getInt(1)+1;
	}else{
		ma=rs.getInt(1);
	}
}catch(SQLException e){
	e.printStackTrace();
}
try{
	String sql="select id,name,password,gender,to_char(birth,'YYYY-MM-DD'),email,phone,address,interest from member0614 where id=?";
	pstmt=conn.prepareStatement(sql);
	pstmt.setString(1, request.getParameter("id"));
	rs=pstmt.executeQuery();
	if(rs.next()){
		String id=rs.getString("id");
		String name=rs.getString("name");
		String password=rs.getString("password");
		String gender=rs.getString("gender");
		String birth=rs.getString(5);
		String br[]=birth.split("-");
		String email=rs.getString("email");
		String em[]=email.split("@");
		String phone=rs.getString("phone");
		String address=rs.getString("address");
		String interest=rs.getString("interest");
		String interests[]=interest.split(",");
		
	
%>

<h2>회원 가입 수정 화면</h2>
<hr>
<form name="form" method="post" action="updatemember.jsp">
<table border="1" id="tab1">
<tr>
<th id="th1">아이디</th>
<td>
<input type="text" name="id" value="<%=id %>">
</td>
</tr>
<tr>
<th id="th1">성 명</th>
<td>
<input type="text" name="name" value="<%=name %>"></td>
</tr>
<tr>
<th id="th1">비밀번호</th>
<td>
<input type="password" name="password" value="<%=password %>">
</td>
</tr>
<tr>
<th id="th1">비밀번호 확인</th>
<td>
<input type="password" name="password1" value="<%=password %>">
</td>
</tr>
<tr>
<th id="th1">성 별</th>
<td>
<input type="radio" name="gender" value="1" <%=gender.equals("1")?"checked":"" %>>남성
<input type="radio" name="gender" value="2"  <%=gender.equals("2")?"checked":"" %>>여성
</td>
</tr>
<tr>
<th id="th1">생 일</th>
<td>
<input type="number" name="birth1" value="<%=br[0]%>">년
<input type="number" name="birth2"  value="<%=br[1]%>">월
<input type="number" name="birth3"  value="<%=br[2]%>">일
</td>
</tr>
<tr>
<th id="th1">이메일</th>
<td>
<input type="text" name="email1"  value="<%=em[0]%>">@
<input type="text" name="email2"  value="<%=em[1]%>">
<select name="email" onchange="email_change()">
<option value="0">선택하세요</option>
<option value="9">직접입력</option>
<option value="korea.com">korea.com</option>
<option value="hanmail.net">hanmail.net</option>
<option value="gmail.com">gamail.com</option>
</select></td>
</tr>
<tr>
<th id="th1">연락처</th>
<td>
<input type="text" name="phone" value="<%=phone%>">
</td>
</tr>
<tr>
<th id="th1">주소</th>
<td>
<input type="text" name="address" value="<%=address%>">
</td>
</tr>
<tr>
<th id="th1">관심분야</th>
<td>
<input type="checkbox" name="interest" value="프로그램" <%for(int i=0;i<interests.length;i++){if(interests[i].equals("프로그램")){%>checked<%}}%>>프로그램
<input type="checkbox" name="interest" value="독서" <%for(int i=0;i<interests.length;i++){if(interests[i].equals("독서")){%>checked<%}}%>>독서
<input type="checkbox" name="interest" value="등산" <%for(int i=0;i<interests.length;i++){if(interests[i].equals("등산")){%>checked<%}}%>>등산
<input type="checkbox" name="interest" value="여행" <%for(int i=0;i<interests.length;i++){if(interests[i].equals("여행")){%>checked<%}}%>>여행
<input type="checkbox" name="interest" value="컴퓨터" <%for(int i=0;i<interests.length;i++){if(interests[i].equals("컴퓨터")){%>checked<%}}%>>컴퓨터
<input type="checkbox" name="interest" value="영화" <%for(int i=0;i<interests.length;i++){if(interests[i].equals("영화")){%>checked<%}}%>>영화
<input type="checkbox" name="interest" value="운동" <%for(int i=0;i<interests.length;i++){if(interests[i].equals("운동")){%>checked<%}}%>>운동
<input type="checkbox" name="interest" value="진학" <%for(int i=0;i<interests.length;i++){if(interests[i].equals("진학")){%>checked<%}}%>>진학
</td>
</tr>
<tr>
<td colspan="2" id="td1">
<input type="submit" value="등록" onclick="check()" id="bt1">
<input type="button" value="취소" onclick="history.back(-1)" id="bt1">
</td>
</tr>
<% 
}
}catch(Exception e){
	e.printStackTrace();
	System.out.println("수정실패");
}
%>

</table>
</form>
<hr>
</section>
<%@ include file="footer.jsp" %>
</body>
</html>
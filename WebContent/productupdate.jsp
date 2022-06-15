<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html >
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>
function check() {
	var doc=document.form;
	if(doc.productId.value==""){
		alert("상품코드를 입력하세요.");
		doc.productId.focus();
	}
	else if(doc.name.value==""){
		alert("상품명을 입력하세요.");
		doc.name.focus();
	}
	else if(doc.name.value.length<4||doc.name.value.length>50){
		alert("[상품명]\n최소 4자에서 최대 50자까지  입력하세요.");
		doc.name.focus();
	}
	else if(doc.unitprice.value==""){
		alert("가격을 입력하세요.");
	     doc.unitprice.focus();
	}
	else if(doc.unitprice.value==0||isNaN(doc.unitprice.value)){
		alert("[가격]\n 숫자만 입력하세요.");
	     doc.unitprice.focus();
	}
	else if(doc.unitprice.value<0){
		alert("[가격]\n 음수를 입력할수없습니다.");
       doc.unitprice.focus();
    }
	else if(doc.unitsInstock.value==0||isNaN(doc.unitsInstock.value)){
		alert("[재고]\n 숫자만 입력하세요.");
		doc.unitsInstock.focus();
	}
	else{
      doc.submit();
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
try{
	String sql="select * from product0614 where productId=?";
	pstmt=conn.prepareStatement(sql);
	pstmt.setString(1, request.getParameter("productId"));
	rs=pstmt.executeQuery();
	if(rs.next()){
		String productId=rs.getString("productId");
		String name=rs.getString("name");
		String unitprice=rs.getString("unitprice");
		String description=rs.getString("description");
		String category=rs.getString("category");
		String manufacturer=rs.getString("manufacturer");
		String unitsInstock=rs.getString("unitsInstock");
		String condition=rs.getString("condition");


%>
<h2>상품 등록 화면</h2>
<hr>
<form name="form" method="post" action="productupdateProcess.jsp">
<table border="1" id="tab1">
<tr>
<th id="th1">상품코드</th>
<td>
<input type="text" name="productId" value="<%=productId %>" >
</td>
</tr>
<tr>
<th id="th1">상품명</th>
<td>
<input type="text" name="name" value="<%=name %>" ></td>
</tr>
<tr>
<th id="th1">가격</th>
<td>
<input type="text" name="unitprice" value="<%=unitprice %>" >
</td>
</tr>
<tr>
<th id="th1">상세정보</th>
<td>
<input type="text" name="description" value="<%=description %>" >
</td>
</tr>
<tr>
<th id="th1">제조사</th>
<td>
<input type="text" name="manufacturer" value="<%=manufacturer%>" >
</td>
</tr>
<tr>
<th id="th1">분류</th>
<td>
<select name="category" >
<option value="10" <%=category.equals("10")?"selected":"" %>>it 제품</option>
<option value="20" <%=category.equals("20")?"selected":"" %>>주방제품</option>
<option value="30" <%=category.equals("30")?"selected":"" %>>전자제품</option>
<option value="40" <%=category.equals("40")?"selected":"" %>>일반잡화</option>
</select></td>
</tr>
<tr>
<th id="th1">재고수</th>
<td>
<input type="text" name="unitsInstock" value="<%=unitsInstock%>">
</td>
</tr>
<tr>
<th id="th1">상태</th>
<td>
<input type="radio" name="condition" value="신규제품" <%=condition.equals("신규제품")?"checked":"" %>>신규 제품
<input type="radio" name="condition" value="중고제품" <%=condition.equals("중고제품")?"checked":"" %>>중고 제품
<input type="radio" name="condition" value="재생제품" <%=condition.equals("재생제품")?"checked":"" %>>재생 제품
</td>
</tr>
<tr>
<td colspan="2" id="td1">
<input type="button" value="등록" onclick="check()" id="bt1">
<input type="button" value="취소" onclick="history.back(-1)" id="bt1">
</td>
<%
	}
}catch(SQLException e){
	e.printStackTrace();
	System.out.println("수정실패");
}
%>
</tr>
</table>
</form>
<hr>
</section>
<%@ include file="footer.jsp" %>
</body>
</html>
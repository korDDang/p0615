<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script>
function changesubmit()
{
	document.form.submit();
}
function check()
{
	
	if(document.form.orderDate.value=="")
	{
		alert("주문일자를 입력하세요.");
		document.form.orderDate.focus();
	}
	else if(document.form.orderName.value=="")
	{
		alert("주문자이름을 입력하세요.");
		document.form.orderName.focus();
	}
	else if(document.form.productId.value=="")
	{
		alert("상품코드를 입력하세요.");
		document.form.productId.focus();
	}
	else if(document.form.orderAddress.value=="")
	{
		alert("주문자 주소를 입력하세요.");
		document.form.orderAddress.focus();
	}
	else
	{
		form.action="updateorderProcess.jsp"
	}
}
</script>
</head>
<body>
<%@ include file="header.jsp" %>
<%@ include file="nav.jsp" %>
<%@ include file="DBConn.jsp" %>
<%
	ResultSet rs=null;
	PreparedStatement pstmt=null;
	
	//업데이트 재고수량저장
	String preQty=request.getParameter("preQty");
	if(preQty==null){preQty="";}
	
	//온체인지검색변수
	String productId=request.getParameter("productId");
	if(productId==null){productId="";}
	//검색대상
	String name=request.getParameter("name");
	if(name==null){name="";}
	
	String unitprice=request.getParameter("unitprice");
	if(unitprice==null){unitprice="0";}
	
	//이전값저장변수
	String orderDate=request.getParameter("orderDate");
	if(orderDate==null){orderDate="";}
	String orderName=request.getParameter("orderName");
	if(orderName==null){orderName="";}
	
	String orderQty=request.getParameter("orderQty");
	if(orderQty==null){orderQty="";}
	String orderAddress=request.getParameter("orderAddress");
	if(orderAddress==null){orderAddress="";}
	
	//주문수량
	int i_qty=0;
	if(orderQty!=""){i_qty=Integer.parseInt(orderQty); }
	
	//업데이트 읽기
	try
	{
		String sql="select * from order0614 where orderDate=? and orderName=?";
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, orderDate);
		pstmt.setString(2, orderName);
		rs=pstmt.executeQuery();	
		
		if(rs.next())
		{	
			orderDate=rs.getString(1);
			productId =rs.getString(3);
			unitprice =rs.getString(4);
			orderQty =rs.getString(5);
			orderAddress =rs.getString(6);
		
		}
		
		
	}catch(SQLException e)
	{
		System.out.println("조회실패");
		e.printStackTrace();
	}
	
%>
	
<section id="sec1">
<br>
<h2>주문정보 수정 화면</h2>
<br>
<form name="form" method="post" action="updateorder1.jsp">
<table id="tab1" border=1>
<tr>
	<th id="th1">주문일자</th>
	<td>
	<input type="text" name="orderDate" value=<%=orderDate %>>
	</td>
	<th id="th1">주문자 이름</th>
	<td>
	<input type="text" name="orderName" value=<%=orderName %>>
	</td>
</tr>
<% 
//대상검색
	//재고수량
	int unitsinstock=0;
	if(productId=="")
	{}
	else
	{
		try
		{
			String sql="select name,unitprice,unitsinstock from product0614 where productid=?";
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1,productId);
			rs=pstmt.executeQuery();
			if(rs.next())
			{
				name=rs.getString(1);
				unitprice=rs.getString(2);
				unitsinstock=rs.getInt(3);
			}		
			else
			{
				%>
				<script>
					alert("등록되지 않은 코드입니다.");
					history.back(-1);
				</script>
				<%
				
			}
		}catch(SQLException ee)
		{
			System.out.println("상품명검색실패");
			ee.printStackTrace();
		}
	}
	
%>
<tr>
	<th id="th1">상품코드</th>
	<td>
	<input type="text" name="productId" value=<%=productId %>>
	</td>	
	<th id="th1">상품명</th>
	<td>
	<input type="text" name="name" value=<%=name %>>
	</td>
</tr>
<%	
	int orderprice=0;
	
	if(orderQty=="")
	{
		System.out.println("qty미입력");
	}
	else
	{
		if(i_qty>unitsinstock)
		{
			System.out.println("재고수량초과");
			%>
			<script>
				alert("주문수량이 재고수량보다 많습니다.");
				history.back(-1);
			</script>
			<%
		}
		else
		{
			orderprice=Integer.parseInt(unitprice)*i_qty;
		}
	}
	
%>
<tr>
	<th id="th1">단 가</th>
	<td>
	<input type="text" name="unitprice" value=<%=unitprice %>>
	</td>
	<th id="th1">주문수량</th>
	<td>
	<input type="text" name="orderQty"  value=<%=orderQty %>>
	</td>
</tr>

			
<tr>
	<th id="th1">주문금액</th>
	<td>
	<input type="text" name="orderprice" value=<%=orderprice %>>
	</td>
	<th id="th1">주문주소</th>
	<td>
	<input type="text" name="orderAddress" value=<%=orderAddress %>>
	</td>
</tr>
<tr>
	<td colspan=4 align="center" height=50px>	
	<input id="btn1" type="submit" value="등록" onclick="check()">
	<input id="btn1" type="reset" value="취소">
	</td>
</tr>
</table>
<input type="hidden" name="unitsinstock" value=<%=unitsinstock %>>
<input type="hidden" name="preQty" value=<%=preQty %>>
</form>
</section>
<%@ include file="footer.jsp" %>
</body>
</html>
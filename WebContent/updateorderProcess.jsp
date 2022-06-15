<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="DBConn.jsp" %>
<%
	
	PreparedStatement pstmt=null;
	

	
	String orderQty=request.getParameter("orderQty");
	int i_qty=Integer.parseInt(orderQty);
	String unitInstock=request.getParameter("unitsinstock");
	int i_instock=Integer.parseInt(unitInstock);
	
	int result=(i_instock)-i_qty;
	
	//재고수량변경
	try
	{
		String sql="update product0614 set unitsInstock=? where productId=?";
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(2,request.getParameter("productId"));
		pstmt.setString(1,Integer.toString(result));
		pstmt.executeUpdate();	
		
	}catch(SQLException e)
	{
		System.out.println("저장실패");
		e.printStackTrace();
	}
	//본문
	try
	{
		String sql="update order0614 set productId=?,unitprice=?,orderQty=?,orderAddress=? where orderDate=? and orderName=?";
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(5,request.getParameter("orderDate"));
		pstmt.setString(6,request.getParameter("orderName"));
		pstmt.setString(1,request.getParameter("productId"));
		pstmt.setString(2,request.getParameter("unitprice"));
		pstmt.setString(3,orderQty);
		pstmt.setString(4,request.getParameter("orderAddress"));
	
		pstmt.executeUpdate();
		%>
		<script>
			alert("등록이 완료되었습니다!");
			location.href="orderselect.jsp";
		</script>
		<%
	}catch(SQLException e)
	{
		System.out.println("저장실패");
		e.printStackTrace();
	}
%>
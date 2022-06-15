<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="DBConn.jsp"%>

<%
   PreparedStatement pstmt=null;
   ResultSet rs=null;
	String orderDate=request.getParameter("orderDate");
	String orderName=request.getParameter("orderName");
	String productId=request.getParameter("productId");
	String unitprice=request.getParameter("unitprice");
	String orderQty=request.getParameter("orderQty");
	String orderAddress=request.getParameter("orderAddress");
	
	try{
		String sql="insert into order0614 values(?,?,?,?,?,?)";
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, orderDate);
		pstmt.setString(2, orderName);
		pstmt.setString(3, productId);
		pstmt.setString(4, unitprice);
		pstmt.setString(5, orderQty);
		pstmt.setString(6, orderAddress);
		pstmt.executeUpdate();
		sql="select unitsinstock from product0614 where productid=?";
		pstmt=conn.prepareStatement(sql);
		pstmt.setString(1, productId);
		rs=pstmt.executeQuery(); rs.next();
		int unitsinstock=rs.getInt(1);
		int qty=Integer.parseInt(orderQty);
		sql="update product0614 set unitsinstock=? where productid=?";
		pstmt=conn.prepareStatement(sql);
		pstmt.setInt(1, unitsinstock-qty);
		pstmt.setString(2, productId);
		pstmt.executeUpdate();
%>
		<script>
			alert("등록이 완료되었습니다!");
			location.href="addOrder.jsp"
		</script>
<%		
	}catch(Exception e){
		e.printStackTrace();
	}
%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<style type="text/css">
:root{
/* background-color : rgb(255,25,25); */
/* background: rgb(2,0,36);
background: linear-gradient(90deg, rgba(2,0,36,1) 0%, rgba(9,9,121,1) 35%, rgba(78,138,8,1) 43%, rgba(7,56,152,1) 50%, rgba(183,5,167,1) 65%, rgba(0,212,255,1) 100%); */
background-color: #8EC5FC;
background-image: linear-gradient(90deg, #8EC5FC 0%, #E0C3FC 100%);
}


</style>
<title>Insert title here</title>
</head>
<body>
 <%@ include file="dbconnect.jsp" %>
 <%
 String m_id = request.getParameter("m_id");
 Statement stmt = conn.createStatement();
 
 String sql = "DELETE FROM member WHERE m_id='" + m_id+ "'";

 stmt.executeUpdate(sql);
 
 stmt.close();
 conn.close();
 out.println("<script>alert('회원 탈퇴가 완료되었습니다. 그동안 이용해주셔서 감사합니다.'); history.go(-2);</script>");
 %>
</body>
</html>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>Main menu</title>
</head>
<body>
<%@ include file="dbconnect.jsp" %>
<%
	String m_id = request.getParameter("m_id");
	String m_pw = request.getParameter("m_pw");
		
	ResultSet m_rs = null;
	Statement m_stmt = conn.createStatement();
	
	String sql = "SELECT m_pw FROM member WHERE m_id='";
	sql += m_id +"'";
	m_rs = m_stmt.executeQuery(sql);
	
	String pw2="";
	while(m_rs.next()){
		pw2 = m_rs.getString("m_pw");
	}
	if(m_id.equals(""))
		out.println("<script>alert('아이디를 입력해주세요.'); history.back();</script>");
	else if(m_pw.equals(""))
		out.println("<script>alert('비밀번호를 입력해주세요.'); history.back();</script>");
	else if(pw2.equals(""))
		out.println("<script>alert('존재하지 않는 아이디입니다.'); history.back();</script>");
	else if(m_pw.equals(pw2)){
		session.setAttribute("m_id", m_id);
		session.setAttribute("m_pw", m_pw);
		pageContext.forward("00_color_client.jsp");
	}
	else{
		out.println("<script>alert('비밀번호가 일치하지 않습니다.'); history.back();</script>");
	}
	m_stmt.close();
	conn.close();
%>
</body>
</html>
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
<title>Join Success</title>
</head>
<body>
	<%@ include file="dbconnect.jsp" %>
	<%
	String m_id = request.getParameter("m_id");
	String m_name = request.getParameter("m_name");
	String m_pw = request.getParameter("m_pw");
	String m_pw2 = request.getParameter("m_pw2");
	
	ResultSet m_rs = null;
	Statement m_stmt = conn.createStatement();
	String m_sql ="SELECT m_id FROM member WHERE m_id = '" + m_id +"' ";
	
	ResultSet rs2 = null;
	String sql2 ="INSERT INTO member(m_id, m_name, m_pw)";
	sql2 += "VALUES('" + m_id + "', '" + m_name + "', '";
	sql2 += m_pw + "' )";
	//
	m_stmt.executeQuery(m_sql);
	
	m_rs = m_stmt.executeQuery(m_sql);

	String id2 ="";
	
	while(m_rs.next()){
		id2 = m_rs.getString("m_id");
	}
	if(m_id.trim().equals(""))
		out.println("<script>alert('아이디를 입력해주세요.'); history.back();</script>");
	else if(m_id.equals(id2)){
		out.println("<script>alert('이미 사용중인 아이디입니다.'); history.back();</script>");
	}
	else if(m_pw.equals(m_pw2)){
		m_stmt.executeUpdate(sql2);
		out.println("<script>alert('환영합니다. 회원가입이 성공적으로 진행되었습니다.'); history.go(-2);</script>");
	}
	else
		out.println("<script>alert('두 비밀번호가 일치하지 않습니다.'); history.back();</script>");
	
	m_stmt.close();
	conn.close();
	%>

	

</body>
</html>
<%@ page language="java" contentType="text/html; charset=EUC-KR"

    pageEncoding="EUC-KR"%>

<%@ page import="java.sql.*" %>

 

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>

<head>

<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">

<title>Insert title here</title>

</head>

<body>

<%

Connection  conn = null;  // JSP와 DB를 연결하는 교량.

String url = "jdbc:mysql://192.168.56.101:3306/membership_dp";

String user = "root";

String password = "1234";

 

Class.forName("com.mysql.jdbc.Driver"); // 복사한 mysql~~.jar 파일

 

conn = DriverManager.getConnection(url, user, password);

 

// out.println("<h1> 접속 성공 ! </h1>");

// conn.close();

%>

 

</body>

</html>
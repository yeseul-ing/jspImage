<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="EUC-KR">
<style type="text/css">
:root{
/* background-color : rgb(255,25,25); */
/* background: rgb(2,0,36);
background: linear-gradient(90deg, rgba(2,0,36,1) 0%, rgba(9,9,121,1) 35%, rgba(78,138,8,1) 43%, rgba(7,56,152,1) 50%, rgba(183,5,167,1) 65%, rgba(0,212,255,1) 100%); */
background-color: #8EC5FC;
background-image: linear-gradient(90deg, #8EC5FC 0%, #E0C3FC 100%);
}
 .sel {background-image: linear-gradient(to right, #77A1D3 0%, #79CBCA  51%, #77A1D3  100%)}
         .sel {
         position : absolute;
         top : 50px;
         left : 400px;
            margin: 10px;
            padding: 8px 70px;
            text-align: center;
            text-transform: uppercase;
            transition: 0.5s;
            background-size: 200% auto;
            color: #040a32;            
            box-shadow: 0 0 20px #eee;
            border-radius: 10px;
            display: block;
          }

          .sel:hover {
            background-position: right center; /* change the direction of the change here */
            color: #040a32
            text-decoration: none;
          }
          

 .lar {background-image: linear-gradient(to right, #ECE9E6 0%, #FFFFFF  51%, #ECE9E6  100%)}
         .lar {
         position : absolute;
         top : 100px;
         left : 350px;
            margin: 10px;
            padding: 8px 70px;
            text-align: center;
            text-transform: uppercase;
            transition: 0.5s;
            background-size: 200% auto;
            color: #040a32;            
            box-shadow: 0 0 20px #eee;
            border-radius: 10px;
            display: block;
          }

          .lar:hover {
            background-position: right center; /* change the direction of the change here */
            color: #040a32
            text-decoration: none;
          }
          
          .val {background-image: linear-gradient(to right, #ECE9E6 0%, #FFFFFF  51%, #ECE9E6  100%)}
         .val {
         position : absolute;
         top : 150px;
         left : 350px;
            margin: 10px;
            padding: 8px 83px;
            text-align: center;
            text-transform: uppercase;
            transition: 0.5s;
            background-size: 200% auto;
            color: #040a32;            
            box-shadow: 0 0 20px #eee;
            border-radius: 10px;
            display: block;
          }

          .val:hover {
            background-position: right center; /* change the direction of the change here */
            color: #040a32
            text-decoration: none;
          }
          
          .fil {background-image: linear-gradient(to right, #ECE9E6 0%, #FFFFFF  51%, #ECE9E6  100%)}
         .fil {
         position : absolute;
         top : 200px;
         left : 350px;
            margin: 10px;
            padding: 8px 50px;
            text-align: center;
            text-transform: uppercase;
            transition: 0.5s;
            background-size: 200% auto;
            color: #040a32;            
            box-shadow: 0 0 20px #eee;
            border-radius: 10px;
            display: block;
          }

          .fil:hover {
            background-position: right center; /* change the direction of the change here */
            color: #040a32
            text-decoration: none;
          }
          
          .sub {background-image: linear-gradient(to right, #77A1D3 0%, #79CBCA  51%, #77A1D3  100%)}
         .sub {
         position : absolute;
         top : 250px;
         left : 450px;
            margin: 10px;
            padding: 10px 45px;
            text-align: center;
            text-transform: uppercase;
            transition: 0.5s;
            background-size: 200% auto;
            color: #040a32;            
            box-shadow: 0 0 20px #eee;
            border: white;
            border-radius: 10px;
            display: block;
          }

          .sub:hover {
            background-position: right center; /* change the direction of the change here */
            color: #040a32
            text-decoration: none;
          }
          
          
          
          
          
</style>
<title>����ó�� Ŭ���̾�Ʈ</title>
</head>
<body>

	<form method="post" action="00_color_server.jsp"
		enctype="multipart/form-data">
		<p class="sel">
			<select name="algo">
				<option value="">~~ ���� �ϼ��� ~~~</option>
				<option value="101">���� ó��</option>
				<option value="102">���/��Ӱ�</option>
				<option value="103">�Ķ󺼶�</option>
				<option value="203">���� ����</option>
				<option value="204">�¿����</option>
				<option value="303">������</option>
				<option value="304">����</option>
				<option value="401">��輱</option>
				<option value="402">���翬����</option>
				<option value="404">LOG</option>
				<option value="405">DOG</option>
				<option value="406">���ö�þ�</option>
									
				 
				 
				 
			</select> <a>

			
			</a>
		</p>
		<p class="lar">
			Ȯ��/���: <input type='text' value=0 name='scale'>
		</p>
		<!-- <p> ȸ������: <input type='text' value=0 name='rotate'></p> -->
		<p class="val">
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;��: <input type='text' value=0 name='val'>
		</p>
		<p class="fil">
			File: <input type='file' name='filename' class="openImg" id='inFile'>
		</p>
		<p >
			<input type='submit' class="sub" value='����ó��(Į��)'>
		</p>

	</form>


</body>
</html>
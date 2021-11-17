<%@page import="java.awt.image.BufferedImage"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="utf-8"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.oreilly.servlet.*"%>
<%@ page import="com.oreilly.servlet.multipart.*"%>
<%@ page import="javax.imageio.*"%>
<%@ page import="java.awt.image.*"%>
<%@ page import="java.io.File" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
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

	<%
		MultipartRequest multi = new MultipartRequest(request, "c:/Upload", 5 * 1024 * 1024, "utf-8",
				new DefaultFileRenamePolicy());

		String tmp;
		//Enumeration params = multi.getParameterNames(); //주의! 넘어오는 순서가 반대.
		String addVal = multi.getParameter("val"); //
		String rotate = multi.getParameter("rotate");
		
		//tmp = (String) params.nextElement();
		String algo = multi.getParameter("algo");
		String scale = multi.getParameter("scale");
		//String addImage2 = request.getParameter("addImage2");
		//dark();

		//  ** 파일 전송 **
		Enumeration files = multi.getFileNames();
		tmp = (String) files.nextElement();
		String filename = multi.getFilesystemName(tmp);
		out.println("<p>업로드 파일명 :" + filename);
		
		 String saveDirectory = getServletContext().getRealPath("/files");

		///////////////////////

		String para = addVal;
		%>
	
		<%!int[][][] inImage = null;
		int inH = 0, inW = 0;
		int[][][] outImage = null;
		int outH = 0, outW = 0;
		%>
<%
		// (1) JSP 파일 처리
		File inFp;
		FileInputStream inFs;
		inFp = new File("c:/Upload/" + filename); // mypic.png
		// 칼라 이미지 처리
		BufferedImage cImage = ImageIO.read(inFp);

		//inFs = new FileInputStream(inFp.getPath()); //占썬�쇽옙��占쏙옙占쎈�占� 獄�占쏙옙占쏙옙占�

		// (2) JSP 배열 처리 : 파일 --> 메모리(2차배열)
		//(중요!) 입력 폭, 높이 결정
		inW = cImage.getHeight();
		inH = cImage.getWidth();

		//Long fLen = inFp.length();
		//inH = inW = (int)Math.sqrt(fLen);

		inImage = new int[3][inH][inW];
		// 파일 --> 메모리
		for (int i = 0; i < inH; i++) {
			for (int k = 0; k < inW; k++) {
				int rgb = cImage.getRGB(i, k);
				//int a = (rgb >> 24) & 0xFF;
				int r = (rgb >> 16) & 0xFF;
				int g = (rgb >> 8) & 0xFF;
				int b = (rgb >> 0) & 0xFF;
				//rgb rbg grb gbr brg bgr
				inImage[0][i][k] = r;
				inImage[1][i][k] = g;
				inImage[2][i][k] = b;
				//inImage[3][i][k] = a;

				//inImage[i][k] = inFs.read();		
			}
		}
		//inFs.close();

		// (3) 영상처리 알고리즘 적용하기.
		switch (algo) {
		// 101. 반전처리
		case "101": // 반전 알고리즘 : out = 255 - in
			// (중요!) 출력 폭, 높이 결정 --> 알고리즘에 의존.
			outH = inH;
			outW = inW;
			outImage = new int[3][outH][outW];
			// ## 진짜 영상처리 알고리즘 ##
			for (int rgb = 0; rgb < 3; rgb++) {
				for (int i = 0; i < inH; i++) {
					for (int k = 0; k < inW; k++) {
						outImage[rgb][i][k] = 255 - inImage[rgb][i][k];
					}
				}
			}
			break;
		//102. 밝게/어둡게	
		case "102": //  out = in + para
			// (중요!) 출력 폭, 높이 결정 --> 알고리즘에 의존.
			outH = inH;
			outW = inW;
			outImage = new int[3][outH][outW];
			// ## 진짜 영상처리 알고리즘 ##
			for (int i = 0; i < inH; i++) {
				for (int k = 0; k < inW; k++) {
					int vr = inImage[0][i][k] + Integer.parseInt(para);
					int vg = inImage[1][i][k] + Integer.parseInt(para);
					int vb = inImage[2][i][k] + Integer.parseInt(para);
					if (vr > 255)
						vr = 255;
					if (vr < 0)
						vr = 0;
					if (vg > 255)
						vg = 255;
					if (vg < 0)
						vg = 0;
					if (vb > 255)
						vb = 255;
					if (vb < 0)
						vb = 0;
					outImage[0][i][k] = vr;
					outImage[1][i][k] = vg;
					outImage[2][i][k] = vb;
				}
			}
			break;
		//103. 파라볼라
		case "103": 
			// (중요!) 출력 폭, 높이 결정 --> 알고리즘에 의존.
			outH = inH;
			outW = inW;
			outImage = new int[3][outH][outW];
			int[] LUT = null;
			LUT = new int[256];
			//  ## 진짜 영상처리 알고리즘 ##
			for (int i = 0; i < 256; i++) {
				double outVal = 255.0 - 255.0 * Math.pow((i / 127.0 - 1), 2.0);
				if (outVal > 255.0)
					outVal = 255.0;
				if (outVal < 0.0)
					outVal = 0.0;
				LUT[i] = (int) outVal;
			}
			for (int rgb = 0; rgb < 3; rgb++) {
				for (int i = 0; i < inH; i++) {
					for (int k = 0; k < inW; k++) {
						int inVal = inImage[rgb][i][k];
						int v = LUT[inVal];
						if (v > 255)
							v = 255;
						if (v < 0)
							v = 0;
						outImage[rgb][i][k] = v;
					}
				}
			}
			break;
		// 104. 평활화	
		case "104":
			// (중요!) 출력 폭, 높이 결정 --> 알고리즘에 의존.
			outH = inH;
			outW = inW;
			outImage = new int[3][outH][outW];
			//  ## 진짜 영상처리 알고리즘 ##
			double[] histoR = new double[256];
			double[] histoG = new double[256];
			double[] histoB = new double[256];

			for (int i = 0; i < inH; i++) {
				for (int k = 0; k < inW; k++) {
					int ValueR = inImage[0][i][k];
					int ValueG = inImage[1][i][k];
					int ValueB = inImage[2][i][k];
					histoR[ValueR]++;
					histoG[ValueG]++;
					histoB[ValueB]++;
				}
			}
			double[] sumHistoR = new double[256];
			double sumValueR = 0;
			for (int i = 0; i < 256; i++) {
				sumValueR += histoR[i];
				sumHistoR[i] = sumValueR;
			}
			double[] sumHistoG = new double[256];
			double sumValueG = 0;
			for (int i = 0; i < 256; i++) {
				sumValueG += histoG[i];
				sumHistoG[i] = sumValueG;
			}
			double[] sumHistoB = new double[256];
			double sumValueB = 0;
			for (int i = 0; i < 256; i++) {
				sumValueB += histoB[i];
				sumHistoB[i] = sumValueB;
			}

			double[] normalHistoR = new double[256];
			for (int i = 0; i < 256; i++) {
				normalHistoR[i] = sumHistoR[i] * (1 / (inH * inW)) * 255;
			}
			double[] normalHistoG = new double[256];
			for (int i = 0; i < 256; i++) {
				normalHistoG[i] = sumHistoG[i] * (1 / (inH * inW)) * 255;
			}
			double[] normalHistoB = new double[256];
			for (int i = 0; i < 256; i++) {
				normalHistoB[i] = sumHistoB[i] * (1 / (inH * inW)) * 255;
			}

			for (int i = 0; i < inH; i++) {
				for (int k = 0; k < inW; k++) {
					int inValR = inImage[0][i][k];
					int inValG = inImage[1][i][k];
					int inValB = inImage[2][i][k];
				
					Double outValR = normalHistoR[inValR];
					Double outValG = normalHistoG[inValG];
					Double outValB = normalHistoB[inValB];
					if (outValR > 255.0)
						outValR = 255.0;
					if (outValR < 0.0)
						outValR = 0.0;
					if (outValG > 255.0)
						outValG = 255.0;
					if (outValG < 0.0)
						outValG = 0.0;
					if (outValB > 255.0)
						outValB = 255.0;
					if (outValB < 0.0)
						outValB = 0.0;

					outImage[0][i][k] = (int) Math.round(outValR);
					outImage[1][i][k] = (int) Math.round(outValG);
					outImage[2][i][k] = (int) Math.round(outValB);
				}
			}


			break;

			
			
			
			
			
		
			// 203.
			case "203": //상하
			outH = inH;
			outW = inW;
			// 메모리 할당
			outImage = new int[3][outH][outW];
			int temp;
			// 진짜 영상처리 알고리즘
			for (int rgb=0; rgb<3; rgb++)
			for(int i=0; i<inH; i++){
				for(int k=0; k<inW/2; k++){
					temp = inImage[rgb][i][k];
					inImage[rgb][i][k] = inImage[rgb][i][inW-k-1];
					inImage[rgb][i][inW-k-1] = temp;
				}
			}
			for (int rgb=0; rgb<3; rgb++)
			for(int i=0; i<inH; i++){
				for(int k=0; k<inW; k++){
					outImage[rgb][i][k] = inImage[rgb][i][k];
				}
			}
			break;

			// 204.
			case "204": //좌우
				

				outH = inH;
				outW = inW;
				// 메모리 할당
				outImage = new int[3][outH][outW];
				// 진짜 영상처리 알고리즘
				for (int rgb=0; rgb<3; rgb++)
				for(int i=0; i<inH/2; i++){
					for(int k=0; k<inW; k++){
						temp = inImage[rgb][i][k];
						inImage[rgb][i][k] = inImage[rgb][inH-i-1][k];
						inImage[rgb][inH-i-1][k] = temp;
					}
				}
				for (int rgb=0; rgb<3; rgb++)
				for(int i=0; i<inH; i++){
					for(int k=0; k<inW; k++){
						outImage[rgb][i][k] = inImage[rgb][i][k];
					}
				}
				break;
	
			
			
			// 303.
			case "303": //엠보싱
				outH = inH;
				outW = inW;
				int[][] mask1 = {{-1,0,0},{0,0,0},{0,0,1}};
				int[][][] tmpImage1 = new int[3][inH+2][inW+2];
				
				for (int rgb=0; rgb<3; rgb++)
				for(int i=0; i<inH; i++){
					for(int k=0; k<inW; k++){
						tmpImage1[rgb][i][k] = 127;
					}
				}
				for (int rgb=0; rgb<3; rgb++)
				for(int i=0; i<inH; i++){
					for(int k=0; k<inW; k++){
						tmpImage1[rgb][i+1][k+1] = inImage[rgb][i][k];
					}
				}
			
				// 메모리 할당
				outImage = new int[3][outH][outW];
				// 진짜 영상처리 알고리즘
				for (int rgb=0; rgb<3; rgb++)
				for(int i=0; i<inH; i++){
					for(int k=0; k<inW; k++){
						int x = 0;
						for(int m=0; m<3; m++){
							for(int n=0; n<3; n++){
								x += mask1[m][n]*tmpImage1[rgb][i+m][k+n];
							}
						}
						x += 127;
						if(x > 255)
							x = 255;
						if(x < 0)
							x = 0;
						outImage[rgb][i][k] = x;
					}
				}
				break;
	
			
			
			
			
			// 304.
			
			
			case "304": //블러링
				outH = inH;
				outW = inW;
				double[][] mask2 = {{1.0/9.0,1.0/9.0,1.0/9.0},
						{1.0/9.0,1.0/9.0,1.0/9.0},
						{1.0/9.0,1.0/9.0,1.0/9.0}};
				int[][][] tmpImage2 = new int[3][inH+2][inW+2];
				
				for (int rgb=0; rgb<3; rgb++)
				for(int i=0; i<inH; i++){
					for(int k=0; k<inW; k++){
						tmpImage2[rgb][i+1][k+1] = inImage[rgb][i][k];
					}
				}
			
				// 메모리 할당
				outImage = new int[3][outH][outW];
				// 진짜 영상처리 알고리즘
				for (int rgb=0; rgb<3; rgb++)
				for(int i=0; i<inH; i++){
					for(int k=0; k<inW; k++){
						double x = 0.0;
						for(int m=0; m<3; m++){
							for(int n=0; n<3; n++){
								x += mask2[m][n]*tmpImage2[rgb][i+m][k+n];
							}
						}
						if(x > 255)
							x = 255;
						if(x < 0)
							x = 0;
						outImage[rgb][i][k] = (int)x;
					}
				}
				break;
	
			
			// 401.
			case "401": //경계선
				
				outH = inH;
				outW = inW;
				double[][] maskW ={{-1.0,-1.0,-1.0},
									{0.0,0.0,0.0},
									{1.0,1.0,1.0}};
				double[][] maskH ={{1.0,0.0,-1.0},
									{1.0,0.0,-1.0},
									{1.0,0.0,-1.0}};
				int[][][] tmpImageW = new int[3][inH+2][inW+2];
				int[][][] tmpImageH = new int[3][inH+2][inW+2];
				int[][][] tmpImageW2 = new int[3][inH][inW];
				int[][][] tmpImageH2 = new int[3][inH][inW];
				
				for (int rgb=0; rgb<3; rgb++)
				for(int i=0; i<inH; i++){
					for(int k=0; k<inW; k++){
						tmpImageW[rgb][i+1][k+1] = inImage[rgb][i][k];
						tmpImageH[rgb][i+1][k+1] = inImage[rgb][i][k];
					}
				}
			
				// 메모리 할당
				outImage = new int[3][outH][outW];
				// 진짜 영상처리 알고리즘
				for (int rgb=0; rgb<3; rgb++)
				for(int i=0; i<inH; i++){
					for(int k=0; k<inW; k++){
						double x = 0.0, y = 0.0;
						for(int m=0; m<3; m++){
							for(int n=0; n<3; n++){
								x += maskW[m][n]*tmpImageW[rgb][i+m][k+n];
								y += maskH[m][n]*tmpImageW[rgb][i+m][k+n];
							}
						}
						int v = (int)Math.sqrt(x*x + y*y);
						if(v>255)
							v = 255;
						else if(v<0)
							v = 0;
						outImage[rgb][i][k] = v;
					}
				}
				break;
	
			
			
			// 402.
			
			case "402": //유사연산자
				
				outH = inH;
				outW = inW;
				int[][][] tmpImage6 = new int[3][inH+2][inW+2];
				
				for (int rgb=0; rgb<3; rgb++)
				for(int i=0; i<inH; i++){
					for(int k=0; k<inW; k++){
						tmpImage6[rgb][i+1][k+1] = inImage[rgb][i][k];
					}
				}
			
				// 메모리 할당
				outImage = new int[3][outH][outW];
				// 진짜 영상처리 알고리즘
				for (int rgb=0; rgb<3; rgb++)
				for(int i=0; i<inH; i++){
					for(int k=0; k<inW; k++){
						double max = 0.0;
						double x = 0.0;
						for(int m=0; m<3; m++){
							for(int n=0; n<3; n++){
								x = Math.abs(tmpImage6[rgb][i+1][k+1] - tmpImage6[rgb][i+m][k+n]);
								if(x>=max)
									max = x;
							}
						}
						if(max > 255)
							max = 255;
						if(max < 0)
							max = 0;
						outImage[rgb][i][k] = (int)max;
					}
				}
				break;

			
			// 404.
			case "404": //LOG
				
				outH = inH;
				outW = inW;
				int[][] mask8 = {{0,0,-1,0,0},
								{0,-1,-2,-1,0},
								{-1,-2,16,-2,-1},
								{0,-1,-2,-1,0},
								{0,0,-1,0,0}};
				int[][][] tmpImage8 = new int[3][inH+4][inW+4];
				
				for (int rgb=0; rgb<3; rgb++)
				for(int i=0; i<inH; i++){
					for(int k=0; k<inW; k++){
						tmpImage8[rgb][i+2][k+2] = inImage[rgb][i][k];
					}
				}
			
				// 메모리 할당
				outImage = new int[3][outH][outW];
				// 진짜 영상처리 알고리즘
				for (int rgb=0; rgb<3; rgb++)
				for(int i=0; i<inH; i++){
					for(int k=0; k<inW; k++){
						int x = 0;
						for(int m=0; m<5; m++){
							for(int n=0; n<5; n++){
								x += mask8[m][n]*tmpImage8[rgb][i+m][k+n];
							}
						}
						if(x > 255)
							x = 255;
						if(x < 0)
							x = 0;
						outImage[rgb][i][k] = x;
					}
				}
				break;
	


			
			// 405.
			case "405": //DOG
				
				outH = inH;
				outW = inW;
				int[][] mask9 = {{0,0,-1,-1,-1,0,0},
								{0,-2,-3,-3,-3,-2,0},
								{-1,-3,5,5,5,-3,-1},
								{-1,-3,5,16,5,-3,-1},
								{-1,-3,5,5,5,-3,-1},
								{0,-2,-3,-3,-3,-2,0},
								{0,0,-1,-1,-1,0,0}};
				int[][][] tmpImage9 = new int[3][inH+6][inW+6];
				
				for (int rgb=0; rgb<3; rgb++)
				for(int i=0; i<inH; i++){
					for(int k=0; k<inW; k++){
						tmpImage9[rgb][i+3][k+3] = inImage[rgb][i][k];
					}
				}
			
				// 메모리 할당
				outImage = new int[3][outH][outW];
				// 진짜 영상처리 알고리즘
				for (int rgb=0; rgb<3; rgb++)
				for(int i=0; i<inH; i++){
					for(int k=0; k<inW; k++){
						int x = 0;
						for(int m=0; m<7; m++){
							for(int n=0; n<7; n++){
								x += mask9[m][n]*tmpImage9[rgb][i+m][k+n];
							}
						}
						if(x > 255)
							x = 255;
						if(x < 0)
							x = 0;
						outImage[rgb][i][k] = x;
					}
				}break;
	
			// 406.
			case "406": //라플라시안
				
				outH = inH;
				outW = inW;
				double[][] mask10 = {{0.0,1.0,0.0},
									{1.0,-4.0,1.0},
									{0.0,1.0,0.0}};
				int[][][] tmpImage10 = new int[3][inH+2][inW+2];
				
				for (int rgb=0; rgb<3; rgb++)
				for(int i=0; i<inH; i++){
					for(int k=0; k<inW; k++){
						tmpImage10[rgb][i+1][k+1] = inImage[rgb][i][k];
					}
				}
			
				// 메모리 할당
				outImage = new int[3][outH][outW];
				// 진짜 영상처리 알고리즘
				for (int rgb=0; rgb<3; rgb++)
				for(int i=0; i<inH; i++){
					for(int k=0; k<inW; k++){
						double x = 0.0;
						for(int m=0; m<3; m++){
							for(int n=0; n<3; n++){
								x += mask10[m][n]*tmpImage10[rgb][i+m][k+n];
							}
						}
						if(x > 255)
							x = 255;
						if(x < 0)
							x = 0;
						outImage[rgb][i][k] = (int)x;
					}
				}
				break;
	

		}

		// (4)  결과를 파일에 쓰기
		File outFp;
		FileOutputStream outFs;
		String outname = "out_" + filename;
		outFp = new File("c:/out/" + outname);
		//outFs = new FileOutputStream(outFp.getPath());

		// 칼라 이미지 저장
		BufferedImage outCImage = new BufferedImage(outH, outW, BufferedImage.TYPE_INT_RGB);

		// 메모리 --> 파일
		for (int i = 0; i < outH; i++) {
			for (int k = 0; k < outW; k++) {
				int r = outImage[0][i][k];
				int g = outImage[1][i][k];
				int b = outImage[2][i][k];
				int px = 0;
				px = px | (r << 16);
				px = px | (g << 8);
				px = px | (b << 0);
				outCImage.setRGB(i, k, px);
			}
		}
		ImageIO.write(outCImage, "jpg", outFp);
		//outFs.close();

		out.println(algo + "  <h1> 처리 끝 </h1>");
		
		

		String url = "<p><h1><a href='http://192.168.56.101:8080/SampleJSP/";
		url += "download.jsp?file=" + outname + "'>download!</a></h1>";
		out.println(url);
	%>
	
	


<div id="canvas">
            <canvas width="400" height="0"></canvas>
            <canvas class="incanvas" id='inCanvas' width=0px height=0px></canvas>
            <canvas class="out_canvas" id='outCanvas' width=0px height=0px> </canvas>
        </div>




</body>
</html>
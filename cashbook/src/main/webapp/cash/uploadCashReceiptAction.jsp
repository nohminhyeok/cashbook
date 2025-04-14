<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.nio.file.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.io.*" %>
<%@ page import="model.*" %>
<%@ page import="dto.*" %>
<%
	String fullDate = request.getParameter("fullDate");
	System.out.println("fullDate.ReceiptAction :" +fullDate);
	int cash_no = Integer.parseInt(request.getParameter("cash_no"));
	System.out.println("cash_no.ReceiptAction :" +cash_no);

	Part part = request.getPart("imageFile"); // 파일 받는 API  
	String originalName = part.getSubmittedFileName();
	System.out.println("originalName : "+originalName);
	// 1) 중복되지 않는 새로운 파일이름 생성 - java.util.UUID API 사용
	UUID uuid = UUID.randomUUID();
	String filename = uuid.toString();
	filename = filename.replace("-", ""); // str 내의 - 를 공백으로 변경
	System.out.println("uuid filename : "+filename);
	
	
	// 2) 1의 결과에 확장자 추가
	int dotLastPos = originalName.lastIndexOf("."); // 마지막 . 의 인덱스 값을 반환
	System.out.println("dotLastPos : "+dotLastPos);
	
	// 확장자 받기
	String ext = originalName.substring(dotLastPos);
	
	// 파일의 확장자가 .png가 아니면 다시 사진 올리는 페이지로 이동
	// request 입력값 유효성 검정
	if(!ext.equals(".png")){
		response.sendRedirect("/cashbook/cash/uploadCashReceiptForm?msg=ErrorNotPng");
		return;
	}
	
	filename = filename + originalName.substring(dotLastPos);
	System.out.println("filename : "+filename);

	Receipt rec = new Receipt();
	rec.setCash_no(cash_no);
	rec.setFilename(filename);
	
	
	// 3) 파일 저장
	// 빈 파일 생성
	// File emptyFile = new File();
	String path = request.getServletContext().getRealPath("upload"); // 톰캣 내부의 poll 프로젝트 내부에 upload폴더의 실제 물리적 주소를 반환
	System.out.println("path : "+ path);
	File emptyFile = new File(path, filename);
	// 파일을 보낼 inputStream 설정
	InputStream is = part.getInputStream(); // 파트 내부의 스트림(이미지파일의 바이너리파일)
	// 파일을 받을 outputStream 설정
	OutputStream os = Files.newOutputStream(emptyFile.toPath());
	is.transferTo(os); // is(inputStream)의 binary - > 반복(1byte씩) - > os(outputStream)으로 보내줌
	
	
	// 4) db의 저장
	ReceiptDao recDao = new ReceiptDao();
	recDao.insertReceipt(rec);
	
	response.sendRedirect("/cashbook/cash/cashOne.jsp?cash_no=" + cash_no + "&fullDate=" + fullDate);

%>
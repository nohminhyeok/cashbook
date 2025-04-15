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

	// 업로드된 이미지 파일 받기
	Part part = request.getPart("imageFile"); // part에 업로드한 imageFile을 받아옴
	String originalName = part.getSubmittedFileName(); // 원본 파일명
	System.out.println("originalName : "+originalName);

	// 1) UUID로 저장할 고유 파일명 생성
	UUID uuid = UUID.randomUUID(); // 중복 방지를 위해 랜덤 UUID 생성
	String filename = uuid.toString().replace("-", ""); // "-" 제거
	System.out.println("uuid filename : "+filename);

	// 2) 원본 파일명에서 확장자 추출
	int dotLastPos = originalName.lastIndexOf("."); // 마지막 '.' 위치 찾기 파일이 어떤 형식인지 알기 위해 .jpg 같은
	System.out.println("dotLastPos : "+dotLastPos);
	String ext = originalName.substring(dotLastPos); // 확장자 자르기

	// 확장자가 .png가 아니면 업로드 실패 처리 (유효성 검사)
	if(!ext.equals(".png")){
		// 업로드 폼으로 다시 이동 (에러 메시지 전달)
		response.sendRedirect("/cashbook/cash/uploadCashReceiptForm?msg=ErrorNotPng");
		return;
	}

	// 최종 저장할 파일명 = uuid + 확장자
	filename = filename + ext; // -를 자른 랜덤한 uuid의 이름에 .png를 붙임
	System.out.println("filename : "+filename);

	// 3) Receipt 객체 생성 후 값 세팅
	Receipt rec = new Receipt();
	rec.setCash_no(cash_no);
	rec.setFilename(filename);

	// 4) 실제 서버 upload 폴더 경로 얻기
	String path = request.getServletContext().getRealPath("upload");
	System.out.println("path : "+ path);

	// 저장할 위치의 파일 객체 생성
	File emptyFile = new File(path, filename);

	// 업로드된 이미지 데이터를 읽을 InputStream
	InputStream is = part.getInputStream();

	// 저장할 파일에 쓸 OutputStream
	OutputStream os = Files.newOutputStream(emptyFile.toPath());

	// 이미지 데이터를 파일로 복사
	is.transferTo(os);

	// 5) DB에 영수증 정보 저장
	ReceiptDao recDao = new ReceiptDao();
	recDao.insertReceipt(rec);

	// 6) 상세보기 페이지로 이동
	response.sendRedirect("/cashbook/cash/cashOne.jsp?cash_no=" + cash_no + "&fullDate=" + fullDate);
%>

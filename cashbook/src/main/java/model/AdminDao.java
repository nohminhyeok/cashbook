package model;

import java.sql.Connection;

import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import dto.Admin;
import jakarta.servlet.http.HttpSession;

public class AdminDao {
	public Admin selectAdmin(String id, String pw) throws ClassNotFoundException, SQLException {
		Admin admin = null;

		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		
		String sql = "select * from admin where admin_id like ? and admin_pw like ?";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, id);
		stmt.setString(2, pw);
		
		rs = stmt.executeQuery();
		
		if(rs.next()) {
			admin = new Admin();
			admin.setAdmin_id(rs.getString("admin_id"));
			admin.setAdmin_pw(rs.getString("admin_pw"));
		}
		
		conn.close();
		return admin;        
	}
	
	public Admin updateAdminPw(String id, String prePw, String newPw) throws ClassNotFoundException, SQLException {
		Admin admin = null;
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		
		String sql = "update admin set admin_pw = ? where admin_id = ? and admin_pw = ?";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, newPw);
		stmt.setString(2, id);
		stmt.setString(3, prePw);
		
	    int rowsUpdated = stmt.executeUpdate(); // 수정된 행의 개수 반환
	    
	    // 업데이트된 행이 있다면
	    if (rowsUpdated > 0) {
	        admin = new Admin();
	        admin.setAdmin_pw(newPw);  // 업데이트된 새 비밀번호
	        System.out.println("비밀번호가 성공적으로 업데이트되었습니다.");
	    } else {
	        System.out.println("사용자 정보를 다시 확인해 주세요");
	    }
	    conn.close();
		return admin;

	}
	
	public int loginck(String id, String pw, HttpSession session) throws ClassNotFoundException, SQLException {
	    
	    Class.forName("com.mysql.cj.jdbc.Driver");
	    Connection conn = null;
	    PreparedStatement stmt = null;
	    ResultSet rs = null;

	    // 데이터베이스 연결
	    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
	    
	    // SQL 쿼리 수정: admin_id와 admin_pw 조건을 AND로 연결
	    String sql = "SELECT * FROM admin WHERE admin_id = ? AND admin_pw = ?";
	    stmt = conn.prepareStatement(sql);
	    
	    stmt.setString(1, id);
	    stmt.setString(2, pw);
	    
	    // 쿼리 실행
	    rs = stmt.executeQuery();  // executeQuery()로 수정
	    
	    int ck = 0;
	     
	    if (rs.next()) {
	        // 조회된 데이터가 있을 경우 (로그인 성공)
	        System.out.println("로그인 성공");
	        ck = 1;

	        // 세션에 사용자 정보 저장 (예: 사용자 ID 또는 이름)
	        session.setAttribute("adminId", rs.getString("admin_id")); // adminId를 세션에 저장
	    } else {
	        // 로그인 실패 시
	        System.out.println("비번 불일치");
	        ck = 2;
	    }
	    
	    conn.close();

	    return ck; // 사용하지 않지만 메소드에서 int를 반환해야 하므로 0을 반환
	}
}

package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import dto.Receipt;

public class ReceiptDao {
	public void insertReceipt(Receipt rec) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		String sql = "insert into receipt(cash_no, filename, createdate) values(?, ?, now())";
		stmt=conn.prepareStatement(sql);
		stmt.setInt(1, rec.getCash_no());
		stmt.setString(2, rec.getFilename());		
		int rowsUpdated = stmt.executeUpdate();

        if (rowsUpdated == 0) {
          System.out.println("등록되지 않았습니다.");
        }
		conn.close();		
	}
	
	public ArrayList<Receipt> selectReceiptListByCashNo(int cash_no) throws ClassNotFoundException, SQLException {
		ArrayList<Receipt> list = new ArrayList<Receipt>();
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		String sql = "SELECT * FROM receipt WHERE cash_no = ? ORDER BY createdate DESC";
		
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, cash_no);
		rs = stmt.executeQuery();
		
		while(rs.next()) {
			Receipt rec = new Receipt();
			rec.setCash_no(rs.getInt("cash_no"));
			rec.setFilename(rs.getString("filename"));
			rec.setCreatedate(rs.getString("createdate"));
			list.add(rec);
		}
		
		conn.close();
		return list;
	}
	
	public void deleteReceipt(int cash_no) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
		String sql = "delete from receipt where cash_no = ?";
		
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, cash_no);
		stmt.executeUpdate();
		
		conn.close();
	}
	
	public boolean hasReceipt(int cash_no) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");

		String sql = "SELECT cash_no FROM receipt WHERE cash_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, cash_no);
		ResultSet rs = stmt.executeQuery();

		boolean exists = rs.next();
		conn.close();
		return exists;
	}
}

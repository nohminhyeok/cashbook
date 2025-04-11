package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import dto.Cash;
import dto.Category;
import dto.Paging;

public class CashDao {
	public ArrayList<Cash> selectCash(Paging p) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook","root","java1234");

		String sql = "SELECT * FROM cash ORDER BY cash_date ASC LIMIT ?, ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, p.getBeginRow());
		stmt.setInt(2, p.getRowPerPage());

		ResultSet rs = stmt.executeQuery();

		ArrayList<Cash> list = new ArrayList<>();
		while(rs.next()) {
			Cash c = new Cash();
			c.setCash_no(rs.getInt("cash_no"));
			c.setCategory_no(rs.getInt("category_no"));
			c.setCash_date(rs.getString("cash_date"));
			c.setAmount(rs.getInt("amount"));
			c.setMemo(rs.getString("memo"));
			c.setColor(rs.getString("color"));
			c.setCreatedate(rs.getString("createdate"));
			c.setUpdatedate(rs.getString("updatedate"));
			list.add(c);
		}
		conn.close();
		return list;
	}
	
	public int countCash() throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook","root","java1234");

		String sql = "SELECT COUNT(*) FROM cash";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();

		int count = 0;
		if(rs.next()) {
			count = rs.getInt(1);
		}
		conn.close();
		return count;
	}
	
	public ArrayList<Cash> selectCashListByMonth(String targetYear, String targetMonth) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
	    PreparedStatement stmt = null;
	    ResultSet rs = null;
	    String sql = "SELECT * FROM cash WHERE YEAR(cash_date) = ? AND MONTH(cash_date) = ?";
	    stmt = conn.prepareStatement(sql);
	    stmt.setInt(1, Integer.parseInt(targetYear));
	    stmt.setInt(2, Integer.parseInt(targetMonth) + 1);
	    
	    rs = stmt.executeQuery();
	    ArrayList<Cash> list = new ArrayList<>();
	    while(rs.next()) {
	    	Cash c = new Cash();
	    	c.setCash_no(rs.getInt("cash_no"));
	    	c.setCategory_no(rs.getInt("category_no"));
	    	c.setCash_date(rs.getString("cash_date"));
	    	c.setAmount(rs.getInt("amount"));
	    	c.setMemo(rs.getString("memo"));
	    	c.setColor(rs.getString("color"));
	    	c.setCreatedate(rs.getString("createdate"));
	    	c.setUpdatedate(rs.getString("updatedate"));
	    	list.add(c);
	    }
	    
	    conn.close();
		return list;
	}
	
	public ArrayList<Cash> selectCashByDay(String fullDate) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
	    PreparedStatement stmt = null;
	    ResultSet rs = null;
	    String sql = "SELECT * FROM cash where cash_date = ?";
	    stmt = conn.prepareStatement(sql);
	    stmt.setString(1, fullDate);
	    
	    rs = stmt.executeQuery();
	    ArrayList<Cash> list = new ArrayList<>();
	    while(rs.next()) {
	    	Cash c = new Cash();
	    	c.setCash_no(rs.getInt("cash_no"));
	    	c.setCategory_no(rs.getInt("category_no"));
	    	c.setCash_date(rs.getString("cash_date"));
	    	c.setAmount(rs.getInt("amount"));
	    	c.setMemo(rs.getString("memo"));
	    	c.setColor(rs.getString("color"));
	    	c.setCreatedate(rs.getString("createdate"));
	    	c.setUpdatedate(rs.getString("updatedate"));
	    	list.add(c);
	    }
	    
	    conn.close();
		return list;
	}
	
	public void insertCash(Cash c) throws SQLException, ClassNotFoundException{
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook","root","java1234");
		String sql = "insert into cash(category_no, cash_date, amount, memo, color) values(?, ?, ?, ?, ?)";
		stmt = conn.prepareStatement(sql);
		stmt.setInt(1, c.getCategory_no());
		stmt.setString(2, c.getCash_date());
		stmt.setInt(3, c.getAmount());
		stmt.setString(4, c.getMemo());
		stmt.setString(5, c.getColor());
		
		int row = stmt.executeUpdate();
		if(row == 1) {
			System.out.println("CategoryDao.insertcategory - 입력성공");
		} else {
			System.out.println("CategoryDao.insertcategory - 입력실패");
		}
		conn.close();
	}
	
	public ArrayList<Cash> selectCashByNo(int cash_no) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook","root","java1234");

		String sql = "SELECT * FROM cash where cash_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, cash_no);

		ResultSet rs = stmt.executeQuery();

		ArrayList<Cash> list = new ArrayList<>();
		while(rs.next()) {
			Cash c = new Cash();
			c.setCash_no(rs.getInt("cash_no"));
			c.setCategory_no(rs.getInt("category_no"));
			c.setCash_date(rs.getString("cash_date"));
			c.setAmount(rs.getInt("amount"));
			c.setMemo(rs.getString("memo"));
			c.setColor(rs.getString("color"));
			c.setCreatedate(rs.getString("createdate"));
			c.setUpdatedate(rs.getString("updatedate"));
			list.add(c);
		}
		conn.close();
		return list;
	}
	
	public Cash updateCash(String cash_date, int amount, String memo, String color, int cash_no) throws ClassNotFoundException, SQLException {
		Cash cash = new Cash();
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook","root","java1234");

		String sql = "update cash set cash_date = ?, amount = ?, memo = ?, color = ? where cash_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, cash_date);
		stmt.setInt(2, amount);
		stmt.setString(3, memo);
		stmt.setString(4, color);
		stmt.setInt(5, cash_no);

		int rowsAffected = stmt.executeUpdate();
		
		if(rowsAffected > 0) {
			cash.setCash_date(cash_date);
			cash.setAmount(amount);
			cash.setMemo(memo);
			cash.setColor(color);
		}
		
		stmt.close();
		conn.close();
		return cash;
	}
	
	public int deleteCash(int cash_no) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook","root","java1234");
		
		String sql = "delete from cash where cash_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, cash_no);
		
		int rowsAffected = stmt.executeUpdate();
	    
	    // 자원 반납
	    stmt.close();
	    conn.close();
	    
	    return rowsAffected; // 삭제된 행 수 반환
	}
}

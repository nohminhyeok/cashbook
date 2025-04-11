package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import dto.Cash;
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
}

package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import dto.Category;
import dto.Paging;

public class CategoryDao {
	public void insertCategory(Category category) throws SQLException, ClassNotFoundException{
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook","root","java1234");
		String sql = "insert into category(kind, title) values(?, ?)";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, category.getKind());
		stmt.setString(2, category.getTitle());
		int row = stmt.executeUpdate();
		if(row == 1) {
			System.out.println("CategoryDao.insertcategory - 입력성공");
		} else {
			System.out.println("CategoryDao.insertcategory - 입력실패");
		}
		conn.close();
	}

	public ArrayList<Category> selectCategory(Paging p, String searchWord) throws ClassNotFoundException, SQLException {
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook","root","java1234");
		String sql = "select * from category where title like ? order by category_no desc limit ?, ?";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, "%"+searchWord+"%");
		stmt.setInt(2, p.getBeginRow());
		stmt.setInt(3, p.getRowPerPage());
		rs = stmt.executeQuery();

		ArrayList<Category> list = new ArrayList<>();
		while(rs.next()) {
			Category c = new Category();
			c.setCategory_no(rs.getInt("category_no"));
			c.setKind(rs.getString("kind"));
			c.setTitle(rs.getString("title"));
			c.setCreatedate(rs.getString("createdate"));
			list.add(c);
		}
		conn.close();
		return list;
		
	}
	
	public int totalCountCategory(String searchWord) throws ClassNotFoundException, SQLException {
		int row = 0;
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook","root","java1234");
		String sql = "select count(*) as cnt from category where title like ?";
		stmt = conn.prepareStatement(sql);
		stmt.setString(1, "%"+searchWord+"%");
		rs=stmt.executeQuery();
		
		if(rs.next()) {
			row = rs.getInt(1);
		}
		
		conn.close();
		return row;
	}
	
	public Category updateCategory(int category_no, String kind, String title) throws ClassNotFoundException, SQLException {
	    Category category = new Category();
	    
	    Connection conn = null;
	    PreparedStatement stmt = null;
	    
	    Class.forName("com.mysql.cj.jdbc.Driver");
	    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook","root","java1234");
	    
	    String sql = "update category set kind = ?, title = ? where category_no = ?";
	    stmt = conn.prepareStatement(sql);
	    stmt.setString(1, kind);
	    stmt.setString(2, title);
	    stmt.setInt(3, category_no);
	    
	    // executeUpdate()로 결과 처리
	    int rowsAffected = stmt.executeUpdate();
	    
	    // 업데이트된 데이터를 category 객체에 반영
	    if (rowsAffected > 0) {
	        category.setKind(kind);
	        category.setTitle(title);
	        category.setCategory_no(category_no);
	    }

	    // 자원 반납
	    stmt.close();
	    conn.close();

	    return category;
	}

	public int deleteCategory(int no) throws ClassNotFoundException, SQLException {
	    Connection conn = null;
	    PreparedStatement stmt = null;
	    
	    // JDBC 드라이버 로드
	    Class.forName("com.mysql.cj.jdbc.Driver");
	    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook","root","java1234");
	    
	    String sql = "delete from category where category_no = ?";
	    stmt = conn.prepareStatement(sql);
	    stmt.setInt(1, no);
	    
	    // 삭제 작업 수행
	    int rowsAffected = stmt.executeUpdate();
	    
	    // 자원 반납
	    stmt.close();
	    conn.close();
	    
	    return rowsAffected; // 삭제된 행 수 반환
	}
	
	public boolean isDuplicateCategory(String kind, String title) throws SQLException, ClassNotFoundException {
	    Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
	    PreparedStatement stmt = null;
	    ResultSet rs = null;
	    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");

	    String sql = "SELECT COUNT(*) FROM category WHERE kind = ? AND title = ?";
	    stmt = conn.prepareStatement(sql);
	    stmt.setString(1, kind);
	    stmt.setString(2, title);
	    rs = stmt.executeQuery();

	    boolean result = false;
	    if (rs.next()) {
	        result = rs.getInt(1) > 0;
	    }

	    // 자원 수동 해제
	    stmt.close();
	    conn.close();

	    return result;
	}
	
	public ArrayList<Category> selectCategoryListBykind(String kind) throws SQLException, ClassNotFoundException{
		ArrayList<Category>list = new ArrayList<>();
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection conn = null;
		conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
	    PreparedStatement stmt = null;
	    ResultSet rs = null;
	    String sql = "select category_no, title from category where kind = ?";
	    stmt = conn.prepareStatement(sql);
	    stmt.setString(1, kind);
	    rs = stmt.executeQuery();
	    while(rs.next()) {
	    	Category c = new Category();
	    	c.setCategory_no(rs.getInt("category_no"));
	    	c.setTitle(rs.getString("title"));
	    	list.add(c);
	    }
	    	
	    return list;
	}
	
	public ArrayList<Category> selectCategoryList() throws SQLException, ClassNotFoundException {
	    ArrayList<Category> list = new ArrayList<>();
	    Class.forName("com.mysql.cj.jdbc.Driver");
	    Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/cashbook", "root", "java1234");
	    PreparedStatement stmt = null;
	    ResultSet rs = null;

	    String sql = "SELECT category_no, kind, title FROM category";
	    stmt = conn.prepareStatement(sql);
	    rs = stmt.executeQuery();

	    while (rs.next()) {
	        Category c = new Category();
	        c.setCategory_no(rs.getInt("category_no"));
	        c.setKind(rs.getString("kind"));
	        c.setTitle(rs.getString("title"));
	        list.add(c);
	    }

	    rs.close();
	    stmt.close();
	    conn.close();

	    return list;
	}
	
}

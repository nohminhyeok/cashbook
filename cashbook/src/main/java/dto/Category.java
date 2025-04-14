package dto;

public class Category {
	public int category_no;
	public String kind;
	public String title;
	public String createdate;
	private int count;
	private int amount;
	private int month;

	public int getMonth() { return month; }
	public void setMonth(int month) { this.month = month; }
	// Getter/Setter 추가
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public int getAmount() {
		return amount;
	}
	public void setAmount(int amount) {
		this.amount = amount;
	}
	public int getCategory_no() {
		return category_no;
	}
	public void setCategory_no(int category_no) {
		this.category_no = category_no;
	}
	public String getKind() {
		return kind;
	}
	public void setKind(String kind) {
		this.kind = kind;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getCreatedate() {
		return createdate;
	}
	public void setCreatedate(String createdate) {
		this.createdate = createdate;
	}
	@Override
	public String toString() {
		return "Category [category_no=" + category_no + ", kind=" + kind + ", title=" + title + ", createdate="
				+ createdate + "]";
	}
}

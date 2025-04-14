package dto;

public class Receipt {
	public int cash_no;
	public String filename;
	public String createdate;
	public int getCash_no() {
		return cash_no;
	}
	public void setCash_no(int cash_no) {
		this.cash_no = cash_no;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public String getCreatedate() {
		return createdate;
	}
	public void setCreatedate(String createdate) {
		this.createdate = createdate;
	}
	@Override
	public String toString() {
		return "Receipt [cash_no=" + cash_no + ", filename=" + filename + ", createdate=" + createdate + "]";
	}
}

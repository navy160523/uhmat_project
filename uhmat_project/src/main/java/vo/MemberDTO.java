package vo;

import java.sql.Date;
/*
CREATE TABLE member (
nickname VARCHAR(50) UNIQUE NOT NULL,
name VARCHAR(5),
email VARCHAR(25) PRIMARY KEY,
passwd VARCHAR(16),
birthdate DATE,
postcode VARCHAR(5),
address1 varchar(50),
address2 varchar(50),
icon VARCHAR(20) DEFAULT 'default.png',
auth_status VARCHAR(1) DEFAULT 'N',
api_id VARCHAR(60)
);
*/
//멤버 관리 하는 클래스
public class MemberDTO {
	private String email;
	private String name;
	private String passwd;
	private String nickName;
	private Date birthdate;
	private Date hiredate;
	private String postCode;
	private String address1;
	private String address2;
	private String icon;
	private String auth_status;
	private String api_id;
	
	

	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getNickName() {
		return nickName;
	}
	public void setNickName(String nickName) {
		this.nickName = nickName;
	}
	public Date getBirthdate() {
		return birthdate;
	}
	public void setBirthdate(Date birthdate) {
		this.birthdate = birthdate;
	}
	public Date getHiredate() {
		return hiredate;
	}
	public void setHiredate(Date hiredate) {
		this.hiredate = hiredate;
	}
	public String getPasswd() {
		return passwd;
	}
	public void setPasswd(String passwd) {
		this.passwd = passwd;
	}


	public String getPostCode() {
		return postCode;
	}
	public void setPostCode(String postCode) {
		this.postCode = postCode;
	}
	public String getAddress1() {
		return address1;
	}
	public void setAddress1(String address1) {
		this.address1 = address1;
	}
	public String getAddress2() {
		return address2;
	}
	public void setAddress2(String address2) {
		this.address2 = address2;
	}
	



	public String getIcon() {
		return icon;
	}
	public void setIcon(String icon) {
		this.icon = icon;
	}
	public String getAuth_status() {
		return auth_status;
	}
	public void setAuth_status(String auth_status) {
		this.auth_status = auth_status;
	}
	public String getApi_id() {
		return api_id;
	}
	public void setApi_id(String api_id) {
		this.api_id = api_id;
	}

	


	 
	

}

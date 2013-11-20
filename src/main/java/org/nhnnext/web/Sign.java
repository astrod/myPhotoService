package org.nhnnext.web;


import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class Sign {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Long id;
	
	public Long getId() {
	// TODO Auto-generated method stub
	return id;
}



	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getUserpsd() {
		return userpsd;
	}

	public void setUserpsd(String userpsd) {
		this.userpsd = userpsd;
	}



	@Column(length=50, nullable=false)
	private String userid;
	
	@Column(length=50, nullable=false)
	private String userpsd;



	


		

}


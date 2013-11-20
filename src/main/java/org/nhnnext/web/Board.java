package org.nhnnext.web;


import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;

@Entity
public class Board {
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private Long id;

	@Column(length=50, nullable=false)
	private String title;
	@Column(length=1000, nullable=false)
	private String contents;

	@Column(length=50, nullable=true)
	private String fileName;
	
	public String getFileName() {
		return fileName;
	}
	
	@OneToMany(mappedBy = "board", fetch = FetchType.EAGER) //두 개의 데이터베이스를 서로 매핑해주는 것임. 원 투 매니는 이쪽에는 하나, 반대쪽
	//데이터베이스에는 많은 데이터를 매핑한다는 뜻임.
    private List<Comment> comments;
	
	public List<Comment> getComments(){
		return comments;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	@Override
	public String toString() {
		return "Board [title=" + title + ", contents=" + contents + "]";
	}

	public Long getId() {
		// TODO Auto-generated method stub
		return id;
	}
		

}

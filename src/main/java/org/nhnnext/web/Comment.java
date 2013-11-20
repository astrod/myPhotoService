package org.nhnnext.web;
 //@~~ 은 어노테이션형으로 프로그램에 영향을 미치는 게 아니라, 컴파일할 때 개발자에게 주석같이 설명처럼 알려주는 형

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;

import org.codehaus.jackson.annotate.JsonIgnore;

@Entity //자바 객체와 데이터베이스 테이블을 매핑한다.
public class Comment {
	@Id //데이터베이스의 primary key와 매핑한다.
	@GeneratedValue(strategy = GenerationType.AUTO) //id생성 규칙에 관한 설정이다. generator와 strategy가 있다. 후자는 엔터키가 주키를
	//생성할 때 하는 주키생성 전략을 의미한다. 디폴트값은 오토이다.
	private Long id;


	@Column(length=1000, nullable=false) // 클래스 필드와 테이블 칼럼을 매핑한다. 랭쓰는 칼럼의 길이고, 널어블은 빈칸으로 남겨놔도 되는지에 관한 설정이
	private String contents;


	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	@Override // 상속이 제대로 기능하는지 확인하는 어노테이션임. 상속실수를 예방하는 역할을 한다.
	public String toString() {
		return "Comments [id=" + id + ", contents=" + contents + "]";
	}

	public Long getId() {
		// TODO Auto-generated method stub
		return id;
	}
		
	
	public Comment(String contents, Board board)
	{
		this.contents = contents;
		this.board = board;
	}

	@JsonIgnore
	@ManyToOne //반대로 많은 데이터를 하나로 매핑해주는 것.
	private Board board;
	
	public Comment() {
		
	}
	
	public Board getBoard() {
		return board;
	}

}

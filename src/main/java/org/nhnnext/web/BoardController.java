package org.nhnnext.web;

import java.util.List;

import org.nhnnext.repository.BoardRepository;
import org.nhnnext.repository.CommentRepository;
import org.nhnnext.support.FileUploader;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;


@Controller //  컨트롤러를 붙임으로써 웹 속성을 처리하는 컨트롤러로 사용할 수 있다.
public class BoardController {
	private static final Logger log = LoggerFactory.getLogger(BoardController.class);
	@Autowired // 자동으로 아래 타입의 BoardRepository의 객체를 생성시킨다. 
	private BoardRepository boardRepository; // private : 같은 클래스 내에서만 접근할 수 있는 변수이다.
	
	@RequestMapping("/board") // 각각의 메서드가 처리할 요청 URL을 설정한다.
	public String list(Model model) {
		model.addAttribute("boards", boardRepository.findAll()); // model은 jsp에 출력할 데이터를 전달한다. addAttribute는 공급된 어트리뷰트를 제공된 이름으로 더한다.
		                                                         // "boards"는 공급된 어트리뷰트의 이름이다. 뒤의 보드 리퍼지터리.findall은 모델 속성값이다.
																// findAll은 모든 타입의 인스턴값을 리턴하라는 의미이다.
		// =>모델로 데이터를 전달할 건데, 모델에 지금 내가 말하는 어트리뷰트를 더해. 이름은 "boards"고, 속성값은 보드 리퍼지터리에 있는 모든 인스턴스값이야.
		// 그럼 이제 그걸 model을 통해 list로 전달할 거야.
		return "list";
	}
	
	@RequestMapping("/board/form")
	public String form() {
		return "form";
	}
	
	@RequestMapping("/board/{id}/remove")
	public String remove(@PathVariable long id, Model model) {
		Board removedboard = boardRepository.findOne(id);
		model.addAttribute("remove", removedboard);
		return "remove";
	}
	
	@RequestMapping(value="/board/removepage/{id}", method=RequestMethod.POST)
	public String removepage(@PathVariable long id, Board board) //페이지를 수정하는 과
	{
		Board tempboard = boardRepository.findOne(id); //id를 가져와서 id에 해당하는 데이터를 tmepboard에 저장한다.
		tempboard.setTitle(board.getTitle()); // tempboard에 setTitle을 이용, board에 getTitle로 얻어온 걸 저장한다.(넘어온 인자는 자동적으로 board 에 저장된다)
		tempboard.setContents(board.getContents()); // 마찬가지로 보드에 저장된 컨텐츠를 불러와, tempboard에 저장한다.
		
		boardRepository.save(tempboard); //이제 tmepboard에 저장된 걸 boardRepository에 저장한다.
		
		return "redirect:/board/"; //리다이렉트!
	}
	
	@Autowired
	private CommentRepository commentRepository;
	
	@RequestMapping(value="/board/{id}/delete", method=RequestMethod.POST)
	public String deletepage(@PathVariable long id) {
		Board deleteboard = boardRepository.findOne(id); //보드의 데이터를 받아온다.
		List<Comment> commentList = deleteboard.getComments(); // List를 만든다. <>안의 것은 데이터형이다. 거기에 코맨트를 넣는다.
		if(commentList.size()>0) { //만약 코멘트가 있다면?
		for(int i=0; i<commentList.size(); i++)
		{
			commentRepository.delete(commentList.get(i).getId()); // 코멘트리스트를 돌면서 get(i)로 데이터에 접근, getId로 Id를 받는다. 그 이후에 삭제한다. 
			boardRepository.delete(id);
		}
		}
		else
		{
			boardRepository.delete(id); //코멘트가 없으면 그냥 삭제해도 댐.
		}
		return "redirect:/board/";
		
	}
	
	
	@RequestMapping(value="/board", method=RequestMethod.POST) //RequestMethod 에 POST / GET 의 요청을 사용할 수 있음.
	         												   //GET은 자원을 조회하는데 사용한다. POST는 자원을 추가하거나 상태를 변경하는데 사용한다.
	
	public String create(Board board, MultipartFile file) {
		
		log.debug("board : {}", board);
		String fileName = FileUploader.upload(file); //form에 형성되있는 name 뒤의 명칭으로 서버로 전송되는 것을 찾을 수 있다. 여기에서는
		//업로드한 것을 찾을 것이기 때문에 파일업로드에 upload 에 file을 저장하여 파일네임에 저장한다.
		board.setFileName(fileName); // 그것을 보드로 보낸다. 
		
		System.out.printf("board : " + board);
		Board savedBoard = 	boardRepository.save(board); // 보드에 있는 값을 보드 리퍼지터리로 보내고, 그걸 세이브보드에 저장한다.
		return "redirect:/board/"+savedBoard.getId(); /*redirect 방식과 forward 방식이 있다. forward는 url을 보드 컨트롤러로 전송한다.
		그 이후에 index로 신호를 전송하고, 브라우저로 코드 200을 전송한다. 
		redirect는 url을 보드 컨트롤러로 전송한다. 보드 컨트롤러는 브라우저로 코드 302를 반환한다. 그 다음에 브라우저에서 홈 컨트롤러로 신호를 보내고, 홈 컨트롤러는
		인덱스로 신호를 보낸다. 인덱스는 브라우저에 코드 200을 전송한다. */ 
		
		//세이브보드에 있는 Id를 보드로 전송한다.
		//전체적으로 이게 업로드를 해주는 메소드가 아니다. 단지 업로드를 하는 건 FileUploader메소드가 하는 것이고, 이건 id를 가져와서 /board/+saved
		//board.getId()로 id를 받아서 아래 /board/{id}로 리퀘스트맵핑을 해준다.
	}
	
	@RequestMapping("/board/{id}")
	public String show(@PathVariable long id, Model model) { //URL을 매핑하는 중에, PathVariable을 사용하여 url을 파라미터로 사용가능하
		Board savedBoard = boardRepository.findOne(id); //findone이 한 가지만 보내겠다는 뜻이 아님. 주키에 맞춰서 보드 리퍼지터리에 있는 개체를
		//찾아서 세이브드보드에 저장하는 것. (개체(엔티티) ==의미있는 하나의 정보단위; 속성(어트리뷰트) == 사물들의 본질적인 성질)
		model.addAttribute("board", savedBoard);
		model.addAttribute("comments", savedBoard.getComments());
		
		return "redirect:/board";
	}
	
	@RequestMapping("/board/loginPage")
	public String loginPage() {
		return "loginPage";
	}
	
	
	
}

package org.nhnnext.web;



import org.nhnnext.repository.BoardRepository;
import org.nhnnext.repository.CommentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;




@Controller
public class CommentController {
	@Autowired
	private BoardRepository boardRepository;
	
	@Autowired
	private CommentRepository commentRepository;
	
	@RequestMapping(value="/board/{id}/comments", method=RequestMethod.POST)
	public String create(@PathVariable long id, String contents) {
		Board board = boardRepository.findOne(id);
		Comment comment = new Comment(contents, board);
		commentRepository.save(comment);
		return "redirect:/board/" + id;
	}
	
	@RequestMapping(value="/board/{id}/comments.json", method=RequestMethod.POST)
	public @ResponseBody Comment createAndShow(@PathVariable long id, String contents) {
		Board board = boardRepository.findOne(id);
		Comment comment = new Comment(contents, board);
		return commentRepository.save(comment);
	}
	
	@RequestMapping(value="board/{id}/commentDelete", method=RequestMethod.GET)
	public String commentDelete(@PathVariable long id) {
		commentRepository.delete(id);
		return "redirect:/board";
	}
	
	@RequestMapping(value="board/{id}/modifyPage", method=RequestMethod.GET)
	public String modifyPage(@PathVariable long id, Model model)
	 {
		Board removedboard = boardRepository.findOne(id);
		model.addAttribute("remove", removedboard);
		return "remove";
	 }
	
	@RequestMapping(value="board/{id}/commentModify", method=RequestMethod.GET)
	public String commentModify(@PathVariable long id, Model model) {
		Comment tempComment = commentRepository.findOne(id);
		model.addAttribute("commentmodify", tempComment);
		return 
	}
}

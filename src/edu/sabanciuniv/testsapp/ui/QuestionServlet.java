package edu.sabanciuniv.testsapp.ui;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import edu.sabanciuniv.testsapp.business.QuestionService;
import edu.sabanciuniv.testsapp.domain.Game;
import edu.sabanciuniv.testsapp.domain.Question;

/**
 * Servlet implementation class QuestionServlet
 */
@WebServlet("/QuestionServlet")
public class QuestionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public QuestionServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		if(request.getParameter("dothis").equals("Add"))
		{		
			String type = request.getParameter("type");
			String question = request.getParameter("question");
			String answer = request.getParameter("answer");
			String category = request.getParameter("category");
			
			QuestionService questionService = new QuestionService();
			
			if(type.equals("multiple"))
			{
				String qCode = request.getParameter("qCode");
				String optionA = request.getParameter("optionA");
				String optionB = request.getParameter("optionB");
				String optionC = request.getParameter("optionC");
				String optionD = request.getParameter("optionD");
				
				
				Question q = new Question(-1, type, question, answer, category, qCode, optionA, optionB, optionC, optionD);
				questionService.AddQuestionMultiple(q);
			}
		}
		
		else if(request.getParameter("dothis").equals("Get"))
		{
			//String type = request.getParameter("type");
			//Game game = (Game)request.getSession().getAttribute("game");
			
			// TO BE CONTINUED
					
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}

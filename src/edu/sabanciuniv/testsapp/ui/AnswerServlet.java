package edu.sabanciuniv.testsapp.ui;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import edu.sabanciuniv.testsapp.domain.Game;
import edu.sabanciuniv.testsapp.domain.User;

/**
 * Servlet implementation class AnswerServlet
 */
@WebServlet("/AnswerServlet")
public class AnswerServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AnswerServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


		Game game = (Game)request.getSession().getAttribute("game");
		User user = (User)request.getSession().getAttribute("user");
		
		String userAnswer = request.getParameter("userAnswer");
		String correctAnswer = request.getParameter("correctAnswer");
		String currentUser = user.getUsername();
		String player1 = game.getPlayer1();
		
		int index = game.getQuestionIndex();			
		if(userAnswer.equals(correctAnswer))
		{
			if(currentUser.equals(player1))
			{
				int currentScore = game.getPlayer1Score();
				game.setPlayer1Score(currentScore+1);
				List<String> answerList = game.getPlayer1Answers();
				if(answerList == null)
					answerList = new ArrayList<String>();
					
				answerList.add(userAnswer);
				game.setPlayer1Answers(answerList);
			}
			else
			{
				int currentScore = game.getPlayer2Score();
				game.setPlayer2Score(currentScore+1);
				List<String> answerList = game.getPlayer2Answers();
				if(answerList == null)
					answerList = new ArrayList<String>();
					
				answerList.add(userAnswer);
				game.setPlayer2Answers(answerList);
			}
		}	
		else
		{
			if(currentUser.equals(player1))
			{
				List<String> answerList = game.getPlayer1Answers();
				if(answerList == null)
					answerList = new ArrayList<String>();
					
				answerList.add(userAnswer);
				game.setPlayer1Answers(answerList);
			}
			else
			{
				List<String> answerList = game.getPlayer2Answers();
				if(answerList == null)
					answerList = new ArrayList<String>();
					
				answerList.add(userAnswer);
				game.setPlayer2Answers(answerList);
			}
		}
		
		if(index < 6)
		{
			game.setQuestionIndex(index+1);
			request.getRequestDispatcher("MultipleChoice.jsp").forward(request, response);
		}
		else
		{
			request.getRequestDispatcher("ShowResults.jsp").forward(request, response);
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

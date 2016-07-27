package edu.sabanciuniv.testsapp.ui;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import edu.sabanciuniv.testsapp.business.GameService;
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
		String timeLeftStr = request.getParameter("timeLeft");
		
		String currentUser = user.getUsername();
		String player1 = game.getPlayer1();
		int index = game.getQuestionIndex();	
				
		double timeLeftDbl = Double.parseDouble(timeLeftStr);	
		int timeLeft = (int)timeLeftDbl + 1 ;
		
		if(timeLeftDbl <= 0)
			timeLeft = 0;
		
		if(currentUser.equals(player1))
		{
			List<Integer> correctList = game.getPlayer1Correctness();
			List<String> answerList = game.getPlayer1Answers();
			List<Integer> timeList = game.getPlayer1Times();
			
			if(correctList == null)
				correctList = new ArrayList<Integer>();
			if(answerList == null)
				answerList = new ArrayList<String>();
			if(timeList == null)
				timeList = new ArrayList<Integer>();
			
			answerList.add(userAnswer);
			timeList.add(timeLeft);
			
			if(userAnswer.equals(correctAnswer))
			{
				correctList.add(1);		
				int currentScore = game.getPlayer1TotalScore();
				game.setPlayer1TotalScore(currentScore + timeLeft*4);
			}
			else
				correctList.add(0);
			
			game.setPlayer1Correctness(correctList);
			game.setPlayer1Times(timeList);
			game.setPlayer1Answers(answerList);
		}
		else
		{
			List<Integer> correctList = game.getPlayer2Correctness();
			List<String> answerList = game.getPlayer2Answers();
			List<Integer> timeList = game.getPlayer2Times();
			
			if(correctList == null)
				correctList = new ArrayList<Integer>();
			if(answerList == null)
				answerList = new ArrayList<String>();
			if(timeList == null)
				timeList = new ArrayList<Integer>();
			
			answerList.add(userAnswer);
			timeList.add(timeLeft);
			
			if(userAnswer.equals(correctAnswer))
			{
				correctList.add(1);		
				int currentScore = game.getPlayer2TotalScore();
				game.setPlayer2TotalScore(currentScore + timeLeft*4);
			}
			else
				correctList.add(0);
			
			game.setPlayer2Correctness(correctList);
			game.setPlayer2Times(timeList);
			game.setPlayer2Answers(answerList);
		}
			
		if(index < 6)
		{
			game.setQuestionIndex(index+1);
			request.getSession().setAttribute("game", game);
			//request.getRequestDispatcher("MultipleChoice.jsp").forward(request, response);
		}
		else if(index == 6)
		{
			GameService gs = new GameService();
			try {
				game.setState(gs.SubmitResults(game, user.getUsername()));
				request.getSession().setAttribute("game", game);
			} catch (SQLException e) {
				e.printStackTrace();
			}
					
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

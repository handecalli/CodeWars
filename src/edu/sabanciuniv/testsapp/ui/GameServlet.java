package edu.sabanciuniv.testsapp.ui;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import edu.sabanciuniv.testsapp.business.GameService;
import edu.sabanciuniv.testsapp.domain.Game;
import edu.sabanciuniv.testsapp.domain.User;

//import org.json.JSONArray;
import org.json.simple.JSONObject;

/**
 * Servlet implementation class GameServlet
 */
@WebServlet("/GameServlet")
public class GameServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GameServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
    
    
    // state = 0  ->  waiting for another player
    // state = 1  ->  waiting for player answers
    // state = 2  ->  show correct answer to players
    // state = 3  ->  game has finished
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//request.getRequestDispatcher("MultipleChoice.jsp").forward(request, response);	
		Game game = (Game)request.getSession().getAttribute("game");
		User user = (User)request.getSession().getAttribute("user");
		
		// FIRST CALL WILL ENTER
		if(user != null && game == null)
		{			
			String player1 = user.getUsername();
			String type = request.getParameter("type");
			
			System.out.println("sent ajax parameter (type): " + type);
			
			GameService gameservice = new GameService();
			try {
				game = gameservice.JoinOrCreateRandomGame(player1, type);
			} catch (SQLException e) {
				//e.printStackTrace();
			}
			System.out.println("(game servlet) Game state: " + game.getState());
			
			if(game != null && game.getState() == 0) //player has to wait for opponent
			{
				System.out.println(user.getUsername() + " has created the game with ID " + game.getGameID() + " and waiting for an opponent.");
				
				request.getSession().setAttribute("game", game);		
				
				JSONObject json = new JSONObject();
				json.put("state", game.getState());

				response.setContentType("application/json");
				response.getWriter().write(json.toString());
			}
			
			else if(game != null && game.getState() == 1)	//game can start
			{							
				System.out.println(user.getUsername() + " has joined the game with ID " + game.getGameID() + ".");
				
				request.getSession().setAttribute("game", game);	
				
				JSONObject json = new JSONObject();
				json.put("state", game.getState());

				response.setContentType("application/json");
				response.getWriter().write(json.toString());
			}
			
			else //Something went wrong
			{
				System.out.println(user.getUsername() + " has failed creating or joining a game");
				if(game != null)
					System.out.println("Game state was: " + game.getState());
				else 
					System.out.println("Game returned null");
			}
		}
		
		// GAME IS CREATED AND PLAYER IS CHECKING IF SOMEONE HAS JOINED
		else if(user != null && game != null && game.getState() == 0)
		{
			GameService gameservice = new GameService();
			try {
				gameservice.CheckPlayerJoin(game);
				
				if(game.getState() == 0)
					System.out.println(user.getUsername() + " is still waiting for an opponent.");
				else if(game.getState() == 1)
					System.out.println(user.getUsername() + " has found an opponent.");
				else
					System.out.println(user.getUsername() + "'s game has finished?");
				
			} catch (SQLException e) {
				//e.printStackTrace();
			}
			
			JSONObject json = new JSONObject();
			json.put("state", game.getState());

			response.setContentType("application/json");
			response.getWriter().write(json.toString());
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

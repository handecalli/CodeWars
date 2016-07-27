package edu.sabanciuniv.testsapp.ui;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import edu.sabanciuniv.testsapp.business.GameService;
import edu.sabanciuniv.testsapp.domain.Game;
import edu.sabanciuniv.testsapp.domain.User;

/**
 * Servlet implementation class ShowResultServlet
 */
@WebServlet("/ShowResultServlet")
public class ShowResultServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ShowResultServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{


		Game game = (Game)request.getSession().getAttribute("game");		
		GameService gs = new GameService();
			
		try 
		{	
			if(gs.GetGameState(game.getGameID()) ==  3)
			{	
				game = gs.GetGame(game);
				request.getSession().setAttribute("game", game);
				
				JSONObject json = new JSONObject();
				json.put("state", game.getState());

				response.setContentType("application/json");
				response.getWriter().write(json.toString());
			}
		} catch (SQLException e) {
			e.printStackTrace();
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

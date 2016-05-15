package edu.sabanciuniv.testsapp.ui;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class LeaderboardServlet
 */
@WebServlet("/LeaderboardServlet")
public class LeaderboardServlet extends HttpServlet {
	
	
	class Player implements Comparable<Player>
	{
	    public String username; 
	    public int points;  
	    public int rating; 
	    
	    public Player(String u, int p, int r)
	    {
	    	username = u;
	    	points = p;
	    	rating = r;
	    }
	    
	    int getPoints()
	    {
	    	return this.points;
	    }

		@Override
		public int compareTo(Player another)
		{
			if (this.getPoints() > another.getPoints())
			    return -1;
			else
			    return 1;
		}  
	 };
	
	
	
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LeaderboardServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {


		String player = "";
		int points = 0, rating = 0;
		
		List<Player> players = new ArrayList<Player>();
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection("jdbc:mysql://localhost/mydb", "root", "admin");

			PreparedStatement ps = con.prepareStatement("SELECT username, points, rating FROM user");
			ResultSet rs = ps.executeQuery();
					
			while(rs.next())
			{
				player = rs.getString("username");
				points = rs.getInt("points");
				rating = rs.getInt("rating");
				
				Player temp = new Player(player, points, rating);
				
				players.add(temp);				
			}
			
			Collections.sort(players);
			
			for (int i=0; i< players.size(); i++)
				System.out.println(players.get(i).username + " has " + players.get(i).points + " points.");
					
			con.close();
			
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
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

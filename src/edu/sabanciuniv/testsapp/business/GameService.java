package edu.sabanciuniv.testsapp.business;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import edu.sabanciuniv.testsapp.domain.Game;
import edu.sabanciuniv.testsapp.domain.Question;

import java.util.ArrayList;
import java.util.List;

import javax.websocket.server.PathParam;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import com.mysql.jdbc.Statement;

@Path("GameService")
public class GameService {

	@GET
	@Path("JoinOrCreateRandomGame/{player2}/{type}")
	@Produces(MediaType.APPLICATION_JSON)
	public Game JoinOrCreateRandomGame(@PathParam("player2") String player2, @PathParam("type") String type) throws SQLException
	{
		Game game = null;	
		Connection con = null;
				
		PreparedStatement ps_GetWaitingGames = null;	
		PreparedStatement ps_SetGameState = null;		
		PreparedStatement ps_CreateGame = null;
		
		ResultSet rs_GetWaitingGames = null;
		ResultSet rs_CreateGame = null;
		
		try {
			con = ConnectionService.createConnection();
			con.setAutoCommit(false);	// BEGINNING OF TRANSACTION BLOCK ***
			
			//state = 0  player1 is waiting for an opponent
			//state = 1  game in progress
			//state = 2  game finished
			
			ps_GetWaitingGames = con.prepareStatement("SELECT gameID, p1name FROM game WHERE type = ? AND p2name IS NULL");
			ps_GetWaitingGames.setString(1, type);	
			rs_GetWaitingGames = ps_GetWaitingGames.executeQuery();
			
			// DEBUG ***********
			System.out.println("Type: " + type);
			
			if(rs_GetWaitingGames.next())	 // JOIN GAME (state = 1)
			{
				int gameID = rs_GetWaitingGames.getInt("gameID");				
				String player1 = rs_GetWaitingGames.getString("p1name");
				
				// DEBUG ***********
				System.out.println("gameID: " + gameID);		
				
				ps_SetGameState = con.prepareStatement("UPDATE game SET p2name = ?, state = ? WHERE gameID = ?");
				ps_SetGameState.setString(1, player2);	
				ps_SetGameState.setInt(2, 1);	
				ps_SetGameState.setInt(3, gameID);
				ps_SetGameState.executeUpdate();
				
				con.commit(); // END OF TRANSACTION BLOCK ***
												
				game = new Game(gameID, player1, player2, type, 1);
				GetQuestionIDs(game);
				
				System.out.println("Game " + gameID + " is started between " + player1 + " and " + player2);			
			}
			
			else	// CREATE GAME (state = 0)
			{				
				ps_CreateGame = con.prepareStatement("INSERT INTO game( type, p1name, state) VALUES (?,?,?)", Statement.RETURN_GENERATED_KEYS);
				ps_CreateGame.setString(1, type);
				ps_CreateGame.setString(2, player2);		
				ps_CreateGame.setInt(3, 0);	
				ps_CreateGame.executeUpdate();
				
				rs_CreateGame = ps_CreateGame.getGeneratedKeys();	// get Primary Key of the newly inserted row
				
				if(rs_CreateGame != null && rs_CreateGame.next())
				{
					int gameID = rs_CreateGame.getInt(1);				
					
					con.commit(); // END OF TRANSACTION BLOCK ***
					
				    game = new Game(gameID, player2, null, type, 0);
					SetQuestionIDs(type, game);
					
					// DEBUG ***********
					System.out.println("Game " + gameID + " is created by " + player2);
				}										
			}			
		} catch (SQLException e) {
			con.rollback();
			game = null;
			e.printStackTrace();
		} finally {
			if (ps_GetWaitingGames != null) {
				ps_GetWaitingGames.close();
			}
			if (ps_SetGameState != null) {
				ps_SetGameState.close();
			}
			if (ps_CreateGame != null) {
				ps_CreateGame.close();
			}
			if (rs_GetWaitingGames != null) {
				rs_GetWaitingGames.close();
			}
			if (rs_CreateGame != null) {
				rs_CreateGame.close();
			}
			if (con != null) {
				con.close();
			}
		}	
		return game; // returns null if an exception was thrown
	}
	
	//in case there is no game to join
	@GET
	@Path("CreateFriendGame/{player}/{friend}/{type}")
	@Produces(MediaType.APPLICATION_JSON)
	public Game CreateFriendGame(@PathParam("player") String player, @PathParam("friend") String friend, @PathParam("type") String type) throws SQLException
	{
		Connection con = null;
		Game game = null;		
		PreparedStatement ps_CreateGame = null;
		ResultSet rs_CreateGame = null;
		
		try {
			con = ConnectionService.createConnection();
			con.setAutoCommit(false);	// BEGINNING OF TRANSACTION BLOCK ***
			
			ps_CreateGame = con.prepareStatement("INSERT INTO game(type, p1name, p2name) VALUES (?,?,?)", Statement.RETURN_GENERATED_KEYS);
			ps_CreateGame.setString(1, type);
			ps_CreateGame.setString(2, player);
			ps_CreateGame.setString(3, friend);			
			ps_CreateGame.executeUpdate();
						
			rs_CreateGame = ps_CreateGame.getGeneratedKeys();	// get Primary Key of the newly inserted row
			
			if(rs_CreateGame != null && rs_CreateGame.next())
			{
				int gameID = rs_CreateGame.getInt(1);					
			    game = new Game(gameID, player, null, type, 0);
				SetQuestionIDs(type, game);
				
				// DEBUG ***********
				System.out.println("Friend challenge " + gameID + " is created by " + player);
			}				
			
			con.commit(); // END OF TRANSACTION BLOCK ***
								
		} catch (SQLException e) {
			con.rollback();		
			game = null;
			e.printStackTrace();
		} finally {
			if (ps_CreateGame != null) {
				ps_CreateGame.close();
			}
			if (rs_CreateGame != null) {
				rs_CreateGame.close();
			}
			if (con != null) {
				con.close();
			}
		}
		return game;
	}
	
	@GET
	@Path("AcceptFriendGame/{gameID}/{friend}/{type}")
	@Produces(MediaType.APPLICATION_JSON)
	public Game FriendGameResponse(int gameID, boolean answer)
	{
		Connection con = null;
		Game game = null;
		
		PreparedStatement ps_UpdateState = null;
		PreparedStatement ps_GetGame = null;
		PreparedStatement ps_GetQuestions = null;
		
		ResultSet rs_GetGame = null;
		ResultSet rs_GetQuestions = null;
		
		try {
			con = ConnectionService.createConnection();
			con.setAutoCommit(false);	// BEGINNING OF TRANSACTION BLOCK ***
			
			ps_UpdateState = con.prepareStatement("UPDATE game SET state = ? WHERE gameID = ?");
						
			if(answer)	// GAME REQUEST ACCEPTED
			{		
				ps_UpdateState.setInt(1, 1);	
				ps_UpdateState.setInt(2, gameID);
				ps_UpdateState.executeUpdate();
				
				ps_GetGame = con.prepareStatement("SELECT p1name, p2name, state, type FROM game WHERE gameID = ?");
				ps_GetGame.setInt(1, gameID);
				rs_GetGame = ps_GetGame.executeQuery();	
				String type = "";
				if(rs_GetGame != null && rs_GetGame.next())
				{
					type = rs_GetGame.getString("type");
					game = new Game(gameID, rs_GetGame.getString("p1name"), rs_GetGame.getString("p2name"), type, rs_GetGame.getInt("state"));
				}
								
				//get questions
				if(game != null && type.equals("multiple"))
				{
					ps_GetQuestions = con.prepareStatement("SELECT qID1, qID2, qID3, qID4, qID5, qID6, qID7 FROM game_questions WHERE gameID = (?)");
					ps_GetQuestions.setInt(1, gameID);
					rs_GetQuestions = ps_GetQuestions.executeQuery();
					
					if(rs_GetQuestions != null && rs_GetQuestions.next())
					{
						//List<Question> questionList = new  ArrayList<Question>();
						
						///// TO BE CONTINUED.. (I hope)
					}
				}
				else	// GAME REQUEST REJECTED
				{
					
				}						
				con.close();
				return game;
			}
			else{
				ps_UpdateState.setInt(1, 2);
				ps_UpdateState.setInt(2, gameID);
				ps_UpdateState.executeQuery();	
				con.close();
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return null;
	}
	
	private void GetQuestionIDs(Game game)
	{
		Connection con = null;
		
		if(game.getType().equals("multiple"))
		{
			List<Question> questionList = new ArrayList<Question>();
			
			try {
				con = ConnectionService.createConnection();
				PreparedStatement ps = con.prepareStatement("SELECT qID1, qID2, qID3, qID4, qID5, qID6, qID7 FROM game_questions WHERE gameID = (?)");
				ps.setInt(1, game.getGameID());
				ResultSet rs = ps.executeQuery();	
				
				if(rs.next())
				{				
					for(int i=1; i<8; i++)
					{
						String idx = "qID" + i;
						int qID = rs.getInt(idx);
						
						PreparedStatement ps2 = con.prepareStatement("SELECT category, question, answer, optionA, optionB, optionC, optionD, code  FROM question WHERE questionID = (?)");
						ps2.setInt(1, qID);				
						ResultSet rs2 = ps2.executeQuery();
						
						if(rs2.next())
						{
							Question q = new Question(qID, "multiple", rs2.getString("question"), rs2.getString("answer"), rs2.getString("category"), rs2.getString("code"), rs2.getString("optionA"), rs2.getString("optionB"), rs2.getString("optionC"), rs2.getString("optionD"));
							questionList.add(q);
						}
					}
				}
				con.close();
				game.setQuestionList(questionList);				
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}		
		}	
	}
	
	private void SetQuestionIDs(String type, Game game)
	{
		QuestionService questionService = new QuestionService();
		Connection con = ConnectionService.createConnection();
		
		if(type.equals("multiple"))
		{
			List<Question> questionList = new ArrayList<Question>();
			
			for(int i=0; i<7; i++)
			{
				Question question = questionService.GetQuestion(type);	
				boolean contains = false;
				for(Question q : questionList)
				{
					if(q.getQuestion_ID() == question.getQuestion_ID())
						contains = true;
				}
					
				if(contains)
					i--;
				else
					questionList.add(question);
			}
						
			game.setQuestionList(questionList);
			
			try {
				PreparedStatement ps = con.prepareStatement("INSERT INTO game_questions (gameID, qID1, qID2, qID3, qID4, qID5, qID6, qID7) VALUES (?,?,?,?,?,?,?,?)");
				ps.setInt(1, game.getGameID());
				ps.setInt(2, questionList.get(0).getQuestion_ID());
				ps.setInt(3, questionList.get(1).getQuestion_ID());
				ps.setInt(4, questionList.get(2).getQuestion_ID());
				ps.setInt(5, questionList.get(3).getQuestion_ID());
				ps.setInt(6, questionList.get(4).getQuestion_ID());
				ps.setInt(7, questionList.get(5).getQuestion_ID());
				ps.setInt(8, questionList.get(6).getQuestion_ID());
				ps.executeUpdate();
				con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		else
		{
			List<Question> questionList = new ArrayList<Question>();
			
			for(int i=0; i<4; i++)
			{
				Question question = questionService.GetQuestion(type);	
				if(questionList.contains(question))
				{
					i--;
				}
				else
				{
					questionList.add(question);
				}
			}
						
			game.setQuestionList(questionList);
			
			try {
				PreparedStatement ps = con.prepareStatement("INSERT INTO game_questions (gameID, qID1, qID2, qID3, qID4) VALUES (?,?,?,?,?)");
				ps.setInt(1, game.getGameID());
				ps.setInt(2, questionList.get(0).getQuestion_ID());
				ps.setInt(3, questionList.get(1).getQuestion_ID());
				ps.setInt(4, questionList.get(2).getQuestion_ID());
				ps.setInt(5, questionList.get(3).getQuestion_ID());
				ps.executeUpdate();
				con.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
	
	// waiting player repeatedly checks if another player has joined the game
	public void CheckPlayerJoin(Game game) throws SQLException
	{
		Connection con = null;
		PreparedStatement ps_CheckPlayerJoin = null;
		ResultSet rs_CheckPlayerJoin = null;
		
		try {
			con = ConnectionService.createConnection();
			//con.setAutoCommit(false);	// BEGINNING OF TRANSACTION BLOCK ***
					
			ps_CheckPlayerJoin = con.prepareStatement("SELECT state, p2name FROM game WHERE gameID = (?)");
			ps_CheckPlayerJoin.setInt(1, game.getGameID());
			rs_CheckPlayerJoin = ps_CheckPlayerJoin.executeQuery();
			
			if(rs_CheckPlayerJoin != null && rs_CheckPlayerJoin.next())
			{
				game.setState(rs_CheckPlayerJoin.getInt("state"));
				game.setPlayer2(rs_CheckPlayerJoin.getString("p2name"));
			}
			//con.commit();  // END OF TRANSACTION BLOCK ***
		}		
		catch (SQLException e) {
			//con.rollback();	
			e.printStackTrace();
		} finally {
			if (ps_CheckPlayerJoin != null) {
				ps_CheckPlayerJoin.close();
			}
			if (rs_CheckPlayerJoin != null) {
				rs_CheckPlayerJoin.close();
			}
			if (con != null) {
				con.close();
			}
		}
	}	
}

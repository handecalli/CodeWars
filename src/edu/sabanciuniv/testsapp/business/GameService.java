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
			//state = 2  waiting for all players to finish
			//state = 3  game is finished for good
			
			ps_GetWaitingGames = con.prepareStatement("SELECT gameID, p1name FROM game WHERE type = ? AND p2name IS NULL");
			ps_GetWaitingGames.setString(1, type);	
			rs_GetWaitingGames = ps_GetWaitingGames.executeQuery();
		
			
			if(rs_GetWaitingGames.next())	 // JOIN GAME (state = 1)
			{
				int gameID = rs_GetWaitingGames.getInt("gameID");				
				String player1 = rs_GetWaitingGames.getString("p1name");
				
				ps_SetGameState = con.prepareStatement("UPDATE game SET p2name = ?, state = ? WHERE gameID = ?");
				ps_SetGameState.setString(1, player2);	
				ps_SetGameState.setInt(2, 1);	
				ps_SetGameState.setInt(3, gameID);
				ps_SetGameState.executeUpdate();
				
				con.commit(); // END OF TRANSACTION BLOCK ***
												
				game = new Game(gameID, player1, player2, type, 1);
				GetQuestionIDs(game);
				
				System.out.println("Game with ID " + gameID + " is started between " + player1 + " and " + player2);			
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
	@Path("FriendGameResponse/{gameID}/{friend}/{type}")
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
	
	@GET
	@Path("GetQuestionIDs/{game}")
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
	
	@GET
	@Path("SetQuestionIDs/{type}/{game}")
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
	
	public int SubmitResults(Game game, String username) throws SQLException
	{
		Connection con = null;
		PreparedStatement ps = null;
		PreparedStatement ps_UpdateGame = null;
		con = ConnectionService.createConnection();
		
		List<String> playerAnswers = null;
		List<Integer> playerTimes = null;
		List<Integer> playerCorrectness = null;
		
		 
		int stateToSet = 2;
		if(GetGameState(game.getGameID()) == 2)
			stateToSet = 3;
		
		if(game.getPlayer1().equals(username))
		{
			playerAnswers = game.getPlayer1Answers();
			playerTimes = game.getPlayer1Times();
			playerCorrectness = game.getPlayer1Correctness();
			
			ps_UpdateGame = con.prepareStatement("UPDATE game SET p1score = ?, state = ? WHERE gameID = ?");
			ps_UpdateGame.setInt(1, game.getPlayer1TotalScore());
			ps_UpdateGame.setInt(2, stateToSet);
			ps_UpdateGame.setInt(3, game.getGameID());
			ps_UpdateGame.executeUpdate();
		}
		else
		{
			playerAnswers = game.getPlayer2Answers();
			playerTimes = game.getPlayer2Times();
			playerCorrectness = game.getPlayer2Correctness();
			
			ps_UpdateGame = con.prepareStatement("UPDATE game SET p2score = ?, state = ? WHERE gameID = ?");
			ps_UpdateGame.setInt(1, game.getPlayer2TotalScore());
			ps_UpdateGame.setInt(2, stateToSet);
			ps_UpdateGame.setInt(3, game.getGameID());
			ps_UpdateGame.executeUpdate();
		}
		
		try {
			ps = con.prepareStatement("INSERT INTO player_answers VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			ps.setInt(1, game.getGameID());
			ps.setString(2, username);
			ps.setString(3, playerAnswers.get(0));
			ps.setString(4, playerAnswers.get(1));
			ps.setString(5, playerAnswers.get(2));
			ps.setString(6, playerAnswers.get(3));
			ps.setString(7, playerAnswers.get(4));
			ps.setString(8, playerAnswers.get(5));
			ps.setString(9, playerAnswers.get(6));
			ps.setInt(10, playerTimes.get(0));
			ps.setInt(11, playerTimes.get(1));
			ps.setInt(12, playerTimes.get(2));
			ps.setInt(13, playerTimes.get(3));
			ps.setInt(14, playerTimes.get(4));
			ps.setInt(15, playerTimes.get(5));
			ps.setInt(16, playerTimes.get(6));
			ps.setInt(17, playerCorrectness.get(0));
			ps.setInt(18, playerCorrectness.get(1));
			ps.setInt(19, playerCorrectness.get(2));
			ps.setInt(20, playerCorrectness.get(3));
			ps.setInt(21, playerCorrectness.get(4));
			ps.setInt(22, playerCorrectness.get(5));
			ps.setInt(23, playerCorrectness.get(6));
			ps.executeUpdate();
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if (ps != null) {
				ps.close();
			}
			if(ps_UpdateGame != null) {
				ps_UpdateGame.close();
			}
			if (con != null) {
				con.close();
			}
		}
		
		return stateToSet;
	}
	
	public int GetGameState(int gameID) throws SQLException
	{
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		con = ConnectionService.createConnection();
		int state = 2;
		
		ps = con.prepareStatement("SELECT state FROM game WHERE gameID = ?"); 
		ps.setInt(1, gameID);	
		rs = ps.executeQuery();
		
		if(rs.next())
		{
			state = rs.getInt(1);
		}
		
		if(con != null)
			con.close();
		
		return state;
	}
	
	public Game GetGame(Game game) throws SQLException
	{
		Connection con = null;
		PreparedStatement ps_game = null;
		PreparedStatement ps_update_game = null;
		PreparedStatement ps_player_answers = null;
		ResultSet rs_game = null;
		ResultSet rs_player_answers = null;
		con = ConnectionService.createConnection();
		
		String p1name = "", p2name = "", winner = "";
		int p1score = 0, p2score = 0, state = 3;
		List<String> player1Answers = null;
		List<Integer> player1Times = null;
		List<Integer> player1Correctness = null;
		List<String> player2Answers = null;
		List<Integer> player2Times = null;
		List<Integer> player2Correctness = null;
		
		ps_game = con.prepareStatement("SELECT * FROM game WHERE gameID = ?"); //gameID, type, p1name, p2name, p1score, p2score, winner, state
		ps_game.setInt(1, game.getGameID());	
		rs_game = ps_game.executeQuery();
		
		if(rs_game.next())
		{
			p1name = rs_game.getString(3);
			p2name = rs_game.getString(4);
			p1score = rs_game.getInt(5);
			p2score = rs_game.getInt(6);
			state = rs_game.getInt(8);
			
			winner = p1name;
			if(p1score < p2score)
				winner = p2name;
			else if (p1score == p2score)
				winner = "draw";	
		}
		
		game.setWinner(winner);
		game.setState(state);
		game.setPlayer1TotalScore(p1score);
		game.setPlayer2TotalScore(p2score);
		
		ps_update_game = con.prepareStatement("UPDATE game SET winner = ? WHERE gameID = ?");
		ps_update_game.setString(1, winner);
		ps_update_game.setInt(2, game.getGameID());
		ps_update_game.executeUpdate();
		
		ps_player_answers = con.prepareStatement("SELECT * FROM player_answers WHERE gameID = ? AND (username = ? OR username = ?)"); 
		//player_answers attributes -> gameID, username, answer[1,7], time [1,7], correctness[1,7]
		ps_player_answers.setInt(1, game.getGameID());	
		ps_player_answers.setString(2, p1name);
		ps_player_answers.setString(3, p2name);
		rs_player_answers = ps_player_answers.executeQuery();
		
		while(rs_player_answers.next())
		{
			String username = rs_player_answers.getString(2);
			
			if(username.equals(p1name))
			{
				player1Answers = new ArrayList<String>();
				player1Answers.add(rs_player_answers.getString(3));
			    player1Answers.add(rs_player_answers.getString(4));
			    player1Answers.add(rs_player_answers.getString(5));
			    player1Answers.add(rs_player_answers.getString(6));
			    player1Answers.add(rs_player_answers.getString(7));
			    player1Answers.add(rs_player_answers.getString(8));
			    player1Answers.add(rs_player_answers.getString(9));
			    
			    player1Times = new ArrayList<Integer>();
				player1Times.add(rs_player_answers.getInt(10));
				player1Times.add(rs_player_answers.getInt(11));
				player1Times.add(rs_player_answers.getInt(12));
				player1Times.add(rs_player_answers.getInt(13));
				player1Times.add(rs_player_answers.getInt(14));
				player1Times.add(rs_player_answers.getInt(15));
				player1Times.add(rs_player_answers.getInt(16));
				
				player1Correctness = new ArrayList<Integer>();
				player1Correctness.add(rs_player_answers.getInt(17));
				player1Correctness.add(rs_player_answers.getInt(18));
				player1Correctness.add(rs_player_answers.getInt(19));
				player1Correctness.add(rs_player_answers.getInt(20));
				player1Correctness.add(rs_player_answers.getInt(21));
				player1Correctness.add(rs_player_answers.getInt(22));
				player1Correctness.add(rs_player_answers.getInt(23));
				
			}
			else if (username.equals(p2name))
			{
				player2Answers = new ArrayList<String>();
				player2Answers.add(rs_player_answers.getString(3));
			    player2Answers.add(rs_player_answers.getString(4));
			    player2Answers.add(rs_player_answers.getString(5));
			    player2Answers.add(rs_player_answers.getString(6));
			    player2Answers.add(rs_player_answers.getString(7));
			    player2Answers.add(rs_player_answers.getString(8));
			    player2Answers.add(rs_player_answers.getString(9));
			    
			    player2Times = new ArrayList<Integer>();
				player2Times.add(rs_player_answers.getInt(10));
				player2Times.add(rs_player_answers.getInt(11));
				player2Times.add(rs_player_answers.getInt(12));
				player2Times.add(rs_player_answers.getInt(13));
				player2Times.add(rs_player_answers.getInt(14));
				player2Times.add(rs_player_answers.getInt(15));
				player2Times.add(rs_player_answers.getInt(16));
				
				player2Correctness = new ArrayList<Integer>();
				player2Correctness.add(rs_player_answers.getInt(17));
				player2Correctness.add(rs_player_answers.getInt(18));
				player2Correctness.add(rs_player_answers.getInt(19));
				player2Correctness.add(rs_player_answers.getInt(20));
				player2Correctness.add(rs_player_answers.getInt(21));
				player2Correctness.add(rs_player_answers.getInt(22));
				player2Correctness.add(rs_player_answers.getInt(23));
			}
		}
		
		game.setPlayer1(p1name);
		game.setPlayer1Answers(player1Answers);
		game.setPlayer1Times(player1Times);
		game.setPlayer1Correctness(player1Correctness);
		
		game.setPlayer2(p2name);
		game.setPlayer2Answers(player2Answers);
		game.setPlayer2Times(player2Times);
		game.setPlayer2Correctness(player2Correctness);
		
		if(con != null)
			con.close();
		
		return game;
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

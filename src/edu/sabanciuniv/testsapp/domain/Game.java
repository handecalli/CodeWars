package edu.sabanciuniv.testsapp.domain;

import java.util.List;

public class Game {
	
	private int gameID;
	
	private String player1;
	private String player2;
	private String type;
	
	private List<Question> questionList = null;
	private List<String> player1Answers = null;
	private List<String> player2Answers = null;
	
	private	int questionIndex;
	private int state;
	private int player1Score;
	private int player2Score;
	
	public Game(int gameID,String player1, String player2, String type, int state)
	{
		this.setGameID(gameID);
		this.setPlayer1(player1);
		this.setPlayer2(player2);
		this.setType(type);
		this.setState(state);
		this.setQuestionIndex(0);
		this.setPlayer1Score(0);
		this.setPlayer2Score(0);	
	}

	public int getGameID() {
		return gameID;
	}

	public void setGameID(int gameID) {
		this.gameID = gameID;
	}

	public String getPlayer1() {
		return player1;
	}

	public void setPlayer1(String player1) {
		this.player1 = player1;
	}

	public String getPlayer2() {
		return player2;
	}

	public void setPlayer2(String player2) {
		this.player2 = player2;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public int getState() {
		return state;
	}

	public void setState(int state) {
		this.state = state;
	}

	public List<Question> getQuestionList() {
		return questionList;
	}

	public void setQuestionList(List<Question> questionList) {
		this.questionList = questionList;
	}

	public int getQuestionIndex() {
		return questionIndex;
	}

	public void setQuestionIndex(int questionIndex) {
		this.questionIndex = questionIndex;
	}

	public int getPlayer1Score() {
		return player1Score;
	}

	public void setPlayer1Score(int player1Score) {
		this.player1Score = player1Score;
	}

	public int getPlayer2Score() {
		return player2Score;
	}

	public void setPlayer2Score(int player2Score) {
		this.player2Score = player2Score;
	}

	public List<String> getPlayer1Answers() {
		return player1Answers;
	}

	public void setPlayer1Answers(List<String> player1Answers) {
		this.player1Answers = player1Answers;
	}

	public List<String> getPlayer2Answers() {
		return player2Answers;
	}

	public void setPlayer2Answers(List<String> player2Answers) {
		this.player2Answers = player2Answers;
	}

}

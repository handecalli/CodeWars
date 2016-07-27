package edu.sabanciuniv.testsapp.domain;

import java.util.List;

public class Game {
	
	private int gameID;
	
	private String player1;
	private String player2;
	private String type;
	private String winner;
	
	private List<Question> questionList = null;
	private List<String> player1Answers = null;
	private List<String> player2Answers = null;
	private List<Integer> player1Times = null;
	private List<Integer> player2Times = null;
	private List<Integer> player1Correctness = null; 
	private List<Integer> player2Correctness = null;
	
	private	int questionIndex;
	private int state;
	private int player1TotalScore;
	private int player2TotalScore;
	
	public Game() {
		super();
	}

	public Game(int gameID,String player1, String player2, String type, int state)
	{
		this.setGameID(gameID);
		this.setPlayer1(player1);
		this.setPlayer2(player2);
		this.setType(type);
		this.setState(state);
		this.setQuestionIndex(0);
		this.setPlayer1TotalScore(0);
		this.setPlayer2TotalScore(0);	
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

	public List<Integer> getPlayer1Times() {
		return player1Times;
	}

	public void setPlayer1Times(List<Integer> player1Times) {
		this.player1Times = player1Times;
	}

	public List<Integer> getPlayer2Times() {
		return player2Times;
	}

	public void setPlayer2Times(List<Integer> player2Times) {
		this.player2Times = player2Times;
	}

	public List<Integer> getPlayer1Correctness() {
		return player1Correctness;
	}

	public void setPlayer1Correctness(List<Integer> player1Correctness) {
		this.player1Correctness = player1Correctness;
	}

	public List<Integer> getPlayer2Correctness() {
		return player2Correctness;
	}

	public void setPlayer2Correctness(List<Integer> player2Correctness) {
		this.player2Correctness = player2Correctness;
	}

	public int getPlayer1TotalScore() {
		return player1TotalScore;
	}

	public void setPlayer1TotalScore(int player1TotalScore) {
		this.player1TotalScore = player1TotalScore;
	}

	public int getPlayer2TotalScore() {
		return player2TotalScore;
	}

	public void setPlayer2TotalScore(int player2TotalScore) {
		this.player2TotalScore = player2TotalScore;
	}
	
	public String getWinner() {
		return winner;
	}

	public void setWinner(String winner) {
		this.winner = winner;
	}

}

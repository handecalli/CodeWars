package edu.sabanciuniv.testsapp.domain;

public class Question {
	
	private int question_ID;
	private String type, question, answer, category;
	private String code;
	
	//additional attributes for multiple question
	private String optionA, optionB, optionC, optionD;
	
	public Question()
	{
		super();
	}
	
	public Question(int qID, String type, String question, String answer, String category, String code)
	{
		super();
		setQuestion_ID(qID);
		setType(type);
		setQuestion(question);
		setAnswer(answer);
		setCategory(category);
		setCode(code);
		
	}
	
	public Question(int qID, String type, String question, String answer, String category, String code, String optionA, String optionB, String optionC, String optionD)
	{
		super();
		setQuestion_ID(qID);
		setType(type);
		setQuestion(question);
		setAnswer(answer);
		setCategory(category);
		setCode(code);
		setOptionA(optionA);
		setOptionB(optionB);
		setOptionC(optionC);
		setOptionD(optionD);
	}

	public int getQuestion_ID() {
		return question_ID;
	}

	public void setQuestion_ID(int question_ID) {
		this.question_ID = question_ID;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getQuestion() {
		return question;
	}

	public void setQuestion(String question) {
		this.question = question;
	}

	public String getAnswer() {
		return answer;
	}

	public void setAnswer(String answer) {
		this.answer = answer;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getOptionA() {
		return optionA;
	}

	public void setOptionA(String optionA) {
		this.optionA = optionA;
	}

	public String getOptionB() {
		return optionB;
	}

	public void setOptionB(String optionB) {
		this.optionB = optionB;
	}

	public String getOptionC() {
		return optionC;
	}

	public void setOptionC(String optionC) {
		this.optionC = optionC;
	}

	public String getOptionD() {
		return optionD;
	}

	public void setOptionD(String optionD) {
		this.optionD = optionD;
	}
}

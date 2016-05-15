package edu.sabanciuniv.testsapp.business;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Random;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import edu.sabanciuniv.testsapp.domain.Question;

@Path("QuestionService")
public class QuestionService {
	
	@GET
	@Path("AddQuestionMultiple/{question}")
	public void AddQuestionMultiple(@PathParam("question") Question question)
	{
		try {
			Connection con = ConnectionService.createConnection();
			
			PreparedStatement ps = con.prepareStatement("INSERT INTO question (type, question, answer, optionA, optionB, optionC, optionD, code, category) VALUES (?,?,?,?,?,?,?,?,?,?)");
			
			ps.setString(1, question.getType());
			ps.setString(2, question.getQuestion());
			ps.setString(3, question.getAnswer());
			ps.setString(4, question.getOptionA());
			ps.setString(5, question.getOptionB());
			ps.setString(6, question.getOptionC());
			ps.setString(7, question.getOptionD());
			ps.setString(8,question.getCode());
			ps.setString(9, question.getCategory());
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
	}
	
	@GET
	@Path("AddQuestionCorrection/{question}")
	public void AddQuestionCorrection(@PathParam("question") String question)
	{
			
		
	}
	
	@GET
	@Path("GetQuestion/{type}")
	@Produces(MediaType.APPLICATION_JSON)
	public Question GetQuestion(@PathParam("type") String type)
	{
		try {
			Connection con = ConnectionService.createConnection();
			
			PreparedStatement ps = con.prepareStatement("SELECT questionID, category, question, answer, optionA, optionB, optionC, optionD, code  FROM question WHERE type = (?)");
			ps.setString(1, type);
			
			ResultSet rs = ps.executeQuery();
			
			int rowcount = 1;
			if (rs.last()) {
				  rowcount = rs.getRow();
				  rs.beforeFirst();
			}
			
			Random rand = new Random(); 
			int randomRow = rand.nextInt(rowcount)+1;
			
			for(int i=0; i<randomRow; i++)
			{
				rs.next();
			}
				
			int questionID = rs.getInt("questionID");
			String question = rs.getString("question");
			String answer = rs.getString("answer");
			String optionA = rs.getString("optionA");
			String optionB = rs.getString("optionB");
			String optionC = rs.getString("optionC");
			String optionD = rs.getString("optionD");
			String category = rs.getString("category");
			String code = rs.getString("code");
			
			if(type.equals("multiple"))
			{
				Question mulQuestion = new Question(questionID, type, question, answer,category, code, optionA, optionB, optionC, optionD);
				return mulQuestion;
			}
			else if(type.equals("coding"))
			{
				Question codeQuestion = new Question(questionID, type, question, answer, category, code);
				return codeQuestion;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return null;
	}
	
	// bunu cagirirken questionID alip question objesi olustur
	@GET
	@Path("checkAnswerMultiple/{question}/{answer}")
	@Produces(MediaType.APPLICATION_JSON)
	public boolean checkAnswerMultiple(@PathParam("question") Question question, @PathParam("answer") String answer)
	{
		try {
			Connection con = ConnectionService.createConnection();
			
			PreparedStatement ps = con.prepareStatement("SELECT answer FROM question WHERE questionID = (?)");
			ps.setInt(1, question.getQuestion_ID());			
			ResultSet rs = ps.executeQuery();
			
			if(rs.next())
			{
				String correctAnswer = rs.getString("answer");
				if(answer.equals(correctAnswer))
					return true;
			}			
			return false;
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}
}

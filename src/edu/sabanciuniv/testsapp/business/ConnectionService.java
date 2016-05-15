package edu.sabanciuniv.testsapp.business;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectionService {
	private static final String DB_DRIVER = "com.mysql.jdbc.Driver";
	private static final String DB_CONNECTION = "jdbc:mysql://localhost/codewars?useSSL=false"; // url
	private static final String DB_USER = "root";
	private static final String DB_PASSWORD = "admin";
	private static final String CON_OPTIONS = "?characterEncoding=UTF-8&useSSL=false";
	
	public static Connection createConnection()
	{
		Connection con = null;
		try {
			Class.forName(DB_DRIVER);
		} catch (ClassNotFoundException e) {
			System.out.println(e.getMessage());
		}
		
		try {
			con = DriverManager.getConnection(DB_CONNECTION+CON_OPTIONS, DB_USER,DB_PASSWORD);
			return con;
		} catch (SQLException e) {
			System.out.println(e.getMessage());
		}
		return con;
	}
}






/*Connection con=null;
try
{
	try
	{
		   Class.forName("com.mysql.jdbc.Driver");
	}
	catch(ClassNotFoundException ex) {
		System.out.println("Error: unable to load driver class!");
		System.exit(1);
	}			
	con = DriverManager.getConnection(dbURL,dbUser,dbPassword);
}
catch(SQLException sqe){ 
	System.out.println("Error: While Creating connection to database");
	sqe.printStackTrace();
}
return con;*/
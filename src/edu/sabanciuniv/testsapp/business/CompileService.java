package edu.sabanciuniv.testsapp.business;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.io.StringReader;
import java.io.UnsupportedEncodingException;


public class CompileService {

	public void CompileCode(String code)
	{
		StringReader sr= new StringReader(code); // wrap your String
		BufferedReader br= new BufferedReader(sr); // wrap your StringReader
		
		createFile(br);
		
		Process proc;
		try {
	//	("g++ C:/Users/Tugcan/Desktop/gameID_username.cpp -o C:/Users/Tugcan/Desktop/gameID_username.cpp/gameID_username".replace("+", "%2B"), "UTF-8").replace("%2B", "+");
		//	System.out.println(decodedPath);
			
			proc = Runtime.getRuntime().exec("C:/MinGW/bin/g++ C:/Users/Tugcan/Desktop/gameID_username.cpp -o C:/Users/Tugcan/Desktop/gameID_username");
			proc = Runtime.getRuntime().exec("C:/Users/Tugcan/Desktop/gameID_username.exe");
			
		    BufferedReader stdInput = new BufferedReader(new
		             InputStreamReader(proc.getInputStream()));
		
		     while(true)
		     {
		             String line = stdInput.readLine();
		             if(line==null)
		                 break;
		             System.out.println(line);
		     }
		
		     BufferedReader stdError = new BufferedReader(new
		              InputStreamReader(proc.getErrorStream()));
		
		     while(true)
		     {
		             String line = stdError.readLine();
		             if(line==null)
		                 break;
		             System.out.println(line);
		     }

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	private void createFile(BufferedReader code)
	{
		try {
			File file = new File ("C:/Users/Tugcan/Desktop/gameID_username.cpp");
			PrintWriter writer = new PrintWriter(file);		
		
		while(true)
		{
	         String line = code.readLine();
	         if(line==null)
	             break;
	         writer.println(line);
		}	
		writer.flush();
		writer.close();
			
		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}

package edu.sabanciuniv.testsapp.business;

import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.security.spec.InvalidKeySpecException;
import java.sql.*;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.PathParam;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

import edu.sabanciuniv.testsapp.domain.User;

@Path ("/UserService")
public class UserService {
	
	private static final int ITERATIONS = 10000;
	private static final int KEY_LENGTH = 256;		// Length of hashed value
	
@GET
@Path("register/{username}/{password}")
public int register(@PathParam("username") String username, @PathParam("password") String password) {
		
	char[] pass_char = password.toCharArray();
	byte[] rand_salt = Create_Salt();
	byte[] hashed_pass = Hash_Password(pass_char, rand_salt);
			
	try {
		Connection con = ConnectionService.createConnection();
		
		PreparedStatement ps = con.prepareStatement("INSERT INTO user (username, password, email, salt, usertype, imageID) VALUES (?,?,?,?,?,?)");
		ps.setString(1, username);
	    //ps.setString(2, password);
		ps.setBytes(2, hashed_pass);
		ps.setString(3, username.concat("@sabanciuniv.edu"));
		ps.setBytes(4, rand_salt);
		ps.setString(5, "player");
		ps.setInt(6, 1);
		ps.executeUpdate();
		System.out.println(username + " " + password + " " + username.concat("@sabanciuniv.edu")+ " is inserted");
		
	} catch (Exception ex) {
		ex.printStackTrace();
		return 0;
	}
	return 1;
}

@GET
@Path("login/{username}/{password}")
@Produces("application/json")
public User login(@PathParam("username")String username, @PathParam("password") String password) {
	try {
		Connection con = ConnectionService.createConnection();
		
		PreparedStatement ps = con.prepareStatement("SELECT password, salt FROM user WHERE BINARY username = (?)");
		ps.setString(1, username);	
		ResultSet rs = ps.executeQuery();
		
		User user = new User();
		
		if(rs.next())
		{
			byte[] original_pass = rs.getBytes("password");
			byte[] original_salt = rs.getBytes("salt");
			
			char[] pass_char = password.toCharArray();
			byte[] hashed_pass = Hash_Password(pass_char, original_salt);
			
			if(Compare_Bytes(original_pass, hashed_pass))
			{
				System.out.println(username + " has successfully logged in.");
				user = GetUser(username);
							

				PreparedStatement ps2 = con.prepareStatement("UPDATE user SET online = 1, available = 1 WHERE username = (?)");
				ps2.setString(1, username);
				ps2.executeUpdate();			
				return user;
			}				
		}
		con.close();
		
	/*	if(rs.next() && rs.getString("password").equals(pass))
		{
			System.out.println(username + " has logged in.");	
			return true;
		}	*/				
	} catch (Exception ex) {
		ex.printStackTrace();
	}
	
	System.out.println(username + " has failed to log in.");	
	return null;
}

@GET
@Path("GetUser/{username}")
@Produces(MediaType.APPLICATION_JSON)
public User GetUser(@PathParam("username") String username) {	
	try{
		Connection con = ConnectionService.createConnection();
	
		PreparedStatement ps = con.prepareStatement("SELECT points, rating, usertype, imageID FROM user WHERE BINARY username = (?)");
		ps.setString(1, username);	
		ResultSet user_results = ps.executeQuery();
		
		if(user_results.next())
		{
			int points = user_results.getInt("points");
			int rating = user_results.getInt("rating");
			int imageID = user_results.getInt("imageID");
			String usertype = user_results.getString("usertype");
			int confirmed_status = 0;
			String friend = "";
			List<String> requestList = new  ArrayList<String>();
			List<String> friendList = new  ArrayList<String>();
			
			PreparedStatement ps2 = con.prepareStatement("SELECT username, confirmed FROM friends WHERE friend_username = (?)");
			ps2.setString(1, username);
			ResultSet friend_results = ps2.executeQuery();
			
			while(friend_results.next())
			{			
				confirmed_status = friend_results.getInt("confirmed");
				friend = friend_results.getString("username");
				
				if(confirmed_status == 1)
				{	
					friendList.add(friend);
				}
				else
				{
					requestList.add(friend);
				}
			}
				
			con.close();
			User user = new User(username, points, rating, usertype, requestList, friendList, imageID);
			return user;
		}
		else
			con.close();
		
	}
	catch(Exception ex){
		ex.printStackTrace();
	}
	return null;
}

@GET
@Path("SearchUser/{username}")
@Produces(MediaType.APPLICATION_JSON)
public String SearchUser(@PathParam("username") String username)
{	
	try {
		Connection con = ConnectionService.createConnection();

		PreparedStatement ps = con.prepareStatement("SELECT username FROM user WHERE username = (?) "); //AND active != 0
		ps.setString(1, username);	
		ResultSet rs = ps.executeQuery();
		
		if(rs.next())
		{
			return rs.getString("username");
		}
		
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
	return null;
}

// char[] password is destroyed after use (filled with zeros)
 private static byte[] Hash_Password(char[] password, byte[] salt) {
    PBEKeySpec spec = new PBEKeySpec(password, salt, ITERATIONS, KEY_LENGTH);
    Arrays.fill(password, Character.MIN_VALUE);
    try {
    	SecretKeyFactory skf = SecretKeyFactory.getInstance("PBKDF2WithHmacSHA1");
		return skf.generateSecret(spec).getEncoded();
    } catch (NoSuchAlgorithmException | InvalidKeySpecException e) {
    	throw new AssertionError("Error while hashing a password: " + e.getMessage(), e);
	    } finally {
	    	spec.clearPassword();
	    }
	}
	
 	private byte[] Create_Salt(){
		SecureRandom random = new SecureRandom();
	    byte salt[] = new byte[32];
	    random.nextBytes(salt);
	    return salt;
	}
	
	private static boolean Compare_Bytes(byte[] a, byte[] b)
	{
		int diff = a.length ^ b.length;
	    for(int i = 0; i < a.length && i < b.length; i++)
	    	diff |= a[i] ^ b[i];
	    return diff == 0;
	}

	@GET
	@Path("logout/{user}")
	public void logout(User user) {
		
		Connection con = ConnectionService.createConnection();
		
		try {
			
			PreparedStatement ps = con.prepareStatement("SELECT available FROM user WHERE username = (?) ");
			ps.setString(1, user.getUsername());	
			ResultSet rs = ps.executeQuery();
			
			if(rs.next())
			{
				int available = rs.getInt("available");
				
				// currently in game
				if(available == 0)
				{
					PreparedStatement ps2 = con.prepareStatement("SELECT p1name, p2name, p1score, p2score FROM game WHERE (p1name = (?) OR p2name = (?)) AND state = 1");
					ps2.setString(1, user.getUsername());
					ps2.setString(2, user.getUsername());
					ResultSet rs2 = ps2.executeQuery();
					
					if(rs2.next())
					{
						String p1name = rs2.getString("p1name");
						String p2name = rs2.getString("p2name");
						int state = 1;
						
						if(p1name.equals(user.getUsername()))
						{				
							if(rs2.getInt("p2score") != -1)
								state = 2;
													
							PreparedStatement ps3 = con.prepareStatement("UPDATE game SET p1score = 0, state = (?) WHERE p1name = (?) AND state = 1");
							ps3.setInt(1, state);
							ps3.setString(2, user.getUsername());
							ps3.executeUpdate();											
						}
						
						else if(p2name.equals(user.getUsername()))
						{
							if(rs2.getInt("p1score") != -1)
								state = 2;
							
							PreparedStatement ps3 = con.prepareStatement("UPDATE game SET p2score = 0, state = (?) WHERE p2name = (?) AND state = 1");
							ps3.setInt(1, state);
							ps3.setString(2, user.getUsername());
							ps3.executeUpdate();
						}								
					}							
				}		
			}				
			
			PreparedStatement ps3 = con.prepareStatement("UPDATE user SET online = 0, available = 0 WHERE username = (?)");
			ps3.setString(1, user.getUsername());
			ps3.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}			
	}
}

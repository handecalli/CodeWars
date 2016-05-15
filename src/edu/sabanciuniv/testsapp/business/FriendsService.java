package edu.sabanciuniv.testsapp.business;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.websocket.server.PathParam;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;

@Path("FriendsService")
public class FriendsService {
	
	// returns 0 if request sent and waiting for response
	// returns 1 if already friends
	// returns 2 if just added as friend
	// returns 3 if there is an error
	@GET
	@Path("AddFriend/{adder}/{addee}")
	@Produces(MediaType.APPLICATION_JSON)
	public int AddFriend(@PathParam("adder") String adder, @PathParam("addee") String addee)
	{
		try {
			Connection con = ConnectionService.createConnection();
			//System.out.println("adder: " + adder + " addee: " + addee);
			PreparedStatement checkRequest = con.prepareStatement("SELECT confirmed FROM friends WHERE username = (?) AND friend_username = (?)");
			checkRequest.setString(1, adder);
			checkRequest.setString(2, addee);
			ResultSet rs = checkRequest.executeQuery();
			
			if(rs.next())
			{
				int confirmed = rs.getInt("confirmed");
				if(confirmed == 0)
				{
					return 0;
				}
				else
				{
					return 1;
				}
			}
			else
			{
				boolean confirmed = false;
				PreparedStatement ps = con.prepareStatement("INSERT INTO friends (username, friend_username, confirmed) VALUES (?,?,?)");
				ps.setString(1, adder);
				ps.setString(2, addee);
				ps.setBoolean(3, confirmed);
				ps.executeQuery();
				
				System.out.println(adder + " added " + addee + " as a friend.");
				con.close();
				return 2;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return 3;
	}
	
	@GET
	@Path("ConfirmFriend/{adder}/{addee}")
	public void ConfirmFriend(@PathParam("adder") String adder, @PathParam("addee") String addee)
	{
		try {
			Connection con = ConnectionService.createConnection();
			
			PreparedStatement ps = con.prepareStatement("UPDATE friends SET confirmed = 1 WHERE username = (?) AND friend_username = (?)");
			ps.setString(1, adder);	
			ps.setString(1, addee);	
			ps.executeUpdate();
			con.commit();
			System.out.println(addee + " confirmed " + adder + "'s friend request.");
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}
}
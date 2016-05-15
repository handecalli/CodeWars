package edu.sabanciuniv.testsapp.domain;

import java.util.List;

public class User {
	    
	    private String username;
	    private String usertype;
	    private int points, rating;
	    private List<String> friendReq;
	    private List<String> friendList;
	    private byte[] image;
	    
	    public User() {
	        super();
	    }

		public User(String username, int points, int rating, String usertype, List<String> friendReq, List<String> friendList, byte[] image ) {
			super();
			this.setUsername(username);
			this.setPoints(points);
			this.setRating(rating);
			this.setUsertype(usertype);
			this.setFriendReq(friendReq);
			this.setFriendList(friendList);
			this.setImage(image);
		}
		
		public int getRating() {
			return rating;
		}

		public void setRating(int rating) {
			this.rating = rating;
		}

		public String getUsername() {
			return username;
		}

		public void setUsername(String username) {
			this.username = username;
		}

		public int getPoints() {
			return points;
		}

		public void setPoints(int points) {
			this.points = points;
		}

		public List<String> getFriendReq() {
			return friendReq;
		}

		public void setFriendReq(List<String> friendReq) {
			this.friendReq = friendReq;
		}

		public List<String> getFriendList() {
			return friendList;
		}

		public void setFriendList(List<String> friendList) {
			this.friendList = friendList;
		}

		public String getUsertype() {
			return usertype;
		}

		public void setUsertype(String usertype) {
			this.usertype = usertype;
		}

		public byte[] getImage() {
			return image;
		}

		public void setImage(byte[] image) {
			this.image = image;
		}
	    
	    
}

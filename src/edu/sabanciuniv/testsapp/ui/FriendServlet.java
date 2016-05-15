package edu.sabanciuniv.testsapp.ui;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import edu.sabanciuniv.testsapp.business.FriendsService;
import edu.sabanciuniv.testsapp.business.UserService;
import edu.sabanciuniv.testsapp.domain.User;

/**
 * Servlet implementation class FriendServlet
 */
@WebServlet("/FriendServlet")
public class FriendServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FriendServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String friendName =	request.getParameter("friendName");
		User user =	(User)request.getSession().getAttribute("user");
		String username = user.getUsername();
		
		UserService userService = new UserService();
		String userCheck = userService.SearchUser(friendName);
		
		if(userCheck == null)
		{
			System.out.println(friendName + " is not found in the database");
		}
		else
		{
			FriendsService fs = new FriendsService();
			int check = fs.AddFriend(username, friendName);
			request.setAttribute("check", check);
		}
		request.getRequestDispatcher("UserMain.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}

package edu.sabanciuniv.testsapp.ui;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import edu.sabanciuniv.testsapp.business.UserService;
import edu.sabanciuniv.testsapp.domain.User;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String username =	request.getParameter("uname");
		String pass =	request.getParameter("pword");
		  
		UserService userService = new UserService();
		User user= userService.login(username, pass);
		 
		if(user != null)
		{
			//session <- user
			HttpSession session = request.getSession();
			session.setAttribute("user", user);
			
			/*request.setAttribute("username", user.getUsername());
			request.setAttribute("points", user.getPoints());
			request.setAttribute("rating", user.getRating());*/
			
			if(user.getUsertype().equals("player"))
			{		
				request.getRequestDispatcher("UserMain.jsp").forward(request, response);
			}
			else // when user type is not player, the user has to be an admin
			{
				request.getRequestDispatcher("AdminMain.jsp").forward(request, response);
			}
		}
		else
		{
			System.out.println("LoginFailed");
			request.getRequestDispatcher("index.html").forward(request, response);
		}
	}
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}

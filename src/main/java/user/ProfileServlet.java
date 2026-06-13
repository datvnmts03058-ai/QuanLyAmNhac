package user;

import java.io.IOException;

import Dao.UserDAO;
import Model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {

	@Override
	protected void doGet(
	        HttpServletRequest req,
	        HttpServletResponse resp)
	        throws ServletException, IOException {

	    HttpSession session = req.getSession(false);

	    if(session == null){
	        resp.sendRedirect("login");
	        return;
	    }

	    String id = req.getParameter("id");

	    UserDAO dao = new UserDAO();

	    User profileUser;

	    if(id != null){

	        profileUser =
	                dao.findById(
	                        Long.parseLong(id));

	    }else{

	        profileUser =
	                (User) session.getAttribute("user");
	    }

	    req.setAttribute(
	            "profileUser",
	            profileUser);

	    req.getRequestDispatcher(
	            "/views/profile.jsp")
	       .forward(req, resp);
	}
}
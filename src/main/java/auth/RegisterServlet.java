package auth;

import java.io.IOException;

import Dao.UserDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import Model.User;
import org.mindrot.jbcrypt.BCrypt;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	UserDAO dao = new UserDAO();

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		req.getRequestDispatcher("/user/register.jsp")
		   .forward(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {

		req.setCharacterEncoding("UTF-8");

		String username = req.getParameter("username");
		String password = req.getParameter("password");
		String fullname = req.getParameter("fullname");
		String email = req.getParameter("email");

		if (dao.exists(username)) {

			req.setAttribute("message",
					"Tên đăng nhập đã tồn tại!");

			req.getRequestDispatcher("/user/register.jsp")
			   .forward(req, resp);

			return;
		}

		User user = new User();
		
		String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

		user.setUsername(username);
		user.setPassword(hashedPassword); 
		user.setFullname(fullname);
		user.setEmail(email);
		user.setRole("USER");

		dao.create(user);

		resp.sendRedirect(req.getContextPath() + "/login");
	}
}
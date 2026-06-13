package auth;

import java.io.IOException;

import Dao.UserDAO;
import Model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/forgot-password")
public class ForgotPasswordServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher(
                "/user/forgot-password.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String username =
                request.getParameter("username");

        String email =
                request.getParameter("email");

        User user =
                userDAO.findByUsername(username);

        if(user == null){

            request.setAttribute(
                    "error",
                    "Không tìm thấy tài khoản");

        }else if(!email.equalsIgnoreCase(user.getEmail())){

            request.setAttribute(
                    "error",
                    "Email không đúng");

        }else{

            request.setAttribute(
                    "password",
                    user.getPassword());
        }

        request.getRequestDispatcher(
                "/user/forgot-password.jsp")
                .forward(request, response);
    }
}

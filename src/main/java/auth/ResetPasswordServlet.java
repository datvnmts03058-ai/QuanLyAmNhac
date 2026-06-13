package auth;

import java.io.IOException;

import Dao.UserDAO;
import Model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/reset-password")
public class ResetPasswordServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher(
                "/user/reset-password.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String username =
                request.getParameter("username");

        User user =
                userDAO.findByUsername(username);

        if(user == null){

            request.setAttribute(
                    "error",
                    "Tài khoản không tồn tại");

            request.getRequestDispatcher(
                    "/user/reset-password.jsp")
                    .forward(request, response);

            return;
        }

        request.setAttribute("user", user);

        request.getRequestDispatcher(
                "/user/reset-account.jsp")
                .forward(request, response);
    }
}
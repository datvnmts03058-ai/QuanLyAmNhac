package auth;

import java.io.IOException;

import Dao.UserDAO;
import Model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/reset-account")
public class ResetAccountServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        Long id =
                Long.valueOf(
                        request.getParameter("id"));

        User user =
                userDAO.findById(id);

        user.setUsername(
                request.getParameter("username"));

        user.setPassword(
                request.getParameter("password"));

        user.setFullname(
                request.getParameter("fullname"));

        user.setEmail(
                request.getParameter("email"));

        userDAO.update(user);

        response.sendRedirect(
                request.getContextPath()
                        + "/home");
    }
}

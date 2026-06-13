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

@WebServlet("/change-password")
public class ChangePasswordServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher(
                "/user/change-password.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        String username =
                request.getParameter("username");

        String oldPassword =
                request.getParameter("oldPassword");

        String newPassword =
                request.getParameter("newPassword");

        String confirmPassword =
                request.getParameter("confirmPassword");

        User user =
                userDAO.findByUsername(username);

        if(user == null){

            request.setAttribute(
                    "error",
                    "Không tìm thấy tài khoản");

        }else if(!user.getPassword().equals(oldPassword)){

            request.setAttribute(
                    "error",
                    "Mật khẩu cũ không đúng");

        }else if(!newPassword.equals(confirmPassword)){

            request.setAttribute(
                    "error",
                    "Xác nhận mật khẩu không khớp");

        }else{

            user.setPassword(newPassword);

            userDAO.update(user);

            request.setAttribute(
                    "success",
                    "Đổi mật khẩu thành công");
        }

        request.getRequestDispatcher(
                "/user/change-password.jsp")
                .forward(request, response);
    }
}
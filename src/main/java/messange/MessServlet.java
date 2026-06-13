package messange;

import java.io.IOException;

import Dao.MessDao;
import Model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/notifications")
public class MessServlet extends HttpServlet {

    private MessDao dao = new MessDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException, ServletException {

        User u = (User) req.getSession().getAttribute("user");

        req.setAttribute("notifications",
            dao.findByUser(u.getId()));

        req.setAttribute("unreadCount",
            dao.countUnread(u.getId()));
        
        req.getRequestDispatcher("/user/Mess.jsp")
            .forward(req, resp);
    }
}

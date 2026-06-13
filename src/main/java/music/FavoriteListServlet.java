package music;

import java.io.IOException;
import java.util.List;

import Dao.FavoriteDAO;
import Model.Favorite;
import Model.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/favorites")
public class FavoriteListServlet
        extends HttpServlet {

    FavoriteDAO dao =
            new FavoriteDAO();

    @Override
    protected void doGet(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException,
                   IOException {

        HttpSession session =
                req.getSession(false);

        if(session == null ||
           session.getAttribute("user") == null){

            resp.sendRedirect(
                    req.getContextPath()
                    + "/login");

            return;
        }

        User user =
            (User) session.getAttribute("user");

        List<Favorite> favorites =
                dao.findByUser(user);

        req.setAttribute(
                "favorites",
                favorites);

        req.getRequestDispatcher(
                "/views/favorite.jsp")
           .forward(req, resp);
    }
}
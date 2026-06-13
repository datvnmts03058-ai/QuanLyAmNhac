package music;

import java.io.IOException;
import java.util.List;

import Dao.FavoriteDAO;
import Model.Favorite;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/report-favorite-users")
public class ReportFavoriteUsersServlet extends HttpServlet {

    FavoriteDAO dao = new FavoriteDAO();

    @Override
    protected void doGet(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

        String songIdStr = req.getParameter("songId");

        if(songIdStr == null || songIdStr.isEmpty()) {
            return;
        }

        Long songId = Long.parseLong(songIdStr);

        List<Favorite> list =
                dao.findBySong(songId);

        req.setAttribute("favUsers", list);

        req.getRequestDispatcher(
                "/admin/favorite_users.jsp")
           .forward(req, resp);
    }
}
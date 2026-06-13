package music;

import java.io.IOException;
import java.util.List;

import Dao.FavoriteDAO;
import Model.Favorite;
import Model.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/playlist")
public class PlaylistServlet extends HttpServlet {

    private FavoriteDAO favoriteDAO = new FavoriteDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if(session == null){
            response.sendRedirect(
                request.getContextPath()+"/login");
            return;
        }

        User user =
            (User) session.getAttribute("user");

        List<Favorite> playlist =
            favoriteDAO.findByUser(user);

        request.setAttribute(
            "playlist",
            playlist
        );

        request.getRequestDispatcher(
            "/views/playlist.jsp"
        ).forward(request, response);
    }
}
package music;

import java.io.IOException;

import Dao.FavoriteDAO;
import Dao.SongDao;
import Model.Song;
import Model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/favorite")
public class FavoriteServlet extends HttpServlet {

    FavoriteDAO favoriteDAO = new FavoriteDAO();
    SongDao songDAO = new SongDao();

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null ||
        	    session.getAttribute("user") == null) {

        	    response.sendRedirect(
        	            request.getContextPath() + "/login");

        	    return;
        	}
        User user = (User) session.getAttribute("user");

        String songIdStr =
                request.getParameter("songId");

        if(songIdStr == null){
            response.sendRedirect(
                    request.getContextPath()+"/home");
            return;
        }

        Long songId =
                Long.parseLong(songIdStr);

        Song song =
                songDAO.findById(songId);

        if(favoriteDAO.exists(user, song)){
            favoriteDAO.remove(user, song);
        }else{
            favoriteDAO.add(user, song);
        }

        response.sendRedirect(
                request.getContextPath()+"/home");
    }
}

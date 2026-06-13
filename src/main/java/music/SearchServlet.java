package music;

import java.io.IOException;
import java.util.List;

import Dao.SongDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import Model.Song;

@WebServlet("/search")
public class SearchServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    SongDao dao = new SongDao();

    @Override
    protected void doGet(HttpServletRequest req,
                         HttpServletResponse resp)
            throws ServletException, IOException {

        String keyword = req.getParameter("keyword");

        List<Song> songs;

        if(keyword == null || keyword.trim().isEmpty()) {
            songs = dao.findAll();
        } else {
            songs = dao.search(keyword);
        }
        
        req.setAttribute("keyword", keyword);
        req.setAttribute("songs", songs);

        req.getRequestDispatcher("/views/home.jsp")
           .forward(req, resp);
    }
}
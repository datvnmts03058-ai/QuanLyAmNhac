package music;

import Dao.ArtistDao;
import Dao.SongDao;
import Model.Artist;
import Model.Song;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/artist")
public class ArtistServlet extends HttpServlet {

    private ArtistDao artistDao = new ArtistDao();
    private SongDao songDao = new SongDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        try {
            Long id = Long.parseLong(req.getParameter("id"));

            Artist artist = artistDao.findById(id);
            List<Song> songs = songDao.findTop3ByArtist(id);

            req.setAttribute("artist", artist);
            req.setAttribute("songs", songs);

            req.getRequestDispatcher("/WEB-INF/views/artist.jsp")
               .forward(req, resp);

        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(404, "Artist not found");
        }
    }
}
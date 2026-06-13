package music;

import java.io.IOException;
import java.util.List;

import Dao.ArtistDao;
import Dao.SongDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import Model.Artist;
import Model.Song;


@WebServlet("/home")
public class HomeServlet extends HttpServlet {

    SongDao dao = new SongDao();  	

        @Override
        protected void doGet(HttpServletRequest req,
                             HttpServletResponse resp)
                throws ServletException, IOException {

            HttpSession session = req.getSession(false);

            if (session == null ||
                session.getAttribute("user") == null) {

                resp.sendRedirect(
                        req.getContextPath() + "/login");
                return;
            }

            // ===== XÓA BÀI HÁT =====
            String action = req.getParameter("action");

            if ("delete".equals(action)) {

                Long id = Long.parseLong(
                        req.getParameter("id"));

                dao.delete(id);

                resp.sendRedirect(
                        req.getContextPath() + "/home");

                return;
            }
            //ca sĩ
            ArtistDao artistDao = new ArtistDao();

            List<Artist> artists = artistDao.findAll();
            req.setAttribute("artists", artists);

            // ===== LOAD DANH SÁCH =====
            List<Song> songs = SongDao.findActiveSongs();

            req.setAttribute("songs", songs);

            req.getRequestDispatcher("/views/home.jsp")
               .forward(req, resp);
        }
    }
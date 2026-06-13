package music;

import java.io.IOException;
import java.util.List;

import Dao.SongDao;
import Model.Song;
import Model.User;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/my-music")
public class MyMusicServlet extends HttpServlet {

    SongDao dao = new SongDao();

    @Override
    protected void doGet(
            HttpServletRequest req,
            HttpServletResponse resp)
            throws ServletException, IOException {

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

        List<Song> songs =
                dao.findByUser(user.getId());

        req.setAttribute("songs", songs);

        req.getRequestDispatcher(
                "/views/mymusic.jsp")
           .forward(req, resp);
    }
}
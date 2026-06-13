package admin;

import java.io.IOException;
import java.util.List;

import Dao.SongDao;
import Model.Song;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/approval")
public class ApprovalServlet extends HttpServlet {

    private SongDao dao = new SongDao();

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        List<Song> pendingSongs = dao.findPendingSongs();

        request.setAttribute("pendingSongs", pendingSongs);

        request.getRequestDispatcher(
                "/admin/song_approval.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        SongDao dao = new SongDao();

        // ===== DUYỆT HÀNG LOẠT =====
        if ("approveSelected".equals(action)) {

            String[] ids =
                    request.getParameterValues("songIds");

            if (ids != null) {

                for (String id : ids) {

                    dao.approveSong(
                            Long.parseLong(id));
                }
            }
        }

        // ===== TỪ CHỐI HÀNG LOẠT =====
        else if ("rejectSelected".equals(action)) {

            String[] ids =
                    request.getParameterValues("songIds");

            if (ids != null) {

                for (String id : ids) {

                    dao.rejectSong(
                            Long.parseLong(id));
                }
            }
        }

        // ===== DUYỆT 1 BÀI =====
        else if (action.startsWith("approve_")) {

            Long id = Long.parseLong(
                    action.replace("approve_", ""));

            dao.approveSong(id);
        }

        // ===== TỪ CHỐI 1 BÀI =====
        else if (action.startsWith("reject_")) {

            Long id = Long.parseLong(
                    action.replace("reject_", ""));

            dao.rejectSong(id);
        }

        response.sendRedirect(
                request.getContextPath()
                + "/AdminController");
    }
}
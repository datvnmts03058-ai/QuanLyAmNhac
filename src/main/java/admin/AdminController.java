package admin;

import Dao.FavoriteDAO;
import Dao.ReportDao;
import Dao.SongDao;
import Model.Song;
import Model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/AdminController")
@MultipartConfig(
    fileSizeThreshold = 1024 * 1024,
    maxFileSize = 1024 * 1024 * 20,
    maxRequestSize = 1024 * 1024 * 50
)
public class AdminController extends HttpServlet {

    private final SongDao songDao = new SongDao();

    private User getCurrentUser(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        return session == null
                ? null
                : (User) session.getAttribute("user");
    }

    private boolean isAdmin(User user) {
        return user != null
                && "ADMIN".equals(user.getRole());
    }
    
    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        User user = getCurrentUser(request);

        if (!isAdmin(user)) {
            response.sendRedirect(
                    request.getContextPath() + "/home");
            return;
        }

        loadAdminData(request);

        String songId = request.getParameter("songId");

        if (songId != null && !songId.isBlank()) {

            FavoriteDAO favoriteDAO = new FavoriteDAO();

            request.setAttribute(
                    "favUsers",
                    favoriteDAO.findBySong(
                            Long.parseLong(songId)));

            request.setAttribute(
                    "selectedSongId",
                    Long.parseLong(songId));

            request.setAttribute(
                    "reportTab",
                    "fav-users");
        }

        request.setAttribute(
                "reportTab",
                request.getParameter("reportTab") == null
                        ? "favorites"
                        : request.getParameter("reportTab"));

        request.setAttribute(
                "activeTab",
                request.getParameter("activeTab") == null
                        ? "song"
                        : request.getParameter("activeTab"));
        

        
        request.getRequestDispatcher("/admin/admin.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User user = session == null ? null : (User) session.getAttribute("user");

        if (user == null || !"ADMIN".equals(user.getRole())) {
            response.sendError(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        String action = request.getParameter("action");

        try {

            switch (action) {

                case "create":

                    Song newSong = new Song();

                    newSong.setTitle(request.getParameter("title"));
                    newSong.setArtist(request.getParameter("artist"));
                    newSong.setGenre(request.getParameter("genre"));

                    Part imagePart = request.getPart("imageFile");
                    Part audioPart = request.getPart("audioFile");

                    newSong.setActive(true);

                    songDao.create(newSong);
                    break;

                case "update":

                    Song updateSong = songDao.findById(requireId(request));

                    if (updateSong == null) {
                        response.sendError(404, "Song not found");
                        return;
                    }

                    updateSong.setTitle(request.getParameter("title"));
                    updateSong.setArtist(request.getParameter("artist"));
                    updateSong.setGenre(request.getParameter("genre"));
                    updateSong.setImageUrl(request.getParameter("imageUrl"));
                    updateSong.setAudioUrl(request.getParameter("audioUrl"));

                    songDao.update(updateSong);
                    break;

                case "delete":

                    songDao.delete(requireId(request));
                    break;

                case "lock":

                    songDao.lockSong(requireId(request));
                    break;

                case "unlock":

                    songDao.unlockSong(requireId(request));
                    break;

                case "approve":

                    songDao.approveSong(requireId(request));
                    break;

                case "reject":

                    songDao.rejectSong(requireId(request));
                    break;

                case "viewFavUsers":

                    String favSongId = request.getParameter("songId");

                    loadAdminData(request);

                    if (favSongId != null && !favSongId.isBlank()) {

                        FavoriteDAO favoriteDAO = new FavoriteDAO();

                        request.setAttribute(
                                "favUsers",
                                favoriteDAO.findBySong(
                                        Long.parseLong(favSongId)));

                        request.setAttribute(
                                "selectedSongId",
                                Long.parseLong(favSongId));
                    }

                    request.setAttribute("reportTab", "fav-users");
                    request.setAttribute("activeTab", "report");

                    request.getRequestDispatcher("/admin/admin.jsp")
                            .forward(request, response);

                    return;

                default:

                    response.sendError(400, "Invalid action");
                    return;
            }

            writeJson(response,
                    "{\"status\":\"success\"}");

        } catch (Exception e) {

            e.printStackTrace();

            response.setStatus(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR);

            writeJson(response,
                    "{\"status\":\"error\",\"message\":\""
                            + e.getMessage()
                            + "\"}");
        }
    }
    private Long requireId(HttpServletRequest request) {

        String id = request.getParameter("id");

        if (id == null || id.isBlank()) {
            throw new IllegalArgumentException("Missing ID");
        }

        return Long.parseLong(id);
    }
    private void writeJson(HttpServletResponse response,
            String json)
		throws IOException {
		
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");
		response.getWriter().write(json);
		}
    private void loadAdminData(HttpServletRequest request) {

        ReportDao reportDao = new ReportDao();

        request.setAttribute("songs", songDao.findAll());

        request.setAttribute("stats",
                reportDao.getFavoriteStats());

        request.setAttribute("totalSongs",
                reportDao.getTotalSongs());

        request.setAttribute("totalUsers",
                reportDao.getTotalUsers());

        request.setAttribute("totalViews",
                reportDao.getTotalViews());

        request.setAttribute("avgSongsPerUser",
                reportDao.getAverageSongsPerUser());

        request.setAttribute("topUploaders",
                reportDao.getTopUploaders());

        request.setAttribute("uploadHistory",
                reportDao.getUploadHistory());

        request.setAttribute("topSongs",
                reportDao.getTopSongs());

        request.setAttribute("pendingSongs",
                songDao.findPendingSongs());
    }
}
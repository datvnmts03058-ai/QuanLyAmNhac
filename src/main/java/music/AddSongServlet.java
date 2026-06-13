package music;

import java.io.File;
import java.io.IOException;

import Dao.SongDao;
import Model.Song;
import Model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@WebServlet("/add-song")
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 15
)
public class AddSongServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private SongDao dao = new SongDao();

    @Override
    protected void doPost(HttpServletRequest request,
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

        String title = request.getParameter("title");
        String artist = request.getParameter("artist");

        if (title == null || title.trim().isEmpty()
                || artist == null || artist.trim().isEmpty()) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/home?error=empty");
            return;
        }

        String imageFolder =
                getServletContext().getRealPath("/images");

        String musicFolder =
                getServletContext().getRealPath("/music");

        new File(imageFolder).mkdirs();
        new File(musicFolder).mkdirs();

        // Upload ảnh
        Part imagePart = request.getPart("imageFile");

        String imageName = "";

        if (imagePart != null
                && imagePart.getSize() > 0
                && imagePart.getSubmittedFileName() != null) {

            imageName =
                    System.currentTimeMillis()
                            + "_"
                            + imagePart.getSubmittedFileName();

            imagePart.write(
                    imageFolder
                            + File.separator
                            + imageName);
        }

        // Upload nhạc
        Part audioPart = request.getPart("audioFile");

        if (audioPart == null
                || audioPart.getSize() == 0) {

            response.sendRedirect(
                    request.getContextPath()
                            + "/home?error=noaudio");
            return;
        }

        String audioName =
                System.currentTimeMillis()
                        + "_"
                        + audioPart.getSubmittedFileName();

        audioPart.write(
                musicFolder
                        + File.separator
                        + audioName);

        Song song = new Song();

        song.setTitle(title.trim());
        song.setArtist(artist.trim());

        song.setImageUrl("images/" + imageName);
        song.setAudioUrl("music/" + audioName);

        song.setUser(user);

        song.setActive(false);
        song.setApproved(false);

        if (song.getViews() == null) {
            song.setViews(0);
        }

        dao.create(song);

        response.sendRedirect(
                request.getContextPath()
                        + "/home?message=pending");
    }
}
package music;

import Dao.ShareDao;
import Dao.SongDao;
import Model.Share;
import Model.Song;
import Model.User;
import utils.MailUtil;
import utils.TokenUtil;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.Date;

@WebServlet("/share-song")
public class ShareServlet extends HttpServlet {

    private SongDao songDao = new SongDao();
    private ShareDao shareDao = new ShareDao();
    
    @Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
    	 req.setCharacterEncoding("UTF-8");

         try {
             Long songId = Long.parseLong(req.getParameter("songId"));
             String email = req.getParameter("email");
             String message = req.getParameter("message");

             Song song = songDao.findById(songId);

             if (song == null) {
                 req.setAttribute("error", "Không tìm thấy bài hát!");
                 req.getRequestDispatcher("/views/Share.jsp").forward(req, resp);
                 return;
             }

             // user từ session
             User user = (User) req.getSession().getAttribute("user");

             String token = TokenUtil.generateToken(25);

             Share share = new Share();
             share.setSong(song);
             share.setUser(user);
             share.setReceiverEmail(email);
             share.setToken(token);
             share.setSharedDate(new Date());

             shareDao.create(share);

             String baseUrl = req.getScheme() + "://"
                     + req.getServerName() + ":"
                     + req.getServerPort()
                     + req.getContextPath();

             String link = baseUrl + "/listen?token=" + token;

             String content =
                     "<h2>🎵 Bạn nhận được bài hát!</h2>" +
                     "<p><b>" + song.getTitle() + "</b> - " + song.getArtist() + "</p>" +
                     (message != null && !message.trim().isEmpty()
                             ? "<p>💬 " + message + "</p>"
                             : "") +
                     "<a href='" + link + "'>▶ Nghe ngay</a>";

             MailUtil.sendMail(email, "Share Music", content);

             req.setAttribute("msg", "Gửi thành công!");
             req.getRequestDispatcher("/views/Share.jsp").forward(req, resp);

         } catch (Exception e) {
             e.printStackTrace();
             req.setAttribute("error", "Lỗi: " + e.getMessage());
             req.getRequestDispatcher("/views/Share.jsp").forward(req, resp);
         }
     }
	}

       

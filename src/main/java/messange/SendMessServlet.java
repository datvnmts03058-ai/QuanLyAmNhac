package messange;
import java.io.IOException;
import java.util.List;

import Dao.MessDao;
import Dao.UserDAO;
import Model.Mess;
import Model.User;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/send-mess")
public class SendMessServlet extends HttpServlet {

    private MessDao dao = new MessDao();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        String title = req.getParameter("title");
        String content = req.getParameter("content");

        String userId = req.getParameter("userId"); 
        // null = gửi ALL
        UserDAO userDAO = new UserDAO();

        if (userId == null || userId.isEmpty()) {

            // 📌 gửi ALL users
            List<User> users = userDAO.findAll();

            for (User u : users) {

                Mess m = new Mess();
                m.setTitle(title);
                m.setContent(content);

                // ✔ fix đúng JPA (không cần constructor)
                User tempUser = new User();
                tempUser.setId(u.getId());
                m.setUser(tempUser);

                m.setIsRead(false);

                dao.create(m);
            }

        } else {

            Mess m = new Mess();
            m.setTitle(title);
            m.setContent(content);

            // ✔ fix userId
            User tempUser = new User();
            tempUser.setId(Long.parseLong(userId));

            m.setUser(tempUser);

            m.setIsRead(false);

            dao.create(m);
        }
}}
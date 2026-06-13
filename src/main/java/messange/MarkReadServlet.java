package messange;

import java.io.IOException;

import Dao.MessDao;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/mark-read")
public class MarkReadServlet extends HttpServlet {

    private MessDao dao = new MessDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {

        Long id = Long.parseLong(req.getParameter("id"));

        dao.markAsRead(id);

        resp.getWriter().write("ok");
    }
}

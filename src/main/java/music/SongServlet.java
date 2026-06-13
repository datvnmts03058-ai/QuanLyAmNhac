package music;

import java.io.IOException;

import Dao.SongDao;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/song")
public class SongServlet extends HttpServlet {

    private SongDao dao = new SongDao();

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws IOException {

        String idStr = request.getParameter("id");

        if(idStr != null){

            dao.increaseView(
                    Long.parseLong(idStr)
            );
        }

        response.setContentType("text/plain");
        response.getWriter().write("success");
    }
}
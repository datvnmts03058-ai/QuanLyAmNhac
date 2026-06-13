package Listener;

import auth.LoginServlet.OnlineCounter;
import jakarta.servlet.annotation.WebListener;
import jakarta.servlet.http.HttpSessionEvent;
import jakarta.servlet.http.HttpSessionListener;

@WebListener
public class SessionCounterListener
        implements HttpSessionListener {

    @Override
    public void sessionCreated(HttpSessionEvent se) {
        OnlineCounter.onlineUsers++;
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent se) {
        OnlineCounter.onlineUsers--;
    }
}
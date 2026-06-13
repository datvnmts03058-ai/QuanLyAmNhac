package utils;

import Dao.UserDAO;
import Model.User;
import org.mindrot.jbcrypt.BCrypt;
import java.util.List;

public class PasswordMigration {

    public static void main(String[] args) {

        UserDAO dao = new UserDAO();
        List<User> users = dao.findAll();

        for (User u : users) {

            String rawPassword = u.getPassword();

            if (rawPassword != null &&
                !rawPassword.startsWith("$2a$") &&
                !rawPassword.startsWith("$2b$") &&
                !rawPassword.startsWith("$2y$")) {

                String hash = BCrypt.hashpw(rawPassword, BCrypt.gensalt());

                // 🔥 LẤY USER MỚI TỪ DB (managed entity)
                User managed = dao.findById(u.getId());
                managed.setPassword(hash);

                dao.update(managed);

                System.out.println("Updated: " + managed.getUsername());
            }
        }
        System.out.println("DONE MIGRATION");
       
    }
}
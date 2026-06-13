package Dao;

import java.util.List;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import Model.User;
import utils.JpaUtil;

public class UserDAO {

    // CREATE
    public void create(User user) {
        EntityManager em = JpaUtil.getEntityManager();

        try {
            em.getTransaction().begin();
            em.persist(user);
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    // UPDATE
    public void update(User user) {
        EntityManager em = JpaUtil.getEntityManager();

        try {
            em.getTransaction().begin();
            em.merge(user);
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    // DELETE
    public void delete(Long id) {
        EntityManager em = JpaUtil.getEntityManager();

        try {
            User user = em.find(User.class, id);

            if (user != null) {
                em.getTransaction().begin();
                em.remove(user);
                em.getTransaction().commit();
            }

        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    // FIND BY ID
    public User findById(Long id) {
        EntityManager em = JpaUtil.getEntityManager();

        try {
            return em.find(User.class, id);
        } finally {
            em.close();
        }
    }

    // FIND ALL
    public List<User> findAll() {
        EntityManager em = JpaUtil.getEntityManager();

        try {
            TypedQuery<User> query =
                    em.createQuery(
                            "SELECT u FROM User u",
                            User.class);

            return query.getResultList();

        } finally {
            em.close();
        }
    }

    // FIND BY USERNAME
    public User findByUsername(String username) {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            TypedQuery<User> query =
                    em.createQuery(
                            "SELECT u FROM User u WHERE u.username = :username",
                            User.class);

            query.setParameter("username", username);

            List<User> list = query.getResultList();

            return list.isEmpty() ? null : list.get(0);

        } finally {
            em.close();
        }
    }

    // LOGIN
    public User login(String username) {

        EntityManager em = JpaUtil.getEntityManager();

        try {
            TypedQuery<User> query =
                em.createQuery(
                    "SELECT u FROM User u WHERE u.username = :username",
                    User.class);

            query.setParameter("username", username);

            List<User> list = query.getResultList();

            return list.isEmpty() ? null : list.get(0);

        } finally {
            em.close();
        }
    }

    // CHECK USERNAME EXISTS
    public boolean exists(String username) {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            Long count =
                    em.createQuery(
                            "SELECT COUNT(u) "
                            + "FROM User u "
                            + "WHERE u.username=:username",
                            Long.class)
                            .setParameter("username", username)
                            .getSingleResult();

            return count > 0;

        } finally {
            em.close();
        }
    }

    // PAGINATION
    public List<User> findPage(int page, int size) {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            TypedQuery<User> query =
                    em.createQuery(
                            "SELECT u FROM User u",
                            User.class);

            query.setFirstResult((page - 1) * size);
            query.setMaxResults(size);

            return query.getResultList();

        } finally {
            em.close();
        }
    }
    
    public User findByEmail(String email) {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            TypedQuery<User> query =
                    em.createQuery(
                            "SELECT u FROM User u WHERE u.email = :email",
                            User.class);

            query.setParameter("email", email);

            List<User> list = query.getResultList();

            return list.isEmpty() ? null : list.get(0);

        } finally {
            em.close();
        }
    }
    
    
}
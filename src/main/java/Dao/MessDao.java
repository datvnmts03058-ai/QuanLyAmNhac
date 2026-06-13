package Dao;

import java.util.List;

import jakarta.persistence.EntityManager;


import Model.Mess;
import utils.JpaUtil;

public class MessDao {

    // 📌 lấy tất cả notification
    public static List<Mess> findAll() {
        EntityManager em = JpaUtil.getEntityManager();

        try {
            return em.createQuery(
                "SELECT m FROM Mess m ORDER BY m.createdAt DESC",
                Mess.class
            ).getResultList();

        } finally {
            em.close();
        }
    }

    // 📌 lấy theo user (cá nhân + system)
    public List<Mess> findByUser(Long userId) {
        EntityManager em = JpaUtil.getEntityManager();

        try {
            return em.createQuery(
                "SELECT m FROM Mess m WHERE m.user.id = :uid OR m.user IS NULL ORDER BY m.createdAt DESC",
                Mess.class
            )
            .setParameter("uid", userId)
            .getResultList();

        } finally {
            em.close();
        }
    }

    // 📌 đếm unread
    public long countUnread(Long userId) {
        EntityManager em = JpaUtil.getEntityManager();

        try {
            return (long) em.createQuery(
                "SELECT COUNT(m) FROM Mess m WHERE (m.user.id = :uid OR m.user IS NULL) AND m.isRead = false"
            )
            .setParameter("uid", userId)
            .getSingleResult();

        } finally {
            em.close();
        }
    }

    // 📌 tạo message
    public void create(Mess m) {
        EntityManager em = JpaUtil.getEntityManager();

        try {
            em.getTransaction().begin();
            em.persist(m);
            em.getTransaction().commit();

        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e;

        } finally {
            em.close();
        }
    }

    // 📌 mark as read
    public void markAsRead(Long id) {
        EntityManager em = JpaUtil.getEntityManager();

        try {
            em.getTransaction().begin();

            Mess m = em.find(Mess.class, id);
            if (m != null) {
                m.setIsRead(true);
            }

            em.getTransaction().commit();

        } finally {
            em.close();
        }
    }
}
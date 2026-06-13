package Dao;

import java.util.List;

import Model.Song;
import jakarta.persistence.EntityManager;
import utils.JpaUtil;

public class ReportDao {

    public List<Object[]> getFavoriteStats() {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            String jpql =
                "SELECT f.song.title, COUNT(f.id), MAX(f.likedDate), MIN(f.likedDate) " +
                "FROM Favorite f GROUP BY f.song.title";

            return em.createQuery(jpql, Object[].class)
                     .getResultList();

        } finally {
            em.close();
        }
    }

    // Tổng số bài hát
    public Long getTotalSongs() {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            return em.createQuery(
                    "SELECT COUNT(s) FROM Song s",
                    Long.class)
                    .getSingleResult();

        } finally {
            em.close();
        }
    }

    // Tổng số user
    public Long getTotalUsers() {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            return em.createQuery(
                    "SELECT COUNT(u) FROM User u",
                    Long.class)
                    .getSingleResult();

        } finally {
            em.close();
        }
    }

    // Tổng lượt nghe
    public Long getTotalViews() {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            Long total = em.createQuery(
                    "SELECT COALESCE(SUM(s.views),0) FROM Song s",
                    Long.class)
                    .getSingleResult();

            return total;

        } finally {
            em.close();
        }
    }

    // Trung bình bài hát trên user
    public Double getAverageSongsPerUser() {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            Long totalSongs = em.createQuery(
                    "SELECT COUNT(s) FROM Song s",
                    Long.class
            ).getSingleResult();

            Long totalUsers = em.createQuery(
                    "SELECT COUNT(u) FROM User u",
                    Long.class
            ).getSingleResult();

            if (totalUsers == 0) {
                return 0.0;
            }

            double avg = (double) totalSongs / totalUsers;

     
            return Math.round(avg * 10.0) / 10.0;

        } finally {
            em.close();
        }
    }

    // Top user đăng nhiều bài nhất
    public List<Object[]> getTopUploaders() {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            return em.createQuery(
                    "SELECT s.user.username, COUNT(s) " +
                    "FROM Song s " +
                    "WHERE s.user IS NOT NULL " +
                    "GROUP BY s.user.username " +
                    "ORDER BY COUNT(s) DESC",
                    Object[].class)
                    .setMaxResults(10)
                    .getResultList();

        } finally {
            em.close();
        }
    }

    // Lịch sử upload mới nhất
    public List<Object[]> getUploadHistory() {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            return em.createQuery(
                    "SELECT s.user.username, s.title, s.createdDate " +
                    "FROM Song s " +
                    "WHERE s.user IS NOT NULL " +
                    "ORDER BY s.createdDate DESC",
                    Object[].class)
                    .setMaxResults(20)
                    .getResultList();

        } finally {
            em.close();
        }
    }

    // Top bài hát nhiều view nhất
    public List<Song> getTopSongs() {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            return em.createQuery(
                    "SELECT s FROM Song s " +
                    "ORDER BY s.views DESC",
                    Song.class)
                    .setMaxResults(10)
                    .getResultList();

        } finally {
            em.close();
        }
    }
}
package Dao;

import java.util.List;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import Model.Favorite;
import Model.Song;
import Model.User;
import utils.JpaUtil;

public class FavoriteDAO {

    public void add(User user, Song song) {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            em.getTransaction().begin();

            Favorite f = new Favorite();
            f.setUser(user);
            f.setSong(song);

            em.persist(f);

            em.getTransaction().commit();

        } catch (Exception e) {

            em.getTransaction().rollback();
            throw e;

        } finally {
            em.close();
        }
    }

    public void remove(User user, Song song) {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            TypedQuery<Favorite> q =
                em.createQuery(
                    "SELECT f FROM Favorite f "
                  + "WHERE f.user.id=:uid "
                  + "AND f.song.id=:sid",
                    Favorite.class);

            q.setParameter("uid", user.getId());
            q.setParameter("sid", song.getId());

            List<Favorite> list = q.getResultList();

            if (!list.isEmpty()) {

                em.getTransaction().begin();

                em.remove(
                    em.merge(list.get(0))
                );

                em.getTransaction().commit();
            }

        } finally {
            em.close();
        }
    }

    public boolean exists(User user, Song song) {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            Long count =
                em.createQuery(
                    "SELECT COUNT(f) "
                  + "FROM Favorite f "
                  + "WHERE f.user.id=:uid "
                  + "AND f.song.id=:sid",
                    Long.class)

                  .setParameter("uid", user.getId())
                  .setParameter("sid", song.getId())
                  .getSingleResult();

            return count > 0;

        } finally {
            em.close();
        }
    }

    public List<Favorite> findByUser(User user) {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            return em.createQuery(
                "SELECT f FROM Favorite f "
              + "WHERE f.user.id = :uid "
              + "AND f.song.active = true",
                Favorite.class)

                .setParameter("uid", user.getId())
                .getResultList();

        } finally {
            em.close();
        }
    }
    public List<Favorite> findBySong(Long songId) {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            return em.createQuery(
                    "SELECT f FROM Favorite f " +
                    "WHERE f.song.id = :sid",
                    Favorite.class)
                    .setParameter("sid", songId)
                    .getResultList();

        } finally {
            em.close();
        }
    }
}
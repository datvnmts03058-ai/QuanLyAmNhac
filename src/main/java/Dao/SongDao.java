package Dao;

import java.util.List;

import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import Model.Song;
import utils.JpaUtil;

public class SongDao {

    public List<Song> findAll() {

        EntityManager em = JpaUtil.getEntityManager();

        try {
            return em.createQuery(
                    "SELECT s FROM Song s",
                    Song.class)
                    .getResultList();
        } finally {
            em.close();
        }
    }

    public List<Song> search(String keyword) {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            TypedQuery<Song> query =
                    em.createQuery(
                            "SELECT s FROM Song s " +
                            "WHERE s.active = true " +
                            "AND s.approved = true " +
                            "AND (" +
                            "LOWER(s.title) LIKE LOWER(:kw) " +
                            "OR LOWER(s.artist) LIKE LOWER(:kw) " +
                            "OR LOWER(s.genre) LIKE LOWER(:kw)" +
                            ")",
                            Song.class);

            query.setParameter("kw", "%" + keyword + "%");

            return query.getResultList();

        } finally {
            em.close();
        }
    }
    
    
 // 1. Tìm theo ID (dùng cho chức năng Edit)
    public Song findById(Long id) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.find(Song.class, id);
        } finally {
            em.close();
        }
    }

    // 2. Thêm mới
    public void create(Song song) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.persist(song);
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    // 3. Cập nhật
    public void update(Song song) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            em.merge(song);
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }

    // 4. Xóa
    public void delete(Long id) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            em.getTransaction().begin();
            Song song = em.find(Song.class, id);
            if (song != null) {
                em.remove(song);
            }
            em.getTransaction().commit();
        } catch (Exception e) {
            em.getTransaction().rollback();
            throw e;
        } finally {
            em.close();
        }
    }
    public List<Song> findByUser(Long userId) {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            return em.createQuery(
                    "SELECT s FROM Song s WHERE s.user.id = :uid",
                    Song.class)
                    .setParameter("uid", userId)
                    .getResultList();

        } finally {
            em.close();
        }
    }
    public List<Song> findFavoriteSongs(Long userId) {

        EntityManager em = JpaUtil.getEntityManager();

        try {
            return em.createQuery(
                    "SELECT s FROM Song s JOIN Favorite f ON s.id = f.song.id " +
                    "WHERE f.user.id = :uid",
                    Song.class)
                    .setParameter("uid", userId)
                    .getResultList();

        } finally {
            em.close();
        }
    }
    public List<Song> findLatest(int limit) {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            return em.createQuery(
                    "SELECT s FROM Song s " +
                    "WHERE s.active = true " +
                    "AND s.approved = true " +
                    "ORDER BY s.id DESC",
                    Song.class)
                    .setMaxResults(limit)
                    .getResultList();

        } finally {
            em.close();
        }
    }
    public List<Song> findTrending() {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            return em.createQuery(
                    "SELECT s FROM Song s " +
                    "WHERE s.active = true " +
                    "AND s.approved = true " +
                    "ORDER BY s.views DESC",
                    Song.class)
                    .getResultList();

        } finally {
            em.close();
        }
    }
    
    public void lockSong(Long id) {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            em.getTransaction().begin();

            Song song = em.find(Song.class, id);

            if (song != null) {
                song.setActive(false);
            }

            em.getTransaction().commit();

        } catch (Exception e) {

            em.getTransaction().rollback();
            throw e;

        } finally {
            em.close();
        }
    }

    public void unlockSong(Long id) {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            em.getTransaction().begin();

            Song song = em.find(Song.class, id);

            if (song != null) {
                song.setActive(true);
            }

            em.getTransaction().commit();

        } catch (Exception e) {

            em.getTransaction().rollback();
            throw e;

        } finally {
            em.close();
        }
    }
    public void increaseView(Long id) {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            em.getTransaction().begin();

            Song song = em.find(Song.class, id);

            if(song != null) {

                if(song.getViews() == null) {
                    song.setViews(0);
                }

                song.setViews(song.getViews() + 1);
            }

            em.getTransaction().commit();

        } catch (Exception e) {

            em.getTransaction().rollback();
            throw e;

        } finally {
            em.close();
        }
    }
    public Long countSongs() {

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
    public Long countActiveSongs() {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            return em.createQuery(
                    "SELECT COUNT(s) FROM Song s WHERE s.active = true",
                    Long.class)
                    .getSingleResult();

        } finally {
            em.close();
        }
    }
    public Long countLockedSongs() {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            return em.createQuery(
                    "SELECT COUNT(s) FROM Song s WHERE s.active = false",
                    Long.class)
                    .getSingleResult();

        } finally {
            em.close();
        }
    }
    public static List<Song> findActiveSongs() {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            return em.createQuery(
                "SELECT s FROM Song s " +
                "WHERE s.active = true " +
                "AND s.approved = true",
                Song.class
            ).getResultList();

        } finally {
            em.close();
        }
    }
    public List<Song> findPendingSongs() {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            return em.createQuery(
                    "SELECT s FROM Song s " +
                    "WHERE s.approved = false",
                    Song.class)
                    .getResultList();

        } finally {
            em.close();
        }
    }
    public void approveSong(Long id) {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            em.getTransaction().begin();

            Song song = em.find(Song.class, id);

            if (song != null) {

                song.setApproved(true);
                song.setActive(true);
            }

            em.getTransaction().commit();

        } catch (Exception e) {

            em.getTransaction().rollback();
            throw e;

        } finally {
            em.close();
        }
    }
    public void rejectSong(Long id) {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            em.getTransaction().begin();

            Song song = em.find(Song.class, id);

            if (song != null) {
                em.remove(song);
            }

            em.getTransaction().commit();

        } catch (Exception e) {

            em.getTransaction().rollback();
            throw e;

        } finally {
            em.close();
        }
    }
    public List<Song> findTop3ByArtist(Long artistId) {

        EntityManager em = JpaUtil.getEntityManager();

        try {

            return em.createQuery(
                    "SELECT s FROM Song s " +
                    "WHERE s.artist.id = :artistId " +
                    "AND s.active = true " +
                    "AND s.approved = true " +
                    "ORDER BY s.views DESC",
                    Song.class)
                    .setParameter("artistId", artistId)
                    .setMaxResults(3)
                    .getResultList();

        } finally {
            em.close();
        }
    }
}
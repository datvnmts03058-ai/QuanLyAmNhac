package Dao;

import Model.Artist;
import jakarta.persistence.EntityManager;
import utils.JpaUtil;

import java.util.List;

public class ArtistDao {

    // lấy danh sách
    public List<Artist> findAll() {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            List<Artist> list = em.createQuery("SELECT a FROM Artist a", Artist.class)
                    .getResultList();

            // ⭐ AUTO INSERT nếu DB chưa có dữ liệu
            if (list.isEmpty()) {
                seedArtists();
                list = em.createQuery("SELECT a FROM Artist a", Artist.class)
                        .getResultList();
            }

            return list;

        } finally {
            em.close();
        }
    }

    // ⭐ TẠO SẴN 4 CA SĨ
    private void seedArtists() {
        EntityManager em = JpaUtil.getEntityManager();

        try {
            em.getTransaction().begin();

            em.persist(newArtist("Sơn Tùng M-TP", "images/sontung.jpg"));
            em.persist(newArtist("Mono", "images/mono.jpg"));
            em.persist(newArtist("Hoàng Linh", "images/hoanglinh.jpg"));
            em.persist(newArtist("Phan Quỳnh", "images/phanquyenh.jpg"));

            em.getTransaction().commit();

        } catch (Exception e) {
            em.getTransaction().rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }

    private Artist newArtist(String name, String image) {
        Artist a = new Artist();
        a.setName(name);
        a.setImage(image);
        return a;
    }

    public Artist findById(Long id) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.find(Artist.class, id);
        } finally {
            em.close();
        }
    }
}
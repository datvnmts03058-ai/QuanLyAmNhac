package Dao;

import Model.Share;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import utils.JpaUtil;

import java.util.List;

public class ShareDao {

    // CREATE
	public void create(Share share) {
	    EntityManager em = JpaUtil.getEntityManager();
	    try {
	        em.getTransaction().begin();
	        em.persist(share);
	        em.getTransaction().commit();
	    } catch (Exception e) {
	        em.getTransaction().rollback();
	        throw e;
	    } finally {
	        em.close();
	    }
	}

    // FIND BY TOKEN
    public Share findByToken(String token) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            TypedQuery<Share> query = em.createQuery(
                    "SELECT s FROM Share s WHERE s.token = :token",
                    Share.class
            );
            query.setParameter("token", token);

            List<Share> list = query.getResultList();
            return list.isEmpty() ? null : list.get(0);

        } finally {
            em.close();
        }
    }

    // HISTORY BY USER
    public List<Share> findByUser(Long userId) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            return em.createQuery(
                    "SELECT s FROM Share s WHERE s.user.id = :uid ORDER BY s.createdDate DESC",
                    Share.class
            )
            .setParameter("uid", userId)
            .getResultList();

        } finally {
            em.close();
        }
    }

    // DELETE
    public void delete(Long id) {
        EntityManager em = JpaUtil.getEntityManager();
        try {
            em.getTransaction().begin();

            Share s = em.find(Share.class, id);
            if (s != null) {
                em.remove(s);
            }

            em.getTransaction().commit();

        } catch (Exception e) {
            if (em.getTransaction().isActive())
                em.getTransaction().rollback();
            e.printStackTrace();
        } finally {
            em.close();
        }
    }
}
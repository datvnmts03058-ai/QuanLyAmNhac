package Model;

import java.util.Date;
import jakarta.persistence.*;

@Entity
@Table(name = "Favorites")
public class Favorite {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "userId")
    private User user;

    @ManyToOne
    @JoinColumn(name = "songId")
    private Song song;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "likedDate")
    private Date likedDate;

    public Favorite() {
    }

    public Long getId() {
        return id;
    }

    public User getUser() {
        return user;
    }

    public Song getSong() {
        return song;
    }

    public Date getLikedDate() {
        return likedDate;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public void setSong(Song song) {
        this.song = song;
    }

    public void setLikedDate(Date likedDate) {
        this.likedDate = likedDate;
    }
}
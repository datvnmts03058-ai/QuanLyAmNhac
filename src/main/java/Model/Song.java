package Model;

import java.util.Date;
import jakarta.persistence.*;

@Entity
@Table(name = "Songs")
public class Song {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String title;

    private String artist;

    private String genre;

    private String imageUrl;

    private String audioUrl;

    @ManyToOne
    @JoinColumn(name = "userId")
    private User user;

    @Column(name = "active")
    private Boolean active;

    @Column(name = "views")
    private Integer views;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "createdDate")
    private Date createdDate;
    
    @Column(nullable = false)
    private String status = "PENDING";

    private String rejectReason;
    
    private Boolean approved;
    
    public Song() {}

    
	public Song(Long id, String title, String artist, String genre, String imageUrl, String audioUrl, User user,
			Boolean active, Integer views, Date createdDate, String status, String rejectReason, Boolean approved) {
		super();
		this.id = id;
		this.title = title;
		this.artist = artist;
		this.genre = genre;
		this.imageUrl = imageUrl;
		this.audioUrl = audioUrl;
		this.user = user;
		this.active = active;
		this.views = views;
		this.createdDate = createdDate;
		this.status = status;
		this.rejectReason = rejectReason;
		this.approved = approved;
	}


	@PrePersist
    public void prePersist() {
        if (active == null) {
            active = true;
        }

        if (views == null) {
            views = 0;
        }

        if (createdDate == null) {
            createdDate = new Date();
        }
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getArtist() {
        return artist;
    }

    public void setArtist(String artist) {
        this.artist = artist;
    }

    public String getGenre() {
        return genre;
    }

    public void setGenre(String genre) {
        this.genre = genre;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public String getAudioUrl() {
        return audioUrl;
    }

    public void setAudioUrl(String audioUrl) {
        this.audioUrl = audioUrl;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Boolean getActive() {
        return active;
    }

    public void setActive(Boolean active) {
        this.active = active;
    }

    public Integer getViews() {
        return views;
    }

    public void setViews(Integer views) {
        this.views = views;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getRejectReason() {
		return rejectReason;
	}

	public void setRejectReason(String rejectReason) {
		this.rejectReason = rejectReason;
	}


	public Boolean getApproved() {
		return approved;
	}


	public void setApproved(Boolean approved) {
		this.approved = approved;
	}


    
}
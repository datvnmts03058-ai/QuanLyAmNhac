package Model;

import jakarta.persistence.*;

@Entity
@Table(name = "Artists")
public class Artist {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;
    private String image;

    public Artist() {}

    public Long getId() { return id; }
    public String getName() { return name; }
    public String getImage() { return image; }

    public void setName(String name) { this.name = name; }
    public void setImage(String image) { this.image = image; }
}
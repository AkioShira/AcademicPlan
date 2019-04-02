package data.model;
import lombok.Data;

@Data
public class User {
    private int idUser;
    private String login;
    private String password;
    private int role;
}

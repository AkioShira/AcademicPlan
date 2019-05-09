package data.model;

import lombok.Data;

@Data
public class Profile {
    private int idProfile;
    private String name;

    public enum sortParameter {
        idProfile, name
    }
}

package data.model;

import lombok.Data;

@Data
public class Role {
    private int idRole;
    private String name;

    public enum sortParameter {
        idRole, name
    }
}

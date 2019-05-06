package data.model;

import lombok.Data;

@Data
public class Faculty {
    private int idFaculty;
    private String name;
    private String shortName;
    private boolean visible;

    public enum sortParameter {
        idFaculty, name, shortName, visible
    }
}

package data.model;

import lombok.Data;

@Data
public class Department {
    private int idDepartment;
    private String name;
    private String shortName;
    private int idFaculty;
    private boolean visible;

    public enum sortParameter{
        idDepartment, name, shortName, idFaculty, visible
    }
}

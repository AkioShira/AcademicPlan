package data.model;

import lombok.Data;

@Data
public class Department {
    private int idDepartment;
    private String name;
    private String shortName;
    private boolean visible;

    public enum sortParameter{
        idDepartment, name, shortName, visible
    }
}

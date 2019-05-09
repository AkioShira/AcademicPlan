package data.model;

import lombok.Data;

@Data
public class Direction {
    private int idDirection;
    private String number;
    private String name;

    public enum sortParameter{
        idDirection, number, name
    }
}

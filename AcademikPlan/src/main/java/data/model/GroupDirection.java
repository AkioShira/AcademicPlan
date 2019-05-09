package data.model;

import lombok.Data;

@Data
public class GroupDirection {
    private int idGroupDirection;
    private String number;
    private String name;

    public enum sortParameter{
        idGroupDirection, number, name
    }
}

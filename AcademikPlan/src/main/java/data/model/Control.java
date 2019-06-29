package data.model;

import lombok.Data;

@Data
public class Control {
    int idVersion;
    int idTitle;
    String name;
    String time;
    boolean current;
}

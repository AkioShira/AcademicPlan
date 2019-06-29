package data.model;

import lombok.Data;

import java.util.ArrayList;
import java.util.List;

@Data
public class Physical {
    int idPhysical;
    int idTitle;
    int idPhysicalType;
    String name;
    int bsr;
    List<Double> week = new ArrayList<>();
}

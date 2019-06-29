package data.model;
import lombok.Data;

/**
 * Name: Шишко А.А.
 * Date: 01.06.2019
 */
@Data
public class Pract {
    int idPract;
    int idTitle;
    int idPractType;
    int semester;
    int week;

    public enum sortParameter{
        idPract, idTitle, idPractType, semester, week
    }
}

package data.model;

import lombok.Data;

@Data
public class Title {
    private int idTitle;
    private String name;
    private int yearReception;
    private int yearCreation;
    private String qualification;
    private int studyTime;
    private String studyLevel;
    private String formEducation;
    private int idGroupDirection;
    private int idDirection;
    private int idProfile;
    private int idDepartment;
    private int idPlan;
    private boolean visible;

    public enum sortParameter{
        idTitle, name, yearReception, yearCreation, qualification, studyTime,
        studyLevel, formEducation, idGroupDirection, idDirection, idProfile, idDepartment
    }
}

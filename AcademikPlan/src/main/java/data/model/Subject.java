package data.model;

import lombok.Data;

import java.util.List;

@Data
public class Subject {
    int idSubject;
    int idPart;
    int number;
    String name;
    String depart;
    int exams;
    int credits;
    int bsr;
    double lec;
    double lab;
    double pract;
    double self;
    List<SubSubject> subSubjectList;
}

package data.model;

import lombok.Data;

@Data
public class Subject {
    int idSubject;
    int idPart;
    double number;
    String name;
    String depart;
    int exams;
    int credits;
    int bsr;
    double lec;
    double lab;
    double pract;
    double self;
}

package data.dao;

import data.model.Subject;

import java.util.List;

public interface SubjectDao {
    Subject getSubjectById(int id);
    List<Subject> getSubjectsByPart(int idPart);
    boolean insertSubjects(List<Subject> subjects);
    boolean updateSubjects(List<Subject> subjects);
    boolean deleteSubject(Subject subject);
    double getMaxNumberByPart(int idPart);
    List<Double> getSumByPart(int idPart);
}

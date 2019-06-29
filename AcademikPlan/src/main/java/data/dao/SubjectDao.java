package data.dao;

import data.model.Subject;

import java.util.List;

public interface SubjectDao {
Subject getSubjectById(int id);
List<Subject> getSubjectsByPart(int idPart);
boolean insertSubjects(List<Subject> subjects);
boolean updateSubjects(List<Subject> subjects);
boolean deleteSubject(Subject subject);
int getMaxNumberByPart(int idPart);
List<Double> getSumByPart(int idPart, int studyTime);
List<Double> getSumAudByTitle(int idTitle);
List<Double> getSumSelfByTitle(int idTitle);
List<Double> getCountExamsByTitle(int idTitle);
List<Double> getCountCreditsByTitle(int idTitle);
List<Double> getCountKPByTitle(int idTitle);
List<Double> getSumCredByTitle(int idTitle);
List<Double> getSumBSRByTitle(int idTitle);
}

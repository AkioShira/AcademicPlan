package data.dao;

import data.model.Budget;
import data.model.StudyShedule;

import java.util.List;

public interface StudySheduleDao {
List<StudyShedule> getSheduleByTitle(int idTitle);
List<StudyShedule> getSheduleByTitleCourse(int idTitle, int course);
List<Budget> getBudgetByTitle(int idTitle, int studyTime);
int getMaxCourseByTitle(int idTitle);
boolean insertShedules(List<StudyShedule> sheduleList);
boolean updateShedules(List<StudyShedule> sheduleList);
boolean deleteShedulesByCourse(int course);
}

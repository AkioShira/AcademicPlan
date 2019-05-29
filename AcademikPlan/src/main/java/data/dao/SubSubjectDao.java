package data.dao;


import data.model.SubSubject;

import java.util.List;

public interface SubSubjectDao {
    SubSubject getSubSubjectById(int id);
    List<SubSubject> getSubSubjectsBySubject(int idPart);
    boolean insertSubSubjects(List<SubSubject> subjects);
    boolean updateSubSubjects(List<SubSubject> subjects);
    boolean deleteSubSubject(SubSubject subject);
}

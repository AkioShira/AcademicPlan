package data.dao;

import data.model.StateSertification;

import java.util.List;

public interface StateSertificationDao {
    StateSertification getStateSertificationById(int id);
    List<StateSertification> getSertificationsByTitle(int idTitle);
    boolean insertSertifications(List<StateSertification> sertifications);
    boolean updateSertifications(List<StateSertification> sertifications);
    boolean deleteSertification(StateSertification state);
}

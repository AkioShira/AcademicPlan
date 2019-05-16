package data.dao;

import data.model.StateSertification;

import java.util.List;

public interface StateSertificationDao {
    List<StateSertification> getSertificationsByTitle(int idTitle);
    boolean insertSertifications(List<StateSertification> sertifications);
    boolean updateSertifications(List<StateSertification> sertifications);
}

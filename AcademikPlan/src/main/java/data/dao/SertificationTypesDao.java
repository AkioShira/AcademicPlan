package data.dao;

import data.model.SertificationType;

import java.util.List;

public interface SertificationTypesDao {
    SertificationType getSertificationTypeById(int id);
    List<SertificationType> getAllSertificationTypes();
    boolean insertSertificationType(SertificationType type);
    boolean updateSertificationType(SertificationType type);
    boolean deleteSertificationType(SertificationType type);
}

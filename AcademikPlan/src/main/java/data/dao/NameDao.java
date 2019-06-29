package data.dao;

import data.model.Name;

import java.util.List;

public interface NameDao {
    Name getNameByTitle(int id);
    List<Name> getAllNames();
    boolean insertName(Name name);
    boolean updateName(Name name);
    boolean deleteName(Name name);
}

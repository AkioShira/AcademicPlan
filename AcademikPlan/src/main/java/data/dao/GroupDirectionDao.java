package data.dao;

import data.model.GroupDirection;

import java.util.List;

public interface GroupDirectionDao {
    GroupDirection getDirectionById(int id);
    List<GroupDirection> getAllDirections();
    boolean insertDirection(GroupDirection direction);
    boolean updateDirection(GroupDirection direction);
    boolean deleteDirection(GroupDirection direction);
    void setOrder(GroupDirection.sortParameter s);
}

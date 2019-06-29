package data.dao;

import data.model.Direction;

import java.util.List;

public interface DirectionDao {
Direction getDirectionById(int id);
List<Direction> getAllDirections();
boolean insertDirection(Direction direction);
boolean updateDirection(Direction direction);
boolean deleteDirection(Direction direction);
void setOrder(Direction.sortParameter s);
}

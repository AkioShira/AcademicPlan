package data.dao;

import data.model.User;

import java.util.List;

public interface UserDao {
    User getUserById(int id);
    List<User> getAllUser();
    List<User> getUsersByVisible(boolean visible);
    List<User> getUsersByDepartment(int idDepartment, boolean visible);
    User getUserByLoginPassword(String login, String password);
    boolean isUniqueLogin(String login);
    boolean isExist(String login, String password);
    boolean insertUser(User user);
    boolean updateUser(User user);
    boolean deleteUser(User user);
    void setOrder(User.sortParameter s);
}

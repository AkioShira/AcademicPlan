package data.dao;

import data.model.User;

import java.util.List;

public interface UserDao {
    User getUserById(int id);
    List<User> getAllUser();
    List<User> getUsersByVisible(boolean visible);
    List<User> getUsersByDepartment(int idDepartment, boolean visible);
    int getRoleByLoginPassword(String login, String password);
    boolean isExist(String login, String password);
    boolean insertUser();
    boolean updateUser(User user);
    boolean deleteUser();
    void setOrder(User.sortParameter s);
}

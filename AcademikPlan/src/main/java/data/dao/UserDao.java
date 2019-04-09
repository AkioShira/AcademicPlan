package data.dao;

import data.model.User;

import java.util.List;

public interface UserDao {
    User getUserById(String id);
    List<User> getAllUser();
    int getRoleByLoginPassword(String login, String password);
    boolean isExist(String login, String password);
    boolean insertUser();
    boolean updateUser();
    boolean deleteUser();
    void setOrder(User.sortParameter s);
}

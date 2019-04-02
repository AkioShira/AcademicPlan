package data.dao;

import data.model.User;

public interface UserDAO {
    User getUser();
    int getRoleByLoginPassword(String login, String password);
    boolean isExist(String login, String password);
    boolean insertUser();
    boolean updateUser();
    boolean deleteUser();
}

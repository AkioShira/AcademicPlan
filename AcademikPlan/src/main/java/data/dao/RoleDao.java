package data.dao;

import data.model.Role;

import java.util.List;

public interface RoleDao {
    Role getRoleById(int id);
    List<Role> getAllRoles();
    void setOrder(Role.sortParameter s);
}

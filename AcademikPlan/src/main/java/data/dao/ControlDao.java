package data.dao;

import data.model.Control;

import java.util.List;

public interface ControlDao {
    Control getControlById(int id);
    List<Control> getControlByTitle(int idTitle);
    boolean insertControl(Control control);
    boolean updateControl(Control control);
    boolean deleteControl(Control control);
}

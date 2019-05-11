package data.dao;

import data.model.Title;

import java.util.List;

public interface TitleDao {
    Title getTitleById(int id);
    List<Title> getTitlesByVisible(boolean visible);
    List<Title> getAllTitles();
    List<Title> getTitlesByDepartment(int idDepartment, boolean visibleTitle);
    boolean insertTitle(Title title);
    boolean updateTitle(Title title);
    boolean deleteTitle(Title title);
    void setOrder(Title.sortParameter s);
}

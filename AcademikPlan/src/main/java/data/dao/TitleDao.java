package data.dao;

import data.model.Title;

import java.util.List;

public interface TitleDao {
    Title getTitleById(int id);
    List<Title> getAllTitles();
    boolean insertTitle(Title title);
    boolean updateTitle(Title title);
    boolean deleteTitle(Title title);
    void setOrder(Title.sortParameter s);
}

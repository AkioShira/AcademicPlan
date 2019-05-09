package data.dao;

import data.model.Profile;

import java.util.List;

public interface ProfileDao {
    Profile getProfileById(int id);
    List<Profile> getAllProfiles();
    boolean insertProfile(Profile profile);
    boolean updateProfile(Profile profile);
    boolean deleteProfile(Profile profile);
    void setOrder(Profile.sortParameter s);
}

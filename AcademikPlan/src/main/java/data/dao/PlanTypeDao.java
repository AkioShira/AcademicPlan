package data.dao;

import data.model.PlanType;

import java.util.List;

public interface PlanTypeDao {
    PlanType getPlanById(int id);
    List<PlanType> getAllPlans();
}

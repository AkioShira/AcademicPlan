package data.dao.mariaDB;

import data.ConnectionService;
import data.dao.PlanTypeDao;
import data.model.PlanType;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class PlanTypeMariaDb extends ConnectionService implements PlanTypeDao {
    private Connection connection;

    PlanTypeMariaDb(Connection connection){
        this.connection = connection;
    }

    @Override
    public PlanType getPlanById(int id) {
        String query = "SELECT * FROM plan_types WHERE idPlan = " + id;
        return getPlans(query).get(0);
    }

    @Override
    public List<PlanType> getAllPlans() {
        String query = "SELECT * FROM plan_types";
        return getPlans(query);
    }


    private List<PlanType> getPlans(String query) {
        List<PlanType> roleList = new ArrayList<PlanType>();
        PreparedStatement statement = null;
        ResultSet rs = null;
        try{
            statement = connection.prepareStatement(query);
            rs = statement.executeQuery();
            while(rs.next()){
                PlanType role = new PlanType();
                role.setIdPlan(rs.getInt("idPlan"));
                role.setName(rs.getString("name"));
                role.setShortName(rs.getString("shortName"));
                roleList.add(role);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            closeResurse(statement, rs);
        }
        return roleList;
    }
}

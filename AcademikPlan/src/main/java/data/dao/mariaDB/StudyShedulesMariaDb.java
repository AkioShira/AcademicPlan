package data.dao.mariaDB;

import data.ConnectionService;

import data.dao.StudySheduleDao;
import data.model.Budget;
import data.model.StudyShedule;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class StudyShedulesMariaDb extends ConnectionService implements StudySheduleDao {
    private Connection connection;

    StudyShedulesMariaDb(Connection connection){
        this.connection = connection;
    }

    @Override
    public List<StudyShedule> getSheduleByTitle(int idTitle) {
        return getShedules("SELECT * FROM study_shedules WHERE idTitle = "+idTitle+" ORDER BY week");
    }

    @Override
    public List<StudyShedule> getSheduleByTitleCourse(int idTitle, int course) {
        return getShedules("SELECT * FROM study_shedules WHERE idTitle = "+idTitle+" AND course = "+course+" ORDER BY week");
    }

    @Override
    public boolean insertShedules(List<StudyShedule> sheduleList) {
        PreparedStatement statement = null;
        ResultSet rs = null;
        String query="INSERT INTO study_shedules SET idTitle = ?, course = ?, week = ?, label = ?";
        try{
            connection.setAutoCommit(false);
            statement = connection.prepareStatement(query);
            for(StudyShedule shedule : sheduleList) {
                statement.setInt(1, shedule.getIdTitle());
                statement.setInt(2, shedule.getCourse());
                statement.setInt(3, shedule.getWeek());
                statement.setString(4, shedule.getLabel());
                statement.addBatch();
            }
            statement.executeBatch();
            connection.commit();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            try {
                connection.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }finally {
            try {
                connection.setAutoCommit(true);
            } catch (SQLException e) {
                e.printStackTrace();
            }
            closeResurse(statement, rs);
        }
        return false;
    }

    @Override
    public int getMaxCourseByTitle(int idTitle) {
        PreparedStatement statement = null;
        ResultSet rs = null;
        try{
            statement = connection.prepareStatement("SELECT MAX(ss.course) FROM study_shedules ss WHERE ss.idTitle = "+idTitle);
            rs = statement.executeQuery();
            rs.next();
            return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            closeResurse(statement, rs);
        }
        return -1;
    }

    @Override
    public boolean deleteShedulesByCourse(int course) {
        String query="DELETE * FROM study_shedules WHERE course = "+course;
        PreparedStatement statement = null;
        try{
            statement = connection.prepareStatement(query);
            statement.execute();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            closeResurse(statement, null);
        }
        return false;
    }

    @Override
    public boolean updateShedules(List<StudyShedule> sheduleList) {
        PreparedStatement statement = null;
        ResultSet rs = null;
        String query="UPDATE study_shedules SET idTitle = ?, course = ?, week = ?, label = ? WHERE idShedule = ?";
        try{
            connection.setAutoCommit(false);
            statement = connection.prepareStatement(query);
            for(StudyShedule shedule : sheduleList) {
                statement.setInt(1, shedule.getIdTitle());
                statement.setInt(2, shedule.getCourse());
                statement.setInt(3, shedule.getWeek());
                statement.setString(4, shedule.getLabel());
                statement.setInt(5, shedule.getIdShedule());
                statement.addBatch();
            }
            statement.executeBatch();
            connection.commit();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            try {
                connection.rollback();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }finally {
            try {
                connection.setAutoCommit(true);
            } catch (SQLException e) {
                e.printStackTrace();
            }
            closeResurse(statement, rs);
        }
        return false;
    }

    @Override
    public List<Budget> getBudgetByTitle(int idTitle, int studyTime) {
        List<Budget> budgets = new ArrayList<Budget>();
        PreparedStatement statement = null;
        ResultSet rs = null;
        try{
            for(int i=1; i<=studyTime; i++) {
                statement = connection.prepareStatement(
                        "SELECT COUNT(*) FROM study_shedules ss WHERE ss.label='' AND ss.idTitle = " + idTitle + " AND ss.course="+i+" UNION ALL\n" +
                                "SELECT COUNT(*) FROM study_shedules ss WHERE ss.label='С' AND ss.idTitle = " + idTitle + " AND ss.course="+i+" UNION ALL\n" +
                                "SELECT COUNT(*) FROM study_shedules ss WHERE ss.label='П' AND ss.idTitle = " + idTitle + " AND ss.course="+i+" UNION ALL\n" +
                                "SELECT COUNT(*) FROM study_shedules ss WHERE ss.label='Д' AND ss.idTitle = " + idTitle + " AND ss.course="+i+" UNION ALL\n" +
                                "SELECT COUNT(*) FROM study_shedules ss WHERE ss.label='Г' AND ss.idTitle = " + idTitle + " AND ss.course="+i+" UNION ALL\n" +
                                "SELECT COUNT(*) FROM study_shedules ss WHERE ss.label='К' AND ss.idTitle = " + idTitle + " AND ss.course="+i);
                rs = statement.executeQuery();
                Budget budget = getBudget(rs);
                budget.setAll(budget.getExam()+budget.getHolidays()+budget.getPractic()+budget.getQualification()
                    +budget.getStateExam()+ budget.getTheory());
                budgets.add(budget);
            }
            statement = connection.prepareStatement(
                    "SELECT COUNT(*) FROM study_shedules ss WHERE ss.label='' AND ss.idTitle = " + idTitle + " AND ss.course<="+studyTime+" UNION ALL\n" +
                            "SELECT COUNT(*) FROM study_shedules ss WHERE ss.label='С' AND ss.idTitle = " + idTitle + " AND ss.course<="+studyTime+" UNION ALL\n" +
                            "SELECT COUNT(*) FROM study_shedules ss WHERE ss.label='П' AND ss.idTitle = " + idTitle + " AND ss.course<="+studyTime+" UNION ALL\n" +
                            "SELECT COUNT(*) FROM study_shedules ss WHERE ss.label='Д' AND ss.idTitle = " + idTitle + " AND ss.course<="+studyTime+" UNION ALL\n" +
                            "SELECT COUNT(*) FROM study_shedules ss WHERE ss.label='Г' AND ss.idTitle = " + idTitle + " AND ss.course<="+studyTime+" UNION ALL\n" +
                            "SELECT COUNT(*) FROM study_shedules ss WHERE ss.label='К' AND ss.idTitle = " + idTitle + " AND ss.course<="+studyTime);
            rs = statement.executeQuery();
            Budget budget = getBudget(rs);
            budget.setAll(budget.getExam()+budget.getHolidays()+budget.getPractic()+budget.getQualification()
                    +budget.getStateExam()+ budget.getTheory());
            budgets.add(budget);
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            closeResurse(statement, rs);
        }
        return budgets;
    }

    private Budget getBudget(ResultSet rs) throws SQLException{
        Budget budget = new Budget();
        rs.next();
        budget.setTheory(rs.getInt(1));
        rs.next();
        budget.setExam(rs.getInt(1));
        rs.next();
        budget.setPractic(rs.getInt(1));
        rs.next();
        budget.setQualification(rs.getInt(1));
        rs.next();
        budget.setStateExam(rs.getInt(1));
        rs.next();
        budget.setHolidays(rs.getInt(1));
        return budget;
    }

    private List<StudyShedule> getShedules(String query) {
        List<StudyShedule> shedules = new ArrayList<StudyShedule>();
        PreparedStatement statement = null;
        ResultSet rs = null;
        try{
            statement = connection.prepareStatement(query);
            rs = statement.executeQuery();
            while(rs.next()){
                StudyShedule shedule = new StudyShedule();
                shedule.setIdShedule(rs.getInt("idShedule"));
                shedule.setIdTitle(rs.getInt("idTitle"));
                shedule.setCourse(rs.getInt("course"));
                shedule.setWeek(rs.getInt("week"));
                shedule.setLabel(rs.getString("label"));
                shedules.add(shedule);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            closeResurse(statement, rs);
        }
        return shedules;
    }
}

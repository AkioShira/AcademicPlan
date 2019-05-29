package data.dao.mariaDB;

import connection.pooling.ConnectionPool;
import data.ConnectionService;
import data.dao.PractDao;
import data.dao.SubjectDao;
import data.model.Pract;
import data.model.Subject;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class SubjectMariaDb extends ConnectionService implements SubjectDao {
    private Connection connection;


    SubjectMariaDb(Connection connection){
        this.connection = connection;
    }

    @Override
    public Subject getSubjectById(int id) {
        return getSubjects("SELECT * FROM subjects WHERE idSubject = "+id).get(0);
    }

    @Override
    public List<Subject> getSubjectsByPart(int idPart) {
        return getSubjects("SELECT * FROM subjects WHERE idPart = "+idPart+" ORDER BY number");
    }

    @Override
    public boolean insertSubjects(List<Subject> subjects) {
        PreparedStatement statement = null;
        ResultSet rs = null;
        String query="INSERT INTO subjects SET idPart = ?, number = ?, name = ?, depart = ?, exams = ?, credits = ?, bsr = ?, lec = ?, lab = ?, pract = ?, self = ?";
        try{
            connection.setAutoCommit(false);
            statement = connection.prepareStatement(query);
            for(Subject subject : subjects) {
                statement.setInt(1, subject.getIdPart());
                statement.setInt(2, subject.getNumber());
                statement.setString(3, subject.getName());
                statement.setString(4, subject.getDepart());
                statement.setInt(5, subject.getExams());
                statement.setInt(6, subject.getCredits());
                statement.setInt(7, subject.getBsr());
                statement.setDouble(8, subject.getLec());
                statement.setDouble(9, subject.getLab());
                statement.setDouble(10, subject.getPract());
                statement.setDouble(11, subject.getSelf());
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
    public boolean updateSubjects(List<Subject> subjects) {
        PreparedStatement statement = null;
        ResultSet rs = null;
        String query="UPDATE subjects SET idPart = ?, number = ?, name = ?, depart = ?, exams = ?, credits = ?, bsr = ?, lec = ?, lab = ?, pract = ?, self = ? WHERE idSubject=?";
        try{
            connection.setAutoCommit(false);
            statement = connection.prepareStatement(query);
            for(Subject subject : subjects) {
                statement.setInt(1, subject.getIdPart());
                statement.setInt(2, subject.getNumber());
                statement.setString(3, subject.getName());
                statement.setString(4, subject.getDepart());
                statement.setInt(5, subject.getExams());
                statement.setInt(6, subject.getCredits());
                statement.setInt(7, subject.getBsr());
                statement.setDouble(8, subject.getLec());
                statement.setDouble(9, subject.getLab());
                statement.setDouble(10, subject.getPract());
                statement.setDouble(11, subject.getSelf());
                statement.setInt(12, subject.getIdSubject());
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
    public int getMaxNumberByPart(int idPart) {
        PreparedStatement statement = null;
        ResultSet rs = null;
        String query="SELECT MAX(s.number) FROM subjects s WHERE s.idPart = "+idPart;
        try{
            statement = connection.prepareStatement(query);
            rs = statement.executeQuery();
            rs.next();
            return rs.getInt(1);
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            closeResurse(statement, rs);
        }
        return 0;
    }

    @Override
    public boolean deleteSubject(Subject subject) {
        PreparedStatement statement = null;
        ResultSet rs = null;
        String query="DELETE FROM subjects WHERE idSubject = "+subject.getIdSubject();
        try{
            statement = connection.prepareStatement(query);
            statement.execute();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            closeResurse(statement, rs);
        }
        return false;
    }



    private List<Subject> getSubjects(String query) {
        List<Subject> subjectList = new ArrayList<Subject>();
        PreparedStatement statement = null;
        ResultSet rs = null;
        try{
            statement = connection.prepareStatement(query);
            rs = statement.executeQuery();
            while(rs.next()){
                Subject subject = new Subject();
                subject.setIdSubject(rs.getInt("idSubject"));
                subject.setIdPart(rs.getInt("idPart"));
                subject.setNumber(rs.getInt("number"));
                subject.setName(rs.getString("name"));
                subject.setDepart(rs.getString("depart"));
                subject.setExams(rs.getInt("exams"));
                subject.setCredits(rs.getInt("credits"));
                subject.setBsr(rs.getInt("bsr"));
                subject.setLec(rs.getDouble("lec"));
                subject.setLab(rs.getDouble("lab"));
                subject.setPract(rs.getDouble("pract"));
                subject.setSelf(rs.getDouble("self"));
                subjectList.add(subject);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            closeResurse(statement, rs);
        }
        return subjectList;
    }

    @Override
    public List<Double> getSumByPart(int idPart, int studyTime) {
        List<Double> sumList = new ArrayList<>();
        PreparedStatement statement = null;
        ResultSet rs = null;
        String query="CALL sumPart("+idPart+", "+studyTime+")";
        try{
            statement = connection.prepareStatement(query);
            rs = statement.executeQuery();
            while(rs.next()){
                sumList.add(rs.getDouble("sum"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            closeResurse(statement, rs);
        }
        return sumList;
    }

    @Override
    public List<Double> getSumAudByTitle(int idTitle) {
        List<Double> audList = new ArrayList<>();
        PreparedStatement statement = null;
        ResultSet rs = null;
        String query="CALL sumAud("+idTitle+")";
        try{
            statement = connection.prepareStatement(query);
            rs = statement.executeQuery();
            while(rs.next()){
                audList.add(rs.getDouble("sum"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            closeResurse(statement, rs);
        }
        return audList;
    }

    @Override
    public List<Double> getSumSelfByTitle(int idTitle) {
        List<Double> selfList = new ArrayList<>();
        PreparedStatement statement = null;
        ResultSet rs = null;
        String query="CALL sumSelf("+idTitle+")";
        try{
            statement = connection.prepareStatement(query);
            rs = statement.executeQuery();
            while(rs.next()){
                selfList.add(rs.getDouble("sum"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            closeResurse(statement, rs);
        }
        return selfList;
    }

    @Override
    public List<Double> getCountExamsByTitle(int idTitle) {
        List<Double> examList = new ArrayList<>();
        PreparedStatement statement = null;
        ResultSet rs = null;
        String query="CALL examCount("+idTitle+")";
        try{
            statement = connection.prepareStatement(query);
            rs = statement.executeQuery();
            while(rs.next()){
                examList.add(rs.getDouble("count"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            closeResurse(statement, rs);
        }
        return examList;
    }

    @Override
    public List<Double> getCountCreditsByTitle(int idTitle) {
        List<Double> creditList = new ArrayList<>();
        PreparedStatement statement = null;
        ResultSet rs = null;
        String query="CALL creditCount("+idTitle+")";
        try{
            statement = connection.prepareStatement(query);
            rs = statement.executeQuery();
            while(rs.next()){
                creditList.add(rs.getDouble("count"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            closeResurse(statement, rs);
        }
        return creditList;
    }

    @Override
    public List<Double> getCountKPByTitle(int idTitle) {
        List<Double> kpList = new ArrayList<>();
        PreparedStatement statement = null;
        ResultSet rs = null;
        String query="CALL kpCount("+idTitle+")";
        try{
            statement = connection.prepareStatement(query);
            rs = statement.executeQuery();
            while(rs.next()){
                kpList.add(rs.getDouble("count"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            closeResurse(statement, rs);
        }
        return kpList;
    }

    @Override
    public List<Double> getSumCredByTitle(int idTitle) {
        List<Double> sumList = new ArrayList<>();
        PreparedStatement statement = null;
        ResultSet rs = null;
        String query="CALL sumZE("+idTitle+")";
        try{
            statement = connection.prepareStatement(query);
            rs = statement.executeQuery();
            while(rs.next()){
                sumList.add(rs.getDouble("sum"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            closeResurse(statement, rs);
        }
        return sumList;
    }

    @Override
    public List<Double> getSumBSRByTitle(int idTitle) {
        List<Double> sumList = new ArrayList<>();
        PreparedStatement statement = null;
        ResultSet rs = null;
        String query="CALL sumBSR("+idTitle+")";
        try{
            statement = connection.prepareStatement(query);
            rs = statement.executeQuery();
            while(rs.next()){
                sumList.add(rs.getDouble("sum"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            closeResurse(statement, rs);
        }
        return sumList;
    }

    public static void main(String ...arc){
        try {
            SubjectMariaDb subjectMariaDb = new SubjectMariaDb(ConnectionPool.getConnection());
            List<Double> list = subjectMariaDb.getSumByPart(10, 4);
            for(double i : list)
                System.out.println(i);
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }
}

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
                statement.setDouble(2, subject.getNumber());
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
                statement.setDouble(2, subject.getNumber());
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
    public double getMaxNumberByPart(int idPart) {
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
                subject.setNumber(rs.getDouble("number"));
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
    public List<Double> getSumByPart(int idPart) {
        List<Double> sumList = new ArrayList<>();
        PreparedStatement statement = null;
        ResultSet rs = null;
        String query="SELECT SUM((s.lec*18+s.lab*18+s.pract*18+s.self*18 + s.bsr)/36) AS 'sum' FROM subjects s WHERE s.idPart = "+idPart+" UNION ALL\n" +
                "SELECT COUNT(s.exams) FROM subjects s WHERE s.idPart = "+idPart+" AND s.exams>0 UNION ALL\n" +
                "SELECT COUNT(s.credits) FROM subjects s WHERE s.idPart = "+idPart+" UNION ALL\n" +
                "SELECT SUM(s.lec*18+s.lab*18+s.pract*18+s.self*18 + s.bsr) FROM subjects s WHERE s.idPart = "+idPart+" UNION ALL\n" +
                "SELECT SUM(s.lec*18+s.lab*18+s.pract*18) FROM subjects s WHERE s.idPart = "+idPart+" UNION ALL\n" +
                "SELECT SUM(s.lec*18) FROM subjects s WHERE s.idPart = "+idPart+"  UNION ALL\n" +
                "SELECT SUM(s.lab*18) FROM subjects s WHERE s.idPart = "+idPart+" UNION ALL\n" +
                "SELECT SUM(s.pract*18) FROM subjects s WHERE s.idPart = "+idPart+" UNION ALL\n" +
                "SELECT SUM(s.self*18 + s.bsr) FROM subjects s WHERE s.idPart = "+idPart+" UNION ALL\n" +
                "SELECT SUM(s.self*18) FROM subjects s WHERE s.idPart = "+idPart+" UNION ALL\n" +
                "SELECT SUM(s.bsr) FROM subjects s WHERE s.idPart = "+idPart+" UNION ALL\n" +
                "\n" +
                "SELECT SUM(s.lec) FROM subjects s WHERE s.idPart = "+idPart+" AND (s.exams=1 OR s.credits=1) UNION ALL\n" +
                "SELECT SUM(s.lab) FROM subjects s WHERE s.idPart = "+idPart+" AND (s.exams=1 OR s.credits=1) UNION ALL\n" +
                "SELECT SUM(s.pract) FROM subjects s WHERE s.idPart = "+idPart+" AND (s.exams=1 OR s.credits=1) UNION ALL\n" +
                "SELECT SUM(s.self) FROM subjects s WHERE s.idPart = "+idPart+" AND (s.exams=1 OR s.credits=1) UNION ALL\n" +
                "\n" +
                "SELECT SUM(s.lec) FROM subjects s WHERE s.idPart = "+idPart+" AND (s.exams=2 OR s.credits=2) UNION ALL\n" +
                "SELECT SUM(s.lab) FROM subjects s WHERE s.idPart = "+idPart+" AND (s.exams=2 OR s.credits=2) UNION ALL\n" +
                "SELECT SUM(s.pract) FROM subjects s WHERE s.idPart = "+idPart+" AND (s.exams=2 OR s.credits=2) UNION ALL\n" +
                "SELECT SUM(s.self) FROM subjects s WHERE s.idPart = "+idPart+" AND (s.exams=2 OR s.credits=2) UNION ALL\n" +
                "\n" +
                "SELECT SUM(s.lec) FROM subjects s WHERE s.idPart = "+idPart+" AND (s.exams=3 OR s.credits=3) UNION ALL\n" +
                "SELECT SUM(s.lab) FROM subjects s WHERE s.idPart = "+idPart+" AND (s.exams=3 OR s.credits=3) UNION ALL\n" +
                "SELECT SUM(s.pract) FROM subjects s WHERE s.idPart = "+idPart+" AND (s.exams=3 OR s.credits=3) UNION ALL\n" +
                "SELECT SUM(s.self) FROM subjects s WHERE s.idPart = "+idPart+" AND (s.exams=3 OR s.credits=3) UNION ALL\n" +
                "\n" +
                "SELECT SUM(s.lec) FROM subjects s WHERE s.idPart = "+idPart+" AND (s.exams=4 OR s.credits=4) UNION ALL\n" +
                "SELECT SUM(s.lab) FROM subjects s WHERE s.idPart = "+idPart+" AND (s.exams=4 OR s.credits=4) UNION ALL\n" +
                "SELECT SUM(s.pract) FROM subjects s WHERE s.idPart = "+idPart+" AND (s.exams=4 OR s.credits=4) UNION ALL\n" +
                "SELECT SUM(s.self) FROM subjects s WHERE s.idPart = "+idPart+" AND (s.exams=4 OR s.credits=4) UNION ALL\n" +
                "\n" +
                "  SELECT SUM(s.lec) FROM subjects s WHERE s.idPart = "+idPart+" AND (s.exams=5 OR s.credits=5) UNION ALL\n" +
                "SELECT SUM(s.lab) FROM subjects s WHERE s.idPart = "+idPart+" AND (s.exams=5 OR s.credits=5) UNION ALL\n" +
                "SELECT SUM(s.pract) FROM subjects s WHERE s.idPart = "+idPart+" AND (s.exams=5 OR s.credits=5) UNION ALL\n" +
                "SELECT SUM(s.self) FROM subjects s WHERE s.idPart = "+idPart+" AND (s.exams=5 OR s.credits=5) UNION ALL\n" +
                "\n" +
                "  SELECT SUM(s.lec) FROM subjects s WHERE s.idPart = "+idPart+" AND (s.exams=6 OR s.credits=6) UNION ALL\n" +
                "SELECT SUM(s.lab) FROM subjects s WHERE s.idPart = "+idPart+" AND (s.exams=6 OR s.credits=6) UNION ALL\n" +
                "SELECT SUM(s.pract) FROM subjects s WHERE s.idPart = "+idPart+" AND (s.exams=6 OR s.credits=6) UNION ALL\n" +
                "SELECT SUM(s.self) FROM subjects s WHERE s.idPart = "+idPart+" AND (s.exams=6 OR s.credits=6) UNION ALL\n" +
                "\n" +
                "  SELECT SUM(s.lec) FROM subjects s WHERE s.idPart = "+idPart+" AND (s.exams=7 OR s.credits=7) UNION ALL\n" +
                "SELECT SUM(s.lab) FROM subjects s WHERE s.idPart = "+idPart+" AND (s.exams=7 OR s.credits=7) UNION ALL\n" +
                "SELECT SUM(s.pract) FROM subjects s WHERE s.idPart = "+idPart+" AND (s.exams=7 OR s.credits=7) UNION ALL\n" +
                "SELECT SUM(s.self) FROM subjects s WHERE s.idPart = "+idPart+" AND (s.exams=7 OR s.credits=7) UNION ALL\n" +
                "\n" +
                "  SELECT SUM(s.lec) FROM subjects s WHERE s.idPart = "+idPart+" AND (s.exams=8 OR s.credits=8) UNION ALL\n" +
                "SELECT SUM(s.lab) FROM subjects s WHERE s.idPart = "+idPart+" AND (s.exams=8 OR s.credits=8) UNION ALL\n" +
                "SELECT SUM(s.pract) FROM subjects s WHERE s.idPart = "+idPart+" AND (s.exams=8 OR s.credits=8) UNION ALL\n" +
                "SELECT SUM(s.self) FROM subjects s WHERE s.idPart = "+idPart+" AND (s.exams=8 OR s.credits=8)";
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
            List<Double> list = subjectMariaDb.getSumByPart(6);
            for(double i : list)
                System.out.println(i);
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }
}

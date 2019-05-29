package data.dao.mariaDB;

import connection.pooling.ConnectionPool;
import data.ConnectionService;
import data.dao.SubSubjectDao;
import data.model.SubSubject;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class SubSubjectMariaDb extends ConnectionService implements SubSubjectDao {
    private Connection connection;

    SubSubjectMariaDb(Connection connection){
        this.connection = connection;
    }

    @Override
    public SubSubject getSubSubjectById(int id) {
        return getSubjects("SELECT * FROM sub_subject WHERE idSubSubject = "+id).get(0);
    }

    @Override
    public List<SubSubject> getSubSubjectsBySubject(int idSubject) {
        return getSubjects("SELECT * FROM sub_subject WHERE idSubject = "+idSubject);
    }

    @Override
    public boolean insertSubSubjects(List<SubSubject> subjects) {
        PreparedStatement statement = null;
        ResultSet rs = null;
        String query="INSERT INTO sub_subject SET idSubject = ?, name = ?";
        try{
            connection.setAutoCommit(false);
            statement = connection.prepareStatement(query);
            for(SubSubject subject : subjects) {
                statement.setInt(1, subject.getIdSubject());
                statement.setString(2, subject.getName());
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
    public boolean updateSubSubjects(List<SubSubject> subjects) {
        PreparedStatement statement = null;
        ResultSet rs = null;
        String query="UPDATE sub_subject SET idSubject = ?, name = ? WHERE idSubSubject=?";
        try{
            connection.setAutoCommit(false);
            statement = connection.prepareStatement(query);
            for(SubSubject subject : subjects) {
                statement.setInt(1, subject.getIdSubject());
                statement.setString(2, subject.getName());
                statement.setInt(3, subject.getIdSubSubject());

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
    public boolean deleteSubSubject(SubSubject subject) {
        PreparedStatement statement = null;
        ResultSet rs = null;
        String query="DELETE FROM sub_subject WHERE idSubSubject = "+subject.getIdSubSubject();
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

    private List<SubSubject> getSubjects(String query) {
        List<SubSubject> subjectList = new ArrayList<SubSubject>();
        PreparedStatement statement = null;
        ResultSet rs = null;
        try{
            statement = connection.prepareStatement(query);
            rs = statement.executeQuery();
            while(rs.next()){
                SubSubject subject = new SubSubject();
                subject.setIdSubSubject(rs.getInt("idSubSubject"));
                subject.setIdSubject(rs.getInt("idSubject"));
                subject.setName(rs.getString("name"));
                subjectList.add(subject);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            closeResurse(statement, rs);
        }
        return subjectList;
    }
}

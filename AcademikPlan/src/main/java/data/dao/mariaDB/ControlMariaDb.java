package data.dao.mariaDB;

import data.ConnectionService;
import data.dao.ControlDao;
import data.model.Control;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ControlMariaDb extends ConnectionService implements ControlDao {
    private Connection connection;

    ControlMariaDb(Connection connection) {
        this.connection = connection;
    }

    @Override
    public Control getControlById(int id) {
        return getControls("SELECT * FROM version_control WHERE idVersion = "+id).get(0);
    }

    @Override
    public List<Control> getControlByTitle(int idTitle) {
        return getControls("SELECT * FROM version_control WHERE idTitle = "+idTitle);
    }

    @Override
    public boolean insertControl(Control control) {
        PreparedStatement statement = null;
        ResultSet rs = null;
        String query="INSERT INTO version_control SET idTitle = ?, name = ?, time = ?, current=?";
        try{
            connection.setAutoCommit(false);
            statement = connection.prepareStatement(query);
            statement.setInt(1, control.getIdVersion());
            statement.setString(2, control.getName());
            statement.setString(3, control.getTime());
            statement.setInt(4, control.isCurrent()? 1 : 0);
            statement.addBatch();
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
    public boolean updateControl(Control control) {
        PreparedStatement statement = null;
        ResultSet rs = null;
        String query="UPDATE version_control SET idTitle = ?, name = ?, time = ?, current=? WHERE idVersion=?";
        try{
            connection.setAutoCommit(false);
            statement = connection.prepareStatement(query);
            statement.setInt(1, control.getIdVersion());
            statement.setString(2, control.getName());
            statement.setString(3, control.getTime());
            statement.setInt(4, control.isCurrent()? 1 : 0);
            statement.setInt(5, control.getIdVersion());
            statement.addBatch();
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
    public boolean deleteControl(Control control) {
        PreparedStatement statement = null;
        ResultSet rs = null;
        String query="DELETE FROM version_control WHERE idVersion = "+control.getIdVersion();
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

    private List<Control> getControls(String query) {
        List<Control> list = new ArrayList<>();
        PreparedStatement statement = null;
        ResultSet rs = null;
        try{
            statement = connection.prepareStatement(query);
            rs = statement.executeQuery();
            while(rs.next()){
                Control control = new Control();
                control.setCurrent(rs.getInt("corrent")==1);
                control.setIdTitle(rs.getInt("idTitle"));
                control.setIdVersion(rs.getInt("idVersion"));
                control.setName(rs.getString("name"));
                control.setTime(rs.getString("time"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }finally {
            closeResurse(statement, rs);
        }
        return list;
    }
}

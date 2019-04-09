package data;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public abstract class ConnectionService {
    protected void closeResurse(Statement statement, ResultSet rs) {
        try {
            if(statement !=null)
                statement.close();
            if(rs !=null)
                rs.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}

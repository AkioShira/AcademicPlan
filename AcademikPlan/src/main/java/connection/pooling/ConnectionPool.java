package connection.pooling;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ConnectionPool {
    private static HikariConfig config = new HikariConfig();
    private static HikariDataSource ds;

    static {
        try {
            DriverManager.registerDriver(new org.mariadb.jdbc.Driver ());
        } catch (SQLException e) {
            e.printStackTrace();
        }
        config.setJdbcUrl("jdbc:mariadb://localhost:3306/academikplan");
        config.setUsername("root");
        config.setPassword("root");
        config.addDataSourceProperty("cachePrepStmts", "true");
        config.addDataSourceProperty("prepStmtCacheSize", "250");
        config.addDataSourceProperty("prepStmtCacheSqlLimit", "2048");
        config.addDataSourceProperty("allowMultiQueries", "true");
        config.setMaximumPoolSize(100);
        ds = new HikariDataSource(config);
    }

    public static Connection getConnection() throws SQLException {
        return ds.getConnection();
    }

    private ConnectionPool(){}
}

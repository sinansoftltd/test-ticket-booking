package sinan.database;

import java.sql.Connection;
import java.sql.Statement;

/**
 * Class to hold some basic data about database instance
 * @author Pezhman Jahanmard
 */
public class Database {
	private String distributionKey;
	private String server;
	private String dbName;
	private String user;
	private String password;

	private String driver;
	/**
	 * May contain {server} and {database} keys
	 */
	private String connectionString;

	private Connection connection;
	private Statement statement;

	public Database(String distributionKey, String server, String dbName, String user, String password, String driver, String connectionString) {
		this.distributionKey = distributionKey;
		this.server = server;
		this.dbName = dbName;
		this.user = user;
		this.password = password;
		this.driver = driver;
		this.connectionString = createConnectionString(connectionString);
	}

	public String getDistributionKey() {
		return distributionKey;
	}

	public String getServer() {
		return server;
	}

	public String getDbName() {
		return dbName;
	}

	public String getUser() {
		return user;
	}

	public String getPassword() {
		return password;
	}

	public String getDriver() {
		return driver;
	}

	public String getConnectionString() {
		return connectionString;
	}

	public Connection getConnection() {
		return connection;
	}

	public void setConnection(Connection connection) {
		this.connection = connection;
	}

	public Statement getStatement() {
		return statement;
	}

	public void setStatement(Statement statement) {
		this.statement = statement;
	}

	@Override
	public boolean equals(Object o) {
		if (this == o) return true;
		if (o == null || getClass() != o.getClass()) return false;

		Database database = (Database) o;

		return distributionKey.equals(database.distributionKey);
	}

	@Override
	public int hashCode() {
		return distributionKey.hashCode();
	}

	private String createConnectionString(String connectionString) {
		return connectionString
				.replace("{server}", server)
				.replace("{database}", dbName);
	}
}

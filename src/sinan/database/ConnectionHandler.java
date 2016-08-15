package sinan.database;

import sinan.utils.PropertiesParser;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Moderates all databases and open connections
 */
public class ConnectionHandler {

	private static final Logger LOGGER = Logger.getLogger(ConnectionHandler.class.getName());
	private List<Database> connectedDatabases = new ArrayList<>();
	private final List<Database> databases; //must be initialized in constructor

	/**
	 * Read database.properties file and initialize database list.
	 */
	public ConnectionHandler() {
		List<Database> databaseList = new ArrayList<>();
		try {
			databaseList.addAll(new PropertiesParser().getDatabases("database.properties"));
		} catch (IOException e) {
			LOGGER.log(Level.SEVERE, e.getMessage(), e);
		}

		databases = databaseList;
	}

	/**
	 * @return list of connected databases
	 */
	public List<Database> getConnectedDatabases() {
		return connectedDatabases;
	}

	/**
	 * Connects to all databases at once and will add them to connectedDatabases list.
	 */
	public ConnectionHandler connect() throws ConnectionHandlerException {
		try {
			for (Database db : databases) {
				Class.forName(db.getDriver()).newInstance();
				Connection connection = DriverManager.getConnection(
						db.getConnectionString(),
						db.getUser(),
						db.getPassword());
				db.setConnection(connection);
				db.setStatement(connection.createStatement());

				connectedDatabases.add(db);
			}
		} catch (Exception e) {
			throw new ConnectionHandlerException(e);
		}

		return this;
	}

	/**
	 * Executes update statement on all connected databases.
	 * @return number of updated rows
	 */
	public long executeUpdate(String distroKey, String updateStatement) throws ConnectionHandlerException {
		checkOpenConnections();

		long result = 0;
		for (Database connectedDB : connectedDatabases) {
			try {
				if (connectedDB.getDistributionKey().equals(distroKey)) {
					result += connectedDB.getStatement().executeUpdate(updateStatement);
				}
			} catch (SQLException e) {
				throw new ConnectionHandlerException(e.getMessage(), e);
			}
		}

		return result;
	}

	/**
	 * Executes query statement (like select) on all connected databases.
	 * @return merged ResultSet into aa ResultSets object
	 */
	public ResultSet executeQuery(String distroKey, String query) throws ConnectionHandlerException {
		checkOpenConnections();

		List<java.sql.ResultSet> results = new ArrayList<>();
		for (Database connectedDB : connectedDatabases) {
			try {
				if (distroKey == null || connectedDB.getDistributionKey().equals(distroKey)) {
					results.add(
							connectedDB.getStatement().executeQuery(query));
				}
			} catch (SQLException e) {
				throw new ConnectionHandlerException(e);
			}
		}

		return new ResultSet(results);
	}

	/**
	 * Disconnects all connected databases
	 */
	public void disconnect() throws ConnectionHandlerException {
		if (connectedDatabases.size() > 0) {
			for (Database connectedDatabase : connectedDatabases) {
				try {
					connectedDatabase.getStatement().close();
					connectedDatabase.getConnection().close();
				} catch (SQLException e) {
					throw new ConnectionHandlerException(e);
				}
			}

			connectedDatabases.clear();
		}
	}

	@Override
	protected void finalize() throws Throwable {
		disconnect();
		super.finalize();
	}

	/**
	 * Finds a database by its distribution key
	 * @param distroKey
	 * @return
	 */
	private Database findDatabase(String distroKey) {
		if (distroKey != null) {
			for (Database db : databases) {
				if (db.getDistributionKey().equals(distroKey)) {
					return db;
				}
			}
		}

		return null;
	}

	/**
	 * If distroKey = null, then we need to use all databases
	 */
	private List<Database> findDatabases(String distroKey) {
		Database database = findDatabase(distroKey);
		if (database != null) {
			return Arrays.asList(database);
		}

		return databases;
	}

	/**
	 * @throws ConnectionHandlerException If no connected database found.
	 */
	private void checkOpenConnections() throws ConnectionHandlerException {
		if (connectedDatabases.size() == 0) {
			throw new ConnectionHandlerException("No database connection found, please connect to one at first.");
		}
	}
}

package sinan.utils;

import sinan.database.ConnectionHandler;
import sinan.database.ConnectionHandlerException;
import sinan.database.Database;
import sinan.database.ResultSet;

import java.sql.SQLException;
import java.util.UUID;

/**
 * To moderate some basic operations about distributions
 */
public class DistributionUtils {

	/**
	 * @param id like "01:15"
	 * @return distribution id from id
	 */
	public static String getDistroKey(String id) {
		if (id != null && id.contains(":")) {
			return id.substring(0, id.indexOf(":"));
		}
		return null;
	}

	/**
	 * Find proper database to add new record into its users table
	 * @param connectionHandler with all connected databases
	 * @return distroKey to add users into
	 */
	public static String generateDistroKey(ConnectionHandler connectionHandler) throws ConnectionHandlerException, SQLException {
		Integer min = Integer.MAX_VALUE;
		String distroKeyMin = null;
		for (Database database : connectionHandler.getConnectedDatabases()) {
			ResultSet resultSet = connectionHandler.executeQuery(database.getDistributionKey(), "SELECT COUNT(*) AS countUsers FROM users");
			resultSet.next();
			int count = resultSet.getInt("countUsers");
			if (count < min) {
				min = count;
				distroKeyMin = database.getDistributionKey();
			}
		}

		return distroKeyMin;
	}

	/**
	 * Generates random Id combined with distroKey to add new records with it.
	 * @return random generated id
	 */
	public static String generateId(String distroKey) {
		return distroKey + ":" + UUID.randomUUID();
	}

	/**
	 * Generates random Id combined with distroKey to add new records with it.
	 * @return random generated id
	 */
	public static String generateId(ConnectionHandler connectionHandler) throws ConnectionHandlerException, SQLException {
		String distroKey = generateDistroKey(connectionHandler);
		return generateId(distroKey);
	}
}

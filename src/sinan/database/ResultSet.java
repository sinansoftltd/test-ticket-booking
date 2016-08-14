package sinan.database;

import java.sql.SQLException;

/**
 * To merge java.sql.ResultSet results.
 */
public class ResultSet {
	private java.util.List<java.sql.ResultSet> resultSets;

	private java.sql.ResultSet current;

	public ResultSet(java.util.List<java.sql.ResultSet> resultSets) {
		this.resultSets = new java.util.ArrayList<>(resultSets);
		current = resultSets.remove(0);
	}

	public boolean next() throws SQLException {
		if (current.next()) {
			return true;
		} else if (!resultSets.isEmpty()) {
			current = resultSets.remove(0);
			return next();
		}
		return false;
	}

	public int getInt(int pos) throws SQLException {
		return current.getInt(pos);
	}

	public int getInt(String pos) throws SQLException {
		return current.getInt(pos);
	}

	public String getString(String field) throws SQLException {
		return current.getString(field);
	}

	public String getString(int pos) throws SQLException {
		return current.getString(pos);
	}
}

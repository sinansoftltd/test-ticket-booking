package sinan.utils;

import sinan.database.Database;

import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * Simple class to parse our properties files
 */
public class PropertiesParser {
	private final static String DATABASE_PROPERTY_PREFIX = "sinan.database.";

	public Properties parse(String propertiesFileName) throws IOException {
		Properties prop = new Properties();
		InputStream inputStream = getClass().getClassLoader().getResourceAsStream("resources/" + propertiesFileName);

		if (inputStream != null) {
			prop.load(inputStream);
		} else {
			throw new FileNotFoundException("property file '" + propertiesFileName + "' not found in the classpath");
		}

		return prop;
	}

	public List<Database> getDatabases(String propertiesFileName) throws IOException {
		Properties properties = parse(propertiesFileName);
		HashMap<String, HashMap<String, String>> set = new HashMap<>();
		for (String key : properties.stringPropertyNames()) {
			String value = properties.getProperty(key);
			if (key.startsWith(DATABASE_PROPERTY_PREFIX)) {
				Matcher matcher = Pattern.compile("sinan\\.database\\.([0-9]+)\\.([a-zA-Z]+)").matcher(key);
				matcher.find();

				HashMap<String, String> storedMap = set.get(matcher.group(1));
				if (storedMap == null) {
					storedMap = new HashMap<>();
				}
				storedMap.put(matcher.group(2), value);
				set.put(matcher.group(1), storedMap);
			}
		}

		List<Database> databaseList = new ArrayList<>();
		for (Map.Entry<String, HashMap<String, String>> entry : set.entrySet()) {
			HashMap<String, String> value = entry.getValue();
			databaseList.add(new Database(
					value.get("distroKey"),
					value.get("server"),
					value.get("dbName"),
					value.get("user"),
					value.get("password"),
					value.get("driver"),
					value.get("connectionString")));
		}


		return databaseList;
	}
}

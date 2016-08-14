package sinan.utils;

/**
 * To moderate some basic operations about distributions
 */
public class DistributionUtil {
	/**
	 *
	 * @param id like "01:15"
	 * @return
	 */
	public static String getDistroKey(String id) {
		return id.substring(0, id.indexOf(":"));
	}
}

package sinan.database;

/**
 * To throw on ConnectionHandler exceptions
 */
public class ConnectionHandlerException extends Throwable {
	public ConnectionHandlerException(String message) {
		super(message);
	}

	public ConnectionHandlerException(String message, Throwable cause) {
		super(message, cause);
	}

	public ConnectionHandlerException(Throwable cause) {
		super(cause);
	}
}

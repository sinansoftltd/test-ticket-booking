package pakiet;

import sinan.database.ConnectionHandler;
import sinan.database.ConnectionHandlerException;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Class to execute basic functions about our booking system
 */
public class Booking {

	private static final Logger LOGGER = Logger.getLogger(Booking.class.getName());
	private ConnectionHandler connectionHandler = new ConnectionHandler();

	/**
	 * The method used to connect to the database. Before performing any operation on the basis of
	 * You have to connect to it using this method and after the operation to end the connection
	 * Using the method disconnects.
	 */
	public void connect() {
		try {
			connectionHandler.connect();
		} catch (ConnectionHandlerException e) {
			LOGGER.log(Level.SEVERE, e.getMessage(), e);
		}
	}

	/**
	 * The method terminates the connection to the database.
	 */
	public void disconnect(){
		try {
			connectionHandler.disconnect();
		} catch (ConnectionHandlerException e) {
			e.printStackTrace();
		}
	}

	/**
	 * The method records in the database of the new user.
	 *
	 * @param email    - Email User
	 * @param password - User użytkownika
	 * @param type     - type of user
	 * @return true/false
	 */
	public boolean register(String email, String password, String type) {
		String query = "INSERT INTO users(email,password,type) VALUES('" + email + "','" + password + "','" + type + "')";
		try {
			statement.executeUpdate(query);
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}

		return true;
	}
	
	/**
	 * The method to check for login. If the given username is busy function returns false.
	 * 
	 * @param email - Email to check
	 * @return true/false
	 */
	public boolean checkLogin(String email){
		String query = "SELECT count(*) as result FROM users WHERE email = '" + email + "'";
		ResultSet rs;
		try {
			rs = statement.executeQuery(query);
			rs.next();
			int result = rs.getInt("result");
			if (result > 0) {
				return false;
			} else {
				return true;
			}
		} catch (SQLException e) {
			return false;
		}
	}

	/**
	 * Method to user logon. As a result of the action returns a ResultSet data logged on user.
	 * If the user has entered the wrong data logging is the method returns an empty ResultSet.
	 *
	 * @param email    - email user
	 * @param password - user password
	 * @return rs
	 */
	public ResultSet log(String email, String password) {
		String query = "SELECT * FROM users WHERE email = '" + email + "' and password = '" + password + "'";
		ResultSet rs = null;
		try {
			rs = statement.executeQuery(query);
		} catch (SQLException e) {

		}

		return rs;
	}

	/**
	 * This method adds to the base of a new event.
	 *
	 * @param userId    - adding user id
	 * @param name      - the name of the event
	 * @param city      - city events
	 * @param place     - venue
	 * @param eventDate - the date of the event
	 * @param tickets   -  number of tickets
	 * @param price     - price ticket
	 * @return true/false
	 */
	public boolean addEvent(int userId, String name, String city, String place, Timestamp eventDate, int tickets, double price) {
		String query = "INSERT INTO events(user_id, name,city,place,eventDate,price,tickets) VALUES(" + userId + ",'" + name + "','" + city + "','" + place + "','" + eventDate + "'," + price + "," + tickets + ")";
		try {
			statement.executeUpdate(query);
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}

		return true;
	}

	/**
	 * The method to change the data of the event.
	 *
	 * @param id        - the event id
	 * @param name      - the new name
	 * @param city      - new city
	 * @param place     - a new place
	 * @param eventDate - new date
	 * @param tickets   - the new number of tickets
	 * @param price     - new price
	 * @return true/false
	 */
	public boolean editEvent(int id, String name, String city, String place, Timestamp eventDate, int tickets, double price) {
		String query = "UPDATE events SET name = '" + name + "',city = '" + city + "', place = '" + place + "', eventDate = '" + eventDate + "',tickets = " + tickets + ", price = " + price + " WHERE id = " + id;
		try {
			statement.executeUpdate(query);
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}

		return true;
	}

	/**
	 * This method retrieves and returns the data logged on user events
	 *
	 * @param id - The logged in user
	 * @return rs
	 */
	public ResultSet getEvents(int id) {
		String query = "SELECT * FROM events WHERE user_id = '" + id + "'";

		ResultSet rs = null;
		try {
			rs = statement.executeQuery(query);
		} catch (SQLException e) {

		}

		return rs;
	}

	/**
	 * This method retrieves from the database all the events and returns an object of type ResultSet.
	 *
	 * @return rs
	 */
	public ResultSet getEvents() {
		String query = "SELECT * FROM events";

		ResultSet rs = null;
		try {
			rs = statement.executeQuery(query);
		} catch (SQLException e) {

		}

		return rs;
	}

	/**
	 * This method retrieves data one event with the given id
	 *
	 * @param id - the event
	 * @return
	 */
	public ResultSet getEvent(int id) {
		String query = "SELECT * FROM events WHERE id = " + id;
		ResultSet rs = null;
		try {
			rs = statement.executeQuery(query);
		} catch (SQLException e) {

		}

		return rs;
	}

	/**
	 * The method removes the event from the database
	 *
	 * @param id - the event
	 * @return
	 */
	public boolean removeEvent(int id) {
		String query = "DELETE FROM events WHERE id = " + id;
		try {
			statement.executeUpdate(query);
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}

		return true;
	}

	/**
	 * This method adds to the system with information about the new book. Once you have reserved iletów their number is subtracted
	 * The pool of tickets available.
	 *
	 * @param event   - an event ID
	 * @param user    - customer ID
	 * @param tickets - the number of reserved tickets
	 * @return true/false
	 */
	public boolean bookTickets(int event, int user, int tickets) {
		String query = "INSERT INTO reservations(event_id,user_id,tickets) VALUES(" + event + "," + user + "," + tickets + ")";
		String query_get = "SELECT tickets FROM events WHERE id = " + event;

		try {
			ResultSet rs = statement.executeQuery(query_get);
			int tickets_update = 0;

			rs.next();
			tickets_update = rs.getInt("tickets") - tickets;

			if (tickets_update < 0) {
				return false;
			} else {
				statement.executeUpdate(query);
				statement.executeUpdate("UPDATE events SET tickets = " + tickets_update + " WHERE id =" + event);
				return true;
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
	}

	/**
	 * This method retrieves a list of the reservation's
	 *
	 * @param id - User
	 * @return rs
	 */
	public ResultSet getReservationList(int id) {
		String query = "SELECT e.name, e.city, e.place, e.eventDate, e.price, r.tickets, r.id FROM reservations r INNER JOIN events e ON r.event_id = e.id WHERE r.user_id = " + id;
		ResultSet rs = null;
		try {
			rs = statement.executeQuery(query);
		} catch (SQLException e) {

		}

		return rs;
	}

	/**
	 * This method retrieves data selected book
	 *
	 * @param id - booking
	 * @return
	 */
	public ResultSet getReservations(int id) {
		String query = "SELECT e.name, e.city, e.place, e.eventDate, e.price, e.id, r.tickets, r.id FROM reservations r INNER JOIN events e ON r.event_id = e.id WHERE r.id = " + id;
		ResultSet rs = null;
		try {
			rs = statement.executeQuery(query);
		} catch (SQLException e) {

		}

		return rs;
	}

	/**
	 * The method takes reservations for a given event
	 *
	 * @param id - the event
	 * @return
	 */
	public ResultSet getReservationsEvents(int id) {
		String query = "SELECT u.email, u.id as userId, r.tickets, r.id as reservationId FROM reservations r INNER JOIN users u ON r.user_id = u.id WHERE r.event_id = " + id;
		ResultSet rs = null;
		try {
			rs = statement.executeQuery(query);
		} catch (SQLException e) {

		}

		return rs;
	}

	/**
	 * The method selected will cancel the entire reservation. After canceling a reservation
	 * Released the tickets are returned to the pool of available tickets
	 *
	 * @param id - booking
	 * @return
	 */
	public boolean cancelReservations(int id) {
		String query = "DELETE FROM reservations WHERE id = " + id;
		try {
			ResultSet rs = statement.executeQuery("SELECT tickets, event_id, user_id FROM reservations WHERE id =" + id);
			rs.next();

			int tickets = rs.getInt("tickets");
			int event_id = rs.getInt("event_id");
			int recipient_id = rs.getInt("user_id");

			rs = statement.executeQuery("SELECT tickets, user_id FROM events WHERE id =" + event_id);
			rs.next();

			int event_tickets = rs.getInt("tickets");
			int sender_id = rs.getInt("user_id");

			statement.executeUpdate("UPDATE events SET tickets = " + (event_tickets + tickets) + " WHERE id=" + event_id);
			statement.executeUpdate(query);
			sendMessage(recipient_id, sender_id, event_id, "Anulowanie rezerwacji", "Twoja rezerwacja została anulowana. Aby uzyskać więcej szczegółów skontaktuj się z organizatorem.");
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}

		return true;
	}

	/**
	 * Method to cancel the reservation. This method can cancel certain amount of ticket reservation.
	 *
	 * @param id      - booking
	 * @param tickets - number of tickets to be canceled
	 * @return true/false
	 */
	public boolean cancelReservations(int id, int tickets) {
		String query = "SELECT tickets, event_id FROM reservations WHERE id = " + id;
		try {
			ResultSet rs = statement.executeQuery(query);
			rs.next();
			int tickets_db = rs.getInt("tickets");
			int event_id = rs.getInt("event_id");

			rs = statement.executeQuery("SELECT tickets FROM events WHERE id =" + event_id);
			rs.next();

			int event_tickets = rs.getInt("tickets");
			tickets_db = tickets_db - tickets;

			statement.executeUpdate("UPDATE reservations SET tickets = " + tickets_db + " WHERE id =" + id);
			statement.executeUpdate("UPDATE events SET tickets = " + (event_tickets + tickets) + " WHERE id=" + event_id);
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}

		return true;
	}

	/**
	 * This method is used to cancel all bookings selected event
	 *
	 * @param id - the event
	 * @return
	 */
	public boolean cancelAllReservations(int id) {
		String query = "DELETE FROM reservations WHERE event_id = " + id;
		try {
			ResultSet rs = statement.executeQuery("SELECT tickets, event_id, user_id FROM reservations WHERE event_id =" + id);

			ArrayList<Integer> tickets = new ArrayList<Integer>();
			ArrayList<Integer> event_id = new ArrayList<Integer>();
			ArrayList<Integer> recipient_id = new ArrayList<Integer>();

			int sender_id = 0;
			while (rs.next()) {
				tickets.add(rs.getInt("tickets"));
				event_id.add(rs.getInt("event_id"));
				recipient_id.add(rs.getInt("user_id"));
			}
			rs.close();

			for (int i = 0; i < tickets.size(); i++) {
				rs = statement.executeQuery("SELECT tickets, user_id FROM events WHERE id =" + event_id.get(i));
				rs.next();

				int event_tickets = rs.getInt("tickets");
				sender_id = rs.getInt("user_id");

				statement.executeUpdate("UPDATE events SET tickets = " + (event_tickets + tickets.get(i)) + " WHERE id=" + event_id.get(i));
				sendMessage(recipient_id.get(i), sender_id, event_id.get(i), "Anulowanie rezerwacji", "Twoja rezerwacja została anulowana. Aby uzyskać więcej szczegółów skontaktuj się z organizatorem.");
				rs.close();
			}

			statement.executeUpdate(query);
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}

		return true;
	}

	/**
	 * Method to retrieve a list of a user. This method retrieves the message headers only
	 *
	 * @param id - the user (customer)
	 * @return
	 */
	public ResultSet getNews(int id) {
		String query = "SELECT u.email, u.id as userId, e.id as eventId, e.name, m.title, m.id as messageId, m.readed FROM messages m INNER JOIN users u ON m.sender_id = u.id INNER JOIN events e ON m.event_id = e.id WHERE m.recipient_id = " + id + " ORDER BY m.id, m.readed DESC";
		ResultSet rs = null;
		try {
			rs = statement.executeQuery(query);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return rs;
	}

	/**
	 * Method to retrieve the selected message. Method takes the whole message.
	 *
	 * @param id - News
	 * @return
	 */
	public ResultSet getMessage(int id) {
		String query = "SELECT u.email, u.id as userId, e.id as eventId, e.name, m.title, m.id as messageId, m.readed, m.message FROM messages m INNER JOIN users u ON m.sender_id = u.id INNER JOIN events e ON m.event_id = e.id WHERE m.id = " + id;
		ResultSet rs = null;
		try {
			statement.executeUpdate("UPDATE messages SET readed = 1 WHERE id = " + id);
			rs = statement.executeQuery(query);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return rs;
	}

	/**
	 * Medota to respond to a message. Retrieves data messages, which will be the answer and return them in the form of ResultSet
	 *
	 * @param id - message identifier, which will be the answer
	 * @return
	 */
	public ResultSet reply(int id) {
		String query = "SELECT m.sender_id as user_id, m.title, e.name, e.id FROM messages m INNER JOIN users u ON m.sender_id = u.id INNER JOIN events e ON m.event_id = e.id WHERE m.id = " + id;
		ResultSet rs = null;
		try {
			rs = statement.executeQuery(query);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return rs;
	}

	/**
	 * The method returns the number of new messages to the user
	 *
	 * @param id - User
	 * @return
	 */
	public int countNewNews(int id) {
		String query = "SELECT count(*) FROM messages WHERE recipient_id = " + id + " and readed = 0";
		ResultSet rs = null;
		int count = 0;
		try {
			rs = statement.executeQuery(query);
			rs.next();
			count = rs.getInt(1);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return count;
	}

	/**
	 * This method retrieves e-mail
	 *
	 * @param id - User
	 * @return
	 */
	public String getEmail(int id) {
		String query = "SELECT email FROM users WHERE id = " + id;
		ResultSet rs = null;
		String email = "";
		try {
			rs = statement.executeQuery(query);
			rs.next();
			email = rs.getString(1);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return email;
	}

	/**
	 * This method is used to send messages. If the method as an identifier for the recipient is given a value of 0
	 * This method will send a message to all participants in the event
	 *
	 * @param recipient_id - identifier of the recipient
	 * @param sender_id    - sender ID
	 * @param event_id     - Identifier events
	 * @param title        - tyuł News
	 * @param message      - the message
	 * @return true/false
	 */
	public boolean sendMessage(int recipient_id, int sender_id, int event_id, String title, String message) {
		if (recipient_id == 0) {
			String query = "SELECT user_id FROM reservations WHERE event_id=" + event_id;
			ArrayList<Integer> users = new ArrayList<Integer>();
			try {
				ResultSet rs = statement.executeQuery(query);
				while (rs.next()) {
					users.add(rs.getInt("user_id"));
				}
				rs.close();

				for (int i = 0; i < users.size(); i++) {
					query = "INSERT INTO messages(recipient_id,sender_id,event_id,title,message) VALUES(" + users.get(i) + "," + sender_id + "," + event_id + ",'" + title + "','" + message + "')";
					statement.executeUpdate(query);
				}
			} catch (SQLException e) {
				e.printStackTrace();
				return false;
			}
		} else {
			String query = "INSERT INTO messages(recipient_id,sender_id,event_id,title,message) VALUES(" + recipient_id + "," + sender_id + "," + event_id + ",'" + title + "','" + message + "')";
			try {
				statement.executeUpdate(query);
			} catch (SQLException e) {
				e.printStackTrace();
				return false;
			}
		}

		return true;
	}

	/**
	 * The method for deleting messages
	 *
	 * @param id
	 * @return
	 */
	public boolean removeMessage(int id) {
		String query = "DELETE FROM messages WHERE id = " + id;
		try {
			statement.executeUpdate(query);
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}

		return true;
	}
}

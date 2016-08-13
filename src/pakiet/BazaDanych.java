package pakiet;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;

/**
 * Klasa służąca do operacji na bazie. Wszelkie operacje na bazie są zaprogramowane właśnie w tej klasie.
 * Wykonuje się je wywołując w aplikacji odpowiednie metody tej klasy.
 * 
 * @author root
 *
 */

public class BazaDanych {
	
	/**
	 * Zmienne, w których są ustawione dane do połączenia z bazą.
	 */
	
	private String server = "localhost";
	private String dbName = "sinan_RezerwacjeBiletow";
	private String user = "root";
	private String password = "";
	
	private Connection connection;
	private Statement statement;
	
	/**
	 * Metoda służy do łączenia z bazą. Przed wykonaniem każdej operacji na bazie 
	 * trzeba nawiązać z nią połączenie za pomocą tej metody a po wykonaniu operacji zakończyć połączenie
	 * za pomocą metody rozlacz.
	 */
	
	public void polacz(){
		String driver = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://"+server+":3306/"+dbName+"?useUnicode=true&characterEncoding=utf8";
		
		try {
			
			Class.forName(driver).newInstance(); 
			
			this.connection = DriverManager.getConnection(url, user, password); 
			this.statement = connection.createStatement(); 
			
			//statement.execute("SET NAMES 'utf-8'");
			
		} catch (Exception e) {
			e.printStackTrace();
		}

	}
	
	/**
	 * Metoda kończy połączenie z bazą danych.
	 */
	public void rozlacz(){
		try {
			statement.close();
			connection.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}		
	}
	
	/**
	 * Metoda rejestruje w bazie nowego użytkownika.
	 * 
	 * @param email - Email użytkownika
	 * @param password - Hasło użytkownika
	 * @param type - Typ użytkownika
	 * @return true/false
	 */
	public boolean zarejestruj(String email, String password, String type){
		
		String query = "INSERT INTO users(email,password,type) VALUES('"+email+"','"+password+"','"+type+"')";
		
		try {
			statement.executeUpdate(query);
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
		
		return true;
	}
	
	/**
	 * Metoda do sprawdzania dostępności loginu. Jeżeli podany login jest zajęty funkcja zwróci fals.
	 * 
	 * @param email - email do sprawdzenia
	 * @return true/false
	 */
	public boolean sprawdzLogin(String email){
		String query = "SELECT count(*) as result FROM users WHERE email = '"+email+"'";
		
		ResultSet rs;
		try {
			
			rs = statement.executeQuery(query);
			rs.next();
			int result = rs.getInt("result"); 
			
			if(result>0){
				return false;
			}else{
				return true;
			}
			
		} catch (SQLException e) {
			return false;
		} 
		
	}
	
	/**
	 * Metoda do logowania użytkownika. Jako wynik działania zwraca obiekt ResultSet z danymi zalogowanego użytkownika.
	 * Jeżeli użytkownik podał błędne dane logowania to metoda zwróci pusty obiekt ResultSet.
	 * 
	 * @param email - email użytkownika
	 * @param password - hasło użytkownika
	 * @return rs
	 */
	public ResultSet zaloguj(String email, String password){
		String query = "SELECT * FROM users WHERE email = '"+email+"' and password = '"+password+"'";
		
		ResultSet rs = null;
		try {			
			rs = statement.executeQuery(query);			
		} catch (SQLException e) {
			
		} 
		
		return rs;
	}
	
	/**
	 * Metoda dodaje do bazy nowe wydarzenie.
	 * 
	 * @param userId - id użytkownika dodającego
	 * @param name - nazwa wydarzenia
	 * @param city - miasto wydarzenia
	 * @param place - miejsce wydarzenia
	 * @param eventDate - data wydarzenia
	 * @param tickets - ilość biletów
	 * @param price - cena biletu
	 * @return true/false
	 */
	public boolean dodajWydarzenie(int userId, String name, String city, String place, Timestamp eventDate, int tickets, double price){
		
		String query = "INSERT INTO events(user_id, name,city,place,eventDate,price,tickets) VALUES("+userId+",'"+name+"','"+city+"','"+place+"','"+eventDate+"',"+price+","+tickets+")";
		
		try {
			statement.executeUpdate(query);
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
		
		return true;
	}
	
	/**
	 * Metoda do zmiany danych wydarzenia.
	 * 
	 * @param id - id wydarzenia
	 * @param name - nowa nazwa
	 * @param city - nowe miasto
	 * @param place - nowe miejsce
	 * @param eventDate - nowa data
	 * @param tickets - nowa ilość biletów
	 * @param price - nowa cena
	 * @return true/false
	 */
	public boolean edytujWydarzenie(int id, String name, String city, String place, Timestamp eventDate, int tickets, double price){
		
		String query = "UPDATE events SET name = '"+name+"',city = '"+city+"', place = '"+place+"', eventDate = '"+eventDate+"',tickets = "+tickets+", price = "+price+" WHERE id = "+id;
		
		try {
			statement.executeUpdate(query);
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
		
		return true;
	}
	
	/**
	 * Metoda pobiera i zwraca dane wydarzenia zalogowanego użytkownika
	 * 
	 * @param id - identyfikator zalogowanego użytkownika
	 * @return rs
	 */
	public ResultSet pobierzWydarzenia(int id){
		String query = "SELECT * FROM events WHERE user_id = '"+id+"'";
		
		ResultSet rs = null;
		try {			
			rs = statement.executeQuery(query);			
		} catch (SQLException e) {
			
		} 
		
		return rs;
	}
	
	/**
	 * Metoda pobiera z bazy wszystkie wydarzenia i zwraca obiekt typu ResultSet.
	 * 
	 * @return rs
	 */
	public ResultSet pobierzWydarzenia(){
		String query = "SELECT * FROM events";
		
		ResultSet rs = null;
		try {			
			rs = statement.executeQuery(query);			
		} catch (SQLException e) {
			
		} 
		
		return rs;
	}
	
	/**
	 * Metoda pobiera dane jednego wydarzenia o podanym identyfikatorze
	 * 	
	 * @param id - identyfikator wydarzenia
	 * @return
	 */
	public ResultSet pobierzWydarzenie(int id){
		String query = "SELECT * FROM events WHERE id = "+id;
		
		ResultSet rs = null;
		try {			
			rs = statement.executeQuery(query);			
		} catch (SQLException e) {
			
		} 
		
		return rs;
	}
	
	/**
	 * Metoda usuwa wydarzenie z bazy
	 * 
	 * @param id - identyfikator wydarzenia
	 * @return
	 */
	public boolean usunWydarzenie(int id){
		
		String query = "DELETE FROM events WHERE id = "+id;
		
		try {			
			
			statement.executeUpdate(query);				
			
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
		
		return true;
	}
	
	/**
	 * Metoda dodaje do systemu informacje o nowej rezerwacji. Po zarezerwowaniu iletów ich ilość jest odejmowana 
	 * od puli biletów dostępnych.
	 * 
	 * @param event - identyfikator wydarzenia
	 * @param user - identyfikator klienta
	 * @param tickets - ilość zarezerwowanych biletów
	 * @return true/false
	 */
	public boolean zarezerwujBilety(int event, int user, int tickets){
		String query = "INSERT INTO reservations(event_id,user_id,tickets) VALUES("+event+","+user+","+tickets+")";
		String query_get = "SELECT tickets FROM events WHERE id = "+event;		
		
		try {
			ResultSet rs = statement.executeQuery(query_get);
			
			int tickets_update = 0;
			
			rs.next();
			tickets_update = rs.getInt("tickets") - tickets;
			
			if(tickets_update<0){
				return false;
			}else{
				statement.executeUpdate(query);				
				statement.executeUpdate("UPDATE events SET tickets = "+tickets_update+" WHERE id ="+event);
				return true;
			}			
			
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}		
		
	}
	
	/**
	 * Metoda pobiera listę rezerwacji użytkownika
	 * 
	 * @param id - identyfikator użytkownika
	 * @return rs
	 */
	public ResultSet pobierzListeRezerwacji(int id){
		String query = "SELECT e.name, e.city, e.place, e.eventDate, e.price, r.tickets, r.id FROM reservations r INNER JOIN events e ON r.event_id = e.id WHERE r.user_id = "+id;
		
		ResultSet rs = null;
		try {			
			rs = statement.executeQuery(query);			
		} catch (SQLException e) {
			
		} 
		
		return rs;
	}
	
	/**
	 * Metoda pobiera dane wybranej rezerwacji
	 * 
	 * @param id - identyfikator rezerwacji
	 * @return
	 */
	public ResultSet pobierzRezerwacje(int id){
		String query = "SELECT e.name, e.city, e.place, e.eventDate, e.price, e.id, r.tickets, r.id FROM reservations r INNER JOIN events e ON r.event_id = e.id WHERE r.id = "+id;
		
		ResultSet rs = null;
		try {			
			rs = statement.executeQuery(query);			
		} catch (SQLException e) {
			
		} 
		
		return rs;
	}
	
	/**
	 * Metoda pobiera rezerwacje na podane wydarzenie
	 * 
	 * @param id - identyfikator wydarzenia
	 * @return
	 */
	public ResultSet pobierzRezerwacjeWydarzenia(int id){
		String query = "SELECT u.email, u.id as userId, r.tickets, r.id as reservationId FROM reservations r INNER JOIN users u ON r.user_id = u.id WHERE r.event_id = "+id;
		
		ResultSet rs = null;
		try {			
			rs = statement.executeQuery(query);			
		} catch (SQLException e) {
			
		} 
		
		return rs;
	}
	
	/**
	 * Metoda anuluje całą wybraną rezerwację. Po anulowaniu rezerwacji 
	 * zwolnione bilety wracają do puli dostępnych biletów
	 * 
	 * @param id - identyfikator rezerwacji
	 * @return
	 */
	public boolean anulujRezerwacje(int id){
		String query = "DELETE FROM reservations WHERE id = "+id;
		
		try {
			ResultSet rs = statement.executeQuery("SELECT tickets, event_id, user_id FROM reservations WHERE id ="+id);
			rs.next();
			
			int tickets = rs.getInt("tickets");
			int event_id = rs.getInt("event_id");
			int recipient_id = rs.getInt("user_id");
			
			rs = statement.executeQuery("SELECT tickets, user_id FROM events WHERE id ="+event_id);
			rs.next();
			
			int event_tickets = rs.getInt("tickets");
			int sender_id = rs.getInt("user_id");
			
			statement.executeUpdate("UPDATE events SET tickets = "+(event_tickets+tickets)+" WHERE id="+event_id);
			
			statement.executeUpdate(query);
			
			wyslijWiadomosc(recipient_id, sender_id, event_id, "Anulowanie rezerwacji", "Twoja rezerwacja została anulowana. Aby uzyskać więcej szczegółów skontaktuj się z organizatorem.");
			
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
		
		return true;
	}
	
	/**
	 * Metoda do anulowania rezerwacji. Tą metodą można anulować określoną ilość biletów z rezerwacji.
	 * 
	 * @param id - identyfikator rezerwacji
	 * @param tickets - ilość biletów do anulowania
	 * @return true/false
	 */
	public boolean anulujRezerwacje(int id, int tickets){
		String query = "SELECT tickets, event_id FROM reservations WHERE id = "+id;
		
		try {
			
			ResultSet rs = statement.executeQuery(query);
			rs.next();
			int tickets_db = rs.getInt("tickets");
			int event_id = rs.getInt("event_id");
			
			rs = statement.executeQuery("SELECT tickets FROM events WHERE id ="+event_id);
			rs.next();
			
			int event_tickets = rs.getInt("tickets");
			
			tickets_db = tickets_db - tickets;			
			
			statement.executeUpdate("UPDATE reservations SET tickets = "+tickets_db+" WHERE id ="+id);
			statement.executeUpdate("UPDATE events SET tickets = "+(event_tickets+tickets)+" WHERE id="+event_id);
			
			
			
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
		
		return true;
	}
	
	/**
	 * Metoda służy do anulowania wszystkich rezerwacji wybranego wydarzenia
	 * 
	 * @param id - identyfikator wydarzenia
	 * @return
	 */
	public boolean anulujWszystkieRezerwacje(int id){
		String query = "DELETE FROM reservations WHERE event_id = "+id;
		
		try {
			ResultSet rs = statement.executeQuery("SELECT tickets, event_id, user_id FROM reservations WHERE event_id ="+id);
			
			ArrayList<Integer> tickets = new ArrayList<Integer>();
			ArrayList<Integer> event_id = new ArrayList<Integer>();
			ArrayList<Integer> recipient_id = new ArrayList<Integer>();
			
			int sender_id = 0;
			
			while(rs.next()){
			
				tickets.add(rs.getInt("tickets"));
				event_id.add(rs.getInt("event_id"));
				recipient_id.add(rs.getInt("user_id"));		
				
			}				
			
			rs.close();
			
			for(int i=0;i<tickets.size();i++){
				rs = statement.executeQuery("SELECT tickets, user_id FROM events WHERE id ="+event_id.get(i));
				rs.next();
				
				int event_tickets = rs.getInt("tickets");
				sender_id = rs.getInt("user_id");
								
				statement.executeUpdate("UPDATE events SET tickets = "+(event_tickets+tickets.get(i))+" WHERE id="+event_id.get(i));
								
				wyslijWiadomosc(recipient_id.get(i), sender_id, event_id.get(i), "Anulowanie rezerwacji", "Twoja rezerwacja została anulowana. Aby uzyskać więcej szczegółów skontaktuj się z organizatorem.");
				
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
	 * metoda do pobierania listy wiadomości użytkownika. Metoda ta pobiera tylko nagłówki wiadomośći 
	 * 
	 * @param id - identyfikator użytkownika (odbiorcy)
	 * @return
	 */
	public ResultSet pobierzWiadomosci(int id){
		String query = "SELECT u.email, u.id as userId, e.id as eventId, e.name, m.title, m.id as messageId, m.readed FROM messages m INNER JOIN users u ON m.sender_id = u.id INNER JOIN events e ON m.event_id = e.id WHERE m.recipient_id = "+id+" ORDER BY m.id, m.readed DESC";
		
		ResultSet rs = null;
		try {			
			rs = statement.executeQuery(query);			
		} catch (SQLException e) {
			e.printStackTrace();
		} 
		
		return rs;
	}
	
	/**
	 * Metoda do pobierania wybranej wiadomości. Metoda pobiera całą wiadomość.
	 * 
	 * @param id - identyfikator wiadomości
	 * @return
	 */
	public ResultSet pobierzWiadomosc(int id){
		String query = "SELECT u.email, u.id as userId, e.id as eventId, e.name, m.title, m.id as messageId, m.readed, m.message FROM messages m INNER JOIN users u ON m.sender_id = u.id INNER JOIN events e ON m.event_id = e.id WHERE m.id = "+id;
		
		ResultSet rs = null;
		try {	
			
			statement.executeUpdate("UPDATE messages SET readed = 1 WHERE id = "+id);
			rs = statement.executeQuery(query);		
			
		} catch (SQLException e) {
			e.printStackTrace();
		} 
		
		return rs;
	}
	
	/**
	 * Medota do odpowiadania na wiadomość. Pobiera dane wiadomości, na którą będzie odpowiedź i zwraca je w postaci obiektu ResultSet
	 * 
	 * @param id - identyfikator wiadomości, na którą będzie odpowiedź
	 * @return
	 */
	public ResultSet odpowiedz(int id){
		String query = "SELECT m.sender_id as user_id, m.title, e.name, e.id FROM messages m INNER JOIN users u ON m.sender_id = u.id INNER JOIN events e ON m.event_id = e.id WHERE m.id = "+id;
		
		ResultSet rs = null;
		try {	
			
			rs = statement.executeQuery(query);		
			
		} catch (SQLException e) {
			e.printStackTrace();
		} 
		
		return rs;
	}
		
	/**
	 * Metoda zwraca liczbę nowych wiadomości dla użytkownika
	 * 
	 * @param id - identyfikator użytkownika
	 * @return
	 */
	public int policzNoweWiadomosci(int id){
		String query = "SELECT count(*) FROM messages WHERE recipient_id = "+id+" and readed = 0";
		
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
	 * Metoda pobiera adres e-mail użytkownika
	 * 
	 * @param id - identyfikator użytkownika
	 * @return
	 */
	public String pobierzEmailUzytkownika(int id){
		String query = "SELECT email FROM users WHERE id = "+id;
		
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
	 * Metoda służy do wysyłania wiadomości. Jeżeli do metody jako identyfikator odbiorcy zostanie podana wartość 0
	 * to metoda wyśle wiadomość do wszystkich uczestników wydarzenia
	 * 
	 * @param recipient_id - identyfikator odbiorcy
	 * @param sender_id - identyfikator nadawcy
	 * @param event_id - identyfikato wydarzenia
	 * @param title - tyuł wiadomości
	 * @param message - treść wiadomości 
	 * @return treu/false
	 */
	public boolean wyslijWiadomosc(int recipient_id, int sender_id, int event_id, String title, String message){
		
		if(recipient_id == 0){
			
			String query = "SELECT user_id FROM reservations WHERE event_id="+event_id;
			ArrayList<Integer> users = new ArrayList<Integer>();
			
			try {
				ResultSet rs = statement.executeQuery(query);
				
				while(rs.next()){
					users.add(rs.getInt("user_id"));
				}
				
				rs.close();
				
				for(int i=0;i<users.size();i++){
					query = "INSERT INTO messages(recipient_id,sender_id,event_id,title,message) VALUES("+users.get(i)+","+sender_id+","+event_id+",'"+title+"','"+message+"')";
					statement.executeUpdate(query);
				}
				
				
			} catch (SQLException e) {
				e.printStackTrace();
				return false;
			}
			
		}else{
		
			String query = "INSERT INTO messages(recipient_id,sender_id,event_id,title,message) VALUES("+recipient_id+","+sender_id+","+event_id+",'"+title+"','"+message+"')";
			
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
	 * Metoda do usuwania wiadomości
	 * 
	 * @param id
	 * @return
	 */
	public boolean usunWiadomosc(int id){
		
		String query = "DELETE FROM messages WHERE id = "+id;
		
		try {
			statement.executeUpdate(query);
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}
		
		return true;
	}
	
}

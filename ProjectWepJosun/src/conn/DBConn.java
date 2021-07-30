package conn;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConn {
	private static Connection dbConn; 
	public static Connection getConnection() {
		if(dbConn == null) { //null일 경우 연결되지 않은 상태
			String driver = "oracle.jdbc.driver.OracleDriver";
			String url = "jdbc:oracle:thin:@localhost:1521:xe";
			String user = "josun";
			String pw = "josun5";
			
			try {
				Class.forName(driver);
				dbConn = DriverManager.getConnection(url, user, pw);
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		return dbConn;
	}
	
	public static void close() {
		if(dbConn != null) { //null이 아니면 연결되어 있는 상태
			try {
				if(!dbConn.isClosed()) {
					dbConn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		dbConn = null;
	}
}

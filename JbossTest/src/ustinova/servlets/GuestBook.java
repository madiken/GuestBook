package ustinova.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Enumeration;

import javax.naming.InitialContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

@SuppressWarnings("serial")
@WebServlet("/GuestBook")
public class GuestBook extends HttpServlet{
	
	
	
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	String sPagePath = "/test.jsp";
    	
    	String[] nameval = request.getParameterValues("name");
    	String[] textval = request.getParameterValues("text");
    	java.util.Date date = new java.util.Date(System.currentTimeMillis());
    	
    	
    	if ((nameval[0].length() == 0) && (textval[0].length() == 0)) 
    		sPagePath = "/test.jsp?empty_name=true&empty_comment=true";
    	else if ((nameval[0].length() != 0) && (textval[0].length() == 0))
    		sPagePath = "/test.jsp?empty_name=false&empty_comment=true";
    	else if ((nameval[0].length() == 0) && (textval[0].length() != 0))
    		sPagePath = "/test.jsp?empty_name=true&empty_comment=false";
    	else if ((nameval[0].length() != 0) && (textval[0].length() != 0))
    		sPagePath = "/test.jsp?empty_name=false&empty_comment=false";
    	
    	
    	
    	
    	if ( (nameval[0].length() == 0) || (textval[0].length() == 0) ) 
        getServletContext().getRequestDispatcher(
        			response.encodeRedirectURL(sPagePath)).forward(request, response);
        
    	else{
    		DataSource ds = null;
    		Connection con = null;
    		Statement stmt = null;

    		InitialContext ic;
    		try {
    			ic = new InitialContext();
    			ds = (DataSource) ic.lookup("java:/SampleDS");

    			con = ds.getConnection();
    			stmt = con.createStatement();
 
    			stmt.executeUpdate("insert into guestbook (name, text, time) values (" + "'" +nameval[0]+ "'" +"," +  "'" + textval[0]+ "'" +"," +  "'" + date.toString() + "'" + "); ");
           
    			stmt.close();
    		} catch (Exception e) {
          
    			e.printStackTrace();
    		} finally {
    			try{
	        	
    				stmt.close();
    				con.close();
    			} catch(SQLException e){
    				e.printStackTrace();
    			}
    		}	
        
    	
    	
    	
    		getServletContext().getRequestDispatcher(
    				response.encodeRedirectURL(sPagePath)).forward(request, response);
    	}
    }
}

<?xml version="1.0" encoding="ISO-8859-1"?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
   "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<%@ page session="false" import = "java.io.IOException,
                                    
                                    java.sql.Connection, 
                                    java.sql.ResultSet,
                                    java.sql.SQLException,
                                    
                                    java.sql.Statement,

                                    javax.naming.InitialContext,
                                    javax.servlet.ServletException,
                                    javax.servlet.annotation.WebServlet,
                                    javax.servlet.http.HttpServlet,
                                    javax.servlet.http.HttpServletRequest,
                                    javax.servlet.http.HttpServletResponse,
                                    javax.sql.DataSource" 
 %>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<HTML>
  <HEAD>
    <TITLE>guest book</TITLE>
  </HEAD>

  <BODY>
  
  <table   align = "center">
  <tr >
  <td  height = "200" width = "400">
   <form action="http://localhost:8080/jbosstest/GuestBook" method="post">
    <font face="calibri" size = "+1"><b>
        Name: <br> 
        <input type="text" name="name" /><br />
        Comment: <br>
        </b>
     </font>
    <!--input type="textarea"  cols = "25" rows="10" name="text" /><br /-->
     <textarea name="text" rows="5" cols="35" name="text" wrap="hard" ></textarea>
    <input type="submit" value="Send comment" />
   </form>
   </td>
   </tr>
    
    <%
      String[] at1 = request.getParameterValues("empty_name");
      String[] at2 = request.getParameterValues("empty_comment");
      
     
     
       
    %>
    
    
      <%
        
        
     	DataSource ds = null;
        Connection con = null;
        Statement stmt = null;
        ResultSet rs = null;
        InitialContext ic;
        try {
            ic = new InitialContext();
            ds = (DataSource) ic.lookup("java:/SampleDS");

            con = ds.getConnection();
            stmt = con.createStatement();
 
            rs = stmt.executeQuery("select name, text, time from guestbook order by time desc; ");
            
            if (at1 != null)
     		 if (("true").equals(at1[0])){
     		%>
     		<tr>
     		  <td  >
     		    <font face="calibri" size="-1" color="red">Enter your name!</font>
     		  </td>
     		</tr>
     		<%} %>
      
            <%
             if (at2 != null)
     				 if (("true").equals(at2[0])){
            %>
            <tr>
     		  <td>
     		   <font face="calibri" size="-1" color="red">Enter your comment!</font>
     		  </td>
     		</tr>
        <%}%>
                        
            <%while (rs.next()) { %>
                
           <tr>
            <td height = "25" >
               <font face="calibri"><b><% out.println(rs.getString("name")); %> <!/b></font>
            </td>   
           </tr> 
           
            <tr>
            <td  align="justify" width="40" >
               <font face="calibri"> <% out.println(rs.getString("text"));%> </font>
            </td>             
           </tr>
           
           <tr> 
            <td >
                  <font face="calibri" size = "-2"><% out.println(rs.getString("time"));%></font>
                  
            </td>   
          </tr>
           
                          
           
  
            
            
            
            
            <%}
            rs.close();
            stmt.close();
        } catch (Exception e) {
            out.println("Exception thrown ");
            e.printStackTrace();
        } finally {
        	try{
	        	rs.close();
	        	stmt.close();
	        	con.close();
        	} catch(SQLException e){
        		e.printStackTrace();
        	}
        }
    %>
  
  
  </table>
  </BODY>
</HTML>




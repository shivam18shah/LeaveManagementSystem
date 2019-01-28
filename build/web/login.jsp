<%-- 
    Document   : login
    Created on : May 23, 2017, 6:23:52 PM
    Author     : Shivam
--%>

<%@page import="java.sql.*"%>
<% Class.forName("com.mysql.jdbc.Driver");%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Authentication Page</title>
    </head>
    <body bgcolor='#FAFAD2'>
        <h1>Authenticating...</h1>
        <%
            String u_id= request.getParameter("u_id");
            String pword= request.getParameter("pword");
            String sql = "Select u_name from employee where u_name= ? and password= ?";
            out.println(u_id);
            out.println(pword);                
         
            //try{
                Class.forName("com.mysql.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/leave_db","root","");
                PreparedStatement log = conn.prepareStatement(sql);
                log.setString(1, u_id);
                log.setString(2, pword);
                ResultSet res = log.executeQuery();
                if(res.next()){
                    Cookie user=new Cookie("u_id",u_id);
                    user.setMaxAge(600);
                    response.addCookie(user);        
                    
                    Cookie passwd =new Cookie("pword",pword);
                    user.setMaxAge(600);
                    response.addCookie(passwd);
                    
                    response.sendRedirect("app_home.jsp");
                }
                else{
                    response.sendRedirect("index.jsp");
                }
            //}catch(SQLException e){}                    
        
        

        %>
        
    </body>
</html>

<%-- 
    Document   : apply_leave
    Created on : May 29, 2017, 11:03:07 PM
    Author     : Shivam
--%>

<%@page import="java.sql.*"%>
<% Class.forName("com.mysql.jdbc.Driver");%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Leave Processing</title>
    </head>
    <body bgcolor='#FAFFD2'>
        <%
        
            Cookie[] cookies = null;
         
         // Get an array of Cookies associated with the this domain
            cookies = request.getCookies();

            
            String applicant = request.getParameter("u_id");
            String appellant = request.getParameter("apply_to");
            String leave_type = request.getParameter("leave_type");
            String desc = request.getParameter("desc");
            String start_date = request.getParameter("start_date");
            String end_date = request.getParameter("end_date");
            String days = request.getParameter("days");
            String status = "pending";

            
            String val = "Select * from leaves_left where u_name = ?";
            
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/leave_db","root","");
            conn.setAutoCommit(false);

                leave_type=leave_type.toLowerCase();
                PreparedStatement validate = conn.prepareStatement(val);
                validate.setString(1, cookies[1].getValue());
                
                ResultSet rs = validate.executeQuery();
                int available;
                rs.first();
                    available = Integer.parseInt(rs.getString(leave_type));
                    int d = Integer.parseInt(days);
                    if(available < d){
                        response.sendRedirect("application_failed.jsp");
                    }      
            
                    
                    //out.println(available);
                    //out.println(days);
                    
                String stmt = "Insert into application values (?,?,?,?,?,?,?,?)";
                PreparedStatement apply = conn.prepareStatement(stmt);

                apply.setString(1, applicant);
                apply.setString(2, appellant);
                apply.setString(3, leave_type);
                apply.setString(4, start_date);
                apply.setString(5, end_date);
                apply.setString(6, days);
                apply.setString(7, desc);
                apply.setString(8, status);

   
            if(available>=d){
                int updateQuery = apply.executeUpdate();
                if(updateQuery==1){
                    out.println("<h3>Leave Application submitted.</h3>"); 
                    conn.commit();
                }
            }
            else
            {
                conn.rollback();
            }
            
            
        %>
                <br><br>
        <h5>
            <a href="app_home.jsp"> Click here to go back to app home </a>
        </h5>
    </body>
</html>

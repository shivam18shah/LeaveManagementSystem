<%-- 
    Document   : changingPassword
    Created on : May 27, 2017, 11:49:29 PM
    Author     : Shivam
--%>

<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Authentication Page</title>
    </head>
    <body bgcolor='#FAFFD2'>
        
        <%
            Cookie[] cookies = null;
         
            // Get an array of Cookies associated with the this domain
            cookies = request.getCookies();
                
            
            
            String current_password = request.getParameter("current_password");
            String new_password = request.getParameter("new_password");
            String confirm_password = request.getParameter("confirm_password");


            Connection con = null;
            Statement st = null;
            String pass = "";
            int id = 0;
            try {
                Class.forName("com.mysql.jdbc.Driver");
                String url = "jdbc:mysql://localhost:3306/leave_db";
                con = DriverManager.getConnection(url, "root", "");
                st = con.createStatement();
                ResultSet rs = st.executeQuery("Select * from employee where password = '"+ current_password + "'");
                if (rs.next()) { 
                    pass = rs.getString("password");
                } 
                if(new_password.equals(confirm_password)){
                    if (pass.equals(current_password)) {
                        st = con.createStatement();
                        st.executeUpdate("Update employee set password='"+ new_password + "' where u_name='" + cookies[1].getValue() + "'");
                        out.println(cookies[1].getValue()+ ", your password was changed successfully.");
                        st.close();
                        con.close();
                    } 
                    else {
                        out.println("Old Password doesn't match");
                    }
                }
                    else{
                        out.println("new password and confirm new password is not matching");
                    }
                }
            catch (Exception e) {
                out.println(e);
            }
        %>
        <br><br><br>
        <p>
            <u>
                <a href="app_home.jsp">
                    Click here to go back to the Website.
                </a>
            </u>
        </p>
    </body>
</html>
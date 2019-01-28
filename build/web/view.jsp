<%-- 
    Document   : view
    Created on : May 30, 2017, 12:09:00 AM
    Author     : Shivam
--%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="java.sql.*"%>
<% Class.forName("com.mysql.jdbc.Driver");%>
<html>
    <head>
        <style>
            body {
                font-family: "Lato", sans-serif;
            }
            
            .disp{
                background-color: #FAFAA2;
                font-size: 14px;
                font-family: sans-serif;
                padding-left: 20px;
                padding-right: 20px;
                opacity: 0.8;
            }

            .sidenav {
                height: 100%;
                width: 0;
                position: fixed;
                z-index: 1;
                top: 0;
                left: 0;
                background-color: #c5ae52;
                overflow-x: hidden;
                transition: 0.5s;
                padding-top: 60px;
            }

            .sidenav a {
                padding: 8px 8px 8px 32px;
                text-decoration: none;
                font-size: 25px;
                color: #818181;
                display: block;
                transition: 0.3s;
            }

            .sidenav a:hover, .offcanvas a:focus{
                color: #f1f1f1;
            }

            .sidenav .closebtn {
                position: absolute;
                top: 0;
                right: 25px;
                font-size: 36px;
                margin-left: 50px;
            }

            @media screen and (max-height: 450px) {
            .sidenav {padding-top: 15px;}
            .sidenav a {font-size: 18px;}
            }
        </style>
        <title>My Applications</title>
    </head>
    <body bgcolor='#FAFFD2'>

        <div id="mySidenav" class="sidenav">
            <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
            <a href="view.jsp">My Applications</a>
            <a href="leave_form.jsp">Leave Form</a>
            <a href="review.jsp">Review Applications</a>
            <a href="addnew.jsp">Add new Employee</a>
            <a href="change_pass.jsp">Change Password</a>
            <a href="logout.jsp">Logout</a>
        </div>
        
        <%
        
        Cookie[] cookies = null;
         
        // Get an array of Cookies associated with the this domain
        cookies = request.getCookies();
         
        if( cookies != null ) {
            %>
        <div id="mySidenav" class="sidenav">
            <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">&times;</a>
            <a href="view.jsp">My Applications</a>
            <a href="leave_form.jsp">Leave Form</a>
            <a href="review.jsp">Review Applications</a>
            <a href="addnew.jsp">Add new Employee</a>
            <a href="change_pass.jsp">Change Password</a>
            <a href="logout.jsp">Logout</a>
        </div>
            <%
        }
        %>
        
        <br><br>
        <span style="font-size:30px;cursor:pointer" onclick="openNav()">&#9776; Welcome, <%=cookies[1].getValue()%></span>
        <script>
            function openNav() {
                document.getElementById("mySidenav").style.width = "250px";
            }

            function closeNav() {
                document.getElementById("mySidenav").style.width = "0";
            }
        </script>
        <br><br>
        
        <%
            String u_name = cookies[1].getValue();
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/leave_db","root","");
            PreparedStatement disp = conn.prepareStatement("Select * from application where applicant = ?");
            
            disp.setString(1, u_name);
            
            ResultSet res = disp.executeQuery();
            if(!res.next()){
                %>
                <div class="disp"> <h4>No applications here.</h4></div>
                <%
            
            }
            else{
                String appellent = res.getString("applied_to");
                String leave_type = res.getString("leave_type");
                String start_date = res.getString("start_date");
                String end_date = res.getString("end_date");
                String days = res.getString("days");
                String description = res.getString("description");
                String status = res.getString("status");
                
                while(res.next()){
                
                    appellent = res.getString("applied_to");
                    leave_type = res.getString("leave_type");
                    start_date = res.getString("start_date");
                    end_date = res.getString("end_date");
                    days = res.getString("days");
                    description = res.getString("description");
                    status = res.getString("status");
                %>        
        <div class="disp">
            Applied to: <input type="text" value="<%=appellent%>" readonly>
            Leave Type: <input type="text" value="<%=leave_type%>" readonly>
            Start Date: <input type="date" value="<%=start_date%>" readonly>
            End Date: <input type="date" value="<%=end_date%>" readonly><br><br>
            Days: <input type="text" value="<%=days%>" readonly>
            Description: <textarea cols="20" rows="1" value="<%=description%>" readonly></textarea>
            Current Status: <input type="text" value="<%=status%>" readonly>
        </div>
        <br><br>
                
        <%        
            }
            }
            
        %>
        
        
        
    </body>
</html>
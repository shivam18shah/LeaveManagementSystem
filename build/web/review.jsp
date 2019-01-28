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
                padding: 10px 0px 10px 10px;
                font-size: 14px;
                font-family: sans-serif;
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
            PreparedStatement disp = conn.prepareStatement("Select * from application where applied_to = ? and status = ?");
            
            disp.setString(1, u_name);
            disp.setString(2, "pending");
            ResultSet res = disp.executeQuery();

                while(res.next()){
                    String applicant = res.getString("applicant");
                    String leave_type = res.getString("leave_type");
                    String start_date = res.getString("start_date");
                    String end_date = res.getString("end_date");
                    String days = res.getString("days");
                    String desc = res.getString("description");
        
                    out.println("<br><br>");
                    out.println("<form action=\"forward_review.jsp\">");
                    out.println("<div class=\"disp\">");
                    out.println("Applicant: <input type=\"text\" name=\"applicant\" value=" + applicant + " readonly>");
                    out.println("Leave type: <input type=\"text\" name=\"leave_type\" value=" + leave_type + " readonly>");
                    out.println("Start date: <input type=\"date\" name=\"start_date\" value=" + start_date + " readonly>");
                    out.println("End Date: <input type=\"date\" name=\"end_date\" value=" + end_date + " readonly>");
                    out.println("Days: <input type=\"text\" name=\"days\" value=" + days + " readonly><br><br>");

                    if(desc != null){      
                        out.println("Description: <input type=\"text\" name=\"desc\" value=" + desc + ">");
                    }
                    
                    out.println("Forward to: <input type=\"text\" name=\"forward_to\">");
                    out.print("<h6>Keep 'Forward to' field blank to give final approval.</h6>");
                    out.println("<input type=\"submit\" name=\"forward\" value=\"Forward\">");
                    out.println("<input type=\"submit\" name=\"reject\" value=\"Reject\">");
                    out.println("</div>");
                    out.println("</form>");
                    out.println("");
        
                }
            
        %>
        <div class="disp">No more applications to review.</div>

    </body>
</html>
<%@page import="java.lang.String"%>
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
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/leave_db","root","");
            String app = "Update application set status = 'approved' where applicant =? and start_date =?";
            String forw = "Update application set applied_to=?, description = ? where applicant =? and start_date =?";
            String rej = "Update application set status = 'rejected' where applicant = ? and start_date = ?";
            
            String forward = request.getParameter("forward");
            String reject = request.getParameter("reject");
            String leave_type = request.getParameter("leave_type");
            leave_type=leave_type.toLowerCase();
            
            String daysString = request.getParameter("days");
            int days=Integer.parseInt(daysString);
            int new_credit=0;
            
            String forward_to = request.getParameter("forward_to");
            String applicant = request.getParameter("applicant");
            String start_date = request.getParameter("start_date");
            String desc = request.getParameter("desc");
            
            if(forward!=null){
                    
                    if(leave_type.compareTo("other")!=0){
                        String leave_credit = "Select * from leaves_left where u_name='"+applicant+"'";
                        Statement select_credit = conn.createStatement();
                        ResultSet rs= select_credit.executeQuery(leave_credit);
                        rs.first();
                        int credit = Integer.parseInt(rs.getString(leave_type));
                        new_credit = credit-days;
                        out.print(new_credit);
                        
                   
                    }

                    
                if(forward_to==""){
                    PreparedStatement disp = conn.prepareStatement(app);
                    disp.setString(1, applicant);
                    disp.setString(2, start_date);
                    disp.executeUpdate();
                    
                        Statement st = conn.createStatement();
                        String query = "Update `leaves_left` set `"+leave_type+"`="+new_credit+" where `u_name`= '"+applicant+"'";
                       //String query ="Update `leaves_left` set `"+leave_type+ "`="+new_credit+" where `u_name= '"+applicant+"'";                      
                       // PreparedStatement up_credit = conn.prepareStatement("Update leaves_left set "+leave_type+ "= "+new_credit+" where 'u_name'=\' "+applicant+"\'");
                     //   up_credit.setString(1,leave_type);
                     //   up_credit.setInt(2,new_credit);
                     //   up_credit.setString(3,applicant);
                       System.out.println(query);
                      
                        out.println(leave_type);
                        out.println(new_credit);
                        out.println(applicant);
                       // up_credit.executeUpdate();
                        int res2 = st.executeUpdate(query);
                }
                else{
                    PreparedStatement disp = conn.prepareStatement(forw);
                    disp.setString(1, forward_to);
                    disp.setString(2, desc);
                    disp.setString(3, applicant);
                    disp.setString(4, start_date);
                    disp.executeUpdate();
                    

                }
            }
            
            if(reject!=null){
                PreparedStatement disp = conn.prepareStatement(rej);
                disp.setString(1, applicant);
                disp.setString(2, start_date);
                disp.executeUpdate();
            }
            conn.close();
            response.sendRedirect("review.jsp");
        %>

    </body>
</html>
<%@page import="java.util.Calendar"%>
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
            }
            
            .top{
                background-color: #FEB25D;
                padding-left: 50px;
                padding-bottom: 16px;
                padding-top: 16px;
                font-size: 18px;
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
        <br>
        <span style="font-size:30px;cursor:pointer" onclick="openNav()">&#9776; Welcome, <%=cookies[1].getValue()%></span>

        <script>
            function openNav() {
                document.getElementById("mySidenav").style.width = "250px";
            }

            function closeNav() {
                document.getElementById("mySidenav").style.width = "0";
            }
        </script>
        <br><br><br>
        <div class="disp">
            
            <fieldset>
                <legend>
                <h3>
                    Available Leaves
                </h3>
                </legend><br>
        <%
            String u_name = cookies[1].getValue();
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/leave_db","root","");
            PreparedStatement disp = conn.prepareStatement("Select * from leaves_left where u_name = ?");
            
            disp.setString(1, u_name);
            
            ResultSet res = disp.executeQuery();
            res.first();
            String emp_type = res.getString("emp_type");
            String casual_leave = res.getString("casual");
            String vacation = res.getString("vacation");
            String earned_leave = res.getString("earned");
            String half_pay_leave = res.getString("halfpay");
            String commuted_leave = res.getString("commuted");
        %>
                      
        Casual Leaves: <input type="text" value="<%=casual_leave%>" readonly><br><br>          
        
        <%
            if(emp_type=="faculty"){
                    %>
                    Vacation: <input type="text" value="<%=vacation%>" readonly><br><br>        

                    <%
            }
        %>
        
        Earned Leave: <input type="text" value="<%=earned_leave%>" readonly><br><br>    
        
        Half-Pay Leave: <input type="text" value="<%=half_pay_leave%>" readonly><br><br>   
        
        Commuted Leave: <input type="text" value="<%=commuted_leave%>" readonly><br><br>
                 
            </fieldset>
        </div>
        <br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>

        <%
        
        
        
        if(cookies[1].getValue().equals("admin")){
            
                Class.forName("com.mysql.jdbc.Driver");

                PreparedStatement log = conn.prepareStatement("Select supervisor from `employee` where u_name='admin'");

                ResultSet rs = log.executeQuery();
                rs.next();
                String supervisor = rs.getString("supervisor");
                int sup = Integer.parseInt(supervisor);
                Calendar cal = Calendar.getInstance();
                //int day = cal.get(Calendar.DAY_OF_MONTH);
                int month = cal.get(Calendar.MONTH);
                //int year = cal.get(Calendar.YEAR);    
            if(sup%2==1 && month==6 || sup%2==0 && month==1){
                
            %>
            <form action="update_leaves.jsp">
            Use every 1st January and 1st July
            <input type="submit" value="Update Leave Credits">
            </form>
            <%
            }
        }
        
        %>

    </body>
</html> 
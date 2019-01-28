<html>
    <head>
        <style>
            body {
                font-family: "Lato", sans-serif;
            }
            
            .disp{
                margin-left: 50px;
                background-color: #FAFAA2;
                font-size: 14px;
                font-family: sans-serif;
                width: 600px;
                padding-top: 30px;
                padding-bottom: 30px;
                padding-left: 50px;
            }
            
            .top{
                background-color: #EECBA3;
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
        <br><br><br>
        
         <%
            String u_id = cookies[1].getValue();
         %>
      
        <p><h5>The application form duly filled in should be sent to the H R Department 15 days before the date from which the leave has been requested.
        </h5></p>
        <br>
        <fieldset class='disp'>
            <legend><b>Leave Form</b></legend>
            <form action="apply_leave.jsp">
                <br>
                Username: <input type="text" name="u_id" value="<%=u_id%>" readonly><br><br>
                Apply to: <input type="text" name="apply_to" required="required"><br><br>

                Choose leave type: <select name="leave_type">
                    <option>Casual</option>
                    <option>Vacation</option>
                    <option>Earned</option>
                    <option>HalfPay</option>
                    <option>Commuted</option>
                    <option>Other</option>
                </select>
                <br><br>
                Describe: <textarea name="desc" rows="2" cols="30" placeholder="optional or in case of other" style="resize:auto;"></textarea><br><br>
                Start Date: <input type="date" name="start_date" required="required">
                End Date: <input type="date" name="end_date" required="required"><br><br>
                Total working days off: <input type="number" min="1" max="300" name="days" required="required"><br><br>
                <input type="submit" name="submit" value="submit">
            </form>
         </fieldset>
    </body>
</html>
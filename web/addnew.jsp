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
            
            span{
                font-size: 50%;
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
            
                        
            var check = function() {
            if (document.getElementById('pass').value == document.getElementById('confirm_password').value) {
            document.getElementById('message').style.color = 'green';
            document.getElementById('message').innerHTML = 'matching';
            }
            else {
            document.getElementById('message').style.color = 'red';
            document.getElementById('message').innerHTML = 'not matching';
                }
            }
            
        </script>
        <br><br>
        <fieldset class="disp">
            <legend><b>Add details of new employee</b></legend>
        <form name="add_emp" action="add2db.jsp" method="post">
            <table>
                <tr>
                <td>Username: </td><td><input type="text" name="user_id" required="required"></td>
                </tr>
                <tr> </tr>
                <tr>
                <td>Employee Type: </td><td><input type="radio" name="emp_type" value="faculty" checked>Faculty
                    <input type="radio" name="emp_type" value="staff">Staff</td> 
                </tr>
                <tr>
                <td>Supervisor: </td><td><input type="text" name="supervisor" value="<%=cookies[1].getValue()%>" readonly></td>
                </tr>
                <tr>
                <td>Department: </td>
                <td><select name="department">
                <option>HR</option>
                <option>IT</option>
                <option>Management</option>
                </select></td>
                </tr>
            
                <tr><td>Date of Joining: </td><td><input type="date" name="join_date" required="required"></td></tr>
                         
                <tr><td>Password: </td><td><input type="password" name="pass" id="pass" required="required" onkeyup='check()'/></td></tr>
                <tr><td>Confirm Password: </td><td><input type="password" name="confirm_password" id="confirm_password" required="required" onkeyup='check()'/> <span id='message'></td></tr>
                <tr><td></td><td><input type="submit" value="submit" name="submit"></td></tr>
            </table>
        </form>
        </fieldset>
        <br><br><br>

    </body>
</html>
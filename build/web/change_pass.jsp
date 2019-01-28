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
                width: 600px;

            }
            
            .match{
                font-size: 16px;
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
            if (document.getElementById('new_password').value == document.getElementById('confirm_password').value) {
            document.getElementById('message').style.color = 'green';
            document.getElementById('message').innerHTML = 'matching';
            }
            else {
            document.getElementById('message').style.color = 'red';
            document.getElementById('message').innerHTML = 'not matching';
                }
            }
            
        </script>
        <br><br><br>
        <div class="disp">
        <fieldset>
            <legend><b>Change your password here</b></legend>
            <form action="changingPassword.jsp">
                <table>
                    <tr><td>Enter current password: </td><td><input type="password" id="current_pass" name="current_password" required="required"></td><td></td></tr>
                <tr><td>Enter new password: </td><td><input type="password" id="new_password" name="new_password" onkeyup='check();' required="required"><td></td><br>
                <tr><td>Confirm new password: </td><td><input type="password" id="confirm_password" name="confirm_password" onkeyup='check();' required="required"></td><td><span id='message'class='match'></span></td></tr>
                    <tr><td><input type="submit" value="submit"></td>
                </table>
            </form>
        </fieldset>
        </div>
        <br><br><br>

    </body>
</html>
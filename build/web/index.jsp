<%-- 
    Document   : index
    Created on : May 24, 2017, 2:41:00 PM
    Author     : Shivam
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home</title>
        <style>
            .disp{
                background-color: #FAFAA2;
                width: 30%;
            }
            .top{
                padding-left: 30px;
                font-size: 18px;
            }
        </style>
    </head>
    <body bgcolor='#FAFFD2'>
        <div class="top">
        <h2>Welcome, User!</h2>
        </div>
        <br>
        <div class='disp'>
        <fieldset>
            <legend> Enter Valid credentials to login </legend>

                <form name="log" action="login.jsp" method="post">

                <br>
                UserID:&nbsp;&nbsp;&nbsp;&nbsp;<input type="text" name="u_id">
                <br><br>
                Password: <input type="password" name="pword">      
                <br><br>
                <input type="submit" name="login" value="Login">

        </form>
        <p> Note: You will be redirected here if login details are invalid.
        </fieldset>   
        </div>
    </body>
</html>

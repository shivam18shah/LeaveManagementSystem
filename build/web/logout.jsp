<%-- 
    Document   : logout
    Created on : May 24, 2017, 2:00:47 AM
    Author     : Shivam
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body bgcolor='#FAFAD2'>
        <%
            Cookie cookie = null;
            Cookie[] cookies = null;
         
            // Get an array of Cookies associated with the this domain
            cookies = request.getCookies();
            if( cookies != null ) {
            
            
            for (int i = 0; i < cookies.length; i++) {
               cookie = cookies[i];
               cookie.setMaxAge(0);
               cookie.setValue("");
               response.addCookie(cookie);
            }
         } 
            session = request.getSession();
            session.invalidate();
            response.sendRedirect("index.jsp");
        %>
    </body>
</html>

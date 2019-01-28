<%-- 
    Document   : add2db
    Created on : May 29, 2017, 12:52:14 AM
    Author     : Shivam
--%>

<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.*"%>
<% Class.forName("com.mysql.jdbc.Driver");%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Adding Employee...</title>
    </head>
    <body bgcolor='#FAFFD2'>
        <h1>Adding Employee... Please wait!</h1>
        
        <%
            String user_id= request.getParameter("user_id");
            String emp_type= request.getParameter("emp_type");
            String supervisor= request.getParameter("supervisor");
            String department= request.getParameter("department");
            String join_date= request.getParameter("join_date");
            String pass= request.getParameter("pass");
            String sql = "Insert into employee(u_name, emp_type, supervisor, department, join_date, password) values(?,?,?,?,?,?)";
            out.println(user_id);  
            //out.println(join_date);
         
                Class.forName("com.mysql.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/leave_db","root","");
                PreparedStatement log = conn.prepareStatement(sql);
                log.setString(1, user_id);
                log.setString(2, emp_type);
                log.setString(3, supervisor);
                log.setString(4, department);
                log.setString(5, join_date);
                log.setString(6, pass);
                int updateQuery = log.executeUpdate();
                
                if(updateQuery==1){
                    out.println("Employee added succesfully."); 
                }
                else{
                    out.println("There was some error and the query could not be executed. Try again later");
                }
                
                
                java.sql.Date dat = java.sql.Date.valueOf(join_date);
                //create calander instance and get required params
                Calendar cal = Calendar.getInstance();
                cal.setTime(dat);
                int month = cal.get(Calendar.MONTH);
                int day = cal.get(Calendar.DAY_OF_MONTH);
                int year = cal.get(Calendar.YEAR);
                //out.println(year);
                //out.println(month);
                //out.println(day);
                int next_year = year +1;
                java.sql.Date nextDate = java.sql.Date.valueOf( next_year+"-01-01" );    
                
                //out.print(nextDate);
                long diff = nextDate.getTime() - dat.getTime();
                diff/=(60*60*24*1000);
                //out.println(diff);
                int dif = (int) diff;
                int vacation=0;
                int earned=0;
                int casual = (dif*8)/365;
                
                if(emp_type.equals("faculty")){
                    vacation = (dif*60)/365;            
                }
                else{
                    earned = (dif%183)*15/183;
                }
                
                int half_pay = ((dif%183)/30)*(5/3);
                int commuted = 90;
                
                Statement st = conn.createStatement();
                st.executeUpdate("Insert into `leaves_left` (`u_name`, `emp_type`, `casual`, `vacation`, `earned`, `halfpay`, `commuted`) values ( '"+user_id+"', '"+emp_type+"', "+casual+", "+vacation+", "+earned+", "+half_pay+", "+commuted+" ) ");
                
                
                
        %>    
        <br><br><br>
        <h5>
            <a href="app_home.jsp"> Click here to go back to app home </a>
        </h5>
    </body>
</html>

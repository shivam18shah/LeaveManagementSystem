<%-- 
    Document   : update_leaves
    Created on : Jun 3, 2017, 12:24:29 AM
    Author     : Shivam
--%>

<%@page import="java.util.Calendar"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.*"%>
<% Class.forName("com.mysql.jdbc.Driver");%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 3.2 Final//EN">
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Updating Leaves</title>
    </head>
    <body>
        <h1>Hello World!</h1>
        <%
            try{
                Class.forName("com.mysql.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/leave_db","root","");

                PreparedStatement log = conn.prepareStatement("Select supervisor from `employee` where u_name='admin'");

                ResultSet rs = log.executeQuery();
                rs.next();
                String supervisor = rs.getString("supervisor");
                int sup = Integer.parseInt(supervisor);
                Calendar cal = Calendar.getInstance();
                int day = cal.get(Calendar.DAY_OF_MONTH);
                int month = cal.get(Calendar.MONTH);
                int year = cal.get(Calendar.YEAR);

                PreparedStatement gen = conn.prepareStatement("Select * from leaves_left");
                ResultSet all = gen.executeQuery();
                int casual=0;
                int vacation=0;
                int earned=0;
                int halfpay=0;
                String emp_type=" ";
                String u_name=" ";

                
                if(month==1){
                    if(sup%2==0){
                        while(all.next()){
                            emp_type = all.getString("emp_type");
                            u_name = all.getString("u_name");
                            casual = all.getInt("casual");
                            earned = all.getInt("earned");
                            vacation = all.getInt("vacation");
                            halfpay = all.getInt("halfpay");
                            casual = 8;
                            halfpay+=10;
                        
                            if(emp_type.equals("faculty")){
                                earned += (vacation/2);
                                vacation = 60;
                            }
                            else{
                                earned+=15;
                                vacation = 0;
                            }
                            earned = Math.min(earned,300);
                            PreparedStatement updat = conn.prepareStatement("Update `leaves_left` set `casual`="+casual+", `earned`="+earned+", `vacation`="+vacation+", `halfpay`="+halfpay+" where `u_name`='"+u_name+"'");
                            updat.executeUpdate();
                            
                        }
                        sup++;
                    }
                    else{
                        response.sendRedirect("app_home.jsp");
                    }
                }
                else if(month==6){
                    if(sup%2==1){     

                        while(all.next()){
                            u_name = all.getString("u_name");
                            emp_type = all.getString("emp_type");
//                            casual = all.getInt("casual");
                            earned = all.getInt("earned");
//                            vacation = all.getInt("vacation");
                            halfpay = all.getInt("halfpay");
                            halfpay+=10;
                            
                            if(emp_type.equals("staff")){
                                earned+=15;
                            }
                            earned = Math.min(earned,300);
                        //out.println(halfpay);
                        
                            PreparedStatement updat = conn.prepareStatement("Update `leaves_left` set `earned`="+earned+", `halfpay`="+halfpay+" where `u_name`='"+u_name+"'");
                            updat.executeUpdate();
                        }
                        sup++;
                    }
                }
                else{
                        response.sendRedirect("app_home.jsp");
                }
                
                //out.println(day);
                //out.println(month);
                //out.println(year);
                
                PreparedStatement ret = conn.prepareStatement("Update `employee` set `supervisor`='"+sup+"' where u_name='admin'");
                ret.executeUpdate();
                response.sendRedirect("app_home.jsp");
                
            }catch(Exception e){e.printStackTrace();}
        %>
        
    </body>
</html>

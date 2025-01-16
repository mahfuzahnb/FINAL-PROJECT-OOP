package controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import models.User;
import models.Admin;
import models.Customer;

@WebServlet(name = "RegisterController", urlPatterns = {"/register"})
public class RegisterController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirect to the registration page
        request.getRequestDispatcher("/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        System.out.println("Starting registration process...");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
 
            if (username.endsWith("/ekadmin")) {
                System.out.println("Processing admin registration...");
                String adminUsername = username.replace("/ekadmin", "").trim(); // Menghapus /ekadmin

                Admin admin = new Admin();
                admin.setUsername(adminUsername);
                admin.setPassword(password);

                // Insert admin
                admin.insertAdmin();
            }  else {
                System.out.println("Processing customer registration...");
                Customer customer = new Customer();
                customer.setUsername(username);
                customer.setPassword(password);
                customer.insertCustomer();
            }
            
            System.out.println("Registration completed successfully");
            
            SessionAlert alert = new SessionAlert(request.getSession());
            alert.setMessage("success","Registration completed successfully");
            
            response.sendRedirect(request.getContextPath() + "/index.jsp?registered=true");
            
        
    }
}
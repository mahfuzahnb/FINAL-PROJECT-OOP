/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import models.Customer;
import models.User;

@WebServlet(name = "CustomerDashboardController", urlPatterns = {"/customerr/*"})
public class CustomerDashboardController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("../index.jsp");
            return;
        }

        String username = (String) session.getAttribute("user");
        Customer customerModel = new Customer();
        Customer customer = customerModel.getCustomerByUsername(username);

        request.setAttribute("customer", customer);
        // Handle navigation
        String action = request.getPathInfo();
        if (action == null) action = "/layanan"; // Default page

        switch (action) {
            case "/layanan":
                response.sendRedirect(request.getContextPath() + "/layanan?menu=view");
                break;
            case "/payment":
                response.sendRedirect(request.getContextPath() + "/payment?menu=view");
                break;
            case "/riwayatPesanan":
               response.sendRedirect(request.getContextPath() + "/order?menu=view");
                break;
            case "/profile":
                request.getRequestDispatcher("/Customer/profile.jsp").forward(request, response);
                break;
             case "/addSaldo":
                request.getRequestDispatcher("/Customer/profile/addSaldo.jsp").forward(request, response);
                break;
            case "/editProfile":
                request.getRequestDispatcher("/Customer/profile/editProfile.jsp").forward(request, response);
                break;
            case "/deleteAccount":
                response.sendRedirect(request.getContextPath() + "/home");
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/customerr/layanan");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Handle any post actions here if needed
        try {
            HttpSession session = request.getSession();
            if(session == null || session.getAttribute("user")== null) {
                response.sendRedirect(request.getContextPath() + "/index.jsp");
                return;
            }
            
            String action = request.getParameter("action");
            Customer customerModel = new Customer();
            User userModel = new User();
            SessionAlert alert = new SessionAlert(request.getSession());

            System.out.println("Action: " + action); 
            
            if ("addSaldo".equals(action)) {
                String username = request.getParameter("username");
                Double amount = Double.parseDouble(request.getParameter("amount"));
                Customer customer = customerModel.getCustomerByUsername(username); 
               if (customer != null) {
                    boolean isSuccess = customer.addSaldo(username, amount);
                    if (isSuccess) {
                        alert.setMessage("success","Berhasil menambahkan saldo");
                    } else {
                        alert.setMessage("error","Gagal menambahkan saldo");
                    }
                } else {
                    alert.setMessage("error","Username tidak ditemukan");
                }
                response.sendRedirect(request.getContextPath() + "/customerr/profile");

                
                response.sendRedirect(request.getContextPath() + "/customerr/profile");
            } else if ("editProfile".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                String username = request.getParameter("username");
                String email = request.getParameter("email");
                String name = request.getParameter("name");
                String address = request.getParameter("address");
                String phone = request.getParameter("phone");
                String password = request.getParameter("password");
                
                boolean isSuccess = customerModel.updateProfile(username, name, email, phone, address, password, id);
                if (isSuccess) {
                    alert.setMessage("success", "Berhasil update profil");
                } else {
                    alert.setMessage("error","Gagal update profile");
                }
                
                session.setAttribute("user", username);
                response.sendRedirect(request.getContextPath() + "/customerr/profile"); 
            } else if ("deleteAccount".equals(action)) {
                int id = Integer.parseInt(request.getParameter("id"));
                userModel.setId(id);
                userModel.delete();
                alert.setMessage("success", "Berhasil menghapus akun dengan username " + userModel.getUsername());
                session.invalidate();
                response.sendRedirect(request.getContextPath() + "/home");
            }
            
        } catch (Exception e){
            e.printStackTrace();
            response.getWriter().println("Terjadi kesalahan pada server.");
        }
    }
}


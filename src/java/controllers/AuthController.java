package controllers;

import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.sql.*;
import models.User;

@WebServlet(name = "AuthController", urlPatterns = {"/auth"})
public class AuthController extends HttpServlet {
    private Connection con;
    private Statement stmt;
    
    private void connect() throws SQLException {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost:3306/easy_kos", "root", "");
            stmt = con.createStatement();
        } catch (ClassNotFoundException e) {
            throw new SQLException("Database driver not found");
        }
    }
    
    private void disconnect() {
        try {
            if (stmt != null) stmt.close();
            if (con != null) con.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("login".equals(action)) {
            // Tampilkan halaman login
            request.getRequestDispatcher("index.jsp").forward(request, response);
        } else if ("register".equals(action)) {
            // Tampilkan halaman registrasi
            request.getRequestDispatcher("register.jsp").forward(request, response);
        } else {
            // Default redirect ke home
            response.sendRedirect(request.getContextPath() + "/home");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        SessionAlert alert = new SessionAlert(request.getSession());
        String action = request.getParameter("action");
        
        if ("login".equals(action)) {
            String username = request.getParameter("username");
            String password = request.getParameter("password");
            
            if ("admin".equals(username)) {
                try {
                    connect();
                    ResultSet rs = stmt.executeQuery("SELECT * FROM admins WHERE username='" + username + "' AND password='" + password + "'");
                    if (rs.next()) {
                        HttpSession session = request.getSession();
                        session.setAttribute("user", username);
                        session.setAttribute("role", "admin");
                        response.sendRedirect(request.getContextPath() + "/layanan?menu=view");
                        return;
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                } finally {
                    disconnect();
                }
            } else {
                User userModel = new User();
                userModel.where("username = '" + username + "' AND password = '" + password + "'");
                ArrayList<User> users = userModel.get();

                if (!users.isEmpty()) {
                    User user = users.get(0);
                    HttpSession session = request.getSession();
                    session.setAttribute("user", user.getUsername());
                    session.setAttribute("role", user.getRole());
                    session.setAttribute("customerId", user.getId());
                    response.sendRedirect(request.getContextPath() + "/layanan?menu=view");
                    return;
                }
            }
            alert.setMessage("error","Username atau password salah!");
            response.sendRedirect(request.getContextPath() + "/index.jsp?error=1");
            
        } else if ("logout".equals(action)) {
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.invalidate();
            }
            response.sendRedirect(request.getContextPath() + "/");
            
        } else {
            response.sendRedirect(request.getContextPath() + "/");
        }
    }
}
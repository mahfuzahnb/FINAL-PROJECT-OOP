package controllers;

import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import models.layanan;
import models.Model;

@WebServlet(name = "HomeController", urlPatterns = {"/"})
public class HomeController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("login".equals(action)) {
            // Forward the request to AuthController to handle login
            request.getRequestDispatcher("/auth?action=login").forward(request, response);
        } else if ("register".equals(action)) {
            // Forward the request to AuthController to handle registration
            request.getRequestDispatcher("/auth?action=register").forward(request, response);
        } else {
            layanan layananModel = new layanan();
            ArrayList<layanan> layanans = layananModel.get();
            request.setAttribute("layanans", layanans);
            request.getRequestDispatcher("Home.jsp").forward(request, response);
        }
    }
}

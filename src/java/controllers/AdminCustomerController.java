package controllers;

import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import models.Customer;

@WebServlet(name = "AdminCustomerController", urlPatterns = {"/Admin/customer"})
public class AdminCustomerController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || !"admin".equals(session.getAttribute("role"))) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }

        Customer customerModel = new Customer();
        ArrayList<Customer> customers = customerModel.getAllCustomers();
        request.setAttribute("customers", customers);
        request.getRequestDispatcher("/Admin/customer.jsp").forward(request, response);
    }
}
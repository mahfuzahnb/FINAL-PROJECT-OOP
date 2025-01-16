package controllers;

import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import models.Order;

@WebServlet(name = "AdminDashboardController", urlPatterns = {"/admin/*"})
public class AdminDashboardController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        // Check if the user is logged in and is an admin
        if (session == null || !"admin".equals(session.getAttribute("role"))) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }

        // Determine which page to display based on the URL
        String action = request.getPathInfo();
        if (action == null || action.equals("/")) action = "/dashboard";

        switch (action) {
            case "/layanan":
                response.sendRedirect(request.getContextPath() + "/layanan?menu=view");
                break;
            case "/customer":
                request.getRequestDispatcher("/Admin/customer.jsp").forward(request, response);
                break;
            case "/orderCustomer":
                Order orderModel = new Order();
                ArrayList<Order> allOrders = orderModel.getAllOrders();
                request.setAttribute("orders", allOrders);
                request.getRequestDispatcher("/Admin/orderCustomer.jsp").forward(request, response);
                break;

            case "/payment":
                response.sendRedirect(request.getContextPath() + "/payment?menu=view");
                break;
            case "/sumorder":
                    String orderId = request.getParameter("orderId");
                    if (orderId != null) {
                        Order orderModelSum = new Order();
                        Order selectedOrder = orderModelSum.findOrder(Integer.parseInt(orderId));
                        if (selectedOrder != null) {
                            request.setAttribute("order", selectedOrder);
                            request.getRequestDispatcher("/Admin/summary_order.jsp").forward(request, response);
                        } else {
                            response.sendRedirect(request.getContextPath() + "/admin/orderCustomer");
                        }
                    }
                    break;
            default:
                response.sendRedirect(request.getContextPath() + "/admin/layanan");
                break;
        }
    }
}
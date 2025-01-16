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
import models.Order;
import models.layanan;
import models.Payment;

@WebServlet(name = "OrderController", urlPatterns = {"/order"})
public class OrderController extends HttpServlet {
    private void handleView(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        Order orderModel = new Order();
        ArrayList<Order> orders = orderModel.get();

        if (orders == null || orders.isEmpty()) {
            request.setAttribute("message", "Tidak ada pesanan yang tersedia.");
        } else {
            request.setAttribute("orders", orders);
        }
        request.getRequestDispatcher("/Customer/riwayatPesanan.jsp").forward(request, response);
    }
    
    private void handleCreate(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String serviceId = request.getParameter("serviceId");
        if (serviceId == null || serviceId.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/order?menu=view");
            return;
        }
        
        layanan layananModel = new layanan();
        layanan layananData = (layanan) layananModel.find(serviceId);

        if (layananData == null) {
            response.sendRedirect(request.getContextPath() + "/order?menu=view");
        } else {
            request.setAttribute("layanan", layananData);
            request.getRequestDispatcher("/Customer/form_order.jsp").forward(request, response);
        }
    }
    
    private void handleSummary(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        String orderId = request.getParameter("id");
        if (orderId == null || orderId.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/order?menu=view");
            return;
        }

        Order orderModel = new Order();
        Order order = (Order) orderModel.find(orderId);

        if (order == null) {
            response.sendRedirect(request.getContextPath() + "/order?menu=view");
        } else {
            // Menyimpan data order ke dalam request
            request.setAttribute("order", order);
            // Forward request ke JSP
            request.getRequestDispatcher("/Customer/order_summary.jsp").forward(request, response);
        }
    }

    
    private void handlePay(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String orderId = request.getParameter("orderId");
            if (orderId == null || orderId.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/order?menu=view");
                return;
            }

            Order orderModel = new Order();
            Order order = (Order) orderModel.find(orderId);
            
            if (order == null) {
                // Jika pesanan tidak ditemukan
                response.sendRedirect(request.getContextPath() + "/error.jsp?message=Order not found");
            }
    }
    
    private void handleCancel(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String orderId = request.getParameter("orderId");
            if (orderId == null || orderId.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/order?menu=view");
                return;
            }

            Order orderModel = new Order();
            Order order = (Order) orderModel.find(orderId);
            
            if (order == null) {
                // Jika pesanan tidak ditemukan
                response.sendRedirect(request.getContextPath() + "/error.jsp?message=Order not found");
            }
    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        
        if (session == null || session.getAttribute("customerId") == null) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }

        String menu = request.getParameter("menu");
        if (menu == null || menu.isEmpty()) {
            response.sendRedirect("order?menu=view");
            return;
        }
        
        try {
            switch (menu) {
                case "view":
                    handleView(request, response);
                    break;

                case "create":
                    handleCreate(request, response);
                    break;

                case "summary":
                    handleSummary(request, response);
                    break;
                    
                case "pay":
                    handlePay(request, response);
                    break; 
                    
                case "cancel":
                    handleCancel(request, response);
                    break; 
                    
                default:
                    response.sendRedirect(request.getContextPath() + "/order?menu=view");
                    break;
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/test.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("customerId") == null) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }
        
        String action = request.getParameter("action");
        Order orderModel = new Order();
        SessionAlert alert = new SessionAlert(request.getSession());
        
        if ("create".equals(action)) {
            try {
            int serviceId = Integer.parseInt(request.getParameter("serviceId"));
            Integer customerId = (Integer) session.getAttribute("customerId");
            if (customerId == null) {
                response.sendRedirect(request.getContextPath() + "/index.jsp");
                return;
            }

            String fullName = request.getParameter("fullName");
            String phoneNumber = request.getParameter("phoneNumber");
            String location = request.getParameter("location");
            String notes = request.getParameter("notes");
            String paymentMethod = request.getParameter("paymentMethod");

            String saldoEWalletStr = request.getParameter("saldoEWallet");
            double saldoEWallet = (saldoEWalletStr != null && !saldoEWalletStr.trim().isEmpty()) 
                ? Double.parseDouble(saldoEWalletStr) 
                : 0.0; // Atau bisa throw exception jika tidak valid

            String duration = request.getParameter("serviceDuration");
            
            double servicePrice = Double.parseDouble(request.getParameter("servicePrice"));
            
            java.sql.Date scheduleDate = java.sql.Date.valueOf(request.getParameter("scheduleDate"));

            orderModel.setServiceId(serviceId);
            orderModel.setCustomerId(customerId);
            orderModel.setFullName(fullName);
            orderModel.setPhoneNumber(phoneNumber);
            orderModel.setLocation(location);
            orderModel.setNotes(notes);
            orderModel.setStatus("pending");
            orderModel.setSaldoEWallet(saldoEWallet);
            orderModel.setPaymentMethod(paymentMethod);
            orderModel.setDuration(duration);
            orderModel.setServicePrice(servicePrice);
            orderModel.setScheduleDate(scheduleDate);
            orderModel.insert();
            
            alert.setMessage("success", "Berhasil membuat pesanan");
            
            response.sendRedirect("order?menu=summary&id=" + orderModel.getOrderId());
            
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/error.jsp?message=Invalid input");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/error.jsp?message=Unexpected error occurred");
        }
        } else if ("summary".equals(action)) {
               String orderId = request.getParameter("id");
               Order order = (Order) orderModel.find(orderId);
               if (order != null) {
                   request.setAttribute("order", order);
                   request.getRequestDispatcher("/Customer/order_summary.jsp").forward(request, response);
               } else {
                   response.sendRedirect("order?menu=view");
               }

        }  else if ("pay".equals(action)) {
                try {
            
            String orderId = request.getParameter("orderId");
            if (orderId == null || orderId.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/order?menu=view");
                return;
            }

            Order order = (Order) orderModel.find(orderId);
            
            if (order == null) {
                response.sendRedirect(request.getContextPath() + "/error.jsp?message=Order not found");
                return;
            }

            if (!"pending".equals(order.getStatus())) {
                response.sendRedirect(request.getContextPath() + "order?menu=view");
                return;
            }

            int customerId = (Integer) session.getAttribute("customerId");
            Customer customer = new Customer();
            double saldoEWallet = customer.getSaldoByCustomerId(customerId);
            
            double servicePrice = order.getServicePrice();
        if (saldoEWallet < servicePrice) {
            // Jika saldo tidak mencukupi
            request.setAttribute("message", "Saldo e-wallet Anda tidak mencukupi untuk membayar layanan ini.");
    request.getRequestDispatcher("/Customer/pesangagal.jsp").forward(request, response);
            return;
        }
            
            int idOrder = Integer.parseInt(request.getParameter("orderId"));
            Order ordr = (Order) new Order().find(request.getParameter("orderId"));

            Payment paymentModel = new Payment();
            paymentModel.setOrderId(idOrder);
            paymentModel.setCustomerId((Integer) session.getAttribute("customerId"));
            paymentModel.setPriceLayanan(ordr.getServicePrice());
            paymentModel.setSaldoEWallet(saldoEWallet);
            paymentModel.insert();
            
            order.setStatus("confirmed");
            order.update(); 
            
            //Update saldo
            String username = request.getParameter("username");
                System.out.println("Username : " + username);
                System.out.println("Username : " + customer.getUsernameById(customerId));
            customer.minSaldo(customer.getUsernameById(customerId), servicePrice,saldoEWallet);
            
            alert.setMessage("success", "Pembayaran berhasil");
                
            response.sendRedirect("order?menu=view");
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/error.jsp?message=Invalid Order ID format");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/error.jsp?message=Unexpected error occurred");
        }
                
                
        } else if ("cancel".equals(action)) {
                try {

            String orderId = request.getParameter("orderId");
            if (orderId == null || orderId.isEmpty()) {
                response.sendRedirect(request.getContextPath() + "/order?menu=view");
                return;
            }

            Order order = (Order) orderModel.find(orderId);
            
            if (order == null) {
                response.sendRedirect(request.getContextPath() + "/error.jsp?message=Order not found");
                return;
            }

            if (!"pending".equals(order.getStatus())) {
                response.sendRedirect(request.getContextPath() + "/order?menu=view");
                return;
            }

            order.setStatus("cancel");
            order.update();
            
            alert.setMessage("success", "Order berhasil di cancel");

            response.sendRedirect("order?menu=view");
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/error.jsp?message=Invalid Order ID format");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/error.jsp?message=Unexpected error occurred");
        }
        }

    }
}
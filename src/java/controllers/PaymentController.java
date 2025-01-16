package controllers;

import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import models.Payment;
import models.Order;

@WebServlet(name = "PaymentController", urlPatterns = {"/payment"})
public class PaymentController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);

        // Cek sesi dan autentikasi pengguna
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "index.jsp");
            return;
        }

        String role = (String) session.getAttribute("role");
        String menu = request.getParameter("menu");
        if (menu == null || menu.isEmpty()) {
            response.sendRedirect("payment?menu=view");
            return;
        }

        if ("view".equals(menu)) {
            Payment paymentModel = new Payment();

            if ("customer".equals(role)) {
                int customerId = (Integer) session.getAttribute("customerId");
                ArrayList<Payment> paymentList = paymentModel.findByCustomerId(customerId);
                request.setAttribute("payment", paymentList);
                request.getRequestDispatcher("/Customer/payment.jsp").forward(request, response);
            } else if ("admin".equals(role)) {
                ArrayList<Payment> paymentList = paymentModel.get();
                request.setAttribute("payment", paymentList);
                request.getRequestDispatcher("/Admin/payment.jsp").forward(request, response);
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "index.jsp");
            return;
        }

        try {
            // Ambil orderId dari request
            int orderId = Integer.parseInt(request.getParameter("orderId"));
            
            // Ambil data order dari database
            Order orderModel = new Order();
            Order order = orderModel.findOrder(orderId);

            if (order == null) {
                throw new Exception("Order not found.");
            }

            // Ambil customerId dari session
            int customerId = (Integer) session.getAttribute("customerId");
            String paymentMethod = request.getParameter("paymentMethod");
            double priceLayanan = order.getServicePrice(); // Ambil harga layanan dari order
            double saldoEWallet = Double.parseDouble(request.getParameter("saldoEWallet")); // Ambil saldo E-Wallet dari request
            double totalPembayaran = priceLayanan; // Total pembayaran sama dengan harga layanan
            String paymentDate = new java.util.Date().toString(); // Atau format tanggal yang sesuai

            // Buat objek Payment dan set data
            Payment paymentModel = new Payment();
            paymentModel.setOrderId(orderId);
            paymentModel.setCustomerId(customerId);
            paymentModel.setPaymentMethod(paymentMethod);
            paymentModel.setPriceLayanan(priceLayanan);
            paymentModel.setSaldoEWallet(saldoEWallet);
            paymentModel.setTotalPembayaran(totalPembayaran);
            paymentModel.setPaymentDate(paymentDate);
            paymentModel.insert(); // Simpan data pembayaran ke database

            // Redirect ke halaman pembayaran setelah sukses
            response.sendRedirect("payment?menu=view");
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/error.jsp?message=Invalid number format");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/error.jsp?message=" + e.getMessage());
        }
    }
}
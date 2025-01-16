package controllers;

import java.io.IOException;
import java.util.ArrayList;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import models.layanan;

@WebServlet(name = "LayananController", urlPatterns = {"/layanan"})
public class LayananController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("index.jsp");
            return;
        }

        String role = (String) session.getAttribute("role");
        String menu = request.getParameter("menu");
        if (menu == null || menu.isEmpty()) {
            response.sendRedirect("layanan?menu=view");
            return;
        }

        layanan layananModel = new layanan();

        if ("view".equals(menu)) {
            ArrayList<layanan> layanans = layananModel.get();
            request.setAttribute("layanans", layanans);
            if ("admin".equals(role)) {
                request.getRequestDispatcher("/Admin/admin_view.jsp").forward(request, response);
            } else if ("customer".equals(role)) {
                request.getRequestDispatcher("/Customer/customer_view.jsp").forward(request, response);
            }
        }else if ("add".equals(menu) || "edit".equals(menu) || "delete".equals(menu)) {
            if (!"admin".equals(role)) {
                response.sendRedirect("layanan?menu=view");
                return;
            }

            if ("add".equals(menu)) {
                request.getRequestDispatcher("/layanan-admin-crud/add.jsp").forward(request, response);
            } else if ("edit".equals(menu)) {
                String id = request.getParameter("id");
                layanan layananData = (layanan) layananModel.find(id); // Pastikan ini bertipe layanan
                if (layananData != null) {
                    request.setAttribute("layanan", layananData);
                    request.getRequestDispatcher("/layanan-admin-crud/edit.jsp").forward(request, response);
                } else {
                    response.sendRedirect("layanan?menu=view");
                }
            }

        } else if ("order".equals(menu)) {
            String serviceId = request.getParameter("serviceId");
            layanan layananData = (layanan) layananModel.find(serviceId);
            if (layananData != null) {
                request.setAttribute("layanan", layananData);
                request.getRequestDispatcher("/Customer/form_order.jsp").forward(request, response);
            } else {
                response.sendRedirect("layanan?menu=view");
            }
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect(request.getContextPath() + "/index.jsp");
            return;
        }

        String action = request.getParameter("action");
        layanan layananModel = new layanan();

        if ("add".equals(action)) {
            String name = request.getParameter("nama");
            String deskripsi = request.getParameter("deskripsi");
            double price = Double.parseDouble(request.getParameter("harga"));
            int durasi = Integer.parseInt(request.getParameter("durasi"));

            layananModel.setName(name);
            layananModel.setDeskripsi(deskripsi);
            layananModel.setPrice(price);
            layananModel.setDurasi(durasi);
            layananModel.insert();

        } else if ("edit".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            String name = request.getParameter("nama");
            String deskripsi = request.getParameter("deskripsi");
            double price = Double.parseDouble(request.getParameter("harga"));
            int durasi = Integer.parseInt(request.getParameter("durasi"));

            layananModel.setId(id);
            layananModel.setName(name);
            layananModel.setDeskripsi(deskripsi);
            layananModel.setPrice(price);
            layananModel.setDurasi(durasi);
            layananModel.update();

        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(request.getParameter("id"));
            layananModel.setId(id);
            layananModel.delete();
        }

        response.sendRedirect("layanan?menu=view");
    }
}
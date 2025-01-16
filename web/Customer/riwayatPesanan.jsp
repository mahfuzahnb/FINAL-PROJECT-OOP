<%@page import="models.Customer"%>
<%@page import="models.Order"%>
<%@page import="models.layanan"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%
    HttpSession userSession = request.getSession(false);
    if (userSession == null || userSession.getAttribute("user") == null) {
        response.sendRedirect("../index.jsp");
        return;
    }

    ArrayList<Order> orders = (ArrayList<Order>) request.getAttribute("orders");
    layanan layanans = new layanan();
    Customer customer = new Customer();
    customer.setId((Integer) session.getAttribute("customerId"));
%>

<!DOCTYPE html>
<html lang="id">
<head>
    <title>Riwayat Pesanan</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f0f2f5;
            color: #2d3748;
            font-size: 16px;
            font-family: 'Segoe UI', system-ui, -apple-system, sans-serif;
            line-height: 1.6;
            min-height: 100vh;
        }
        
        h2.text-primary {
            color: #4a90e2;
            font-weight: 700;
            text-align: center;
            margin-bottom: 40px;
        }

        /* Gaya untuk kartu layanan */
        .card {
            border: none;
            border-radius: 12px;
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            overflow: hidden;
            background: linear-gradient(145deg, #ffffff, #f3f4f6);
        }

        .card:hover {
            transform: translateY(-8px);
            box-shadow: 0 12px 24px rgba(0, 0, 0, 0.15);
        }

        /* Gaya untuk konten dalam kartu */
        .card-body {
            padding: 20px;
            color: #333;
            text-align: center;
        }

        /* Judul kartu */
        .card-title {
            font-size: 18px;
            font-weight: 700;
            color: #333;
            margin-bottom: 15px;
        }

        /* Deskripsi kartu */
        .card-text {
            font-size: 14px;
            color: #555;
            margin-bottom: 12px;
        }

        /* Harga dan durasi */
        .card-text strong {
            display: block;
            margin-top: 8px;
            font-size: 15px;
            color: #4a90e2;
        }

        /* Tombol "Pesan Sekarang" */
        .btn-primary {
            background-color: #4a90e2;
            border-color: #4a90e2;
            font-size: 14px;
            font-weight: 600;
            padding: 8px 16px;
            border-radius: 8px;
            transition: all 0.3s ease;
        }

        .btn-primary:hover {
            background-color: #357ab8;
            border-color: #357ab8;
            box-shadow: 0 4px 12px rgba(74, 144, 226, 0.4);
        }


        .wrapper {
            display: flex;
            min-height: 100vh;
        }

        .sidebar {
            background: linear-gradient(135deg, #56c4e3 0%, #3a9cb7 100%);
            width: 300px;
            position: fixed;
            top: 0;
            left: 0;
            height: 100vh;
            padding-top: 20px;
            box-shadow: 4px 0 10px rgba(0, 0, 0, 0.1);
            z-index: 1000;
        }

        .sidebar .nav-link {
            color: white;
            font-weight: 500;
            padding: 12px 24px;
            font-size: 16px;
            margin: 4px 8px;
            border-radius: 8px;
            transition: all 0.3s ease;
        }

        .sidebar .nav-link:hover {
            background-color: rgba(255, 255, 255, 0.1);
            transform: translateX(5px);
        }

        .sidebar .nav-link.active {
            background-color: rgba(255, 255, 255, 0.2);
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        h2 {
            font-size: 32px;
            color: #2c5282;
            font-weight: 700;
            margin-bottom: 24px;
            border-bottom: 3px solid #4a90e2;
            padding-bottom: 10px;
        }

        .table {
            width: 100%;
            background-color: #ffffff;
            border-collapse: collapse;
            border-radius: 12px;
            overflow: hidden;
        }

        .table th {
            background: linear-gradient(135deg, #4a90e2 0%, #357abd 100%);
            color: #ffffff;
            text-align: left;
            padding: 12px 16px;
            font-size: 16px;
            font-weight: 600;
            text-transform: uppercase;
        }

        .table td {
            padding: 12px 16px;
            font-size: 16px;
            color: #4a5568;
            border-bottom: 1px solid #e2e8f0;
        }

        .table tr:hover td {
            background-color: #f8f9fa;
        }

        .btn {
            padding: 10px 20px;
            font-size: 16px;
            font-weight: 500;
            border-radius: 8px;
            transition: all 0.3s ease;
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .btn-sm {
            padding: 6px 12px;
            font-size: 14px;
        }
        
        .badge {
            padding: 8px 16px;
            font-size: 14px;
            font-weight: 500;
            border-radius: 6px;
        }
        
        .badge.bg-danger {
            background-color: #f56565 !important;
        }

        .badge.bg-success {
            background-color: #48bb78 !important;
        }

        .badge.bg-secondary {
            background-color: #718096 !important;
        }

        @media (max-width: 768px) {
            .sidebar {
                width: 100%;
                height: auto;
                position: relative;
            }

            h2 {
                font-size: 24px;
            }
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <nav class="col-md-3 col-lg-2 d-md-block sidebar">
                <h2 class="text-center text-white py-3">Dashboard</h2>
                <ul class="nav flex-column">
                    <li class="nav-item">
                        <a class="nav-link" href="<%= request.getContextPath() %>/customerr/layanan">Layanan</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<%= request.getContextPath() %>/customerr/payment">Payment</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<%= request.getContextPath() %>/customerr/profile">Profile</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="<%= request.getContextPath() %>/customerr/riwayatPesanan">Riwayat Pesanan</a>
                    </li>
                    <li class="nav-item">
                        <form method="POST" action="<%= request.getContextPath() %>/auth" style="display: inline;">
                            <input type="hidden" name="action" value="logout">
                            <button type="submit" class="btn btn-danger w-100 mt-2">Logout</button>
                        </form>
                    </li>
                </ul>
            </nav>
            <main class="col-md-9 ms-sm-auto col-lg-9">
                <div class="container my-5">
                    <!-- Notificationable -->
                    <% 
                    String alertMessage = (String) session.getAttribute("alertMessage");
                    String alertType = (String) session.getAttribute("alertType");
                    %>
                    <% if (alertMessage != null) { %>
                        <div class="alert <%= alertType %> text-center">
                            <%= alertMessage %>
                        </div>
                        <% session.removeAttribute("alertMessage"); %>
                    <% } %>
                    
                    <h2 class="container">Riwayat Pesanan</h2>
                    <div class="table-responsive">
                        <table class="table table-striped table-hover mt-4">
                            <thead class="table-dark">
                                <tr>
                                    <th>ID Order</th>
                                    <th>Layanan</th>
                                    <th>Nama</th>
                                    <th>Status</th>
                                    <th>Aksi</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    if (orders != null && !orders.isEmpty()) {
                                        for (Order order : orders) {
                                        if (order.getCustomerId() == customer.getId()){
                                %>
                                <tr>
                                    <td><%= order.getOrderId() %> </td>
                                    <td><%= layanans.getNameByID(order.getServiceId())%> </td>
                                    <td><%= order.getFullName() %></td>
                                    <td>
                                          <% 
                                            String status = order.getStatus();
                                            String statusClass;
                                            switch (status.toLowerCase()) {
                                                case "cancel":
                                                    statusClass = "bg-danger text-white";
                                                    break;
                                                case "pending":
                                                    statusClass = "bg-secondary text-white";
                                                    break;
                                                case "confirmed":
                                                    statusClass = "bg-success text-white";
                                                    break;
                                                default:
                                                    statusClass = "bg-secondary text-white";
                                            } 
                                            %>
                                            <span class="<%= statusClass %> badge">
                                                <%= status %>
                                            </span>
                                    </td>
                                    <td>
                                        <a href="order?menu=summary&id=<%= order.getOrderId() %>" class="btn btn-warning btn-sm text-white">Lihat Ringkasan</a>
                                    </td>
                                </tr>
                                <%
                                    }}
                                    } else {
                                %>
                                <tr>
                                    <td colspan="5" class="text-center">Tidak ada pesanan yang tersedia.</td>
                                </tr>
                                <%
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </main>
        </div>
    </div>
</body>
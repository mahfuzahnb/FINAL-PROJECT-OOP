<%@page import="models.layanan"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpSession userSession = request.getSession(false);
    if (userSession == null || userSession.getAttribute("user") == null) {
        response.sendRedirect("index.jsp");
        return;
    }
    ArrayList<layanan> layanans = (ArrayList<layanan>) request.getAttribute("layanans");
%>
<!DOCTYPE html>
<html lang="id">
<head>
    <title>Dashboard Layanan</title>
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

        .wrapper {
            display: flex;
            min-height: 100vh;
        }

        .sidebar {
            background: linear-gradient(135deg, #56c4e3 0%, #3a9cb7 100%);
            width: 280px;
            position: fixed;
            top: 0;
            left: 0;
            height: 100vh;
            padding-top: 20px;
            box-shadow: 4px 0 10px rgba(0, 0, 0, 0.1);
            z-index: 1000;
        }

        .main-content {
            flex: 1;
            margin-left: 280px;
            padding: 30px;
            background-color: #f0f2f5;
            min-height: 100vh;
        }

        .content-container {
            background-color: #ffffff;
            border-radius: 12px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
            padding: 30px;
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

        @media (max-width: 768px) {
            .sidebar {
                width: 100%;
                height: auto;
                position: relative;
            }

            .main-content {
                margin-left: 0;
                padding: 15px;
            }

            .content-container {
                padding: 15px;
            }

            h2 {
                font-size: 24px;
            }
        }
    </style>
</head>
<body>
    <div class="wrapper">
        <!-- Sidebar -->
        <nav class="sidebar">
            <h2 class="text-center py-3 text-white">Admin Dashboard</h2>
            <ul class="nav flex-column">
                <li class="nav-item"><a class="nav-link active" href="<%= request.getContextPath() %>/admin/layanan">Layanan</a></li>
                <li class="nav-item"><a class="nav-link" href="<%= request.getContextPath() %>/admin/customer">Customer</a></li>
                <li class="nav-item"><a class="nav-link" href="<%= request.getContextPath() %>/admin/orderCustomer">Order Customer</a></li>
                <li class="nav-item"><a class="nav-link" href="<%= request.getContextPath() %>/admin/payment">Payment</a></li>
                <li class="nav-item">
                    <form method="POST" action="<%= request.getContextPath() %>/auth">
                        <input type="hidden" name="action" value="logout">
                        <button type="submit" class="btn btn-danger w-100">Logout</button>
                    </form>
                </li>
            </ul>
        </nav>

        <!-- Main Content -->
        <div class="main-content">
            <div class="content-container">
                <div class="d-flex justify-content-between align-items-center mb-4">
                    <h2>Daftar Layanan</h2>
                    <a href="<%= request.getContextPath() %>/layanan?menu=add" class="btn btn-success">Tambah Layanan</a>
                </div>
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Nama</th>
                                <th>Deskripsi</th>
                                <th>Harga</th>
                                <th>Durasi</th>
                                <th>Aksi</th>
                            </tr>
                        </thead>
                        <tbody>
                        <% if (layanans != null && !layanans.isEmpty()) {
                            for (layanan layananItem : layanans) { %>
                                <tr>
                                    <td><%= layananItem.getName() %></td>
                                    <td><%= layananItem.getDeskripsi() %></td>
                                    <td><%= layananItem.getPrice() %></td>
                                    <td><%= layananItem.getDurasi() %></td>
                                    <td>
                                        <a href="<%= request.getContextPath() %>/layanan?menu=edit&id=<%= layananItem.getId() %>" class="btn btn-warning btn-sm">Edit</a>
                                        <form method="POST" action="<%= request.getContextPath() %>/layanan" style="display: inline;">
                                            <input type="hidden" name="action" value="delete">
                                            <input type="hidden" name="id" value="<%= layananItem.getId() %>">
                                            <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Apakah Anda yakin ingin menghapus layanan ini?');">Hapus</button>
                                        </form>
                                    </td>
                                </tr>
                        <% } } else { %>
                            <tr>
                                <td colspan="5" class="text-center">Tidak ada data layanan.</td>
                            </tr>
                        <% } %>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</body>
</html>

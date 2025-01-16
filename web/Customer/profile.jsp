<%@page import="models.Customer"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    HttpSession userSession = request.getSession(false);
    if (userSession == null || userSession.getAttribute("user") == null) {
        response.sendRedirect("../index.jsp");
        return;
    }
    Customer customer = (Customer) request.getAttribute("customer");
%>

<!DOCTYPE html>
<html lang="id">
<head>
    <title>Profile</title>
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
        }

        .balance-card {
            position: absolute;
            top: 20px;
            right: 20px;
            background-color: #ffffff;
            border: 1px solid #ddd;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            padding: 12px;
            z-index: 1000;
            width: 200px;
        }
        .balance-card .btn-primary {
            font-size: 12px;
            padding: 5px 10px;
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
                        <a class="nav-link active" href="<%= request.getContextPath() %>/customerr/profile">Profile</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<%= request.getContextPath() %>/customerr/riwayatPesanan">Riwayat Pesanan</a>
                    </li>
                    <li class="nav-item">
                        <form method="POST" action="<%= request.getContextPath() %>/auth" style="display: inline;">
                            <input type="hidden" name="action" value="logout">
                            <button type="submit" class="btn btn-danger w-100 mt-2">Logout</button>
                        </form>
                    </li>
                </ul>
            </nav>

            <!-- Main Content -->
            <main class="col-md-9 ms-sm-auto col-lg-9 content">
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
                    
                    <!-- Profile Header -->
                    <div class="d-flex justify-content-between align-items-center">
                        <h2 class="text-primary">Profile</h2>
                    </div>
                    <div class="mb-4">
                        <form id="deleteAccount" action="<%= request.getContextPath() %>/customerr?action=deleteAccount" method="POST">
                            <input type="hidden" name="id" value="<%=customer.getId()%>">
                            <input type="hidden" name="username" value="<%=customer.getUsername()%>">
                            <a class="btn btn-primary " href="<%= request.getContextPath() %>/customerr/editProfile" role="button">Edit Profile</a>
                            <button type="button" class="btn btn-danger" data-bs-toggle="modal" data-bs-target="#confirmModal">Delete Account</button>
                        </form>
                    </div>

                    <!-- Balance Card -->
                    <div class="balance-card">
                        <h5 class="mb-2">Saldo</h5>
                        <h3 class="text-success">Rp <%= String.format("%,.0f", customer.getSaldo()) %> </h3>
                        <a class="nav-link btn btn-primary w-100 text-white" href="<%= request.getContextPath() %>/customerr/addSaldo">Isi Saldo</a>
                    </div>

                    <!-- Personal Info -->
                    <div class="card mb-4">
                        <div class="card-header btn-primary text-white">
                            <h5 class="mb-0">Personal Information</h5>
                        </div>
                        <div class="card-body">
                            <div class="row">
                                <div class="col-md-6">
                                    <p class="fw-bold">Username:</p>
                                    <p><%= customer.getUsername() %></p>
                                    <p class="fw-bold">Email:</p>
                                    <p><%= customer.getEmail() %></p>
                                    
                                    <p class="fw-bold">No Telepon:</p>
                                    <p><%= customer.getPhone() %></p>
                                </div>
                                <div class="col-md-6">
                                    <p class="fw-bold">Nama Lengkap:</p>
                                    <p><%= customer.getName() %></p>
                                    <p class="fw-bold">Alamat:</p>
                                    <p><%= customer.getAddress() %></p>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>
                         
                <!-- Modal -->
                <div class="modal fade" id="confirmModal" tabindex="-1" aria-labelledby="confirmModalLabel" aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="confirmModalLabel">Konfirmasi</h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                Apakah Anda yakin ingin menghapus akun?
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Batal</button>
                                <button type="button" class="btn btn-primary" id="confirmSubmit">Ya, Lanjutkan</button>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>
    
    <!-- Bootstrap JS and dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.getElementById('confirmSubmit').addEventListener('click', function () {
            document.getElementById('deleteAccount').submit();
        });
    </script>
</body>
</html>

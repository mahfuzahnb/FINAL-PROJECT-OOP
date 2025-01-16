<%-- 
    Document   : addSaldo
    Created on : 27 Dec 2024, 21.40.35
    Author     : Asus
--%>
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
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Isi Saldo</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <div class="container py-5">
        <div class="row justify-content-center">
            <div class="col-md-6">
                <div class="card shadow-sm">
                    <div class="card-body">
                        <h2 class="card-title text-center mb-4">Isi Saldo</h2>
                        <form id="addSaldoForm" action="<%= request.getContextPath() %>/customerr?action=addSaldo" method="POST">
                            <div class="mb-3">
                                <label for="username" class="form-label">Username:</label>
                                <input type="text" id="username" name="username" class="form-control" placeholder="Masukkan Username" required>
                            </div>
                            <div class="mb-3">
                                <label for="amount" class="form-label">Jumlah Saldo:</label>
                                <input type="number" id="amount" name="amount" class="form-control" placeholder="Masukkan jumlah saldo" min="0" required>
                            </div>
                            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#confirmModal">Isi Saldo</button>
                            <a class="btn btn-secondary" href="<%= request.getContextPath() %>/customerr/profile" role="button">Cancel</a>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
      <!-- Error and Success Messages -->
      <% if (request.getParameter("error") != null) { %>
        <div class="alert alert-danger mt-3 text-center w-50 mx-auto">
            Username yang anda masukkan salah.
        </div>
      <% } %>

    <!-- Modal -->
    <div class="modal fade" id="confirmModal" tabindex="-1" aria-labelledby="confirmModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="confirmModalLabel">Konfirmasi</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    Apakah Anda yakin ingin menambah saldo?
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Batal</button>
                    <button type="button" class="btn btn-primary" id="confirmSubmit">Ya, Lanjutkan</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS and dependencies -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        document.getElementById('confirmSubmit').addEventListener('click', function () {
            document.getElementById('addSaldoForm').submit();
        });
    </script>
</body>
</html>



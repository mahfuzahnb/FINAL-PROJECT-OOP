<%@page import="models.layanan"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="id">
<head>
    <title>Edit Layanan</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <%
        layanan layanan = (layanan) request.getAttribute("layanan");
        if (layanan == null) {
    %>
        <div class="container my-5">
            <div class="alert alert-danger text-center">
                <h4>Data layanan tidak ditemukan.</h4>
                <a href="layanan?menu=view" class="btn btn-primary mt-3">Kembali ke Dashboard</a>
            </div>
        </div>
    <%
        } else {
    %>
    <div class="container my-5">
        <div class="card shadow">
            <div class="card-header bg-warning text-dark text-center">
                <h2>Edit Layanan</h2>
            </div>
            <div class="card-body">
                <form method="POST" action="layanan">
                    <input type="hidden" name="action" value="edit">
                    <input type="hidden" name="id" value="<%= layanan.getId() %>">
                    
                    <div class="form-floating mb-3">
                        <input type="text" class="form-control" name="nama" value="<%= layanan.getName() %>" required>
                        <label>Nama Layanan</label>
                    </div>
                    
                    <div class="form-floating mb-3">
                        <textarea class="form-control" name="deskripsi" style="height: 100px" required><%= layanan.getDeskripsi() %></textarea>
                        <label>Deskripsi Layanan</label>
                    </div>

                    <div class="form-floating mb-3">
                        <input type="number" class="form-control" name="harga" value="<%= layanan.getPrice() %>" required>
                        <label>Harga Layanan</label>
                    </div>
                    
                    <div class="form-floating mb-3">
                        <input type="number" class="form-control" name="durasi" value="<%= layanan.getDurasi() %>" required>
                        <label>Durasi Layanan</label>
                    </div>

                    <div class="d-flex justify-content-between">
                        <a href="layanan?menu=view" class="btn btn-secondary btn-lg">Kembali</a>
                        <button type="submit" class="btn btn-warning btn-lg">Simpan Perubahan</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <%
        }
    %>
</body>
</html>

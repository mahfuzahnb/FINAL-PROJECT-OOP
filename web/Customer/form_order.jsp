<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="models.layanan"%>
<%@page import="models.Customer"%>
<%
    layanan layananData = (layanan) request.getAttribute("layanan");
    if (layananData == null) {
        response.sendRedirect("order?menu=view");
        return;
    }

    // Ambil saldo e-wallet customer
    int customerId = (Integer) session.getAttribute("customerId");
    Customer customer = new Customer();
    double saldoEWallet = customer.getSaldoByCustomerId(customerId);

    // Ambil harga layanan
    double servicePrice = layananData.getPrice();

    // Tentukan apakah saldo cukup
    boolean saldoCukup = saldoEWallet >= servicePrice;

    // Pesan alert jika saldo tidak cukup
    String alertMessage = !saldoCukup ? "Saldo e-wallet Anda tidak mencukupi untuk membayar layanan ini." : null;
%>
<!DOCTYPE html>
<html lang="id">
<head>
    <title>Pesan Layanan</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card shadow-lg">
                    <div class="card-header bg-primary text-white text-center">
                        <h2>Form Pesan Layanan</h2>
                    </div>
                    <div class="card-body">
                        <!-- Tampilkan alert jika saldo tidak cukup -->
                        <% if (alertMessage != null) { %>
                        <div class="alert alert-danger" role="alert">
                            <%= alertMessage %>
                        </div>
                        <% } %>

                        <form method="post" action="<%= request.getContextPath() %>/order">
                            <input type="hidden" name="action" value="create">
                            <input type="hidden" name="serviceId" value="<%= layananData.getId() %>">
                            
                            <div class="mb-3">
                                <label class="form-label">Nama Layanan:</label>
                                <input type="text" class="form-control" value="<%= layananData.getName() %>" disabled>
                            </div>
                            
                            <div class="mb-3">
                                <label class="form-label">Deskripsi Layanan:</label>
                                <input type="text" class="form-control" value="<%= layananData.getDeskripsi() %>" disabled>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Nama:</label>
                                <input type="text" class="form-control" name="fullName" placeholder="Masukkan Nama Anda" required>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Nomor Telepon:</label>
                                <input type="text" class="form-control" name="phoneNumber" placeholder="Masukkan Nomor Telepon Anda" required>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Lokasi:</label>
                                <input type="text" class="form-control" name="location" placeholder="Masukkan Lokasi Anda" required>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Catatan Tambahan:</label>
                                <textarea class="form-control" name="notes" placeholder="Masukkan catatan jika ada"></textarea>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Metode Pembayaran:</label>
                                <select class="form-select" name="paymentMethod" required>
                                    <option value="eWallet">E-Wallet</option>
                                    <option value="bankTransfer">Transfer Bank</option>
                                </select>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Saldo E-Wallet:</label>
                                <input type="text" class="form-control" value="<%= saldoEWallet %>" disabled>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Durasi:</label>
                                <input type="text" class="form-control" value="<%= layananData.getDurasi() %>" disabled>
                                <input type="hidden" class="form-control" name="serviceDuration" value="<%= layananData.getDurasi() %>">
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Harga Layanan:</label>
                                <input type="text" class="form-control" value="<%= layananData.getPrice() %>" disabled>
                                <input type="hidden" class="form-control" name="servicePrice" value="<%= layananData.getPrice() %>">
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Jadwal Layanan:</label>
                                <input type="date" class="form-control" name="scheduleDate" required>
                            </div>

                            <div class="d-grid">
                                <button type="submit" class="btn btn-primary" <%= !saldoCukup ? "disabled" : "" %>>Pesan Sekarang</button>
                            </div>
                        </form>
                    </div>
                    <div class="card-footer text-center">
                        <a href="order?menu=view" class="btn btn-secondary">Kembali</a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>

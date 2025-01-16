<%-- 
    Document   : summary_order
    Created on : 6 Jan 2025, 09.04.46
    Author     : Asus
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="models.Order"%>
<!DOCTYPE html>
<html>
<head>
    <title>Ringkasan Pesanan</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        /* Gaya untuk kartu ringkasan */
.card {
    border: none;
    border-radius: 16px;
    box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
    background: linear-gradient(145deg, #ffffff, #f9f9fb);
    overflow: hidden;
    transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.card:hover {
    transform: translateY(-5px);
    box-shadow: 0 12px 30px rgba(0, 0, 0, 0.2);
}

.card-header {
    background: linear-gradient(145deg, #4a90e2, #357abd);
    color: white;
    padding: 20px;
    font-weight: 700;
    text-align: center;
    font-size: 20px;
    border-radius: 16px 16px 0 0;
}

.card-body {
    padding: 30px;
    font-family: 'Arial', sans-serif;
    color: #444;
}

.card-title {
    font-weight: 700;
    color: #333;
    font-size: 18px;
    margin-bottom: 15px;
}

.card-text {
    font-size: 15px;
    line-height: 1.6;
    margin-bottom: 12px;
    color: #555;
}

/* Tombol */
.btn-success, .btn-danger, .btn-secondary {
    font-size: 15px;
    font-weight: 600;
    padding: 12px 20px;
    border-radius: 10px;
    transition: all 0.3s ease;
    text-transform: uppercase;
    letter-spacing: 0.5px;
}

.btn-success {
    background: linear-gradient(145deg, #28a745, #218838);
    border: none;
    color: white;
}

.btn-success:hover {
    background: linear-gradient(145deg, #218838, #1e7e34);
    box-shadow: 0 6px 15px rgba(40, 167, 69, 0.4);
    transform: translateY(-2px);
}

.btn-danger {
    background: linear-gradient(145deg, #dc3545, #c82333);
    border: none;
    color: white;
}

.btn-danger:hover {
    background: linear-gradient(145deg, #c82333, #bd2130);
    box-shadow: 0 6px 15px rgba(220, 53, 69, 0.4);
    transform: translateY(-2px);
}

.btn-secondary {
    background: linear-gradient(145deg, #6c757d, #5a6268);
    border: none;
    color: white;
}

.btn-secondary:hover {
    background: linear-gradient(145deg, #5a6268, #545b62);
    box-shadow: 0 6px 15px rgba(108, 117, 125, 0.4);
    transform: translateY(-2px);
}

/* Tombol dalam satu baris */
.d-flex {
    display: flex;
    align-items: center;
    justify-content: space-evenly;
    gap: 15px;
    margin-top: 20px;
}

/* Responsif */
@media (max-width: 768px) {
    .card-body {
        padding: 20px;
    }

    .btn-success, .btn-danger, .btn-secondary {
        font-size: 13px;
        padding: 10px 16px;
    }

    .d-flex {
        flex-direction: column;
        gap: 10px;
    }
}

    </style>
</head>
<body>
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card shadow-lg">
                    <div class="card-header bg-primary text-white text-center">
                        <h2>Ringkasan Pesanan</h2>
                    </div>
                    <div class="card-body">
                        <h5 class="card-title">Detail Pesanan</h5>
                        <p class="card-text"><strong>ID Pesanan:</strong> ${order.orderId}</p>
                        <p class="card-text"><strong>Nama Layanan:</strong> ${order.serviceId}</p>
                        <p class="card-text"><strong>Nama Pelanggan:</strong> ${order.fullName}</p>
                        <p class="card-text"><strong>Status:</strong> ${order.status}</p>
                        <p class="card-text"><strong>Metode Pembayaran:</strong> ${order.paymentMethod}</p>
                        <p class="card-text"><strong>Harga Layanan:</strong> ${order.servicePrice}</p>
                        <p class="card-text"><strong>Jadwal:</strong> ${order.scheduleDate}</p>
                        
                        
                        
                        <a href="<%= request.getContextPath() %>/admin/orderCustomer" class="btn btn-secondary mt-2">Kembali ke Daftar Pesanan</a> 
                    </div>
                </div>
            </div>
        </div>
    </div>    
</body>
</html>
<%@page import="models.layanan"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    ArrayList<layanan> layanans = (ArrayList<layanan>) request.getAttribute("layanans");
%>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard - EasyKost</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f4f9;
        }

        .hero-section {
            text-align: center;
            margin-top: 40px;
            padding: 20px;
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            min-height: 100vh;
        }

        .hero-section h1 {
            font-size: 32px;
            font-weight: bold;
            color: #333;
        }

        .hero-section p {
            font-size: 16px;
            color: #777;
        }

        .service-card {
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 20px;
            background-color: #ffffff;
            text-align: center;
            transition: transform 0.3s, box-shadow 0.3s;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .service-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
        }

        .service-card h5 {
            font-size: 20px;
            font-weight: bold;
            color: #0056b3;
            margin-bottom: 10px;
        }

        .service-card p {
            font-size: 14px;
            color: #555;
            margin-bottom: 15px;
        }

        .service-card .btn-pesan {
            background-color: #0056b3;
            color: white;
            border-radius: 5px;
            padding: 12px 25px;
            text-decoration: none;
            font-weight: bold;
            transition: background-color 0.3s;
        }

        .service-card .btn-pesan:hover {
            background-color: #ff6347;
        }

        .swiper-container {
            padding: 20px 0;
        }

        .swiper-slide {
            display: flex;
            justify-content: center;
        }
        
        /* Styling Navbar */
    .navbar {
        background-color: #f8f9fa;
        padding: 10px 20px;
    }

    .navbar-brand {
        font-size: 1.5rem;
        font-weight: bold;
        color: #007bff;
        text-transform: uppercase;
        letter-spacing: 1px;
        transition: color 0.3s;
    }

    .navbar-brand:hover {
        color: #0056b3;
    }

    .nav-item .nav-link {
        font-size: 1rem;
        font-weight: 500;
        color: #555;
        transition: color 0.3s, padding-left 0.3s;
    }

    .nav-item .nav-link:hover {
        color: #007bff;
        padding-left: 10px;
    }

    .navbar-nav .nav-item {
        margin-left: 15px;
    }

    /* Toggler Icon Styling */
    .navbar-toggler-icon {
        background-color: #007bff;
    }

        /* Responsiveness */
        @media (max-width: 991px) {
            .navbar-nav {
                text-align: center;
            }
            .navbar-nav .nav-item {
                margin-bottom: 10px;
            }
        }

        @media (max-width: 768px) {
            .hero-section h1 {
                font-size: 28px;
            }

            .service-card h5 {
                font-size: 16px;
            }

            .service-card p {
                font-size: 12px;
            }
        }
    </style>
    <link rel="stylesheet" href="https://unpkg.com/swiper/swiper-bundle.min.css" />
    <script src="https://unpkg.com/swiper/swiper-bundle.min.js"></script>
</head>
<body>
    
    <nav class="navbar navbar-expand-lg navbar-light bg-light shadow-sm">
        <div class="container-fluid">
            <a class="navbar-brand fw-bold text-primary" href="<%= request.getContextPath() %>/home">EasyKost</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="<%= request.getContextPath() %>/home">Layanan</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="home?action=login">Login</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="home?action=register">Register</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Hero Section -->
    <div class="hero-section">
        <h1>Layanan Kebersihan EasyKost</h1>
        <p>Pilih layanan jasa cleaning terlengkap yang sesuai dengan kebutuhan hunian Anda</p>
        <div class="container">
            <!-- Service Cards -->
            <div class="swiper-container">
                <div class="swiper-wrapper">
                <% if (layanans != null && !layanans.isEmpty()) {
                    for (layanan layanan : layanans) { %>
                        <div class="swiper-slide">
                            <div class="service-card pb-4" style="padding: 20px;">
                                <h5 class="mb-3"><%= layanan.getName() %></h5>
                                <p class="mb-4">Mulai dari Rp <%= (int) layanan.getPrice() %></p>
                                <a href="layanan?menu=view" class="btn-pesan mt-3 mb-5">Pesan Sekarang</a>
                            </div>
                        </div>
                <% } } else { %>
                        <div class="col-12">
                            <p class="text-center">Tidak ada layanan tersedia.</p>
                        </div>
                <% } %>
                </div>
                <div class="swiper-button-next"></div>
                <div class="swiper-button-prev"></div>
                <!-- Pagination -->
                <div class="swiper-pagination"></div>
            </div>
            <script>
            const swiper = new Swiper('.swiper-container', {
                slidesPerView: 3, // Menampilkan 3 kartu sekaligus
                spaceBetween: 20, // Jarak antar kartu
                navigation: {
                    nextEl: '.swiper-button-next',
                    prevEl: '.swiper-button-prev',
                },
                pagination: {
                    el: '.swiper-pagination',
                    clickable: true,
                },
                breakpoints: {
                    768: {
                        slidesPerView: 2, // 2 kartu untuk tablet
                    },
                    480: {
                        slidesPerView: 1, // 1 kartu untuk ponsel
                    },
                },
            });
            </script>
        </div>
    </div>
        
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

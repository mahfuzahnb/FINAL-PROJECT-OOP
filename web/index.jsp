<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - EasyKos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
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
    <div class="container d-flex justify-content-center align-items-center min-vh-100">
        <div class="card shadow-lg p-4" style="width: 100%; max-width: 400px;">
            <h2 class="text-center mb-4">Login</h2>
            <form method="POST" action="<%= request.getContextPath() %>/auth">
                <input type="hidden" name="action" value="login">
                
                <!-- Username Input -->
                <div class="mb-3">
                    <label for="username" class="form-label">Username</label>
                    <input type="text" class="form-control" id="username" name="username" placeholder="Enter your username" required>
                </div>
                
                <!-- Password Input -->
                <div class="mb-3">
                    <label for="password" class="form-label">Password</label>
                    <input type="password" class="form-control" id="password" name="password" placeholder="Enter your password" required>
                </div>
                
                <!-- Submit Button -->
                <div class="d-grid">
                    <button type="submit" class="btn" style="background-color: #56c4e3; color: white;">Login</button>
                </div>

                <!-- Register Link -->
                <p class="text-center mt-3">
                    Don't have an account? <a href="<%= request.getContextPath() %>/register.jsp">Register here</a>
                </p>

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
            </form>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
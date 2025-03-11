<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset = UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<html>
    <head>
        <meta charset="utf-8">
        <title>Thanh Toán - PickleBall47</title>
        <meta content="width=device-width, initial-scale=1.0" name="viewport">
        <meta content="Free HTML Templates" name="keywords">
        <meta content="Free HTML Templates" name="description">

        <!-- Favicon -->
        <link href="img/favicon.ico" rel="icon">
        <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
        <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>        
        <!-- Google Web Fonts -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Nunito:wght@400;600;700;800&family=Rubik:wght@400;500;600;700&display=swap" rel="stylesheet">

        <!-- Icon Font Stylesheet -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">
        <link
            href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css"
            rel="stylesheet">
        <!-- Libraries Stylesheet -->
        <link href="lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
        <link href="lib/animate/animate.min.css" rel="stylesheet">

        <!-- Customized Bootstrap Stylesheet -->
        <link href="css/bootstrap.min.css" rel="stylesheet">

        <!-- Template Stylesheet -->
        <link href="css/style.css" rel="stylesheet">
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <!--CSS Nhat-->
        <link rel="stylesheet" href="css/style_Chun.css"/>
        <!-- Include jQuery library -->

        <!-- Include jQuery UI library with Datepicker widget -->
        <link rel="stylesheet"
              href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
        <script
        src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

        <!-- Font Awesome CDN -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css" integrity="sha384-oEmeNbsrr8kMf3zSSsL0pTOrFc51pjcfX2iCcmAKjF/k9w8ANNCe83R2QnqIbzHf" crossorigin="anonymous">

        <fmt:setLocale value="vi_VN"/>

        <style>
            :root {
                --primary-color: #3a86ff;
                --secondary-color: #ff006e;
                --dark-color: #212529;
                --light-color: #f8f9fa;
                --success-color: #38b000;
            }

            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f7f7f9;
                color: var(--dark-color);
            }

            /* Checkout Styles */
            .checkout-container {
                padding: 3rem 0;
            }

            .checkout-header {
                margin-bottom: 2rem;
                border-bottom: 1px solid #dee2e6;
                padding-bottom: 1rem;
            }

            .checkout-title {
                font-size: 2rem;
                font-weight: 700;
                color: var(--dark-color);
            }

            .checkout-step {
                background-color: white;
                border-radius: 15px;
                box-shadow: 0 5px 15px rgba(0,0,0,0.05);
                padding: 1.5rem;
                margin-bottom: 1.5rem;
            }

            .step-title {
                font-size: 1.2rem;
                font-weight: 600;
                color: var(--dark-color);
                margin-bottom: 1.5rem;
                border-bottom: 1px solid #dee2e6;
                padding-bottom: 0.75rem;
            }

            .form-label {
                font-weight: 500;
                margin-bottom: 0.5rem;
            }

            .form-control {
                border-radius: 8px;
                padding: 0.6rem 1rem;
                margin-bottom: 1rem;
                border: 1px solid #dee2e6;
            }

            .form-control:focus {
                border-color: var(--primary-color);
                box-shadow: 0 0 0 0.25rem rgba(58, 134, 255, 0.1);
            }

            .payment-method {
                padding: 1rem;
                border: 1px solid #dee2e6;
                border-radius: 8px;
                margin-bottom: 1rem;
                cursor: pointer;
                transition: all 0.2s;
            }

            .payment-method:hover {
                background-color: #f8f9fa;
            }

            .payment-method.active {
                border-color: var(--primary-color);
                background-color: rgba(58, 134, 255, 0.05);
            }

            .payment-method-title {
                font-weight: 600;
                margin-bottom: 0.5rem;
            }

            .payment-method-description {
                color: #6c757d;
                font-size: 0.9rem;
            }

            .order-summary {
                background-color: white;
                border-radius: 15px;
                box-shadow: 0 5px 15px rgba(0,0,0,0.05);
                padding: 2rem;
                position: sticky;
                top: 2rem;
            }

            .summary-title {
                font-size: 1.5rem;
                font-weight: 700;
                margin-bottom: 1.5rem;
                color: var(--dark-color);
                border-bottom: 1px solid #dee2e6;
                padding-bottom: 0.75rem;
            }

            .order-item {
                display: flex;
                justify-content: space-between;
                align-items: center;
                padding: 0.75rem 0;
                border-bottom: 1px solid #f1f1f1;
            }

            .order-item-image {
                width: 50px;
                height: 50px;
                object-fit: contain;
                border-radius: 8px;
            }

            .order-item-name {
                font-weight: 500;
                font-size: 0.9rem;
                margin-bottom: 0.25rem;
            }

            .order-item-price {
                color: var(--secondary-color);
                font-weight: 600;
                font-size: 0.9rem;
            }

            .order-item-quantity {
                font-size: 0.9rem;
                color: #6c757d;
            }

            .summary-item {
                display: flex;
                justify-content: space-between;
                margin-bottom: 1rem;
            }

            .summary-label {
                color: #6c757d;
            }

            .summary-value {
                font-weight: 600;
            }

            .summary-total {
                font-size: 1.2rem;
                font-weight: 700;
                margin-top: 1rem;
                padding-top: 1rem;
                border-top: 1px solid #dee2e6;
            }

            .place-order-btn {
                background-color: var(--primary-color);
                color: white;
                border: none;
                border-radius: 8px;
                padding: 1rem;
                font-weight: 600;
                font-size: 1.1rem;
                width: 100%;
                transition: all 0.3s ease;
                margin-top: 1.5rem;
            }

            .place-order-btn:hover {
                background-color: #2b76e5;
                transform: translateY(-3px);
                box-shadow: 0 5px 15px rgba(58, 134, 255, 0.3);
            }

            .back-to-cart {
                display: block;
                text-align: center;
                margin-top: 1rem;
                color: var(--primary-color);
                text-decoration: none;
                font-weight: 500;
            }

            .back-to-cart:hover {
                text-decoration: underline;
            }

            /* Responsive Adjustments */
            @media (max-width: 991.98px) {
                .order-summary {
                    margin-top: 2rem;
                    position: static;
                }
            }

            /* Cart Styles */
            .cart-container {
                padding: 3rem 0;
            }

            .cart-header {
                margin-bottom: 2rem;
                border-bottom: 1px solid #dee2e6;
                padding-bottom: 1rem;
            }

            .cart-title {
                font-size: 2rem;
                font-weight: 700;
                color: var(--dark-color);
            }

            .cart-item {
                background-color: white;
                border-radius: 15px;
                box-shadow: 0 5px 15px rgba(0,0,0,0.05);
                padding: 1.5rem;
                margin-bottom: 1.5rem;
                transition: transform 0.2s;
            }

            .cart-item:hover {
                transform: translateY(-5px);
            }

            .cart-item-image {
                width: 100px;
                height: 100px;
                object-fit: contain;
                border-radius: 10px;
            }

            .cart-item-name {
                font-weight: 600;
                font-size: 1.1rem;
                margin-bottom: 0.5rem;
            }

            .cart-item-price {
                color: var(--secondary-color);
                font-weight: 600;
            }
        </style>
    </head>

    <body>
        <!-- Spinner Start -->
        <div id="spinner" class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
            <div class="spinner"></div>
        </div>
        <!-- Spinner End -->


        <!-- Topbar Start -->

        <!-- Topbar End -->


        <!-- Navbar & Carousel Start -->

        <nav class="navbar navbar-expand-lg px-5 py-3 py-lg-0 bg-dark navbar-dark position-sticky">
            <a href="index.jsp" class="navbar-brand p-0">
                <h1 class="m-0"><i class="fa fa-user-tie me-2"></i>PickleBall47</h1>
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarCollapse">
                <span class="fa fa-bars"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarCollapse">
                <div class="navbar-nav ms-auto py-0">
                    <a href="index.jsp" class="nav-item nav-link">Trang Chủ</a>
                    <a href="danhsachtimsan" class="nav-item nav-link">Tìm Sân</a>
                    <a href="productlist" class="nav-item nav-link">Sản phẩm</a>
                    <a href="contact.html" class="nav-item nav-link">Liên Hệ</a>
                </div >
                <a href="orderhistory" class="icon-button">
                    <span class="material-icons">history</span>
                </a>

                <c:if test="${sessionScope.account!=null}">
                    <a href="cart" class="position-relative">
                        <i class="fas fa-shopping-cart"></i>
                        <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger">
                            ${empty sessionScope.cartSize ? 0 : sessionScope.cartSize}
                        </span>
                    </a>
                </c:if>

                <h1 class="m-4 ">
                    <div class="d-none d-lg-block ">
                        <c:if test="${sessionScope.account==null}">
                            <a href="login" class="bi-person custom-icon me-3">Login!</a>
                        </c:if>
                        <c:if test="${sessionScope.account!=null }">
                            <div class="dropdown">
                                <button type="button" id="dropdownMenuButton1" class="btn dropdown-toggle " data-bs-toggle="dropdown" aria-expanded="false"style="color: #06A3DA;
                                        font-size: 20px;">
                                    ${sessionScope.account.name}
                                </button>
                                <div class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
                                    <a class="dropdown-item " href="profile">Profile</a>
                                    <a class="dropdown-item " href="#">Update</a>
                                    <a class="dropdown-item " href="logout">Logout</a>
                                </div>
                            </div>
                        </c:if> 
                    </div>
                </h1>
            </div>
        </nav>    
        <!-- Navbar & Carousel End -->
        <!--Content start-->
        <div class="container checkout-container">

            <!-- Order Success Message -->
            <div class="order-success">
                <h2>🎉 ${orderstatus}</h2>
                <p>${message}</p>
                <a href="productlist" class="btn btn-primary">Tiếp tục mua sắm</a>
            </div>

            <div class="row">
                <!-- Order Summary -->
                <div class="col-lg-4">
                    <div class="order-summary">
                        <h3 class="summary-title">Đơn Hàng Của Bạn</h3>

                        <!-- Order Items -->
                        <div class="order-items mb-4">
                            <c:forEach var="item" items="${ciList}">
                                <div class="order-item">
                                    <div class="d-flex align-items-center">
                                        <img src="${item.image}" class="order-item-image me-3" alt="${item.name}">
                                        <div>
                                            <div class="order-item-name">${item.name}</div>
                                            <div class="order-item-quantity">SL: ${item.quantity}</div>
                                        </div>
                                    </div>
                                    <div class="order-item-price">
                                        <fmt:formatNumber value="${item.price * item.quantity}" type="currency" currencyCode="VND" maxFractionDigits="0"/>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!--Content end-->
        <!-- Footer Start -->
        <div class="container-fluid bg-dark text-light mt-5 wow fadeInUp" data-wow-delay="0.1s">
            <div class="container">
                <div class="row gx-5">
                    <div class="col-lg-4 col-md-6 footer-about">
                        <div class="d-flex flex-column align-items-center justify-content-center text-center h-100 bg-primary p-4">
                            <a href="index.html" class="navbar-brand">
                                <h1 class="m-0 text-white"><i class="fa fa-user-tie me-2"></i>PickleBall47</h1>
                            </a>
                            <p class="mt-3 mb-4">Địa chỉ chuyên nghiệp dành cho mọi lứa tuổi, hãy cùng nhau trải nghiệm sân chơi đẳng cấp của chúng tôi ngay nhé.</p>
                            <form action="">
                                <div class="input-group">
                                    <input type="text" class="form-control border-white p-3" placeholder="Your Email">
                                    <button class="btn btn-dark">Sign Up</button>
                                </div>
                            </form>
                        </div>
                    </div>
                    <div class="col-lg-8 col-md-6">
                        <div class="row gx-5">
                            <div class="col-lg-4 col-md-12 pt-5 mb-5">
                                <div class="section-title section-title-sm position-relative pb-3 mb-4">
                                    <h3 class="text-light mb-0">Get In Touch</h3>
                                </div>
                                <div class="d-flex mb-2">
                                    <i class="bi bi-geo-alt text-primary me-2"></i>
                                    <p class="mb-0">78 Bình Kỳ, Ngũ Hành Sơn, Đà Nẵng</p>
                                </div>
                                <div class="d-flex mb-2">
                                    <i class="bi bi-envelope-open text-primary me-2"></i>
                                    <p class="mb-0">PickleBall47@gmail.com</p>
                                </div>
                                <div class="d-flex mb-2">
                                    <i class="bi bi-telephone text-primary me-2"></i>
                                    <p class="mb-0">+012 345 67890</p>
                                </div>
                                <div class="d-flex mt-4">
                                    <a class="btn btn-primary btn-square me-2" href="#"><i class="fab fa-twitter fw-normal"></i></a>
                                    <a class="btn btn-primary btn-square me-2" href="#"><i class="fab fa-facebook-f fw-normal"></i></a>
                                    <a class="btn btn-primary btn-square me-2" href="#"><i class="fab fa-linkedin-in fw-normal"></i></a>
                                    <a class="btn btn-primary btn-square" href="#"><i class="fab fa-instagram fw-normal"></i></a>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-12 pt-0 pt-lg-5 mb-5">
                                <div class="section-title section-title-sm position-relative pb-3 mb-4">
                                    <h3 class="text-light mb-0">Quick Links</h3>
                                </div>
                                <div class="link-animated d-flex flex-column justify-content-start">
                                    <a class="text-light mb-2" href="#"><i class="bi bi-arrow-right text-primary me-2"></i>Trang Chủ</a>
                                    <a class="text-light mb-2" href="#"><i class="bi bi-arrow-right text-primary me-2"></i>Tìm Sân</a>
                                    <a class="text-light mb-2" href="#"><i class="bi bi-arrow-right text-primary me-2"></i>Tìm Đối Thủ</a>
                                    <a class="text-light mb-2" href="#"><i class="bi bi-arrow-right text-primary me-2"></i>Giải Đấu</a>
                                    <a class="text-light mb-2" href="#"><i class="bi bi-arrow-right text-primary me-2"></i>Khóa Học Bóng Đá</a>
                                    <a class="text-light" href="#"><i class="bi bi-arrow-right text-primary me-2"></i>Liên Hệ</a>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-12 pt-0 pt-lg-5 mb-5">
                                <div class="section-title section-title-sm position-relative pb-3 mb-4">
                                    <h3 class="text-light mb-0">Popular Links</h3>
                                </div>
                                <div class="link-animated d-flex flex-column justify-content-start">
                                    <a class="text-light mb-2" href="#"><i class="bi bi-arrow-right text-primary me-2"></i>Trang Chủ</a>
                                    <a class="text-light mb-2" href="#"><i class="bi bi-arrow-right text-primary me-2"></i>Tìm Sân</a>
                                    <a class="text-light mb-2" href="#"><i class="bi bi-arrow-right text-primary me-2"></i>Tìm Đối Thủ</a>
                                    <a class="text-light mb-2" href="#"><i class="bi bi-arrow-right text-primary me-2"></i>Giải Đấu</a>
                                    <a class="text-light mb-2" href="#"><i class="bi bi-arrow-right text-primary me-2"></i>Khóa Học Bóng Đá</a>
                                    <a class="text-light" href="#"><i class="bi bi-arrow-right text-primary me-2"></i>Liên Hệ</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="container-fluid text-white" style="background: #061429;">
            <div class="container text-center">
                <div class="row justify-content-end">
                    <div class="col-lg-8 col-md-6">
                        <div class="d-flex align-items-center justify-content-center" style="height: 75px;">
                            <p class="mb-0">&copy; <a class="text-white border-bottom" href="#">Your Site Name</a>. All Rights Reserved. 

                                <!--/*** This template is free as long as you keep the footer author's credit link/attribution link/backlink. If you'd like to use the template without the footer author's credit link/attribution link/backlink, you can purchase the Credit Removal License from "https://htmlcodex.com/credit-removal". Thank you for your support. ***/-->
                                Designed by <a class="text-white border-bottom" href="https://htmlcodex.com">HTML Codex</a></p>
                            <br>Distributed By: <a class="border-bottom" href="https://themewagon.com" target="_blank">ThemeWagon</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Footer End -->


        <!-- Back to Top -->
        <a href="#" class="btn btn-lg btn-primary btn-lg-square rounded back-to-top"><i class="bi bi-arrow-up"></i></a>
        <!-- JavaScript Libraries -->
        <script src="lib/wow/wow.min.js"></script>
        <script src="lib/easing/easing.min.js"></script>
        <script src="lib/waypoints/waypoints.min.js"></script>
        <script src="lib/counterup/counterup.min.js"></script>
        <script src="lib/owlcarousel/owl.carousel.min.js"></script>
        <!-- Template Javascript -->
        <script src="js/main.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.1/moment.min.js"></script>
        <!--tập hợp js-->
        <script src="js/js_chun.js"></script>
    </script>
</body>
</html>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset = UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%--<%@ taglib prefix = "fn" uri = "http://java.sun.com/jsp/jstl/functions" %>--%>

<html>
    <head>
        <meta charset="utf-8">
        <title>Sân PickleBall47</title>
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

            /* Product Detail Page */
            .product-detail-container {
                padding: 3rem 0;
            }

            .product-image-container {
                position: relative;
                border-radius: 15px;
                overflow: hidden;
                background-color: white;
                box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            }

            .product-image {
                width: 100%;
                height: 700px;
                object-fit: contain;
                background-color: #f8f9fa;
                padding: 1.5rem;
                transition: transform 0.5s ease;
            }

            .product-image:hover {
                transform: scale(1.05);
            }

            .product-thumbnails {
                display: flex;
                gap: 10px;
                margin-top: 1rem;
            }

            .thumbnail {
                width: 70px;
                height: 70px;
                border-radius: 10px;
                cursor: pointer;
                border: 2px solid transparent;
                object-fit: cover;
                transition: all 0.2s ease;
            }

            .thumbnail:hover, .thumbnail.active {
                border-color: var(--primary-color);
                transform: translateY(-2px);
            }

            .product-info-card {
                background-color: white;
                border-radius: 15px;
                box-shadow: 0 5px 15px rgba(0,0,0,0.05);
                padding: 2rem;
                height: 100%;
            }

            .product-name {
                font-size: 1.2rem;
                font-weight: 700;
                margin-bottom: 1rem;
                color: var(--dark-color);
            }

            .product-price {
                font-size: 1.2rem;
                font-weight: 700;
                color: var(--secondary-color);
                margin-bottom: 1.5rem;
            }

            .product-description {
                color: #6c757d;
                margin-bottom: 2rem;
                line-height: 1.7;
            }

            .product-stock {
                display: flex;
                align-items: center;
                margin-bottom: 1.5rem;
            }

            .stock-badge {
                display: inline-block;
                padding: 0.35rem 0.75rem;
                border-radius: 20px;
                font-size: 0.8rem;
                font-weight: 600;
                letter-spacing: 0.5px;
                margin-left: 0.5rem;
            }

            .in-stock {
                background-color: rgba(56, 176, 0, 0.1);
                color: var(--success-color);
            }

            .quantity-control {
                display: flex;
                align-items: center;
                margin-bottom: 2rem;
            }

            .quantity-label {
                font-weight: 600;
                margin-right: 1rem;
                min-width: 100px;
            }

            .quantity-input-group {
                display: flex;
                border: 1px solid #dee2e6;
                border-radius: 8px;
                overflow: hidden;
                width: 140px;
            }

            .quantity-btn {
                width: 40px;
                background: none;
                border: none;
                font-size: 1.2rem;
                cursor: pointer;
                transition: background-color 0.2s;
            }

            .quantity-btn:hover {
                background-color: #f8f9fa;
            }

            .quantity-input {
                width: 60px;
                border: none;
                text-align: center;
                font-weight: 600;
                border-left: 1px solid #dee2e6;
                border-right: 1px solid #dee2e6;
            }

            .quantity-input:focus {
                outline: none;
            }

            .add-to-cart-btn {
                background-color: var(--primary-color);
                color: white;
                border: none;
                border-radius: 8px;
                padding: 0.6rem;
                font-weight: 600;
                font-size: 0.8rem;
                width: 100%;
                transition: all 0.3s ease;
                margin-top: 1rem;
            }

            .add-to-cart-btn:hover {
                background-color: #2b76e5;
                transform: translateY(-3px);
                box-shadow: 0 5px 15px rgba(58, 134, 255, 0.3);
            }

            .product-actions {
                display: flex;
                gap: 1rem;
                margin-top: 1.5rem;
            }

            .action-btn {
                flex: 1;
                padding: 0.8rem;
                border: 1px solid #dee2e6;
                border-radius: 8px;
                background: none;
                display: flex;
                align-items: center;
                justify-content: center;
                font-weight: 500;
                gap: 0.5rem;
                transition: all 0.2s ease;
            }

            .action-btn:hover {
                background-color: #f8f9fa;
            }

            .divider {
                height: 1px;
                background-color: #dee2e6;
                margin: 2rem 0;
            }

            .product-features {
                margin-top: 2rem;
            }

            .feature-title {
                font-weight: 600;
                margin-bottom: 1rem;
            }

            .feature-list {
                list-style-type: none;
                padding-left: 0;
            }

            .feature-item {
                display: flex;
                align-items: center;
                margin-bottom: 0.8rem;
            }

            .feature-icon {
                color: var(--primary-color);
                margin-right: 0.8rem;
            }

            /* Responsive Adjustments */
            @media (max-width: 991.98px) {
                .product-image-container {
                    margin-bottom: 2rem;
                }
            }

            @media (max-width: 767.98px) {
                .product-name {
                    font-size: 1.5rem;
                }

                .product-price {
                    font-size: 1.5rem;
                }

                .product-image {
                    height: 350px;
                }
            }
        </style>
    </head>

    <body>
        <!-- Spinner Start -->
        <div id="spinner" class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
            <div class="spinner"></div>
        </div>
        <!-- Spinner End -->

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
                    <a href="productlist" class="nav-item nav-link active">Sản phẩm</a>
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
        <div class="container product-detail-container">
            <div class="row">
                <!-- Product Image -->
                <div class="col-lg-6">
                    <div class="product-image-container">
                        <img src="${p.image}" class="product-image rounded" alt="${p.name}">
                    </div>
                </div>
                        
                <!-- Product Info -->
                <div class="col-lg-6">
                    <div class="product-info-card">
                        <h1 class="product-name">${p.name}</h1>

                        <h2 class="product-price"><fmt:formatNumber value="${p.price}" type="currency" currencyCode="VND" maxFractionDigits="0"/></h2>

                        <p class="product-description">${p.description}</p>

                        <div class="product-stock">
                            <span class="quantity-label">Trạng thái:</span>
                            <span class="stock-badge in-stock">Còn hàng: ${p.stock_quantity}</span>
                        </div>

                        <div class="quantity-control">
                            <span class="quantity-label">Số lượng:</span>
                            <div class="quantity-input-group">
                                <button class="quantity-btn decrease-btn">-</button>
                                <input id="quantity" type="number" class="quantity-input" name="quantity" min="1" max="${p.stock_quantity}" value="1">
                                <button class="quantity-btn increase-btn">+</button>
                            </div>
                        </div>

                        <button class="add-to-cart-btn" data-id="${p.product_id}">
                            <i class="fas fa-shopping-cart me-2"></i> Thêm vào giỏ hàng
                        </button>

                        <div class="divider"></div>

                        <div class="product-features">
                            <h3 class="feature-title">Đặc điểm nổi bật</h3>
                            <ul class="feature-list">
                                <li class="feature-item">
                                    <i class="fas fa-check-circle feature-icon"></i>
                                    <span>Chất lượng cao</span>
                                </li>
                                <li class="feature-item">
                                    <i class="fas fa-check-circle feature-icon"></i>
                                    <span>Bảo hành 12 tháng</span>
                                </li>
                                <li class="feature-item">
                                    <i class="fas fa-check-circle feature-icon"></i>
                                    <span>Giao hàng miễn phí</span>
                                </li>
                                <li class="feature-item">
                                    <i class="fas fa-check-circle feature-icon"></i>
                                    <span>Đổi trả trong 30 ngày</span>
                                </li>
                            </ul>
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

                                <!--/*** This template is free as long as you keep the footer author’s credit link/attribution link/backlink. If you'd like to use the template without the footer author’s credit link/attribution link/backlink, you can purchase the Credit Removal License from "https://htmlcodex.com/credit-removal". Thank you for your support. ***/-->
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
        <script>
            $(document).ready(function () {
                $(".add-to-cart-btn").click(function () {
                    let productId = $(this).data("id");
                    let quantity = $('#quantity').val();

                    if (quantity <= 0) {
                        alert("Vui lòng chọn số lượng mua!");
                        return;
                    }

                    if (${p.stock_quantity} <= 0) {
                        alert("Sản phẩm đã hết hàng!");
                        return;
                    }

                    $.ajax({
                        url: "addtocart",
                        type: "POST",
                        data: {
                            id: productId,
                            quantity: quantity
                        },
                        success: function (response) {
                            if (response.status === "failed") {
                                alert(response.message);
                                window.location.href = 'login';
                            }

                            if (response.status === "success") {
                                alert(response.message);
                                window.location.reload();
                            }
                        },
                        error: function () {
                            alert("Failed to add product to cart.");
                        }
                    });
                });
            });

            document.addEventListener('DOMContentLoaded', function () {
                const quantityInput = document.querySelector('.quantity-input');
                const decreaseBtn = document.querySelector('.decrease-btn');
                const increaseBtn = document.querySelector('.increase-btn');
                const maxQuantity = parseInt(quantityInput.getAttribute('max'));

                decreaseBtn.addEventListener('click', function () {
                    let value = parseInt(quantityInput.value);
                    if (value > 1) {
                        quantityInput.value = value - 1;
                    }
                });

                increaseBtn.addEventListener('click', function () {
                    let value = parseInt(quantityInput.value);
                    if (value < maxQuantity) {
                        quantityInput.value = value + 1;
                    }
                });

                quantityInput.addEventListener('change', function () {
                    let value = parseInt(this.value);
                    if (isNaN(value) || value < 1) {
                        this.value = 1;
                    } else if (value > maxQuantity) {
                        this.value = maxQuantity;
                    }
                });
            });
        </script>
    </body>
</html>

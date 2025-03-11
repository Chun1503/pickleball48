<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset = UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<html>
    <head>
        <meta charset="utf-8">
        <title>Giỏ Hàng - PickleBall47</title>
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

            .cart-item-quantity {
                width: 60px;
                text-align: center;
                border: 1px solid #dee2e6;
                border-radius: 5px;
                padding: 0.375rem 0.75rem;
            }

            .cart-item-total {
                font-weight: 700;
                color: var(--dark-color);
            }

            .cart-item-remove {
                color: #dc3545;
                background: none;
                border: none;
                font-size: 1.2rem;
                cursor: pointer;
                transition: color 0.2s;
            }

            .cart-item-remove:hover {
                color: #b02a37;
            }

            .cart-summary {
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

            .checkout-btn {
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

            .checkout-btn:hover {
                background-color: #2b76e5;
                transform: translateY(-3px);
                box-shadow: 0 5px 15px rgba(58, 134, 255, 0.3);
            }

            .continue-shopping {
                display: block;
                text-align: center;
                margin-top: 1rem;
                color: var(--primary-color);
                text-decoration: none;
                font-weight: 500;
            }

            .continue-shopping:hover {
                text-decoration: underline;
            }

            .empty-cart {
                text-align: center;
                padding: 3rem;
                background-color: white;
                border-radius: 15px;
                box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            }

            .empty-cart-icon {
                font-size: 5rem;
                color: #dee2e6;
                margin-bottom: 1.5rem;
            }

            .empty-cart-message {
                font-size: 1.5rem;
                margin-bottom: 1.5rem;
                color: #6c757d;
            }

            .quantity-control {
                display: flex;
                align-items: center;
            }

            .quantity-btn {
                width: 30px;
                height: 30px;
                border-radius: 50%;
                border: 1px solid #dee2e6;
                background: none;
                font-size: 0.8rem;
                cursor: pointer;
                display: flex;
                align-items: center;
                justify-content: center;
                transition: all 0.2s;
            }

            .quantity-btn:hover {
                background-color: #f8f9fa;
            }

            /* Responsive Adjustments */
            @media (max-width: 991.98px) {
                .cart-summary {
                    margin-top: 2rem;
                    position: static;
                }
            }

            @media (max-width: 767.98px) {
                .cart-item {
                    text-align: center;
                }

                .cart-item-image {
                    margin-bottom: 1rem;
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
        <div class="container cart-container">
            <div class="cart-header">
                <h1 class="cart-title">Giỏ Hàng Của Tôi</h1>
            </div>

            <div class="row">
                <!-- Cart Items -->
                <div class="col-lg-8">

                    <c:if test="${not empty message}">
                        <div id="alertMessage" class="alert alert-warning" role="alert">
                            ${message}
                        </div>

                        <script>
                            // Auto hide alert after 3 seconds
                            setTimeout(function () {
                                let alertBox = document.getElementById("alertMessage");
                                if (alertBox) {
                                    alertBox.style.transition = "opacity 1s ease-out";
                                    alertBox.style.opacity = "0"; // Fade out
                                    setTimeout(() => alertBox.remove(), 1000); // Remove from DOM after fade-out
                                }
                            }, 3000);
                        </script>
                    </c:if>

                    <c:if test="${empty sessionScope.cart}">
                        <div class="empty-cart">
                            <div class="empty-cart-icon">
                                <i class="fas fa-shopping-cart"></i>
                            </div>
                            <h3 class="empty-cart-message">Giỏ hàng của bạn đang trống</h3>
                            <a href="productlist" class="btn btn-primary">Tiếp tục mua sắm</a>
                        </div>
                    </c:if>

                    <c:if test="${not empty sessionScope.cart}">
                        <c:forEach var="entry" items="${sessionScope.cart}">
                            <c:set var="item" value="${entry.value}" />
                            <div class="cart-item ${item.stock_quantity < 1 ? "" : ""}">
                                <div class="row align-items-center">
                                    <div class="col-md-2 col-4">
                                        <img src="${item.image}" class="cart-item-image" alt="${item.name}">
                                    </div>
                                    <div class="col-md-4 col-8">
                                        <h5 class="cart-item-name">${item.name}</h5>
                                        <p class="cart-item-price"><fmt:formatNumber value="${item.price}" type="currency" currencyCode="VND" maxFractionDigits="0"/></p>
                                    </div>
                                    <div class="col-md-3 col-6 mt-3 mt-md-0">
                                        <div class="quantity-control">
                                            <button class="quantity-btn decrease-btn" data-id="${item.id}">-</button>
                                            <input type="number" class="cart-item-quantity mx-2" value="${item.quantity}" min="1" max="100" data-id="${item.id}">
                                            <button class="quantity-btn increase-btn" data-id="${item.id}">+</button>
                                        </div>

                                        <div class="stock">
                                            <p>${item.stock_quantity < 1 ? "" : "Còn lại: "} ${item.stock_quantity < 1 ? "Hết hàng" : item.stock_quantity}  </p>
                                        </div>
                                    </div>
                                    <div class="col-md-2 col-4 mt-3 mt-md-0">
                                        <span class="cart-item-total"><fmt:formatNumber value="${item.price * item.quantity}" type="currency" currencyCode="VND" maxFractionDigits="0"/></span>
                                    </div>
                                    <div class="col-md-1 col-2 mt-3 mt-md-0 text-end">
                                        <button class="cart-item-remove" data-id="${item.id}">
                                            <i class="fas fa-trash-alt"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:if>
                </div>

                <c:if test="${not empty sessionScope.cart}">
                    <!-- Cart Summary -->
                    <div class="col-lg-4">
                        <div class="cart-summary">
                            <h3 class="summary-title">Tóm Tắt Đơn Hàng</h3>

                            <div class="summary-item">
                                <span class="summary-label">Tổng sản phẩm:</span>
                                <span class="summary-value">${sessionScope.cartSize}</span>
                            </div>

                            <!-- Calculate total price -->
                            <c:set var="total" value="0" />
                            <c:forEach var="entry" items="${sessionScope.cart}">
                                <c:set var="item" value="${entry.value}" />
                                <c:set var="total" value="${total + (item.price * item.quantity)}" />
                            </c:forEach>

                            <div class="summary-item summary-total">
                                <span class="summary-label">Tổng cộng:</span>
                                <span class="summary-value"><fmt:formatNumber value="${total}" type="currency" currencyCode="VND" maxFractionDigits="0"/></span>
                            </div>

                            <button class="checkout-btn">
                                <i class="fas fa-lock me-2"></i> Thanh Toán
                            </button>

                            <a href="productlist" class="continue-shopping">
                                <i class="fas fa-arrow-left me-1"></i> Tiếp tục mua sắm
                            </a>
                        </div>
                    </div>
                </c:if>
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
        <script>
                            $(document).ready(function () {
                                $('.cart-item-quantity').change(function () {
                                    let productId = $(this).data('id');
                                    let quantity = $(this).val();
                                    updateCartItem(productId, quantity);
                                });

                                $('.decrease-btn').click(function () {
                                    let productId = $(this).data('id');
                                    let input = $(this).siblings('.cart-item-quantity');
                                    let currentVal = parseInt(input.val());

                                    if (currentVal > 1) {
                                        input.val(currentVal - 1);
                                        updateCartItem(productId, currentVal - 1);
                                    }
                                });

                                $('.increase-btn').click(function () {
                                    let productId = $(this).data('id');
                                    let input = $(this).siblings('.cart-item-quantity');
                                    let currentVal = parseInt(input.val());
                                    let max = parseInt(input.attr('max'));

                                    if (currentVal < max) {
                                        input.val(currentVal + 1);
                                        updateCartItem(productId, currentVal + 1);
                                    }
                                });

                                $('.cart-item-remove').click(function () {
                                    let productId = $(this).data('id');

                                    if (confirm('Bạn có chắc muốn xóa sản phẩm này khỏi giỏ hàng?')) {
                                        $.ajax({
                                            url: "cart",
                                            type: "POST",
                                            data: {
                                                action: "delete",
                                                pid: productId
                                            },
                                            success: function (response) {
                                                window.location.reload();
                                            },
                                            error: function () {
                                                alert("Không thể xóa sản phẩm khỏi giỏ hàng.");
                                            }
                                        });
                                    }
                                });

                                $('.checkout-btn').click(function () {
                                    let hasStock = false;

                                    $('.cart-item').each(function () {
                                        let stockText = $(this).find('.stock p').text().trim();
                                        if (stockText.includes("Còn lại")) {
                                            hasStock = true;
                                            return false;
                                        }
                                    });

                                    if (hasStock) {
                                        window.location.href = "checkout";
                                    } else {
                                        alert("Tất cả sản phẩm trong giỏ hàng đã hết hàng. Vui lòng kiểm tra lại!");
                                    }
                                });

                                function updateCartItem(productId, quantity) {
                                    $.ajax({
                                        url: "cart",
                                        type: "POST",
                                        data: {
                                            action: "update",
                                            pid: productId,
                                            quantity: quantity
                                        },
                                        success: function (response) {
                                            window.location.reload();
                                        },
                                        error: function () {
                                            alert("Không thể cập nhật số lượng sản phẩm.");
                                        }
                                    });
                                }
                            });
        </script>
    </script>
</body>
</html>
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
            /* Product Grid Styling */
            .product-card-grid {
                margin-top: 2rem;
                margin-bottom: 2rem;
            }

            .card {
                transition: transform 0.3s ease, box-shadow 0.3s ease;
                overflow: hidden;
            }

            .card:hover {
                transform: translateY(-5px);
                box-shadow: 0 10px 20px rgba(0,0,0,0.1) !important;
            }

            .product-image {
                transition: transform 0.5s ease;
            }

            .card:hover .product-image {
                transform: scale(1.05);
            }

            .product-name {
                font-size: 1.1rem;
                min-height: 2.5rem;
                display: -webkit-box;
                -webkit-line-clamp: 2;
                -webkit-box-orient: vertical;
                overflow: hidden;
            }

            .product-price {
                color: #dc3545;
                font-weight: 700;
                margin: 0.5rem 0;
            }

            .buy-now-btn {
                font-weight: 600;
                text-transform: uppercase;
                letter-spacing: 0.5px;
                border-radius: 50px;
                padding: 0.5rem 1rem;
            }

            .buy-now-btn:hover {
                transform: scale(1.05);
            }

            .badge {
                font-size: 0.7rem;
                padding: 0.5rem 0.7rem;
                z-index: 10;
            }

            /* Responsive adjustments */
            @media (max-width: 767.98px) {
                .card-title {
                    font-size: 1rem;
                }

                .product-image {
                    height: 180px !important;
                }
            }

            /* Animation for new badge */
            @keyframes pulse {
                0% { transform: scale(1); }
                50% { transform: scale(1.1); }
                100% { transform: scale(1); }
            }

            .badge.bg-danger {
                animation: pulse 2s infinite;
            }
        </style>
    </head>

    <body>
        <!-- Spinner Start -->
<!--        <div id="spinner" class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
            <div class="spinner"></div>
        </div>-->
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
        <div class="container-fluid bg-white py-4">
            <div class="container">
                <!-- Search Filter -->
                <div class="filter mb-4">
                    <div class="row justify-content-center">
                        <div class="col-md-6">
                            <div class="input-group shadow-sm">
                                <input type="text" name="search" class="form-control rounded-start search-input" placeholder="Search products...">
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Product List -->
                <div class="row row-cols-1 row-cols-sm-2 row-cols-md-3 row-cols-lg-5 g-4">
                    <c:forEach items="${pList}" var="p">
                        <div class="col">
                            <div class="card h-100 shadow-md border-0 rounded-3">
                                <div class="position-relative">
                                    <img src="${p.image}" class="card-img-top rounded-top product-image bg-white" alt="Product Image" style="height: 220px; object-fit: contain;">
                                    <span class="position-absolute top-0 end-0 badge bg-danger m-2">New</span>
                                </div>
                                <div class="card-body d-flex flex-column text-center bg-white">
                                    <h5 class="card-title product-name">${p.name}</h5>
                                    <p class="card-text text-dark fs-5 product-price">Giá: <fmt:formatNumber value="${p.price}" type="currency" currencyCode="VND" maxFractionDigits="0"/></p>
                                    <p class="card-text text-dark">Chỉ còn lại: ${p.stock_quantity} sản phẩm</p>
                                    <div class="mt-auto">
                                        <a href="productdetail?id=${p.product_id}"><button class="btn btn-dark w-100 mb-2 buy-now-btn">Mua ngay</button></a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <div class="d-flex justify-content-between align-items-center mt-4 pagination-custom">
                    <span id="pageIndicator" class="text-secondary">${itemFrom} - ${itemTo} of ${totalItems} Items</span>
                    <div class="d-flex gap-3">
                        <i id="prevPage" class="fas fa-chevron-left text-secondary fs-4" style="cursor: pointer;"></i>
                        <i id="nextPage" class="fas fa-chevron-right text-secondary fs-4" style="cursor: pointer;"></i>
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
                const totalPage = parseInt("${totalPage}");
                let debounceTimer;
                function getCurrentPage() {
                    const urlParams = new URLSearchParams(window.location.search);
                    return parseInt(urlParams.get("page")) || 1;
                }

                function updateURL() {
                    clearTimeout(debounceTimer);
                    debounceTimer = setTimeout(() => {
                        const urlParams = new URLSearchParams();
                        $(".search-input").each(function () {
                            const value = $(this).val().trim();
                            const name = $(this).attr("name");
                            if (value !== "") {
                                urlParams.set(name, value);
                            }
                        });
                        urlParams.set("page", 1);
                        window.location.search = urlParams.toString();
                    }, 500);
                }

                function updatePage(newPage) {
                    if (newPage < 1 || newPage > totalPage)
                        return;
                    const urlParams = new URLSearchParams(window.location.search);
                    urlParams.set("page", newPage);
                    window.location.search = urlParams.toString();
                }

                $("input.search-input").on("input", updateURL);
                $("#prevPage").on("click", function () {
                    let currentPage = getCurrentPage();
                    if (currentPage > 1) {
                        updatePage(currentPage - 1);
                    }
                });
                $("#nextPage").on("click", function () {
                    let currentPage = getCurrentPage();
                    if (currentPage < totalPage) {
                        updatePage(currentPage + 1);
                    }
                });
                const urlParams = new URLSearchParams(window.location.search);
                $(".search-input").each(function () {
                    const name = $(this).attr("name");
                    if (urlParams.has(name)) {
                        $(this).val(urlParams.get(name));
                    }
                });
            });
        </script>
    </body>
</html>

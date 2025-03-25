<%-- 
    Document   : list
    Created on : Mar 15, 2025, 12:58:31 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Product Management</title>
    <link rel="stylesheet" href="https://cdn.datatables.net/2.2.2/css/dataTables.bootstrap5.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/5.3.0/css/bootstrap.min.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css" />
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;600&display=swap" rel="stylesheet" />
    <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/style.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/sidebar.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dashboard.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/data-table.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/sb-admin-2.min.css" />
  </head>
  <body>
    <!-- sidebar  -->
    <div class="sidebar active">
      <div class="top">
        <div class="logo">
          <!-- <i class="bx bxl-codepen"></i> -->
          <span>Quản lý</span>
        </div>
        <i style="font-size: 30px"  class="bx bx-menu" id="sidebar-menu-btn"></i>
      </div>
      <div class="user">
        <i class="bx bxs-user-rectangle user-img"></i>
        <div class="user-info">
          <p class="bold" id="sidebar-username"></p>
          <p id="sidebar-user-email"></p>
        </div>
      </div>
      <ul style="padding-left: 0">
        <li>
          <a href="${pageContext.request.contextPath}/admin/dashboard.jsp">
              <i style="font-size: 30px" class="bx bxs-grid-alt"></i>
            <span class="nav-item">Thống kê</span>
          </a>
          <span class="tooltip">Thống kê</span>
        </li>
        <li>
          <a href="${pageContext.request.contextPath}/admin/products">
            <i style="font-size: 30px" class="bx bxs-shopping-bag"></i>
            <span class="nav-item">Sản phẩm</span>
          </a>
          <span class="tooltip">Sản phẩm</span>
        </li>
        <li>
          <a href="${pageContext.request.contextPath}/admin/order-history">
            <i style="font-size: 30px" class="bx bx-list-check"></i>
            <span class="nav-item">Đơn đặt</span>
          </a>
          <span class="tooltip">Đơn đặt</span>
        </li>
        <li>
          <a href="${pageContext.request.contextPath}/admin/order-payment">
            <i style="font-size: 30px" class="bx bxs-food-menu"></i>
            <span class="nav-item">Thanh toán</span>
          </a>
          <span class="tooltip">Thanh toán</span>
        </li>
        <li>
          <a href="#">
            <i style="font-size: 30px" class="bx bx-body"></i>
            <span class="nav-item">Customers</span>
          </a>
          <span class="tooltip">Customers</span>
        </li>
        <li>
          <a href="#">
            <i style="font-size: 30px" class="bx bx-location-plus"></i>
            <span class="nav-item">Vận chuyển</span>
          </a>
          <span class="tooltip">Vận chuyển</span>
        </li>
        <li>
          <a href="#">
            <i style="font-size: 30px" class="bx bx-cog"></i>
            <span class="nav-item">Cài đặt</span>
          </a>
          <span class="tooltip">Cài đặt</span>
        </li>
        <li>
          <a href="#" id="logout">
            <i style="font-size: 30px" class="bx bx-log-out"></i>
            <span class="nav-item">Đăng xuất</span>
          </a>
          <span class="tooltip">Đăng xuất</span>
        </li>
      </ul>
    </div>
    <!-- data table  -->
    <main class="main-content mt-5">
            <div class="container-fluid">
        <div class="row">
            <div class="col-xl-3 col-md-6 mb-4">
                <div class="card border-left-danger shadow h-100 py-2">
                    <div class="card-body">
                        <div class="row no-gutters align-items-center">
                            <div class="col mr-2">
                                <div class="text-xs font-weight-bold text-danger text-uppercase mb-1">
                                    Doanh thu tháng này</div>
                                <div id="monthlyRevenue" class="h5 mb-0 font-weight-bold text-gray-800">
                                    
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-xl-3 col-md-6 mb-4">
                <div class="card border-left-success shadow h-100 py-2">
                    <div class="card-body">
                        <div class="row no-gutters align-items-center">
                            <div class="col mr-2">
                                <div class="text-xs font-weight-bold text-success text-uppercase mb-1">
                                    Doanh thu năm nay</div>
                                <div id="yearlyRevenue" class="h5 mb-0 font-weight-bold text-gray-800"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-xl-3 col-md-6 mb-4">
                <div class="card border-left-warning shadow h-100 py-2">
                    <div class="card-body">
                        <div class="row no-gutters align-items-center">
                            <div class="col mr-2">
                                <div class="text-xs font-weight-bold text-warning text-uppercase mb-1">Số lượng sản phẩm
                                </div>
                                <div class="row no-gutters align-items-center">
                                    <div class="col-auto">
                                        <div class="h5 mb-0 mr-3 font-weight-bold  text-gray-800" id="totalProducts">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-xl-3 col-md-6 mb-4">
                <div class="card border-left-primary shadow h-100 py-2">
                    <div class="card-body">
                        <div class="row no-gutters align-items-center">
                            <div class="col mr-2">
                                <div class="text-xs font-weight-bold text-primary text-uppercase mb-1">
                                    Số đơn đặt hàng</div>
                                <div class="h5 mb-0 font-weight-bold text-gray-800" id="totalOrders"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-8 mb-4">
                <div class="card shadow mb-4">
                    <div class="card-header py-3 d-flex justify-content-between align-items-center">
                        <h6 class="m-0 font-weight-bold text-primary">Thống kê doanh thu</h6>
                        <select id="yearSelector" class="form-control w-auto">
                            <option value="2021">2021</option>
                            <option value="2022">2022</option>
                            <option value="2023">2023</option>
                            <option value="2024">2024</option>
                            <option value="2025" selected>2025</option>
                        </select>
                    </div>
                    <div class="card-body">
                        <div class="chart-area">
                            <div class="chartjs-size-monitor">
                                <div class="chartjs-size-monitor-expand">
                                    <div class=""></div>
                                </div>
                                <div class="chartjs-size-monitor-shrink">
                                    <div class=""></div>
                                </div>
                            </div>
                            <canvas id="myAreaChart" style="display: block; height: 320px; width: 371px;" width="408" height="352" class="chartjs-render-monitor"></canvas>
                        </div>
                        <hr>
                    </div>
                </div>
            </div>
            <div class="col-lg-4 mb-4">
                <div class="card shadow mb-4">
                    <div class="card-header py-3">
                        <h6 class="m-0 font-weight-bold text-primary">Top 5 sản phẩm bán chạy nhất</h6>
                    </div>
                    <div class="card-body">
                        <div class="chart-pie">
                            <canvas id="myPieChart"></canvas>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>
    </main>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
document.addEventListener("DOMContentLoaded", function () {
    const yearSelector = document.getElementById("yearSelector");
    let chartInstance = null;
    function fetchAndRenderChart(year) {
        strr = 'http://localhost:8080/PickleBall47/admin/dashboard?year=' + year;
        fetch(strr)
            .then(response => response.json()) // Chuyển đổi sang JSON
            .then(data => {
                console.log("Dữ liệu từ server:", data);

                // Hiển thị doanh thu trên giao diện
                console.log(data)
                document.getElementById("monthlyRevenue").innerText = data.month.toLocaleString() + " VND";
                document.getElementById("yearlyRevenue").innerText = data.yearlyRevenue.toLocaleString() + " VND";
                document.getElementById("totalProducts").innerText = data.totalProducts;
                document.getElementById("totalOrders").innerText = data.totalOrders;
                if (chartInstance) {
                    chartInstance.destroy();
                    chartInstance1.destroy();
                }

                // Cập nhật dữ liệu cho biểu đồ
                const labels = data.topProducts.map(product => product.productName);
                const quantities = data.topProducts.map(product => product.totalQuantity);

                // Vẽ biểu đồ tròn
                var ctx = document.getElementById("myPieChart").getContext("2d");
                chartInstance = new Chart(ctx, {
                    type: "pie",
                    data: {
                        labels: labels,
                        datasets: [{
                            data: quantities,
                            backgroundColor: ["#4e73df", "#1cc88a", "#36b9cc", "#f6c23e", "#e74a3b"],
                            hoverBackgroundColor: ["#2e59d9", "#17a673", "#2c9faf", "#f4b619", "#d63031"],
                            borderWidth: 1,
                        }]
                    },
                    options: {
                        responsive: true,
                        maintainAspectRatio: false,
                        plugins: {
                            legend: { position: 'right' }
                        }
                    }
                });

                if (data.monthlyRevenue) {
                    // Xử lý dữ liệu để lấy tháng và doanh thu
                    const labels = Array(12).fill("Tháng ").map((text, index) => text + (index + 1)); // Tạo mảng tháng 1-12
                    const revenueData = Array(12).fill(0); // Mảng chứa doanh thu, mặc định là 0

                    // Điền doanh thu vào đúng vị trí trong mảng
                    data.monthlyRevenue.forEach(item => {
                        const monthIndex = parseInt(item.month.split("-")[1], 10) - 1;
                        revenueData[monthIndex] = item.revenue; // Đổi sang triệu VNĐ
                    });

                    // Vẽ biểu đồ với dữ liệu thực
                    var ctx = document.getElementById("myAreaChart").getContext('2d');
                    chartInstance1 =  new Chart(ctx, {
                        type: 'bar',
                        data: {
                            labels: labels,
                            datasets: [{
                                label: "Doanh thu (triệu VNĐ)",
                                backgroundColor: "rgba(78, 115, 223, 0.8)",
                                borderColor: "rgba(78, 115, 223, 1)",
                                borderWidth: 1,
                                data: revenueData,
                            }],
                        },
                        options: {
                            responsive: true,
                            maintainAspectRatio: false,
                            scales: {
                                x: {
                                    title: {
                                        display: true,
                                        text: "Tháng"
                                    }
                                },
                                y: {
                                    title: {
                                        display: true,
                                        text: "Doanh thu (VNĐ)"
                                    },
                                    ticks: {
                                        callback: function(value) {
                                            return value + " VNĐ";
                                        }
                                    }
                                }
                            },
                            plugins: {
                                legend: {
                                    display: false
                                },
                                tooltip: {
                                    callbacks: {
                                        label: function(tooltipItem) {
                                            return tooltipItem.raw + "VNĐ";
                                        }
                                    }
                                }
                            }
                        }
                    });
                } else {
                    console.error("Dữ liệu API không hợp lệ!");
                }
            })
            .catch(error => console.error("Lỗi khi tải dữ liệu:", error));
        }
        fetchAndRenderChart(yearSelector.value);

        // Cập nhật biểu đồ khi người dùng chọn năm mới
        yearSelector.addEventListener("change", function () {
            fetchAndRenderChart(this.value);
        });
});
</script>  
  </body>
  
</html>
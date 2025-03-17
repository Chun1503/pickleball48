<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Tạo mới đơn hàng</title>

    <!-- Bootstrap core CSS -->
    <link href="assets/bootstrap.min.css" rel="stylesheet"/>

    <!-- Custom styles for this template -->
    <link href="assets/jumbotron-narrow.css" rel="stylesheet">

    <!-- VNPAY CSS -->
    <link href="https://pay.vnpay.vn/lib/vnpay/vnpay.css" rel="stylesheet" />

    <script src="assets/jquery-1.11.3.min.js"></script>
    <script src="assets/bootstrap.min.js"></script>
</head>

<body>
    <div class="container">
        <div class="header clearfix">
            <h3 class="text-muted">Thanh toán tiền cọc sân</h3>
        </div>
        <h3>Tạo mới đơn hàng</h3>
        <div class="table-responsive">
            <form action="vnpayajax" method="POST">
    <input type="hidden" name="amount" value="100000">
    
    <h4>Chọn phương thức thanh toán</h4>
    <label><input type="radio" name="bankCode" value=""> Cổng VNPayQR</label><br>
    <label><input type="radio" name="bankCode" value="VNPAYQR"> Ứng dụng hỗ trợ VNPayQR</label><br>
    <label><input type="radio" name="bankCode" value="VNBANK"> Thẻ ATM nội địa</label><br>
    <label><input type="radio" name="bankCode" value="INTCARD"> Thẻ quốc tế</label><br>

    <h4>Chọn ngôn ngữ</h4>
    <label><input type="radio" name="language" value="vn" checked> Tiếng Việt</label>
    <label><input type="radio" name="language" value="en"> English</label><br>

    <button type="submit">Thanh toán</button>
</form>

        </div>
        <footer class="footer">
            <p>&copy; VNPAY 2020</p>
        </footer>
    </div>

    <!-- VNPAY JavaScript -->
    <script src="https://pay.vnpay.vn/lib/vnpay/vnpay.min.js"></script>
    <script>
        $("#frmCreateOrder").submit(function () {
            var postData = $(this).serialize();
            var submitUrl = $(this).attr("action");
            $.ajax({
                type: "POST",
                url: submitUrl,
                data: postData,
                dataType: 'JSON',
                success: function (x) {
                    if (x.code === '00') {
                        if (window.vnpay) {
                            vnpay.open({width: 768, height: 600, url: x.data});
                        } else {
                            location.href = x.data;
                        }
                        return false;
                    } else {
                        alert(x.Message);
                    }
                }
            });
            return false;
        });
    </script>       
</body>
</html>

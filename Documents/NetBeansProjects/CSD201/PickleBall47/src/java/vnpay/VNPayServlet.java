package vnpay;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet xử lý thanh toán VNPay
 */
@WebServlet(name = "VNPayServlet", urlPatterns = {"/vnpayajax"})
public class VNPayServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 1️⃣ Thiết lập các tham số VNPay
        String vnp_Version = "2.1.0";
        String vnp_Command = "pay";
        String orderType = "other";
        long amount = Integer.parseInt(req.getParameter("amount")) * 100;
        String bankCode = req.getParameter("bankCode");
        String vnp_TxnRef = Config.getRandomNumber(8);
        String vnp_IpAddr = Config.getIpAddress(req);
        String vnp_TmnCode = Config.vnp_TmnCode;

        // 2️⃣ Tạo danh sách tham số
        Map<String, String> vnp_Params = new HashMap<>();
        vnp_Params.put("vnp_Version", vnp_Version);
        vnp_Params.put("vnp_Command", vnp_Command);
        vnp_Params.put("vnp_TmnCode", vnp_TmnCode);
        vnp_Params.put("vnp_Amount", String.valueOf(amount));
        vnp_Params.put("vnp_CurrCode", "VND");

        if (bankCode != null && !bankCode.isEmpty()) {
            vnp_Params.put("vnp_BankCode", bankCode);
        }
        vnp_Params.put("vnp_TxnRef", vnp_TxnRef);
        vnp_Params.put("vnp_OrderInfo", "Thanh toán đơn hàng: " + vnp_TxnRef);
        vnp_Params.put("vnp_OrderType", orderType);
        vnp_Params.put("vnp_Locale", req.getParameter("language") != null ? req.getParameter("language") : "vn");
        vnp_Params.put("vnp_ReturnUrl", Config.vnp_ReturnUrl);
        vnp_Params.put("vnp_IpAddr", vnp_IpAddr);

        // 3️⃣ Xử lý thời gian đơn hàng
        Calendar cld = Calendar.getInstance(TimeZone.getTimeZone("Etc/GMT+7"));
        SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");
        vnp_Params.put("vnp_CreateDate", formatter.format(cld.getTime()));

        cld.add(Calendar.MINUTE, 15);
        vnp_Params.put("vnp_ExpireDate", formatter.format(cld.getTime()));

        // 4️⃣ Tạo chuỗi query URL
        List<String> fieldNames = new ArrayList<>(vnp_Params.keySet());
        Collections.sort(fieldNames);
        StringBuilder hashData = new StringBuilder();
        StringBuilder query = new StringBuilder();

        for (String fieldName : fieldNames) {
    String fieldValue = vnp_Params.get(fieldName);
    if (fieldValue != null && !fieldValue.isEmpty()) {
        // Chuyển charset thành String
        String encodedValue = URLEncoder.encode(fieldValue, StandardCharsets.UTF_8.toString());
        String encodedField = URLEncoder.encode(fieldName, StandardCharsets.UTF_8.toString());

        // Xây dựng chuỗi hash và query
        hashData.append(fieldName).append('=').append(encodedValue);
        query.append(encodedField).append('=').append(encodedValue);
        
        if (!fieldName.equals(fieldNames.get(fieldNames.size() - 1))) {
            hashData.append('&');
            query.append('&');
        }
    }
}

        // 5️⃣ Tạo mã bảo mật và URL thanh toán
        String vnp_SecureHash = Config.hmacSHA512(Config.secretKey, hashData.toString());
        String paymentUrl = Config.vnp_PayUrl + "?" + query.toString() + "&vnp_SecureHash=" + vnp_SecureHash;

        // 🚀 6️⃣ Redirect người dùng đến trang thanh toán VNPay
        resp.sendRedirect(paymentUrl);
    }
}

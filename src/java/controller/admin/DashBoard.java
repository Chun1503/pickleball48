package controller.admin;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import dao.OrderDAO;
import model.Order;
import model.TopProduct;
import java.io.IOException;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/admin/dashboard")
public class DashBoard extends HttpServlet {

    private OrderDAO orderDAO;

    @Override
    public void init() throws ServletException {
        try {
            orderDAO = new OrderDAO();
        } catch (SQLException e) {
            throw new ServletException("Lỗi kết nối database", e);
        }
    }
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            // Lấy tham số 'year' từ request, nếu không có thì mặc định là 2025
            String yearParam = req.getParameter("year");
            int year = (yearParam != null && !yearParam.isEmpty()) ? Integer.parseInt(yearParam) : 2025;

            // Gọi các phương thức DAO để lấy dữ liệu
            List<Map<String, Object>> monthlyRevenue = orderDAO.getMonthlyRevenue(year);
            double yearlyRevenue = orderDAO.getYearlyRevenue();
            double month = orderDAO.getMonthRevenue();
            int totalProducts = orderDAO.getTotalProducts();
            int totalOrders = orderDAO.getTotalOrders();
            List<TopProduct> topProducts = orderDAO.getTopProducts();

            // Đóng gói dữ liệu vào HashMap
            Map<String, Object> responseData = new HashMap<>();
            responseData.put("month", month);
            responseData.put("monthlyRevenue", monthlyRevenue);
            responseData.put("yearlyRevenue", yearlyRevenue);
            responseData.put("totalProducts", totalProducts);
            responseData.put("totalOrders", totalOrders);
            responseData.put("topProducts", topProducts);

            // Chuyển đổi thành JSON
            Gson gson = new GsonBuilder().create();
            String jsonResponse = gson.toJson(responseData);

            // Trả về JSON
            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            resp.getWriter().write(jsonResponse);

        } catch (NumberFormatException e) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid year format");
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Server error");
        }
    }

    

}

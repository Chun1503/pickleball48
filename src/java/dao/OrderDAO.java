package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.Order;
import model.OrderDetail;
import model.TopProduct;

public class OrderDAO {
    private Connection conn;

    public OrderDAO() throws SQLException {
        conn = new DBContext().getConnection();
    }

    public List<Order> getOrders() {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT o.*, a.name AS user_name FROM Orders o JOIN Account a ON o.user_id = a.IDAccount ORDER BY o.created_at DESC";
        
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                int orderId = rs.getInt("order_id");
                int userId = rs.getInt("user_id");
                String userName = rs.getString("user_name");
                double totalPrice = rs.getDouble("total_price");
                String status = rs.getString("status");
                Date createdAt = rs.getTimestamp("created_at");
                                
                Order order = new Order(orderId, userId, totalPrice, status, createdAt);
                order.setUsername(userName);
                orders.add(order);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return orders;
    }
    
    public Order getOrderById(int orderId) {
        Order order = null;
        String sql = "SELECT * FROM Orders WHERE order_id = ?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, orderId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                int userId = rs.getInt("user_id");
                double totalPrice = rs.getDouble("total_price");
                String status = rs.getString("status");
                Date createdAt = rs.getTimestamp("created_at");

                order = new Order(orderId, userId, totalPrice, status, createdAt);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return order;
    }
    
    
    public List<OrderDetail> getOrderDetailsByOrderId(int orderId) {
        List<OrderDetail> orderDetails = new ArrayList<>();
        String sql = "SELECT * FROM Order_Details WHERE order_id = ?";

        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, orderId);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                int orderDetailId = rs.getInt("order_detail_id");
                int productId = rs.getInt("product_id");
                int quantity = rs.getInt("quantity");
                double price = rs.getDouble("price");

                orderDetails.add(new OrderDetail(orderDetailId, orderId, productId, quantity, price));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orderDetails;
    }
    
    public double getMonthRevenue() throws SQLException {
        String sql = "SELECT SUM(total_price) FROM Orders WHERE MONTH(created_at) = MONTH(GETDATE()) AND YEAR(created_at) = YEAR(GETDATE())";
        try (PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            return rs.next() ? rs.getDouble(1) : 0;
        }
    }

    public double getYearlyRevenue() throws SQLException {
        String sql = "SELECT SUM(total_price) FROM Orders WHERE YEAR(created_at) = YEAR(GETDATE())";
        try (PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            return rs.next() ? rs.getDouble(1) : 0;
        }
    }

    // Tổng số hóa đơn (tương đương số đơn đặt hàng)
    public int getTotalOrders() throws SQLException {
        String sql = "SELECT COUNT(*) FROM Orders";
        try (PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            return rs.next() ? rs.getInt(1) : 0;
        }
    }

    // Tổng số tiền của 1000 hóa đơn gần nhất
    public int getTotalProducts() throws SQLException {
        String sql = "SELECT COUNT(*) FROM Products";
        try (PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            return rs.next() ? rs.getInt(1) : 0;
        }
    }
    
    public List<TopProduct> getTopProducts() throws SQLException {
        List<TopProduct> topProducts = new ArrayList<>();
        String sql = "SELECT TOP 5 " +
                     "    od.product_id, " +
                     "    p.name, " +
                     "    SUM(od.quantity) AS total_quantity " +
                     "FROM Order_Details od " +
                     "JOIN Products p ON od.product_id = p.product_id " +
                     "GROUP BY od.product_id, p.name " +
                     "ORDER BY total_quantity DESC; ";

        try (PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                // Đảm bảo lấy đúng tên cột trong SQL query
                topProducts.add(new TopProduct(rs.getString("name"), rs.getInt("total_quantity")));
            }
        }
        return topProducts;
    }
    
    public List<Map<String, Object>> getMonthlyRevenue(Integer year) {
        List<Map<String, Object>> revenueData = new ArrayList<>();
        if (year == null) {
            year = 2025; 
        }

        String sql = "SELECT FORMAT(created_at, 'yyyy-MM') AS Month, SUM(total_price) AS MonthlyRevenue " +
                     "FROM Orders WHERE YEAR(created_at) = ? " +
                     "GROUP BY FORMAT(created_at, 'yyyy-MM') ORDER BY Month ASC";

        try (PreparedStatement stmt = conn.prepareStatement(sql);) {

            stmt.setInt(1, year);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Map<String, Object> data = new HashMap<>();
                data.put("month", rs.getString("Month"));
                data.put("revenue", rs.getDouble("MonthlyRevenue"));
                revenueData.add(data);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return revenueData;
    }


}

package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import model.OrderPayment;
import model.OrderDetail;

// OrderDAO.java
import java.sql.*;
import java.util.*;

public class OrderPaymentDAO {
    private Connection conn;

    public OrderPaymentDAO() throws SQLException {
        this.conn = new DBContext().getConnection();
    }

    public List getListOrderPayment() throws SQLException {
        List<OrderPayment> payments = new ArrayList<>();
        String sql = "SELECT p.payment_id, u.name, p.order_id, p.amount, p.payment_method, p.status, p.created_at FROM Order_Payments p JOIN Account u ON p.user_id = u.IDAccount";
        
        try (PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                payments.add(new OrderPayment(
                    rs.getInt("payment_id"),
                    rs.getString("name"), // Lấy tên thay vì user_id
                    rs.getInt("order_id"),
                    rs.getBigDecimal("amount"),
                    rs.getString("payment_method"),
                    rs.getString("status"),
                    rs.getTimestamp("created_at")
                ));
            }
        }
        return payments;
    }
}

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Order_Details;
import model.Order_Payments;
import model.Orders;

public class OrderDAO extends DBContext {

    public int addOrder(Orders o) {
        String sql = "INSERT INTO Orders(user_id, total_price) VALUES (?, ?)";
        int orderId = -1;

        try {
            PreparedStatement st = getConnection().prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

            st.setInt(1, o.getUser_id());
            st.setDouble(2, o.getTotal_price());

            int affectedRows = st.executeUpdate();

            if (affectedRows > 0) {
                ResultSet rs = st.getGeneratedKeys();
                if (rs.next()) {
                    orderId = rs.getInt(1);
                }
            }

        } catch (Exception ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return orderId;
    }

    public boolean addOrderDetail(List<Order_Details> odList) {
        String sql = "INSERT INTO Order_Details(order_id, product_id, quantity, price) VALUES (?, ?, ?, ?)";

        try {
            PreparedStatement st = getConnection().prepareStatement(sql);

            for (Order_Details od : odList) {
                st.setInt(1, od.getOrder_id());
                st.setInt(2, od.getProduct_id());
                st.setInt(3, od.getQuantity());
                st.setDouble(4, od.getPrice());

                st.addBatch();
            }

            int[] rowsAffected = st.executeBatch();

            return rowsAffected.length == odList.size();
        } catch (Exception ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return false;
    }

    public boolean addPayment(Order_Payments op) {
        String sql = "INSERT INTO Order_Payments(user_id, order_id, amount, payment_method) VALUES (?, ?, ?, ?)";

        try {
            PreparedStatement st = getConnection().prepareStatement(sql);
            st.setInt(1, op.getUser_id());
            st.setInt(2, op.getOrder_id());
            st.setDouble(3, op.getAmount());
            st.setString(4, op.getPayment_method());

            return st.executeUpdate() > 0;
        } catch (Exception ex) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return false;
    }

    public boolean updateOrderStatus(int orderId, String status) {
        String sql = "UPDATE Orders \n"
                + "SET status = ? \n"
                + "WHERE order_id = ?";

        try {
            PreparedStatement st = getConnection().prepareStatement(sql);
            st.setString(1, status);
            st.setInt(2, orderId);

            return st.executeUpdate() > 0;
        } catch (Exception e) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, e);
        }

        return false;
    }

    public boolean updatePaymentStatus(int orderId, String status) {
        String sql = "UPDATE Order_Payments \n"
                + "SET status = ? \n"
                + "WHERE order_id = ?";

        try {
            PreparedStatement st = getConnection().prepareStatement(sql);
            st.setString(1, status);
            st.setInt(2, orderId);

            return st.executeUpdate() > 0;
        } catch (Exception e) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, null, e);
        }

        return false;
    }

    public List<Orders> getListOrderByUserId(int uid, Date date, String status, int limit, int offset) {
        List<Orders> oList = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM Orders WHERE user_id = ?");

        if (date != null) {
            sql.append(" AND CONVERT(date, created_at) = CONVERT(date, ?)");
        }

        if (status != null && !status.isEmpty()) {
            sql.append(" AND status = ?");
        }

        sql.append(" ORDER BY created_at DESC OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");

        try {
            PreparedStatement st = getConnection().prepareStatement(sql.toString());
            int paramIndex = 1;

            st.setInt(paramIndex++, uid);

            if (date != null) {
                st.setDate(paramIndex++, new java.sql.Date(date.getTime()));
            }

            if (status != null && !status.isEmpty()) {
                st.setString(paramIndex++, status);
            }

            st.setInt(paramIndex++, offset);
            st.setInt(paramIndex, limit);

            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Orders o = new Orders();
                o.setOrder_id(rs.getInt("order_id"));
                o.setUser_id(rs.getInt("user_id"));
                o.setTotal_price(rs.getDouble("total_price"));
                o.setStatus(rs.getString("status"));
                o.setCreated_at(rs.getTimestamp("created_at"));
                oList.add(o);
            }
        } catch (Exception e) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.SEVERE, "Error getting orders: " + e.getMessage(), e);
        }
        return oList;
    }

    public List<Order_Payments> getListPaymentByUserId(int uid) {
        List<Order_Payments> opList = new ArrayList<>();
        String sql = "SELECT * FROM Order_Payments WHERE user_id = ?";

        try {
            PreparedStatement st = getConnection().prepareStatement(sql);
            st.setInt(1, uid);

            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Order_Payments op = new Order_Payments();
                op.setPayment_id(rs.getInt("payment_id"));
                op.setUser_id(rs.getShort("user_id"));
                op.setOrder_id(rs.getInt("order_id"));
                op.setAmount(rs.getDouble("amount"));
                op.setPayment_method(rs.getString("payment_method"));
                op.setStatus(rs.getString("status"));
                op.setCreated_at(rs.getTimestamp("created_at"));

                opList.add(op);
            }
        } catch (Exception e) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.WARNING, "Error");
        }

        return opList;
    }

    public Order_Payments getPaymentByOrderId(int oid) {
        Order_Payments op = new Order_Payments();
        String sql = "SELECT * FROM Order_Payments WHERE order_id = ?";

        try {
            PreparedStatement st = getConnection().prepareStatement(sql);
            st.setInt(1, oid);

            ResultSet rs = st.executeQuery();
            while (rs.next()) {

                op.setPayment_id(rs.getInt("payment_id"));
                op.setUser_id(rs.getShort("user_id"));
                op.setOrder_id(rs.getInt("order_id"));
                op.setAmount(rs.getDouble("amount"));
                op.setPayment_method(rs.getString("payment_method"));
                op.setStatus(rs.getString("status"));
                op.setCreated_at(rs.getTimestamp("created_at"));

            }
        } catch (Exception e) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.WARNING, "Error");
        }

        return op;
    }

    public List<Order_Details> getListOrderDetailsByOrderId(int orderId) {
        List<Order_Details> odList = new ArrayList<>();
        String sql = "SELECT * FROM Order_Details WHERE order_id = ?";

        try {
            PreparedStatement st = getConnection().prepareStatement(sql);
            st.setInt(1, orderId);

            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Order_Details od = new Order_Details();
                od.setOrder_detail_id(rs.getInt("order_detail_id"));
                od.setOrder_id(rs.getInt("order_id"));
                od.setProduct_id(rs.getInt("product_id"));
                od.setQuantity(rs.getInt("quantity"));
                od.setPrice(rs.getDouble("price"));
                odList.add(od);
            }
        } catch (Exception e) {
            Logger.getLogger(OrderDAO.class.getName()).log(Level.WARNING, "Error");
        }

        return odList;
    }

    public Orders getOrderById(int oid) {
        Orders o = new Orders();
        String sql = "SELECT * FROM Orders WHERE order_id = ?";

        try {
            PreparedStatement st = getConnection().prepareStatement(sql);
            st.setInt(1, oid);
            ResultSet rs = st.executeQuery();

            if (rs.next()) {
                o.setOrder_id(rs.getInt("order_id"));
                o.setUser_id(rs.getInt("user_id"));
                o.setTotal_price(rs.getDouble("total_price"));
                o.setStatus(rs.getString("status"));
                o.setCreated_at(rs.getTimestamp("created_at"));
            }
        } catch (Exception e) {
            System.out.println(e);
        }

        return o;
    }

    public List<Integer> getListProductIdByOrderId(int oid) {
        List<Integer> pidList = new ArrayList<>();
        String sql = "SELECT product_id  FROM Order_Details WHERE order_id = ?";

        try {
            PreparedStatement st = getConnection().prepareStatement(sql);
            st.setInt(1, oid);
            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                pidList.add(rs.getInt("product_id"));
            }
        } catch (Exception e) {
            System.out.println(e);
        }

        return pidList;
    }

    public static void main(String[] args) {
        OrderDAO dao = new OrderDAO();
//        Orders o = new Orders(1, 1, 10000, "Completed", Timestamp.valueOf(LocalDateTime.now()));
//        System.out.println(dao.addOrder(o, 1));

        Order_Details od = new Order_Details(1, 4, 1, 10, 30000);
        Order_Payments op = new Order_Payments(1, 1, 4, 100000, "bank_transfer", "", Timestamp.valueOf(LocalDateTime.now()));
        System.out.println(dao.getListProductIdByOrderId(27));
//        System.out.println(dao.addOrderDetail(od));
    }
}

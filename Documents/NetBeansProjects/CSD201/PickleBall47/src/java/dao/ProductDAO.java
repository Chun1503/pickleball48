/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Products;

public class ProductDAO extends DBContext {

    public List<Products> getListProductsByListProductId(List<Integer> pid) {
        List<Products> pList = new ArrayList<>();

        StringBuilder sql = new StringBuilder("SELECT * FROM Products WHERE product_id IN (");

        for (int i = 0; i < pid.size(); i++) {
            sql.append("?");
            if (i < pid.size() - 1) {
                sql.append(",");
            }
        }
        sql.append(")");

        try {
            PreparedStatement st = getConnection().prepareStatement(sql.toString());

            for (int i = 0; i < pid.size(); i++) {
                st.setInt(i + 1, pid.get(i));
            }

            ResultSet rs = st.executeQuery();

            while (rs.next()) {
                Products p = new Products();
                p.setProduct_id(rs.getInt("product_id"));
                p.setName(rs.getString("name"));
                p.setDescription(rs.getString("description"));
                p.setPrice(rs.getDouble("price"));
                p.setStock_quantity(rs.getInt("stock_quantity"));
                p.setCreated_at(rs.getTimestamp("created_at"));
                p.setImage(rs.getString("image"));

                pList.add(p);
            }

            rs.close();
            st.close();
        } catch (Exception e) {
            System.out.println(e);
        }

        return pList;
    }

    public List<Products> getAllProduct(int limit, int offset, String name, double price) {
        List<Products> pList = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM Products WHERE stock_quantity > 0");

        if (name != null && !name.isEmpty()) {
            sql.append(" AND name COLLATE Latin1_General_CI_AI LIKE ?");
        }
        if (price > 0) {
            sql.append(" AND price = ?");
        }

        if (limit > 0) {
            sql.append(" ORDER BY product_id OFFSET ? ROWS FETCH NEXT ? ROWS ONLY");
        }

        try {
            PreparedStatement st = getConnection().prepareStatement(sql.toString());
            int paramIndex = 1;

            if (name != null && !name.isEmpty()) {
                st.setString(paramIndex++, "%" + name + "%"); // Không dùng N?
            }

            if (price > 0) {
                st.setDouble(paramIndex++, price);
            }

            if (limit > 0) {
                st.setInt(paramIndex++, offset);
                st.setInt(paramIndex++, limit);
            }

            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Products p = new Products();
                p.setProduct_id(rs.getInt("product_id"));
                p.setName(rs.getString("name"));
                p.setDescription(rs.getString("description"));
                p.setPrice(rs.getDouble("price"));
                p.setStock_quantity(rs.getInt("stock_quantity"));
                p.setCreated_at(rs.getTimestamp("created_at"));
                p.setImage(rs.getString("image"));
                pList.add(p);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return pList;
    }

    public Products getProductById(int id) {
        Products p = new Products();
        String sql = "SELECT * FROM Products WHERE product_id = ?";

        try {
            PreparedStatement st = getConnection().prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                p.setProduct_id(rs.getInt("product_id"));
                p.setName(rs.getString("name"));
                p.setDescription(rs.getString("description"));
                p.setPrice(rs.getDouble("price"));
                p.setStock_quantity(rs.getInt("stock_quantity"));
                p.setCreated_at(rs.getTimestamp("created_at"));
                p.setImage(rs.getString("image"));
            }
        } catch (SQLException ex) {
            Logger.getLogger(RegisteredPickleBallFieldDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return p;
    }

    public boolean updateQuantity(int id, int quantity) {
        String sql = "UPDATE Products \n"
                + "SET stock_quantity = ? \n"
                + "WHERE product_id = ? ";

        try {
            PreparedStatement st = getConnection().prepareStatement(sql);
            st.setInt(1, quantity);
            st.setInt(2, id);

            return st.executeUpdate() > 0;

        } catch (SQLException ex) {
            Logger.getLogger(RegisteredPickleBallFieldDAO.class.getName()).log(Level.SEVERE, null, ex);
        }

        return false;
    }

    public static void main(String[] args) {
        ProductDAO dao = new ProductDAO();
        List<Integer> l = new ArrayList<>();
        l.add(1);
        l.add(2);
        l.add(3);

        System.out.println(dao.getListProductsByListProductId(l).size());
    }
}

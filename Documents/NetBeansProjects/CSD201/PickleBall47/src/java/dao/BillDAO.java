package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Bill;
import model.RegisteredPickleBallField;
import model.Account;

/**
 *
 * @author Minh Trung
 */
public class BillDAO extends DBContext {

    // Thêm một hóa đơn mới vào cơ sở dữ liệu
    public void insertBillWithRegisteredPickleBallField(Bill bill) {
    String sql = "INSERT INTO [dbo].[Bill] ([Invoice], [IDRegisteredPickleBallField], [PaymentDate]) VALUES (?, ?, ?)";
    
    try (Connection conn = getConnection();
         PreparedStatement st = conn.prepareStatement(sql)) {
        
        st.setString(1, bill.getInvoice());
        st.setInt(2, bill.getRegisteredPickleBallField().getIDRegisteredPickleBallField());
        st.setString(3, bill.getPaymentDate());

        int rowsAffected = st.executeUpdate();
        if (rowsAffected > 0) {
            System.out.println("✅ Bill đã được thêm vào database thành công!");
        } else {
            System.out.println("⚠️ Không có Bill nào được thêm!");
        }
    } catch (SQLException e) {
        System.out.println("❌ Lỗi khi thêm Bill vào database: " + e.getMessage());
        e.printStackTrace();
    }
}
    public void insertBillWithRegisteredPickleBallField1(Bill bill) {
    String sql = "INSERT INTO [dbo].[Bill] ([Invoice], [IDRegisteredPickleBallField], [PaymentDate], [TotalPrice]) VALUES (?, ?, ?, ?)";
    
    try (Connection conn = getConnection();
         PreparedStatement st = conn.prepareStatement(sql)) {
        
        st.setString(1, bill.getInvoice());
        st.setInt(2, bill.getRegisteredPickleBallField().getIDRegisteredPickleBallField());
        st.setString(3, bill.getPaymentDate());
        st.setDouble(4, bill.getTotalPrice()); // Thêm totalPrice vào câu lệnh SQL

        int rowsAffected = st.executeUpdate();
        if (rowsAffected > 0) {
            System.out.println("✅ Bill đã được thêm vào database thành công!");
        } else {
            System.out.println("⚠️ Không có Bill nào được thêm!");
        }
    } catch (SQLException e) {
        System.out.println("❌ Lỗi khi thêm Bill vào database: " + e.getMessage());
        e.printStackTrace();
    }
}


    // Cập nhật tổng số tiền của hóa đơn
    public void updateTotalPrice(int idBill, double totalPrice) {
        String sql = "UPDATE [dbo].[Bill]\n"
                + "   SET [TotalPrice] = ?\n"
                + " WHERE IDBill = ?";
        try {
            PreparedStatement st = getConnection().prepareStatement(sql);
            st.setDouble(1, totalPrice);
            st.setInt(2, idBill);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    // Cập nhật IDAccount2 của hóa đơn
    public void updateIDAccount2(int idBill, int idAcc2) {
        String sql = "UPDATE [dbo].[Bill]\n"
                + "   SET [IDAccount2] = ?\n"
                + " WHERE IDBill = ?";
        try {
            PreparedStatement st = getConnection().prepareStatement(sql);
            st.setInt(1, idAcc2);
            st.setInt(2, idBill);
            st.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    // Kiểm tra xem một hóa đơn có tồn tại hay không dựa trên IDBill
    public boolean checkIDBill(int id) {
        String sql = "SELECT [IDBill]\n"
                + "  FROM [dbo].[Bill] WHERE IDBill = ?";
        try {
            PreparedStatement st = getConnection().prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return true;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }

    // Lấy danh sách tất cả các hóa đơn
    public List<Bill> getBills() {
        List<Bill> list = new ArrayList<>();
        String sql = "SELECT [IDBill]\n"
                + "      ,[Invoice]\n"
                + "      ,[IDRegisteredPickleBallField]\n"
                + "      ,[IDAccount2]\n"
                + "      ,[PaymentDate]\n"
                + "      ,[TotalPrice]\n"
                + "  FROM [dbo].[Bill]";
        try {
            PreparedStatement st = getConnection().prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                int IDBill = rs.getInt("IDBill");
                String Invoice = rs.getString("Invoice");
                int IDRegisteredPickleBallField = rs.getInt("IDRegisteredPickleBallField");
                int IDAccount2 = rs.getInt("IDAccount2");
                String PaymentDate = rs.getString("PaymentDate");
                double TotalPrice = rs.getDouble("TotalPrice");

                // Lấy thông tin RegisteredPickleBallField và Account từ các DAO tương ứng
                RegisteredPickleBallFieldDAO rPFD = new RegisteredPickleBallFieldDAO();
                AccountDAO accountDAO = new AccountDAO();

                RegisteredPickleBallField registeredPickleBallField = rPFD.getRegisteredPickleBallFieldByID(IDRegisteredPickleBallField);
                Account account2 = accountDAO.getAccountByID(IDAccount2);

                Bill bill = new Bill(IDBill, Invoice, registeredPickleBallField, account2, PaymentDate, TotalPrice);
                list.add(bill);
            }
        } catch (SQLException ex) {
            Logger.getLogger(BillDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    // Lấy danh sách hóa đơn theo IDAccount2
    public List<Bill> getBillsByIDAccount2(int idAccount2) {
        List<Bill> list = new ArrayList<>();
        String sql = "SELECT [IDBill]\n"
                + "      ,[Invoice]\n"
                + "      ,[IDRegisteredPickleBallField]\n"
                + "      ,[IDAccount2]\n"
                + "      ,[PaymentDate]\n"
                + "      ,[TotalPrice]\n"
                + "  FROM [dbo].[Bill] WHERE [IDAccount2] = ?";
        try {
            PreparedStatement st = getConnection().prepareStatement(sql);
            st.setInt(1, idAccount2);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                int IDBill = rs.getInt("IDBill");
                String Invoice = rs.getString("Invoice");
                int IDRegisteredPickleBallField = rs.getInt("IDRegisteredPickleBallField");
                int IDAccount2 = rs.getInt("IDAccount2");
                String PaymentDate = rs.getString("PaymentDate");
                double TotalPrice = rs.getDouble("TotalPrice");

                // Lấy thông tin RegisteredPickleBallField và Account từ các DAO tương ứng
                RegisteredPickleBallFieldDAO rPFD = new RegisteredPickleBallFieldDAO();
                AccountDAO accountDAO = new AccountDAO();

                RegisteredPickleBallField registeredPickleBallField = rPFD.getRegisteredPickleBallFieldByID(IDRegisteredPickleBallField);
                Account account2 = accountDAO.getAccountByID(IDAccount2);

                Bill bill = new Bill(IDBill, Invoice, registeredPickleBallField, account2, PaymentDate, TotalPrice);
                list.add(bill);
            }
        } catch (SQLException ex) {
            Logger.getLogger(BillDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    // Lấy hóa đơn theo IDBill
    public Bill getBillByID(int id) {
        String sql = "SELECT [IDBill]\n"
                + "      ,[Invoice]\n"
                + "      ,[IDRegisteredPickleBallField]\n"
                + "      ,[IDAccount2]\n"
                + "      ,[PaymentDate]\n"
                + "      ,[TotalPrice]\n"
                + "  FROM [dbo].[Bill] WHERE IDBill = ?";
        try {
            PreparedStatement st = getConnection().prepareStatement(sql);
            st.setInt(1, id);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                int IDBill = rs.getInt("IDBill");
                String Invoice = rs.getString("Invoice");
                int IDRegisteredPickleBallField = rs.getInt("IDRegisteredPickleBallField");
                int IDAccount2 = rs.getInt("IDAccount2");
                String PaymentDate = rs.getString("PaymentDate");
                double TotalPrice = rs.getDouble("TotalPrice");

                // Lấy thông tin RegisteredPickleBallField và Account từ các DAO tương ứng
                RegisteredPickleBallFieldDAO rPFD = new RegisteredPickleBallFieldDAO();
                AccountDAO accountDAO = new AccountDAO();

                RegisteredPickleBallField registeredPickleBallField = rPFD.getRegisteredPickleBallFieldByID(IDRegisteredPickleBallField);
                Account account2 = accountDAO.getAccountByID(IDAccount2);

                return new Bill(IDBill, Invoice, registeredPickleBallField, account2, PaymentDate, TotalPrice);
            }
        } catch (SQLException ex) {
            Logger.getLogger(BillDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    // Lấy hóa đơn theo Invoice
    public Bill getBillByInvoice(String invoice) {
        String sql = "SELECT [IDBill]\n"
                + "      ,[Invoice]\n"
                + "      ,[IDRegisteredPickleBallField]\n"
                + "      ,[IDAccount2]\n"
                + "      ,[PaymentDate]\n"
                + "      ,[TotalPrice]\n"
                + "  FROM [dbo].[Bill] WHERE Invoice = ?";
        try {
            PreparedStatement st = getConnection().prepareStatement(sql);
            st.setString(1, invoice);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                int IDBill = rs.getInt("IDBill");
                String Invoice = rs.getString("Invoice");
                int IDRegisteredPickleBallField = rs.getInt("IDRegisteredPickleBallField");
                int IDAccount2 = rs.getInt("IDAccount2");
                String PaymentDate = rs.getString("PaymentDate");
                double TotalPrice = rs.getDouble("TotalPrice");

                // Lấy thông tin RegisteredPickleBallField và Account từ các DAO tương ứng
                RegisteredPickleBallFieldDAO rPFD = new RegisteredPickleBallFieldDAO();
                AccountDAO accountDAO = new AccountDAO();

                RegisteredPickleBallField registeredPickleBallField = rPFD.getRegisteredPickleBallFieldByID(IDRegisteredPickleBallField);
                Account account2 = accountDAO.getAccountByID(IDAccount2);

                return new Bill(IDBill, Invoice, registeredPickleBallField, account2, PaymentDate, TotalPrice);
            }
        } catch (SQLException ex) {
            Logger.getLogger(BillDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }

    // Lấy IDBill lớn nhất (last index)
    public int getIDBillLastIndex() {
        String sql = "SELECT TOP 1 [IDBill] FROM [dbo].[Bill] ORDER BY [IDBill] DESC";
        try {
            PreparedStatement st = getConnection().prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt("IDBill");
            }
        } catch (SQLException ex) {
            Logger.getLogger(BillDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return -1;
    }
       public List<Bill> getBillsByAdminFromdateTodate(String ngayFrom, String ngayTo) {
        List<Bill> list = new ArrayList<>();
        RegisteredPickleBallFieldDAO rPFD = new RegisteredPickleBallFieldDAO();
        AccountDAO accountDAO = new AccountDAO();
        String sql = "SELECT [IDBill]\n"
                + "      ,[Invoice]\n"
                + "      ,[IDRegisteredPickleBallField]\n"
                + "      ,[IDAccount2]\n"
                + "      ,[PaymentDate]\n"
                + "      ,[TotalPrice]\n"
                + "FROM [dbo].[Bill]\n"
                + "WHERE CAST(PaymentDate AS date) BETWEEN ? AND ?";
        try {
            PreparedStatement st = getConnection().prepareStatement(sql);
            st.setString(1, ngayFrom);
            st.setString(2, ngayTo);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                int IDBill = rs.getInt("IDBill");
                String Invoice = rs.getString("Invoice");
                int IDRegisteredPickleBallField = rs.getInt("IDRegisteredPickleBallField");
                int IDAccount2 = rs.getInt("IDAccount2");
                String PaymentDate = rs.getString("PaymentDate");
                double TotalPrice = rs.getDouble("TotalPrice");

                // Lấy thông tin RegisteredPickleBallField và Account từ các DAO tương ứng
                RegisteredPickleBallField registeredPickleBallField = rPFD.getRegisteredPickleBallFieldByID(IDRegisteredPickleBallField);
                Account account2 = accountDAO.getAccountByID(IDAccount2);

                Bill bill = new Bill(IDBill, Invoice, registeredPickleBallField, account2, PaymentDate, TotalPrice);
                list.add(bill);
            }
        } catch (SQLException ex) {
            Logger.getLogger(BillDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    // Thêm phương thức getBillsByIDAccount2FromdateTodate
    public List<Bill> getBillsByIDAccount2FromdateTodate(int idAccount2, String ngayFrom, String ngayTo) {
        List<Bill> list = new ArrayList<>();
        RegisteredPickleBallFieldDAO rPFD = new RegisteredPickleBallFieldDAO();
        AccountDAO accountDAO = new AccountDAO();
        String sql = "SELECT [IDBill]\n"
                + "      ,[Invoice]\n"
                + "      ,[IDRegisteredPickleBallField]\n"
                + "      ,[IDAccount2]\n"
                + "      ,[PaymentDate]\n"
                + "      ,[TotalPrice]\n"
                + "FROM [dbo].[Bill]\n"
                + "WHERE CAST(PaymentDate AS date) BETWEEN ? AND ? AND IDAccount2 = ?";
        try {
            PreparedStatement st = getConnection().prepareStatement(sql);
            st.setString(1, ngayFrom);
            st.setString(2, ngayTo);
            st.setInt(3, idAccount2);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                int IDBill = rs.getInt("IDBill");
                String Invoice = rs.getString("Invoice");
                int IDRegisteredPickleBallField = rs.getInt("IDRegisteredPickleBallField");
                int IDAccount2 = rs.getInt("IDAccount2");
                String PaymentDate = rs.getString("PaymentDate");
                double TotalPrice = rs.getDouble("TotalPrice");

                // Lấy thông tin RegisteredPickleBallField và Account từ các DAO tương ứng
                RegisteredPickleBallField registeredPickleBallField = rPFD.getRegisteredPickleBallFieldByID(IDRegisteredPickleBallField);
                Account account2 = accountDAO.getAccountByID(IDAccount2);

                Bill bill = new Bill(IDBill, Invoice, registeredPickleBallField, account2, PaymentDate, TotalPrice);
                list.add(bill);
            }
        } catch (SQLException ex) {
            Logger.getLogger(BillDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        return list;
    }

    

    // Phương thức main để test
    public static void main(String[] args) {
        BillDAO billDAO = new BillDAO();
        List<Bill> bills = billDAO.getBills();
        for (Bill bill : bills) {
            System.out.println(bill.toString());
        }
    }
}
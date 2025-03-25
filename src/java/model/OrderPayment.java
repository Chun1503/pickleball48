package model;

import java.math.BigDecimal;
import java.sql.Timestamp;

public class OrderPayment {
    private int paymentId;
    private String userName; // Lấy từ bảng Users
    private int orderId;
    private BigDecimal amount;
    private String paymentMethod;
    private String status;
    private Timestamp createdAt;

    public OrderPayment() {
    }

    public OrderPayment(int paymentId, String userName, int orderId, BigDecimal amount, String paymentMethod, String status, Timestamp createdAt) {
        this.paymentId = paymentId;
        this.userName = userName;
        this.orderId = orderId;
        this.amount = amount;
        this.paymentMethod = paymentMethod;
        this.status = status;
        this.createdAt = createdAt;
    }

    public int getPaymentId() {
        return paymentId;
    }

    public void setPaymentId(int paymentId) {
        this.paymentId = paymentId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public BigDecimal getAmount() {
        return amount;
    }

    public void setAmount(BigDecimal amount) {
        this.amount = amount;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }
}

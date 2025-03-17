/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.security.Timestamp;

/**
 *
 * @author Minh Trung
 */
public class Bill {
    private int IDBill;
    private String Invoice;
    private RegisteredPickleBallField RegisteredPickleBallField;
    private Account Account2;;
    private String PaymentDate;
    private double TotalPrice;
    public Bill() {
    }


    public Bill(int IDBill, String Invoice, RegisteredPickleBallField RegisteredPickleBallField, Account Account2, String PaymentDate, double TotalPrice) {
        this.IDBill = IDBill;
        this.Invoice = Invoice;
        this.RegisteredPickleBallField = RegisteredPickleBallField;
        this.Account2 = Account2;
        this.PaymentDate = PaymentDate;
        this.TotalPrice = TotalPrice;
    }

    public int getIDBill() {
        return IDBill;
    }

    public void setIDBill(int IDBill) {
        this.IDBill = IDBill;
    }

    public String getInvoice() {
        return Invoice;
    }

    public void setInvoice(String Invoice) {
        this.Invoice = Invoice;
    }

    public RegisteredPickleBallField getRegisteredPickleBallField() {
        return RegisteredPickleBallField;
    }

    public void setRegisteredPickleBallField(RegisteredPickleBallField RegisteredPickleBallField) {
        this.RegisteredPickleBallField = RegisteredPickleBallField;
    }

    public Account getAccount2() {
        return Account2;
    }

    public void setAccount2(Account Account2) {
        this.Account2 = Account2;
    }

    public String getPaymentDate() {
        return PaymentDate;
    }

    public void setPaymentDate(String PaymentDate) {
        this.PaymentDate = PaymentDate;
    }

    public double getTotalPrice() {
        return TotalPrice;
    }

    public void setTotalPrice(double TotalPrice) {
        this.TotalPrice = TotalPrice;
    }
}
    
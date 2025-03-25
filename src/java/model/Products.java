/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package model;

import java.sql.Timestamp;

//import java.security.Timestamp;
public class Products {
    private int product_id;
    private String name;
    private String description;
    private double price;
    private int stock_quantity;
    private Timestamp created_at;
    private String image;

   public Products() {
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public Products(int product_id, String name, String description, double price, int stock_quantity, Timestamp created_at, String image) {
        this.product_id = product_id;
        this.name = name;
        this.description = description;
        this.price = price;
        this.stock_quantity = stock_quantity;
        this.created_at = created_at; 
        this.image = image;
    }
    public int getProduct_id() { return product_id; }
    public void setProduct_id(int product_id) { this.product_id = product_id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public int getStock_quantity() { return stock_quantity; }
    public void setStock_quantity(int stock_quantity) { this.stock_quantity = stock_quantity; }

    public Timestamp getCreated_at() { return created_at; }
    public void setCreated_at(Timestamp created_at) { this.created_at = created_at; }
}


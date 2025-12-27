package com.equrban.models;

import java.sql.Timestamp;

public class Order {

    private int orderId;
    private int userId;
    private Timestamp orderDate;
    private double totalAmount;
    private String status;
    private String notes;

    // TAMBAHAN
    private String animalName;

    // ===== GETTER =====
    public int getOrderId() {
        return orderId;
    }

    public int getUserId() {
        return userId;
    }

    public Timestamp getOrderDate() {
        return orderDate;
    }

    public double getTotalAmount() {
        return totalAmount;
    }

    public String getStatus() {
        return status;
    }

    public String getNotes() {
        return notes;
    }

    public String getAnimalName() {
        return animalName;
    }

    // ===== SETTER =====
    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public void setOrderDate(Timestamp orderDate) {
        this.orderDate = orderDate;
    }

    public void setTotalAmount(double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public void setAnimalName(String animalName) {
        this.animalName = animalName;
    }
}

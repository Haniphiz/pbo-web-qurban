package com.equban.config;

import java.sql.Connection;
import java.sql.DriverManager;

public class Database {
    
    private static final String URL = "jdbc:postgresql://localhost:5432/db_kurban";
    private static final String USER = "postgres";
    private static final String PASSWORD = "hanip10";

    public static Connection getConnection() {
        Connection conn = null;
        try {
            Class.forName("org.postgresql.Driver");
            conn = DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (Exception e) {
            System.out.println("Koneksi gagal: " + e.getMessage());
        }
        return conn;
    }
}

package com.equrban.dao;

import com.equrban.config.Database;
import com.equrban.models.Animal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class AnimalDAO {

    // 🔹 UNTUK KATALOG
    public List<Animal> getAllAnimals() {
        List<Animal> animals = new ArrayList<>();
        String sql = "SELECT * FROM animals WHERE status = 'available'";

        try (Connection conn = Database.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql); ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Animal animal = new Animal();
                animal.setAnimal_id(rs.getInt("animal_id"));
                animal.setName(rs.getString("name"));
                animal.setPrice(rs.getDouble("price"));
                animal.setPhoto(rs.getString("photo"));
                animal.setDescription(rs.getString("description"));
                animals.add(animal);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return animals;
    }

    // 🔹 UNTUK DETAIL
    public Animal getAnimalById(int id) {
        Animal animal = null;
        String sql = "SELECT * FROM animals WHERE animal_id = ?";

        try (Connection conn = Database.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                animal = new Animal();
                animal.setAnimal_id(rs.getInt("animal_id"));
                animal.setName(rs.getString("name"));
                animal.setAge(rs.getInt("age"));           // ✅ INI KUNCI
                animal.setWeight(rs.getDouble("weight")); 
                animal.setPrice(rs.getDouble("price"));
                animal.setPhoto(rs.getString("photo"));
                animal.setDescription(rs.getString("description"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return animal;
    }

    public boolean insertAnimal(Animal animal) {
        String sql = "INSERT INTO animals "
                + "(category_id, name, age, weight, price, stock, description, photo, status) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, 'available')";

        try (Connection conn = Database.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, animal.getCategory_id()); // ❌ JANGAN SALAH URUT
            stmt.setString(2, animal.getName());
            stmt.setInt(3, animal.getAge());
            stmt.setDouble(4, animal.getWeight());
            stmt.setDouble(5, animal.getPrice());
            stmt.setInt(6, animal.getStock());
            stmt.setString(7, animal.getDescription());
            stmt.setString(8, animal.getPhoto());

            return stmt.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean reduceStock(int animalId, int qty) {
        String sql
                = "UPDATE animals "
                + "SET stock = stock - ? "
                + "WHERE animal_id = ? AND stock >= ?";

        try (Connection conn = Database.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, qty);
            stmt.setInt(2, animalId);
            stmt.setInt(3, qty);

            return stmt.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    public void updateStatusIfSold(int animalId) {
        String sql
                = "UPDATE animals SET status = 'sold' "
                + "WHERE animal_id = ? AND stock = 0";

        try (Connection conn = Database.getConnection(); PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, animalId);
            stmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}

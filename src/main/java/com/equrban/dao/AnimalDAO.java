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

        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

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

        try (Connection conn = Database.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                animal = new Animal();
                animal.setAnimal_id(rs.getInt("animal_id"));
                animal.setName(rs.getString("name"));
                animal.setPrice(rs.getDouble("price"));
                animal.setPhoto(rs.getString("photo"));
                animal.setDescription(rs.getString("description"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return animal;
    }
}

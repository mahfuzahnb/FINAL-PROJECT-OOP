/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

import java.sql.ResultSet;
import java.sql.SQLException;

// src/models/Admin.java
public class Admin extends User {
    public Admin() {
        super();
        this.table = "admins";
        this.primaryKey = "id";
    }
    
    public Admin(int id, String username, String password) {
        this();
        this.id = id;
        this.username = username;
        this.password = password;
    }

    @Override
    public Admin toModel(ResultSet rs) {
        try {
            return new Admin(
                rs.getInt("id"),
                rs.getString("username"),
                rs.getString("password")
            );
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
            return null;
        }
    }

    public void insertAdmin() {
        try {
            // Step 1: Insert data ke tabel users
            User user = new User();
            user.setUsername(this.getUsername());
            user.setPassword(this.getPassword());
            user.setRole("admin");
            System.out.println("Inserting into users table...");

            // Cek apakah username sudah ada di tabel users
            if (!user.usernameExists(user.getUsername())) {
                user.insert();
                
                // Get the ID of the newly inserted user
                user.where("username = '" + this.getUsername() + "'");
                User insertedUser = user.get().get(0);
                
                // Set the ID for admin
                this.setId(insertedUser.getId());
                
                // Step 2: Insert data ke tabel admins
                System.out.println("Inserting into admins table...");
                this.insert();
                System.out.println("Successfully inserted into admins table.");
            } else {
                System.out.println("Username already exists in users table.");
                return;
            }

        } catch (Exception e) {
            System.out.println("Error inserting admin: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
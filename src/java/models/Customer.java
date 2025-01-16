/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package models;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.sql.PreparedStatement;

public class Customer extends User {
    private String email;
    private String name;
    private String phone;
    private String address;
    private double saldo;
    
    public Customer() {
        super();
        this.table = "customers";
        this.primaryKey = "id";
    }

    public Customer(String email, String name, String phone, String address, int id, String username, String password, double saldo) {
        this();
        this.id = id;
        this.username=username;
        this.password=password;
        this.email = email;
        this.name = name;
        this.phone = phone;
        this.address = address;
        this.saldo = saldo;
    }


    @Override
    public Customer toModel(ResultSet rs) {
        try {
            return new Customer(
                rs.getString("email"),
                rs.getString("name"),
                rs.getString("phone"),
                rs.getString("address"),
                rs.getInt("id"),
                rs.getString("username"),
                rs.getString("password"),
                rs.getDouble("saldo")
            );
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
            return null;
        }
    }

    // Tambahan method untuk insert ke dua tabel
    public void insertCustomer() {
        try {
            System.out.println("Starting customer registration process...");

            // Insert ke tabel users
            User user = new User();
            user.setUsername(this.getUsername());
            user.setPassword(this.getPassword());
            user.setRole("customer");
            System.out.println("Inserting into users table...");
            user.insert();
            System.out.println("Successfully inserted into users table.");

            // Insert ke tabel customers
            Customer customer = new Customer();
            customer.setId(this.getId());
            customer.setUsername(this.getUsername());
            customer.setPassword(this.getPassword());
            customer.setEmail(this.getEmail() != null ? this.getAddress() : "");
            customer.setName(this.getName()  != null ? this.getAddress() : "");
            customer.setAddress(this.getAddress() != null ? this.getAddress() : "");
            customer.setPhone(this.getPhone() != null ? this.getPhone() : "");
            
            System.out.println("Inserting into customers table...");
            customer.insert();
            System.out.println("Successfully inserted into customers table.");

            System.out.println("Customer registration completed.");
        } catch (Exception e) {
            System.out.println("Error in insertCustomer: " + e.getMessage());
        }
    }

    public ArrayList<Customer> getAllCustomers() {
        ArrayList<Customer> customers = new ArrayList<>();
        try {
            this.connect();
            String query = "SELECT * FROM " + table;
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next()) {
                customers.add(toModel(rs));
            }
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        } finally {
            disconnect();
        }
        return customers;
    }
    // In src/models/Customer.java
    public Customer getCustomerByUsername(String username) {
        try {
            this.connect();
            String query = "SELECT * FROM " + table + " WHERE username = '" + username + "'";
            ResultSet rs = stmt.executeQuery(query);
            if (rs.next()) {
                return toModel(rs);
            }
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        } finally {
            disconnect();
        }
        return null;
    }    

    
    public void minSaldo(String username, double amount, double saldoAwal) {
            updateSaldo(username, saldoAwal-amount);
            System.out.println("Saldo : " + this.saldo);
    }
    
    public String getUsernameById(int id) {
        try {
            this.connect();
            String query = "SELECT username FROM " + table + " WHERE id = " + id;
            ResultSet rs = stmt.executeQuery(query);
            if (rs.next()) {
                return rs.getString("username");
            }
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        } finally {
            disconnect();
        }  
        return null;
    }
    
    @Override
    public int getId() {
        return id;
    }

    @Override
    public void setId(int id) {
        this.id = id;
    }

    @Override
    public String getUsername() {
        return username;
    }

    @Override
    public void setUsername(String username) {
        this.username = username;
    }

    @Override
    public String getPassword() {
        return password;
    }

    @Override
    public void setPassword(String password) {
        this.password = password;
    }

    @Override
    public String getRole() {
        return role;
    }

    @Override
    public void setRole(String role) {
        this.role = role;
    }
    
    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public double getSaldo() {
        return saldo;
    }

    public void setSaldo(double saldo) {
        this.saldo = saldo;
    }
    
    public boolean addSaldo(String username, double amount) {
        if (amount > 0) {
            this.saldo += amount;
            updateSaldo(username, this.saldo);
        }
        return true;
    }

    
    public boolean minSaldo(String username, double amount) {
        if (amount > 0) {
            this.saldo -= amount;
            updateSaldo(username, this.saldo);
        }
        return true;
    }

    public Customer updateSaldo(String username, double saldo) {

        try {
            this.connect();
            String query = "UPDATE customers SET saldo = ? WHERE username = ?";
            PreparedStatement ps = con.prepareStatement(query);
            ps.setDouble(1, saldo);
            ps.setString(2, username);
            int rowsUpdated = ps.executeUpdate();
            if (rowsUpdated > 0) {
                System.out.println("Saldo berhasil diperbarui untuk user: " + username);
            } else {
                System.out.println("Gagal memperbarui saldo. Username tidak ditemukan.");
            }
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        } finally {
            disconnect();
        }
        return null;
    }
    
  public boolean updateProfile(String username, String name, String email, String phone, String address, String password, int id) {
    try {
        this.connect();
        
        // Update user
        User userModel = new User();
        userModel.setId(id);
        userModel.setUsername(username);
        userModel.setPassword(password);
        userModel.update();
        
        // Update Customer
        String query = "UPDATE customers SET username = ?, name = ?, email = ?, phone = ?, address = ?, password = ? WHERE id = ?";
        PreparedStatement ps = con.prepareStatement(query);
        ps.setString(1, username);
        ps.setString(2, name);
        ps.setString(3, email);
        ps.setString(4, phone);
        ps.setString(5, address);
        ps.setString(6, password);
        ps.setInt(7, id);
        ps.executeUpdate();
        return true;
    } catch (SQLException e) {
        System.out.println("Error: " + e.getMessage());
        return false;
    } finally {
        disconnect();
    }
}

    public double getSaldoByCustomerId(int customerId) {
      double saldo = 0;
      try {
          this.connect();
          String query = "SELECT saldo FROM " + table + " WHERE " + primaryKey + " = ?";
          PreparedStatement ps = con.prepareStatement(query);
          ps.setInt(1, customerId);
          ResultSet rs = ps.executeQuery();
          if (rs.next()) {
              saldo = rs.getDouble("saldo");
          }
      } catch (SQLException e) {
          System.out.println("Error fetching saldo: " + e.getMessage());
      } finally {
          disconnect();
      }
      return saldo;
  }


}


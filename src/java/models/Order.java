package models;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;

public class Order extends Model{
    private int orderId;
    private int serviceId;
    private int customerId;
    private String fullName;
    private String phoneNumber;
    private String location;
    private String notes;
//    private enum status{"pending", "confirmed", "cancel"};
    private String status;
    private double saldoEWallet;
    private String paymentMethod;
    private String duration;
    private double servicePrice;
    private Date scheduleDate;

    public Order() {
        this.table = "orders";
        this.primaryKey = "orderId";
    }

    public Order(int orderId, int customerId, int serviceId, String fullName, String phoneNumber, String location,
                 String notes, String status, double saldoEWallet, String paymentMethod, String duration,
                 double servicePrice, Date scheduleDate) {
        this.table = "orders";
        this.primaryKey = "orderId";
        this.orderId = orderId;
        this.customerId = customerId;
        this.serviceId = serviceId;
        this.fullName = fullName;
        this.phoneNumber = phoneNumber;
        this.location = location;
        this.notes = notes;
        this.status = status;
        this.saldoEWallet = saldoEWallet;
        this.paymentMethod = paymentMethod;
        this.duration = duration;
        this.servicePrice = servicePrice;
        this.scheduleDate = scheduleDate;
    }

    @Override
    public Order toModel(ResultSet rs) {
        try {
            return new Order(
                rs.getInt("orderId"),
                rs.getInt("customerId"),
                rs.getInt("serviceId"),
                rs.getString("fullName"),
                rs.getString("phoneNumber"),
                rs.getString("location"),
                rs.getString("notes"),
                rs.getString("status"),
                rs.getDouble("saldoEWallet"),
                rs.getString("paymentMethod"),
                rs.getString("duration"),
                rs.getDouble("servicePrice"),
                rs.getDate("scheduleDate")
            );
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
            return null;
        }
    }
    // Metode untuk menemukan order berdasarkan orderId

    public Order findOrder(int orderId) {

        try {

            connect();

            String query = "SELECT * FROM " + table + " WHERE " + primaryKey + " = " + orderId;

            ResultSet rs = stmt.executeQuery(query);

            if (rs.next()) {

                return toModel(rs); // Mengonversi ResultSet menjadi objek Order

            }

        } catch (SQLException e) {

            System.out.println("Error fetching order: " + e.getMessage());

        } finally {

            disconnect();

        }

        return null; // Kembalikan null jika tidak ditemukan

    }
    public ArrayList<Order> getAllOrders() {
        ArrayList<Order> orders = new ArrayList<>();
        try {
            connect();
            String query = "SELECT * FROM " + table; // Ambil semua data dari tabel orders
            ResultSet rs = stmt.executeQuery(query);
            while (rs.next()) {
                orders.add(toModel(rs));
            }
        } catch (SQLException e) {
            System.out.println("Error: " + e.getMessage());
        } finally {
            disconnect();
        }
        return orders;
    }
    

    // Getter dan Setter
    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getServiceId() {
        return serviceId;
    }

    public void setServiceId(int serviceId) {
        this.serviceId = serviceId;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public double getSaldoEWallet() {
        return saldoEWallet;
    }

    public void setSaldoEWallet(double saldoEWallet) {
        this.saldoEWallet = saldoEWallet;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public String getDuration() {
        return duration;
    }

    public void setDuration(String duration) {
        this.duration = duration;
    }

    public double getServicePrice() {
        return servicePrice;
    }

    public void setServicePrice(double servicePrice) {
        this.servicePrice = servicePrice;
    }

    public Date getScheduleDate() {
        return scheduleDate;
    }

    public void setScheduleDate(Date scheduleDate) {
        this.scheduleDate = scheduleDate;
    }

}

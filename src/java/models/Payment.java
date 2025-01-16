package models;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import java.util.ArrayList;

public class Payment extends Model<Payment> {
    // Atribut
    private int paymentId;
    private int orderId;
    private int customerId;
    private String paymentMethod;
    private double priceLayanan;
    private double saldoEWallet;
    private double totalPembayaran;
    private String paymentDate;

    // Konstruktor tanpa parameter
    public Payment() {
        this.table = "payments";
        this.primaryKey = "paymentId";
    }

    // Konstruktor dengan parameter
    public Payment(int paymentId, int orderId, int customerId, String paymentMethod, double priceLayanan, double saldoEWallet, double totalPembayaran, String paymentDate) {
        if (paymentId < 0 || orderId < 0 || customerId < 0 || priceLayanan < 0 || saldoEWallet < 0 || totalPembayaran < 0) {
            throw new IllegalArgumentException("Values must be positive.");
        }

        this.table = "payments";
        this.primaryKey = "paymentId";
        this.paymentId = paymentId;
        this.orderId = orderId;
        this.customerId = customerId;
        this.paymentMethod = paymentMethod;
        this.priceLayanan = priceLayanan;
        this.saldoEWallet = saldoEWallet;
        this.totalPembayaran = totalPembayaran;
        this.paymentDate = paymentDate;
    }

    /**
     * Mengonversi ResultSet menjadi objek Payment.
     *
     * @param rs ResultSet dari database.
     * @return Objek Payment.
     */
    @Override
    public Payment toModel(ResultSet rs) {
        try {
            return new Payment(
                rs.getInt("paymentId"),
                rs.getInt("orderId"),
                rs.getInt("customerId"),
                rs.getString("paymentMethod"),
                rs.getDouble("priceLayanan"),
                rs.getDouble("saldoEWallet"),
                rs.getDouble("totalPembayaran"),
                rs.getString("paymentDate")
            );
        } catch (SQLException e) {
            System.out.println("Error mapping ResultSet to Payment: " + e.getMessage());
            return null;
        }
    }
    
    public ArrayList<Payment> findByCustomerId(int customerId) {

        ArrayList<Payment> payments = new ArrayList<>();

        try {

            connect();

            String query = "SELECT * FROM " + table + " WHERE customerId = " + customerId; // Menggunakan int langsung

            ResultSet rs = stmt.executeQuery(query);

            while (rs.next()) {

                payments.add(toModel(rs));

            }

        } catch (SQLException e) {

            System.out.println("Error fetching payments: " + e.getMessage());

        } finally {

            disconnect();

        }

        return payments;

    }

    // Getter dan Setter
    public int getPaymentId() {
        return paymentId;
    }

    public void setPaymentId(int paymentId) {
        this.paymentId = paymentId;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getCustomerId() {
        return customerId;
    }

    public void setCustomerId(int customerId) {
        this.customerId = customerId;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public double getPriceLayanan() {
        return priceLayanan;
    }

    public void setPriceLayanan(double priceLayanan) {
        this.priceLayanan = priceLayanan;
    }

    public double getSaldoEWallet() {
        return saldoEWallet;
    }

    public void setSaldoEWallet(double saldoEWallet) {
        this.saldoEWallet = saldoEWallet;
    }

    public double getTotalPembayaran() {
        return totalPembayaran;
    }

    public void setTotalPembayaran(double totalPembayaran) {
        this.totalPembayaran = totalPembayaran;
    }

    public String getPaymentDate() {
        return paymentDate;
    }

    public void setPaymentDate(String paymentDate) {
        this.paymentDate = paymentDate;
    }

    /**
     * Metode debugging untuk menampilkan detail pembayaran.
     *
     * @return String dengan detail pembayaran.
     */
    public String paymentDetails() {
        return "Payment ID: " + paymentId + "\n" +
               "Order ID: " + orderId + "\n" +
               "Customer ID: " + customerId + "\n" +
               "Payment Method: " + paymentMethod + "\n" +
               "Price Layanan: " + priceLayanan + "\n" +
               "Saldo E-Wallet: " + saldoEWallet + "\n" +
               "Total Pembayaran: " + totalPembayaran + "\n" +
               "Payment Date: " + paymentDate;
    }
}

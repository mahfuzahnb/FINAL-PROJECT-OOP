package models;
import java.lang.reflect.Field;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

    public abstract class Model<E> {

        protected Connection con;
        protected Statement stmt;
        private boolean isConnected;
        private String message;
        protected String table;
        protected String primaryKey;
        protected String select = "*";
        private String where = "";
        private String join = "";
        private String otherQuery = "";

        public void connect() {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                // (#1.1) Sesuaikan formatting con dengan nama DB anda
                con = DriverManager.getConnection( "jdbc:mysql://localhost:3306/easy_kos","root",""); 
                stmt = con.createStatement();
                isConnected = true;
                message = "Database Terkoneksi";
            } catch (ClassNotFoundException | SQLException e) {
                isConnected = false;
                message = e.getMessage();
            }
        }

        public void disconnect() {
            try {
                stmt.close();
                con.close();
            } catch (SQLException e) {
                message = e.getMessage();
            }
        }

        public void insert() {
            try {
                connect();
                StringBuilder colsBuilder = new StringBuilder();
                StringBuilder valuesBuilder = new StringBuilder();
                boolean hasValues = false;

                // Print class name and table for debugging
                System.out.println("Attempting to insert into table: " + table);
                System.out.println("Class being used: " + this.getClass().getName());

                // Get all fields including inherited ones
                Class<?> currentClass = this.getClass();
                while (currentClass != null && currentClass != Object.class) {
                    for (Field field : currentClass.getDeclaredFields()) {
                        field.setAccessible(true);
                        Object value = field.get(this);

                        // Skip if field is 'table' or 'primaryKey' or other Model fields
                        if (field.getName().equals("table") || 
                            field.getName().equals("primaryKey") ||
                            field.getName().equals("select") ||
                            field.getName().equals("where") ||
                            field.getName().equals("join") ||
                            field.getName().equals("otherQuery") ||
                            field.getName().equals("con") ||
                            field.getName().equals("stmt") ||
                            field.getName().equals("isConnected") ||
                            field.getName().equals("message")) {
                            continue;
                        }

                        System.out.println("Processing field: " + field.getName() + " with value: " + value);

                        if (value != null) {
                            colsBuilder.append(field.getName()).append(", ");
                            valuesBuilder.append("'").append(value).append("', ");
                            hasValues = true;
                        }
                    }
                    currentClass = currentClass.getSuperclass();
                }

                if (!hasValues) {
                    System.out.println("No values found to insert!");
                    return;
                }

                String cols = colsBuilder.substring(0, colsBuilder.length() - 2);
                String values = valuesBuilder.substring(0, valuesBuilder.length() - 2);

                String query = "INSERT INTO " + table + " (" + cols + ") VALUES (" + values + ")";
                System.out.println("Executing query: " + query);

                int result = stmt.executeUpdate(query);
                System.out.println("Insert result: " + result + " rows affected");

            } catch (Exception e) {
                System.out.println("Error during insert: " + e.getMessage());
                e.printStackTrace();
            } finally {
                disconnect();
            }
        }

        public void update() {
            try {
                connect();
                String values = "";
                Object pkValue = 0;
                for (Field field : this.getClass().getDeclaredFields()) {
                    field.setAccessible(true);
                    Object value = field.get(this);
                    if (field.getName().equals(primaryKey)) pkValue = value;
                    else if (value != null) {
                        values += field.getName() + " = '" + value + "', ";
                    }
                }
                int result = stmt.executeUpdate("UPDATE " + table + " SET " + values.substring(0, values.length() - 2)
                                                + " WHERE " + primaryKey + " = '" + pkValue +"'");
                message = "info update: " + result + " rows affected";
            } catch (IllegalAccessException | IllegalArgumentException | SecurityException | SQLException e) {
                message = e.getMessage();
            } finally {
                disconnect();
            }
        }

        public void delete() {
            try {
                connect();
                Object pkValue = 0;
                for (Field field : this.getClass().getDeclaredFields()) {
                    field.setAccessible(true);
                    if (field.getName().equals(primaryKey)) {
                        pkValue = field.get(this);
                        break;
                    }
                }
                int result = stmt.executeUpdate("DELETE FROM " + table + " WHERE " + primaryKey + " = '" + pkValue +"'");
                message = "info delete: " + result + " rows affected";
            } catch (IllegalAccessException | IllegalArgumentException | SecurityException | SQLException e) {
                message = e.getMessage();
            } finally {
                disconnect();
            }
        }

        ArrayList<Object> toRow(ResultSet rs) {
            ArrayList<Object> res = new ArrayList<>();
            int i = 1;
            try {
                while (true) {
                    res.add(rs.getObject(i));
                    i++;
                }
            } catch(SQLException e) {

            }
            return res;
        }

        public ArrayList<ArrayList<Object>> query(String query) {
            ArrayList<ArrayList<Object>> res = new ArrayList<>();
            try {
                connect();
                ResultSet rs = stmt.executeQuery(query);
                while (rs.next()) {
                    res.add(toRow(rs));
                }
            } catch (SQLException e) {
                message = e.getMessage();
            } finally {
                disconnect();
            }
            return res;
        }

        abstract E toModel(ResultSet rs);

        public ArrayList<E> get() {
            ArrayList<E> res = new ArrayList<>();
            try {
                this.connect();
                String query = "SELECT " +  select + " FROM " + table;
                if (!join.equals("")) query += join;
                if (!where.equals("")) query += " WHERE " + where;
                if (!otherQuery.equals("")) query += " " + otherQuery;
                ResultSet rs = stmt.executeQuery(query);
                while (rs.next()) {
                    res.add(toModel(rs));
                }
            } catch (SQLException e) {
                message = e.getMessage();
            } finally {
                disconnect();
                select = "*";
                where = "";
                join = "";
                otherQuery = "";
            }
            return res;
        }

        public E find(String pkValue) {
            try {
                connect();
                String query = "SELECT " + select + " FROM " + table + " WHERE " + primaryKey + " = '" + pkValue + "'";
                ResultSet rs = stmt.executeQuery(query);
                if (rs.next()) {
                    return toModel(rs); // Memastikan toModel menghasilkan tipe yang benar
                }
            } catch (SQLException e) {
                message = e.getMessage();
            } finally {
                disconnect();
                select = "*";
            }
            return null;
        }


        public void select(String cols) {
            select = cols;
        }

        public void join(String table, String on) {
            join += " JOIN " + table + " ON " + on;
        }

        public void where(String cond) {
            where = cond;
        }

        public void addQuery(String query) {
            otherQuery = query;
        }

        public boolean isConnected() {
            return isConnected;
        }

        public String getMessage() {
            return message;
        }

        public void setMessage(String message) {
            this.message = message;
        }
        public void setTable(String table) {
            this.table = table;
        }
    }

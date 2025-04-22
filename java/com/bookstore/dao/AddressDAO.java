package com.bookstore.dao;

import com.bookstore.config.DbConfig;
import com.bookstore.model.Address;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class AddressDAO {

	public boolean saveAddress(Address address, Connection conn) throws SQLException {
        String sql = "INSERT INTO Address (User_id, Address_line, City, State, Postal_code, Country) "
                   + "VALUES (?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, address.getUserId());
            ps.setString(2, address.getAddressLine());
            ps.setString(3, address.getCity());
            ps.setString(4, address.getState());
            ps.setString(5, address.getPostalCode());
            ps.setString(6, address.getCountry());

            int affected = ps.executeUpdate();
            if (affected == 0) return false;

            try (ResultSet rs = ps.getGeneratedKeys()) {
                if (rs.next()) {
                    address.setAddressId(rs.getInt(1));
                }
            }
            return true;
        }
    }

    public List<Address> getUserAddresses(int userId) throws SQLException {
        List<Address> addresses = new ArrayList<>();
        String sql = "SELECT a.*, CASE WHEN uap.Default_address_id = a.Address_id THEN 1 ELSE 0 END AS is_default " +
                     "FROM Address a " +
                     "LEFT JOIN UserAddressPreference uap ON a.User_id = uap.User_id " +
                     "WHERE a.User_id = ?";
        
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Address address = new Address(
                    rs.getInt("Address_id"),
                    userId,
                    rs.getString("Address_line"),
                    rs.getString("City"),
                    rs.getString("State"),
                    rs.getString("Postal_code"),
                    rs.getString("Country"),
                    rs.getBoolean("is_default")
                );
                addresses.add(address);
            }
        }
        return addresses;
    }

    public boolean deleteAddress(int addressId, int userId, Connection conn) throws SQLException {
        String sql = "DELETE FROM Address WHERE Address_id = ? AND User_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, addressId);
            ps.setInt(2, userId);
            return ps.executeUpdate() > 0;
        }
    }
}
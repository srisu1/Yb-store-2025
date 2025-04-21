package com.bookstore.dao;

import com.bookstore.config.DbConfig;
import com.bookstore.model.UserAddressPreference;
import java.sql.*;

public class UserAddressPreferenceDAO {

    public void updatePreferences(UserAddressPreference pref, Connection conn) throws SQLException {
        String sql = "INSERT INTO UserAddressPreference (User_id, Default_address_id, Shipping_address_id) "
                + "VALUES (?, ?, ?) "
                + "ON DUPLICATE KEY UPDATE "
                + "Default_address_id = VALUES(Default_address_id), "
                + "Shipping_address_id = VALUES(Shipping_address_id)";
     try (PreparedStatement ps = conn.prepareStatement(sql)) {
         ps.setInt(1, pref.getUserId());
         ps.setInt(2, pref.getDefaultAddressId());
         if (pref.getShippingAddressId() != null) {
             ps.setInt(3, pref.getShippingAddressId());
         } else {
             ps.setNull(3, Types.INTEGER);
         }
         ps.executeUpdate();
     }
 }
    public UserAddressPreference getPreferences(int userId) throws SQLException {
        String sql = "SELECT * FROM UserAddressPreference WHERE User_id = ?";
        
        try (Connection conn = DbConfig.getDbConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                return new UserAddressPreference(
                    userId,
                    rs.getInt("Default_address_id"),
                    rs.getObject("Shipping_address_id", Integer.class)
                );
            }
            return null;
        }
    }
}
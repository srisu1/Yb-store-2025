package com.bookstore.model;




public class User {
    private int userId;
    private String fullName;
    private String email;
    private String passwordHash;
    private String address;
    private String phoneNumber;
    private String languagePreference;
    private String role;
    private String profilePictureUrl;
    private int loyaltyPoints;
    private String createdAt;
    private String updatedAt;
    
    
	public User(int userId, String fullName, String email, String passwordHash, String address, String phoneNumber,
			String languagePreference, String role, String profilePictureUrl, int loyaltyPoints, String createdAt,
			String updatedAt) {
		super();
		this.userId = userId;
		this.fullName = fullName;
		this.email = email;
		this.passwordHash = passwordHash;
		this.address = address;
		this.phoneNumber = phoneNumber;
		this.languagePreference = languagePreference;
		this.role = role;
		this.profilePictureUrl = profilePictureUrl;
		this.loyaltyPoints = loyaltyPoints;
		this.createdAt = createdAt;
		this.updatedAt = updatedAt;
	}


	public int getUserId() {
		return userId;
	}


	public void setUserId(int userId) {
		this.userId = userId;
	}


	public String getFullName() {
		return fullName;
	}


	public void setFullName(String fullName) {
		this.fullName = fullName;
	}


	public String getEmail() {
		return email;
	}


	public void setEmail(String email) {
		this.email = email;
	}


	public String getPasswordHash() {
		return passwordHash;
	}


	public void setPasswordHash(String passwordHash) {
		this.passwordHash = passwordHash;
	}


	public String getAddress() {
		return address;
	}


	public void setAddress(String address) {
		this.address = address;
	}


	public String getPhoneNumber() {
		return phoneNumber;
	}


	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}


	public String getLanguagePreference() {
		return languagePreference;
	}


	public void setLanguagePreference(String languagePreference) {
		this.languagePreference = languagePreference;
	}


	public String getRole() {
		return role;
	}


	public void setRole(String role) {
		this.role = role;
	}


	public String getProfilePictureUrl() {
		return profilePictureUrl;
	}


	public void setProfilePictureUrl(String profilePictureUrl) {
		this.profilePictureUrl = profilePictureUrl;
	}


	public int getLoyaltyPoints() {
		return loyaltyPoints;
	}


	public void setLoyaltyPoints(int loyaltyPoints) {
		this.loyaltyPoints = loyaltyPoints;
	}


	public String getCreatedAt() {
		return createdAt;
	}


	public void setCreatedAt(String createdAt) {
		this.createdAt = createdAt;
	}


	public String getUpdatedAt() {
		return updatedAt;
	}


	public void setUpdatedAt(String updatedAt) {
		this.updatedAt = updatedAt;
	}
    
    
    
}
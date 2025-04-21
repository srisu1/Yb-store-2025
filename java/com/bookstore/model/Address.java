package com.bookstore.model;



public class Address {
    private int addressId;
    private int userId;
    private String addressLine;
    private String city;
    private String state;
    private String postalCode;
    private String country;
    private boolean isDefault;
    
    
	public Address(int addressId, int userId, String addressLine, String city, String state, String postalCode,
			String country, boolean isDefault) {
		super();
		this.addressId = addressId;
		this.userId = userId;
		this.addressLine = addressLine;
		this.city = city;
		this.state = state;
		this.postalCode = postalCode;
		this.country = country;
		this.isDefault = isDefault;
	}


	public int getAddressId() {
		return addressId;
	}


	public void setAddressId(int addressId) {
		this.addressId = addressId;
	}


	public int getUserId() {
		return userId;
	}


	public void setUserId(int userId) {
		this.userId = userId;
	}


	public String getAddressLine() {
		return addressLine;
	}


	public void setAddressLine(String addressLine) {
		this.addressLine = addressLine;
	}


	public String getCity() {
		return city;
	}


	public void setCity(String city) {
		this.city = city;
	}


	public String getState() {
		return state;
	}


	public void setState(String state) {
		this.state = state;
	}


	public String getPostalCode() {
		return postalCode;
	}


	public void setPostalCode(String postalCode) {
		this.postalCode = postalCode;
	}


	public String getCountry() {
		return country;
	}


	public void setCountry(String country) {
		this.country = country;
	}


	public boolean isDefault() {
		return isDefault;
	}


	public void setDefault(boolean isDefault) {
		this.isDefault = isDefault;
	}
	
	

    
}
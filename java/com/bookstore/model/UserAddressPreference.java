package com.bookstore.model;

public class UserAddressPreference {
    private int userId;
    private int defaultAddressId;
    private Integer shippingAddressId;
    
	public UserAddressPreference(int userId, int defaultAddressId, Integer shippingAddressId) {
		super();
		this.userId = userId;
		this.defaultAddressId = defaultAddressId;
		this.shippingAddressId = shippingAddressId;
	}

	public int getUserId() {
		return userId;
	}

	public void setUserId(int userId) {
		this.userId = userId;
	}

	public int getDefaultAddressId() {
		return defaultAddressId;
	}

	public void setDefaultAddressId(int defaultAddressId) {
		this.defaultAddressId = defaultAddressId;
	}

	public Integer getShippingAddressId() {
		return shippingAddressId;
	}

	public void setShippingAddressId(Integer shippingAddressId) {
		this.shippingAddressId = shippingAddressId;
	}
	
	
	
	
	
	
	

    
}

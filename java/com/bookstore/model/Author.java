package com.bookstore.model;



public class Author {
    private int authorId;
    private String name;
    private String bio;
    private String email;
    
	public Author(int authorId, String name, String bio, String email) {
		super();
		this.authorId = authorId;
		this.name = name;
		this.bio = bio;
		this.email = email;
	}

	public int getAuthorId() {
		return authorId;
	}

	public void setAuthorId(int authorId) {
		this.authorId = authorId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getBio() {
		return bio;
	}

	public void setBio(String bio) {
		this.bio = bio;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}
	
	

    
}
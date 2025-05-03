package com.bookstore.model;
import com.bookstore.model.Author;


import java.util.Date;

import java.util.List; // Needed to store multiple authors

public class Book {
    private int bookId;
    private String title;
    private String coverImageUrl;
    
    private byte[] bookCoverImage;
    
    private double price;
    private String description;
    private String isbn;
    private Date publicationDate;
    private int stockQuantity;

    //  List to hold multiple authors for this book
    private List<Author> authors;

    // Constructor (without authors, authors can be set later using setter)
    public Book(int bookId, String title, String coverImageUrl, double price, String description, String isbn,
                Date publicationDate, int stockQuantity) {
        this.bookId = bookId;
        this.title = title;
        this.coverImageUrl = coverImageUrl;
        this.price = price;
        this.description = description;
        this.isbn = isbn;
        this.publicationDate = publicationDate;
        this.stockQuantity = stockQuantity;
    }

    // Getters and Setters — used by DAO to store or retrieve values

    public int getBookId() {
        return bookId;
    }

    public void setBookId(int bookId) {
        this.bookId = bookId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getCoverImageUrl() {
        return coverImageUrl;
    }

    public void setCoverImageUrl(String coverImageUrl) {
        this.coverImageUrl = coverImageUrl;
    }
    
    
    public byte[] getBookCoverImage() {
        return bookCoverImage;
    }

    public void setBookCoverImage(byte[] bookCoverImage) {
        this.bookCoverImage = bookCoverImage;
    }

    public double getPrice() {
        return price;
    }
    

    public void setPrice(double price) {
        this.price = price;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getIsbn() {
        return isbn;
    }

    public void setIsbn(String isbn) {
        this.isbn = isbn;
    }

    public Date getPublicationDate() {
        return publicationDate;
    }

    public void setPublicationDate(Date publicationDate) {
        this.publicationDate = publicationDate;
    }

    public int getStockQuantity() {
        return stockQuantity;
    }

    public void setStockQuantity(int stockQuantity) {
        this.stockQuantity = stockQuantity;
    }

    // Get and set the list of authors for this book
    public List<Author> getAuthors() {
        return authors;
    }

    public void setAuthors(List<Author> authors) {
        this.authors = authors;
    }
}



package com.bookstore.model;



public class ReviewBookUser {
    private int reviewId;
    private int bookId;
    private int userId;

    // Constructors
    public ReviewBookUser(int reviewId, int bookId, int userId) {
        this.reviewId = reviewId;
        this.bookId = bookId;
        this.userId = userId;
    }

    // Getters and Setters
    public int getReviewId() {
        return reviewId;
    }

    public void setReviewId(int reviewId) {
        this.reviewId = reviewId;
    }

    public int getBookId() {
        return bookId;
    }

    public void setBookId(int bookId) {
        this.bookId = bookId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }
}

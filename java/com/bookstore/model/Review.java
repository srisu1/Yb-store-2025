package com.bookstore.model;



import java.sql.Timestamp;

public class Review {
    private int reviewId;
    private int rating;
    private String reviewText;
    private Timestamp reviewCreatedAt;
    private String reviewStatus;

    // Constructors
    public Review(int reviewId, int rating, String reviewText, Timestamp reviewCreatedAt, String reviewStatus) {
        this.reviewId = reviewId;
        this.rating = rating;
        this.reviewText = reviewText;
        this.reviewCreatedAt = reviewCreatedAt;
        this.reviewStatus = reviewStatus;
    }

    // Getters and Setters
    public int getReviewId() {
        return reviewId;
    }

    public void setReviewId(int reviewId) {
        this.reviewId = reviewId;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public String getReviewText() {
        return reviewText;
    }

    public void setReviewText(String reviewText) {
        this.reviewText = reviewText;
    }

    public Timestamp getReviewCreatedAt() {
        return reviewCreatedAt;
    }

    public void setReviewCreatedAt(Timestamp reviewCreatedAt) {
        this.reviewCreatedAt = reviewCreatedAt;
    }

    public String getReviewStatus() {
        return reviewStatus;
    }

    public void setReviewStatus(String reviewStatus) {
        this.reviewStatus = reviewStatus;
    }
}
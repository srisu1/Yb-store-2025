package com.bookstore.model;






public class RelatedBook {
    private int bookId;
    private int relatedBookId;

    // Constructors
    public RelatedBook(int bookId, int relatedBookId) {
        this.bookId = bookId;
        this.relatedBookId = relatedBookId;
    }

    // Getters and Setters
    public int getBookId() {
        return bookId;
    }

    public void setBookId(int bookId) {
        this.bookId = bookId;
    }

    public int getRelatedBookId() {
        return relatedBookId;
    }

    public void setRelatedBookId(int relatedBookId) {
        this.relatedBookId = relatedBookId;
    }
}
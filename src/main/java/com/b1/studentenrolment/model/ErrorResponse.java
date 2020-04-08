package com.b1.studentenrolment.model;

public class ErrorResponse {
    private String url;
    private String error;
    private String method;

    public ErrorResponse(String url, String message, String method) {
        this.url = url;
        this.error = message;
        this.method = method;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }

    public String getMethod() {
        return method;
    }

    public void setMethod(String method) {
        this.method = method;
    }
}

package com.b1.studentenrolment.exceptions;

import com.b1.studentenrolment.model.ErrorResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@ControllerAdvice
public class StudentApiExceptionsHandler {

    private static final Logger LOGGER = LoggerFactory.getLogger(StudentApiExceptionsHandler.class);
    private String errorMessage = "Error Occurred while processing the request '%s'. Exception Message - %s";

    @ResponseStatus(value = HttpStatus.INTERNAL_SERVER_ERROR)
    @ExceptionHandler(value = { Exception.class })
    protected @ResponseBody ErrorResponse handleGlobalException(HttpServletRequest req, HttpServletResponse resp, Exception ex) {
        // ex.printStackTrace();
        logException(req, resp, ex);
        return new ErrorResponse(req.getRequestURL().toString(), ex.getMessage(), req.getMethod());
    }

    private void logException(HttpServletRequest request, HttpServletResponse response, Exception e) {
        LOGGER.error(String.format(errorMessage, request.getRequestURI(), e.getMessage()));
    }
}

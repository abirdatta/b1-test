package com.b1.studentenrolment.service;

import com.b1.studentenrolment.exceptions.StudentApiException;
import com.b1.studentenrolment.model.Student;

import java.util.List;

public interface StudentService {
    Iterable<Student> findAllStudents();
    Student findStudentById(String studentId) throws StudentApiException;
    Student addStudent(Student student) throws StudentApiException;
    String removeStudent(String studentId) throws StudentApiException;
    Student updateStudent(String studentId, Student student) throws StudentApiException;
    List<Student> findStudentsByClassName(String className) throws StudentApiException;
}

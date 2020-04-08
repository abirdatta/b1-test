package com.b1.studentenrolment.service.impl;

import com.b1.studentenrolment.exceptions.StudentApiException;
import com.b1.studentenrolment.model.Student;
import com.b1.studentenrolment.repository.StudentRepository;
import com.b1.studentenrolment.service.StudentService;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.BeanWrapper;
import org.springframework.beans.BeanWrapperImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.stereotype.Service;

import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;
import java.util.*;

@Service
public class StudentServiceImpl implements StudentService {
    @Autowired
    private StudentRepository studentRepository;

    @Override
    public Iterable<Student> findAllStudents() {
        return studentRepository.findAll();
    }

    @Override
    public Student findStudentById(String studentId) throws StudentApiException {
        try {
            long studentIdLongVal = Long.parseLong(studentId);
            Optional<Student> optionalStudent = studentRepository.findById(studentIdLongVal);
            if (optionalStudent.isPresent())
                return optionalStudent.get();
            else
                throw new StudentApiException("No student with id " + studentId + " exists.");
        } catch (NumberFormatException nfe) {
            throw new StudentApiException("Please pass a valid NUMERIC student ID.");
        }
    }

    @Override
    public Student addStudent(Student student) throws StudentApiException {
        try {
            Student savedStudent = studentRepository.save(student);
            return savedStudent;
        } catch (ConstraintViolationException e) {
            List<String> missingProperties = new ArrayList<>();
            for (ConstraintViolation constraintViolation : e.getConstraintViolations()) {
                missingProperties.add(constraintViolation.getPropertyPath().toString());
            }
            throw new StudentApiException("The following properties are missing or incorrectly spelled - "
                    + missingProperties.toString());
        }
    }

    @Override
    public String removeStudent(String studentId) throws StudentApiException {
        try {
            long studentIdLongVal = Long.parseLong(studentId);
            studentRepository.deleteById(studentIdLongVal);
            return "Successfully Deleted student with ID - " + studentIdLongVal;
        } catch (NumberFormatException nfe) {
            throw new StudentApiException("Please pass a valid NUMERIC student ID.");
        } catch (EmptyResultDataAccessException e) {
            throw new StudentApiException("No student with id " + studentId + " exists.");
        }
    }

    @Override
    public Student updateStudent(String studentId, Student studentInput) throws StudentApiException {
        Student updatedStudent = new Student();
        try {
            if (studentInput.isEmpty()) {
                throw new StudentApiException("The input json for update, doesn't have any proper attributes.");
            }
            long studentIdLongVal = Long.parseLong(studentId);
            if (studentRepository.existsById(studentIdLongVal)) {
                Student student = studentRepository.getOne(studentIdLongVal);
                copyNonNullProperties(studentInput, student);
                student.setId(studentIdLongVal);
                return studentRepository.save(student);
            } else {
                throw new StudentApiException("Student Id - " + studentId + " doesn't exist");
            }
        } catch (NumberFormatException nfe) {
            throw new StudentApiException("Please pass a valid NUMERIC student ID.");
        }
    }

    @Override
    public List<Student> findStudentsByClassName(String className) throws StudentApiException {
        List<Student> studentList = studentRepository.findByClassName(className);
        if(studentList.size() == 0)
            throw new StudentApiException("No Students found for the class - "+className);
        else
            return studentList;
    }

    private static void copyNonNullProperties(Object src, Object target) {
        BeanUtils.copyProperties(src, target, getNullPropertyNames(src));
    }

    private static String[] getNullPropertyNames(Object source) {
        final BeanWrapper src = new BeanWrapperImpl(source);
        java.beans.PropertyDescriptor[] pds = src.getPropertyDescriptors();

        Set<String> emptyNames = new HashSet<String>();
        for (java.beans.PropertyDescriptor pd : pds) {
            Object srcValue = src.getPropertyValue(pd.getName());
            if (srcValue == null) emptyNames.add(pd.getName());
        }
        String[] result = new String[emptyNames.size()];
        return emptyNames.toArray(result);
    }
}

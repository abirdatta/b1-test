package com.b1.studentenrolment.controller;

import com.b1.studentenrolment.exceptions.StudentApiException;
import com.b1.studentenrolment.model.Student;
import com.b1.studentenrolment.service.StudentService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/students")
@Api(value = "Student Enrolment System")
public class StudentController {

    @Autowired
    private StudentService studentService;

    @ApiOperation(value = "Get the list of all enrolled students")
    @GetMapping(value = "")
    public Iterable<Student> findAllStudents() {
        return studentService.findAllStudents();
    }

    @ApiOperation(value = "Get a student by the ID")
    @GetMapping(value = "/{studentId}")
    public Student findStudentById(@PathVariable(name = "studentId") String studentId) throws StudentApiException {
        return studentService.findStudentById(studentId);
    }

    @ApiOperation(value = "Add a student")
    @PostMapping(value = "")
    public Student addStudent(@RequestBody Student student) throws StudentApiException {
        return studentService.addStudent(student);
    }

    @ApiOperation(value = "Delete a student enrolment record")
    @DeleteMapping(value = "/{studentId}")
    public String removeStudent(@PathVariable(name = "studentId") String studentId) throws StudentApiException {
        return studentService.removeStudent(studentId);
    }

    @ApiOperation(value = "Update a student enrolment record")
    @PutMapping(value = "/{studentId}")
    public Student updateStudent(@PathVariable(name = "studentId") String studentId,
                                @RequestBody Student studentInput) throws StudentApiException {

        return studentService.updateStudent(studentId, studentInput);
    }

    @ApiOperation(value = "Get the list of students in a particular class")
    @GetMapping(value = "/class/{className}")
    public List<Student> getStudentsByClassName(@PathVariable(name = "className") String className)
            throws StudentApiException {
        return studentService.findStudentsByClassName(className);
    }


}

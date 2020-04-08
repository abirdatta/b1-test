package com.b1.studentenrolment.controller;

import com.b1.studentenrolment.model.Student;
import com.b1.studentenrolment.service.StudentService;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.Mockito;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.boot.test.mock.mockito.MockBean;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.test.web.servlet.MockMvc;

import java.util.ArrayList;
import java.util.List;

import static org.hamcrest.Matchers.hasSize;
import static org.hamcrest.Matchers.is;
import static org.mockito.Mockito.when;
import static org.springframework.http.MediaType.APPLICATION_JSON;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.*;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@RunWith(SpringRunner.class)
@WebMvcTest(StudentController.class)
public class StudentControllerTests {
    @Autowired
    private MockMvc mockMvc;

    @MockBean
    private StudentService studentService;

    @Autowired
    private ObjectMapper objectMapper;

    @Test
    public void findAllStudentsTest() throws Exception {
        when(studentService.findAllStudents()).thenReturn(buildStudents());
        this.mockMvc.perform(get("/students"))
                .andExpect(status().isOk())
                .andExpect(content().contentType(APPLICATION_JSON))
                .andExpect(jsonPath("$", hasSize(2)))
                .andExpect(jsonPath("$[0].id", is(1)))
                .andExpect(jsonPath("$[0].firstName", is("A")))
                .andExpect(jsonPath("$[0].lastName", is("D")))
                .andExpect(jsonPath("$[0].className", is("1A")))
                .andExpect(jsonPath("$[0].nationality", is("Indian")))
                .andExpect(jsonPath("$[1].id", is(2)))
                .andExpect(jsonPath("$[1].firstName", is("S")))
                .andExpect(jsonPath("$[1].lastName", is("D")))
                .andExpect(jsonPath("$[1].className", is("2A")))
                .andExpect(jsonPath("$[1].nationality", is("Singaporean")));
    }

    @Test
    public void addStudentTest() throws Exception {
        Student studentResponse = buildStudentResponse();
        when(studentService.addStudent(Mockito.any(Student.class))).thenReturn(studentResponse);
        this.mockMvc.perform(post("/students")
                            .contentType(APPLICATION_JSON)
                            .content(objectMapper.writeValueAsBytes(buildStudentRequest())))
                .andExpect(status().isOk())
                .andExpect(content().contentType(APPLICATION_JSON))
                .andExpect(jsonPath("id", is(1)))
                .andExpect(jsonPath("firstName", is(studentResponse.getFirstName())))
                .andExpect(jsonPath("lastName", is(studentResponse.getLastName())))
                .andExpect(jsonPath("className", is(studentResponse.getClassName())))
                .andExpect(jsonPath("nationality", is(studentResponse.getNationality())));
    }

    @Test
    public void findStudentByIdTest() throws Exception {
        Student studentResponse = buildStudentResponse();
        when(studentService.findStudentById(Mockito.any(String.class))).thenReturn(studentResponse);
        this.mockMvc.perform(get("/students/1"))
                .andExpect(status().isOk())
                .andExpect(content().contentType(APPLICATION_JSON))
                .andExpect(jsonPath("id", is(1)))
                .andExpect(jsonPath("firstName", is(studentResponse.getFirstName())))
                .andExpect(jsonPath("lastName", is(studentResponse.getLastName())))
                .andExpect(jsonPath("className", is(studentResponse.getClassName())))
                .andExpect(jsonPath("nationality", is(studentResponse.getNationality())));
    }

    @Test
    public void removeStudentTest() throws Exception {
        when(studentService.removeStudent(Mockito.any(String.class))).thenReturn("Successfully Deleted student with ID - 1");
        this.mockMvc.perform(delete("/students/1"))
                .andExpect(status().isOk())
                .andExpect(content().string("Successfully Deleted student with ID - 1"));
    }

    @Test
    public void updateStudentTest() throws Exception {
        Student studentResponse = buildStudentResponse();
        when(studentService.updateStudent(Mockito.any(String.class), Mockito.any(Student.class))).thenReturn(studentResponse);
        this.mockMvc.perform(put("/students/1")
                .contentType(APPLICATION_JSON)
                .content(objectMapper.writeValueAsBytes(buildStudentRequest())))
                .andExpect(status().isOk())
                .andExpect(content().contentType(APPLICATION_JSON))
                .andExpect(jsonPath("id", is(1)))
                .andExpect(jsonPath("firstName", is(studentResponse.getFirstName())))
                .andExpect(jsonPath("lastName", is(studentResponse.getLastName())))
                .andExpect(jsonPath("className", is(studentResponse.getClassName())))
                .andExpect(jsonPath("nationality", is(studentResponse.getNationality())));
    }

    private Student buildStudentRequest(){
        return new Student("A","D","1A","Indian");
    }

    private Student buildStudentResponse(){
        return new Student(1,"A","D","1A","Indian");
    }

    private Iterable<Student> buildStudents() {
        Student student1 = new Student(1,"A","D","1A","Indian");
        Student student2 = new Student(2,"S","D","2A","Singaporean");
        List<Student> students = new ArrayList<>();
        students.add(student1);
        students.add(student2);
        return students;
    }
}

package com.b1.studentenrolment.service;

import com.b1.studentenrolment.model.Student;
import com.b1.studentenrolment.repository.StudentRepository;
import com.b1.studentenrolment.service.impl.StudentServiceImpl;
import org.hamcrest.core.StringContains;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.Mockito;
import org.springframework.test.context.junit4.SpringRunner;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import static org.junit.Assert.assertEquals;
import static org.mockito.Mockito.when;

@RunWith(SpringRunner.class)
public class StudentServiceTests {

    @Mock
    private StudentRepository studentRepository;

    @InjectMocks
    StudentServiceImpl studentService;

    @Test
    public void findAllStudentsTest() throws Exception {
        when(studentRepository.findAll()).thenReturn(buildStudents());
        List<Student> studentList = (List<Student>) studentService.findAllStudents();
        assertEquals(2, studentList.size());
    }

    @Test
    public void findStudentByIdTest() throws Exception {
        when(studentRepository.findById(Mockito.any(Long.class))).thenReturn(buildOptionalStudent());
        Student student = studentService.findStudentById("1");
        assertEquals(1, student.getId());
    }

    @Test
    public void addStudentTest() throws Exception {
        when(studentRepository.save(Mockito.any(Student.class))).thenReturn(buildStudentWithoutIdForSaving());
        Student student = studentService.addStudent(buildStudentWithoutIdForSaving());
        assertEquals(1, student.getId());
    }

    @Test
    public void removeStudentTest() throws Exception {
        Mockito.doNothing().when(studentRepository).deleteById(Mockito.any(Long.class));
        String deleteResponse = studentService.removeStudent("1");
        Assert.assertThat(deleteResponse, StringContains.containsString("Successfully Deleted student with ID - "));
    }

    @Test
    public void updateStudentTest() throws Exception {
        Student srcStudent = buildStudentWithoutIdForSaving();
        when(studentRepository.getOne(Mockito.any(Long.class))).thenReturn(srcStudent);
        when(studentRepository.save(Mockito.any(Student.class))).thenReturn(buildStudentWithId());
        when(studentRepository.existsById(Mockito.any(Long.class))).thenReturn(true);
        Student student = studentService.updateStudent("1", srcStudent);
        assertEquals(1, student.getId());
        assertEquals("2A", student.getClassName());
    }

    @Test
    public void findStudentsInClassTest() throws Exception {
        when(studentRepository.findByClassName(Mockito.anyString())).thenReturn(buildStudentsinOneClass());
        assertEquals(2, studentService.findStudentsByClassName("2A").size());
    }

    private Student buildStudentWithoutIdForSaving() {
        return new Student(1, "A", "D", "1A", "Indian");
    }

    private Student buildStudentWithId() {
        return new Student(1, "A", "D", "2A", "Indian");
    }

    private Optional<Student> buildOptionalStudent() {
        return Optional.of(new Student(1, "A", "D", "1A", "Indian"));
    }

    private List<Student> buildStudents() {
        Student student1 = new Student(1, "A", "D", "1A", "Indian");
        Student student2 = new Student(2, "S", "D", "2A", "Singaporean");
        List<Student> students = new ArrayList<Student>() {{
            add(student1);
            add(student2);
        }};
        return students;
    }

    private List<Student> buildStudentsinOneClass() {
        Student student1 = new Student(1, "A", "D", "2A", "Indian");
        Student student2 = new Student(2, "S", "D", "2A", "Singaporean");
        List<Student> students = new ArrayList<Student>() {{
            add(student1);
            add(student2);
        }};
        return students;
    }
}

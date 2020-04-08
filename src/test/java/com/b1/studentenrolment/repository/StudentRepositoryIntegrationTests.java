package com.b1.studentenrolment.repository;

import com.b1.studentenrolment.model.Student;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit4.SpringRunner;
import org.springframework.transaction.annotation.Transactional;

import java.util.LinkedList;
import java.util.List;

import static org.junit.Assert.assertEquals;

@RunWith(SpringRunner.class)
@Transactional
@SpringBootTest
public class StudentRepositoryIntegrationTests {

    @Autowired
    private StudentRepository studentRepository;

    @Test
    public void studentSaveAndUpdateToDBTest() {
        Student student = new Student("Test", "User", "5A", "Indian");
        Student savedStudent = studentRepository.save(student);
        assertEquals("Test", savedStudent.getFirstName());
        assertEquals("User", savedStudent.getLastName());
        assertEquals("5A", savedStudent.getClassName());
        assertEquals("Indian", savedStudent.getNationality());
        savedStudent.setClassName("6A");
        savedStudent.setNationality("Singaporean");
        Student updatedStudent = studentRepository.save(savedStudent);
        assertEquals("Test", updatedStudent.getFirstName());
        assertEquals("User", updatedStudent.getLastName());
        assertEquals("6A", updatedStudent.getClassName());
        assertEquals("Singaporean", updatedStudent.getNationality());
    }

    @Test
    public void findAllStudentsFromDBTest(){
        List<Student> studentList = getStudents();
        studentRepository.saveAll(studentList);
        assertEquals(2, studentRepository.findAll().size());
    }

    @Test
    public void findOneStudentFromDBTest(){
        List<Student> studentList = getStudents();
        List<Student> studentListSaved = studentRepository.saveAll(studentList);
        assertEquals("John", studentRepository.findById(studentListSaved.get(0).getId()).get().getFirstName());
        assertEquals("Abir", studentRepository.findById(studentListSaved.get(1).getId()).get().getFirstName());
    }

    @Test
    public void deleteOneStudentFromDBTest(){
        List<Student> studentList = getStudents();
        List<Student> studentListSaved = studentRepository.saveAll(studentList);
        assertEquals(2, studentListSaved.size());
        studentRepository.deleteById(studentListSaved.get(0).getId());
        assertEquals(1, studentRepository.findAll().size());
    }

    @Test
    public void fetchStudentByClassnameFromDBTest(){
        List<Student> studentList = getStudents();
        List<Student> studentListSaved = studentRepository.saveAll(studentList);
        assertEquals(2, studentListSaved.size());
        List<Student> studentsByClass2A = studentRepository.findByClassName("2A");
        assertEquals(1, studentsByClass2A.size());
        assertEquals("John",studentsByClass2A.get(0).getFirstName());
        assertEquals("2A",studentsByClass2A.get(0).getClassName());
        List<Student> studentsByClass3A = studentRepository.findByClassName("3A");
        assertEquals(1, studentsByClass3A.size());
        assertEquals("Abir",studentsByClass3A.get(0).getFirstName());
        assertEquals("3A",studentsByClass3A.get(0).getClassName());
    }

    private List<Student> getStudents() {
        Student student1 = new Student("John", "Smith", "2A", "British");
        Student student2 = new Student("Abir", "Datta", "3A", "Indian");
        return new LinkedList<Student>(){{
            add(student1);
            add(student2);
        }};
    }

}

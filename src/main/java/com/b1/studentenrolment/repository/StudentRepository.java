package com.b1.studentenrolment.repository;

import com.b1.studentenrolment.model.Student;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Transactional
@Repository
public interface StudentRepository extends CrudRepository<Student, Long>, JpaRepository<Student, Long> {
    List<Student> findByClassName(String className);
}

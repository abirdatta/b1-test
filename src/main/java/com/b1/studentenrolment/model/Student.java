package com.b1.studentenrolment.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

import javax.persistence.*;
import javax.validation.constraints.NotEmpty;

@Entity
@Table(name = "students")
@ApiModel(description = "Student Details.")
public class Student {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @ApiModelProperty(notes = "DB generated student ID")
    private long id;

    @ApiModelProperty(notes = "First Name of the student")
    @NotEmpty
    private String firstName;

    @ApiModelProperty(notes = "Last Name of the student")
    @NotEmpty
    private String lastName;

    @ApiModelProperty(notes = "Class the student studies")
    @NotEmpty
    private String className;

    @ApiModelProperty(notes = "Nationality of the student")
    @NotEmpty
    private String nationality;

    public Student(long id, String firstName, String lastName, String className, String nationality) {
        this.id = id;
        this.firstName = firstName;
        this.lastName = lastName;
        this.className = className;
        this.nationality = nationality;
    }

    public Student(String firstName, String lastName, String className, String nationality) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.className = className;
        this.nationality = nationality;
    }

    public Student() {
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
    }

    public String getNationality() {
        return nationality;
    }

    public void setNationality(String nationality) {
        this.nationality = nationality;
    }

    @Override
    public String toString() {
        return "Student{" +
                "id=" + id +
                ", firstName='" + firstName + '\'' +
                ", lastName='" + lastName + '\'' +
                ", className='" + className + '\'' +
                ", nationality='" + nationality + '\'' +
                '}';
    }

    @JsonIgnore
    public boolean isEmpty() {
        return (this.id == 0 && this.firstName == null && this.lastName == null
                && this.className == null && this.nationality == null);
    }
}

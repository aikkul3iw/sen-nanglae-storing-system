package com.proj.ejb.face;

import java.util.List;

import com.proj.ejb.entity.Student;

public interface StudentService {
	public void save(Student stu);

	public void update(Student stu);

	public void delete(long id);

	public Student findStudentById(long id);

	public List<Student> listAllStudent();
}

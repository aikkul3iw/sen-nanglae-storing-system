package com.proj.ejb.bean;

import java.util.List;

import javax.ejb.Remote;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import com.proj.ejb.entity.Student;
import com.proj.ejb.face.StudentService;

@Stateless
@Remote(StudentService.class)
public class StudentServiceBean implements StudentService {

	@PersistenceContext(unitName = "EJBDatebase")
	EntityManager em;

	@Override
	public void save(Student stu) {
		// TODO Auto-generated method stub
		this.em.persist(stu);
	}

	@Override
	public void update(Student stu) {
		// TODO Auto-generated method stub
		this.em.merge(stu);
	}

	@Override
	public void delete(long id) {
		// TODO Auto-generated method stub
		Student stu = findStudentById(id);
		if (stu != null) {
			em.remove(stu);
		}
	}

	@Override
	public Student findStudentById(long id) {
		// TODO Auto-generated method stub
		return this.em.find(Student.class, id);
	}

	@Override
	public List<Student> listAllStudent() {
		// TODO Auto-generated method stub
		List<Student> list = em.createQuery("SELECT stu FROM Student stu").getResultList();
		return list;
	}

}

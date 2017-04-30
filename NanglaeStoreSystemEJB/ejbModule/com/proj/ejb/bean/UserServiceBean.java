package com.proj.ejb.bean;

import java.util.List;

import javax.ejb.Remote;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;


import com.proj.ejb.entity.User;
import com.proj.ejb.face.UserService;

@Stateless
@Remote(UserService.class)
public class UserServiceBean implements UserService{
	
	@PersistenceContext(unitName = "EJBDatebase")
	EntityManager em;

	@Override
	public void save(User user) {
		this.em.persist(user);
	}

	@Override
	public void update(User user) {
		this.em.merge(user);
	}

	@Override
	public void delete(long id) {
		User user = findUserById(id);
		if (user != null) {
			em.remove(user);
		}
	}

	@Override
	public User findUserById(long id) {
		return this.em.find(User.class, id);
	}

	@Override
	public List<User> listAllUser() {
		List<User> list = em.createQuery("SELECT user FROM User user").getResultList();
		return list;
	}
	
	@Override
	public User login(String username,String password){
		
		List<User> list = em.createQuery("SELECT user FROM User user WHERE user.username = :username AND user.password = :password")
				.setParameter("username", username).setParameter("password", password).getResultList();
		System.out.println("intro"+list.size());
		return list.get(0);
	}
	
	public String Checkrole(String username,String password,String role) {
		List<User> list = em.createQuery("SELECT user FROM user.username = :username AND user.password = :password AND user.role = :role")
				.setParameter("username", username).setParameter("password", password).setParameter("role", role).getResultList();
		if(!list.isEmpty()){
			
		}
		return role;
		
	}
	
	public String Role(String role) {
		List<User> list = em.createQuery("SELECT user FROM User user WHERE user.role = :role")
				.setParameter("role", role).getResultList();
		if(!list.isEmpty()){
			
		}
		return role;
		
	}
}









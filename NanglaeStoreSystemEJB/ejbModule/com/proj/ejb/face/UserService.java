package com.proj.ejb.face;

import java.util.List;


import com.proj.ejb.entity.User;

public interface UserService {
	public void save(User user);
	public void update(User user);
	public void delete(long id);
	public User findUserById(long id);
	public List<User> listAllUser();
	public  List<User> login(String username,String password);
	public String Checkrole(String username,String password,String role);
	public String Role(String role);
}

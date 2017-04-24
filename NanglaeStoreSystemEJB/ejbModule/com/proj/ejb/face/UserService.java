package com.proj.ejb.face;

import java.util.List;

import com.proj.ejb.entity.User;

public interface UserService {
	public void save(User user);
	public void update(User user);
	public void delete(long id);
	public User findUserById(long id);
	public List<User> listAllUser();
	
}

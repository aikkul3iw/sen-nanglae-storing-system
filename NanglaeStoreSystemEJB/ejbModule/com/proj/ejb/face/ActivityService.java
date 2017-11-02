package com.proj.ejb.face;

import java.util.List;

import com.proj.ejb.entity.Activity;

public interface ActivityService {
	public void save(Activity act);

	public void update(Activity act);

	public void delete(long id);

	public Activity findActivityById(long id);

	public List<Activity> listAllActivity();
}

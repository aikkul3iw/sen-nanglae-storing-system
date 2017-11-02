package com.proj.ejb.bean;

import java.util.List;

import javax.ejb.Remote;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import com.proj.ejb.entity.Activity;
import com.proj.ejb.face.ActivityService;

@Stateless
@Remote(ActivityService.class)
public class ActivityServiceBean implements ActivityService {
	
	@PersistenceContext(unitName = "EJBDatebase")
	EntityManager em;

	@Override
	public void save(Activity act) {
		// TODO Auto-generated method stub
		this.em.persist(act);
	}

	@Override
	public void update(Activity act) {
		// TODO Auto-generated method stub
		this.em.merge(act);
	}

	@Override
	public void delete(long id) {
		// TODO Auto-generated method stub
		Activity act = findActivityById(id);
		if (act != null) {
			em.remove(act);
		}
	}

	@Override
	public Activity findActivityById(long id) {
		// TODO Auto-generated method stub
		return this.em.find(Activity.class, id);
	}

	@Override
	public List<Activity> listAllActivity() {
		// TODO Auto-generated method stub
		List<Activity> list = em.createQuery("SELECT act FROM Activity act").getResultList();
		return list;
	}

}

package com.proj.ejb.bean;

import java.util.List;

import javax.ejb.Remote;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import com.proj.ejb.entity.Education;
import com.proj.ejb.face.EducationService;

@Stateless
@Remote(EducationService.class)
public class EducationServiceBean implements EducationService{

	@PersistenceContext(unitName = "EJBDatebase")
	EntityManager em;
	
	@Override
	public void save(Education edu) {
		this.em.persist(edu);
		
	}

	@Override
	public void update(Education edu) {
		this.em.merge(edu);
		
	}

	@Override
	public void delete(long edu_id) {
		Education edu = findEducationById(edu_id);
		if(edu != null){
			em.remove(edu);;
		}
		
	}

	@Override
	public Education findEducationById(long edu_id) {
		return this.em.find(Education.class, edu_id);
	}



	@Override
	public List<Education> listAllEducation() {
		List<Education> list = em.createQuery("SELECT e FROM Education e").getResultList();
		return list;
	}

}

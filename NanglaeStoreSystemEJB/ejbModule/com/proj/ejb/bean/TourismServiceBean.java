package com.proj.ejb.bean;

import java.util.List;

import javax.ejb.Remote;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import com.proj.ejb.entity.Tourism;
import com.proj.ejb.face.TourismService;

@Stateless
@Remote(TourismService.class)
public class TourismServiceBean implements TourismService {
	
	@PersistenceContext(unitName = "EJBDatebase")
	EntityManager em;

	@Override
	public void save(Tourism tour) {
		// TODO Auto-generated method stub
		this.em.persist(tour);
	}

	@Override
	public void update(Tourism tour) {
		// TODO Auto-generated method stub
		this.em.merge(tour);
	}

	@Override
	public void delete(long tour_id) {
		// TODO Auto-generated method stub
		Tourism tour = findTourismById(tour_id);
		if (tour != null) {
			em.remove(tour);
		}
	}

	@Override
	public Tourism findTourismById(long tour_id) {
		// TODO Auto-generated method stub
		return this.em.find(Tourism.class, tour_id);
	}

	@Override
	public List<Tourism> listAllTourism() {
		// TODO Auto-generated method stub
		List<Tourism> list = em.createQuery("SELECT tour FROM Tourism tour ORDER BY tour.tour_year DESC").getResultList();
		return list;
	}

}

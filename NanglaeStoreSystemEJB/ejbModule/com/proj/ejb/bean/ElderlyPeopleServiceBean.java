package com.proj.ejb.bean;

import java.util.List;

import javax.ejb.Remote;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import com.proj.ejb.entity.ElderlyPeople;
import com.proj.ejb.face.ElderlyPeopleService;

@Stateless
@Remote(ElderlyPeopleService.class)
public class ElderlyPeopleServiceBean implements ElderlyPeopleService {
	
	@PersistenceContext(unitName = "EJBDatebase")
	EntityManager em;

	@Override
	public void save(ElderlyPeople elder) {
		// TODO Auto-generated method stub
		this.em.persist(elder);
	}

	@Override
	public void update(ElderlyPeople elder) {
		// TODO Auto-generated method stub
		this.em.merge(elder);
	}

	@Override
	public void delete(long id) {
		// TODO Auto-generated method stub
		ElderlyPeople elder = findElderlyPeopleById(id);
		if (elder != null) {
			em.remove(elder);
		}
	}

	@Override
	public ElderlyPeople findElderlyPeopleById(long id) {
		// TODO Auto-generated method stub
		return this.em.find(ElderlyPeople.class, id);
	}

	@Override
	public List<ElderlyPeople> listAllElderlyPeople() {
		// TODO Auto-generated method stub
		List<ElderlyPeople> list = em.createQuery("SELECT elder FROM ElderlyPeople elder").getResultList();
		return list;
	}

}

package com.proj.ejb.bean;

import java.util.List;

import javax.ejb.Remote;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import com.proj.ejb.entity.Population1;
import com.proj.ejb.face.Population1Service;

@Stateless
@Remote(Population1Service.class)
public class Population1ServiceBean implements Population1Service {

	@PersistenceContext(unitName = "EJBDatebase")
	EntityManager em;

	
	@Override
	public void save(Population1 pop) {
		this.em.persist(pop);

	}

	@Override
	public void update(Population1 pop) {
		this.em.merge(pop);

	}

	@Override
	public void delete(long pop_id) {
		Population1 pop = findPopulation1ById(pop_id);
		if (pop != null) {
			em.remove(pop);
			;
		}

	}

	@Override
	public Population1 findPopulation1ById(long pop_id) {
		return this.em.find(Population1.class, pop_id);
	}

	@Override
	public List<Population1> listAllPopulation1() {
		List<Population1> list = em.createQuery("SELECT p FROM Population1 p ORDER BY p.pop_year DESC, p.location.vil_number").getResultList();
		return list;
	}

	@Override
	public List<Population1> searchPopulation1(String year, String vil) {
		System.out.print("Start Searching ...>>");
		System.out.println(vil + " bean");
		
		String select = "";
		String from = "";
		String where = "";
		
		select = "SELECT pop,vil";
		from = " FROM Population1 pop";
		
		if(year != "" || vil != "") {
			where += " WHERE";
		}
		
		if(year != "") {
			where += " pop.pop_year LIKE '%"+year+"%'";
			if(vil != "") {
				where = " AND";
			}
		}
		
		if(vil != "") {
			where += " pop.location.vil_name LIKE '%"+vil+"%'";
		}
		
		System.out.println(select+from+where);
		System.out.println("เทสๆๆ");
		
		List<Population1> list = em.createQuery(select+from+where+" ORDER BY pop.pop_year DESC, pop.location.vil_number").getResultList();
		
		System.out.println("Search Success");
		return list;
	}

}

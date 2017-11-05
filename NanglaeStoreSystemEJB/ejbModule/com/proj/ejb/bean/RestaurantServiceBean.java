package com.proj.ejb.bean;

import java.util.List;

import javax.ejb.Remote;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import com.proj.ejb.entity.Restaurant;
import com.proj.ejb.face.RestaurantService;

@Stateless
@Remote(RestaurantService.class)
public class RestaurantServiceBean implements RestaurantService {

	@PersistenceContext(unitName = "EJBDatebase")
	EntityManager em;

	@Override
	public void save(Restaurant res) {
		// TODO Auto-generated method stub
		this.em.persist(res);
	}

	@Override
	public void update(Restaurant res) {
		// TODO Auto-generated method stub
		this.em.merge(res);
	}

	@Override
	public void delete(long id) {
		// TODO Auto-generated method stub
		Restaurant res = findRestaurantById(id);
		if (res != null) {
			em.remove(res);
		}
	}

	@Override
	public Restaurant findRestaurantById(long id) {
		// TODO Auto-generated method stub
		return this.em.find(Restaurant.class, id);
	}

	@Override
	public List<Restaurant> listAllRestaurant() {
		// TODO Auto-generated method stub
		List<Restaurant> list = em.createQuery("SELECT restaurant FROM Restaurant restaurant").getResultList();
		return list;
	}

}

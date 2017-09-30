package com.proj.ejb.face;

import java.util.List;

import com.proj.ejb.entity.Restaurant;

public interface RestaurantService {
	public void save(Restaurant res);

	public void update(Restaurant res);

	public void delete(long id);

	public Restaurant findRestaurantById(long id);

	public List<Restaurant> listAllRestaurant();
}

package com.proj.ejb.bean;

import java.util.List;

import javax.ejb.Remote;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import com.proj.ejb.entity.Picture;
import com.proj.ejb.face.PictureService;

@Stateless
@Remote(PictureService.class)
public class PictureServiceBean implements PictureService{
	@PersistenceContext(unitName = "EJBDatebase")
	EntityManager em;

	@Override
	public void save(Picture pic) {
		// TODO Auto-generated method stub
		this.em.persist(pic);
	}

	@Override
	public void update(Picture pic) {
		// TODO Auto-generated method stub
		this.em.merge(pic);
	}

	@Override
	public void delete(long pic_id) {
		// TODO Auto-generated method stub
		Picture pic = findPictureById(pic_id);
		if (pic != null) {
			em.remove(pic);
		}
	}

	@Override
	public Picture findPictureById(long pic_id) {
		// TODO Auto-generated method stub
		return this.em.find(Picture.class, pic_id);
	}

	@Override
	public List<Picture> listAllPicture() {
		// TODO Auto-generated method stub
		List<Picture> list = em.createQuery("SELECT pic FROM Picture pic").getResultList();
		return list;
	}
	
	@Override
	public List<Picture> listAllPictureByTourOwner(long tour_owner) {
		// TODO Auto-generated method stub
		List<Picture> list = em.createQuery("SELECT pic FROM Picture pic WHERE pic.tour_owner.tour_id = :param1").setParameter("param1", tour_owner).getResultList();
		return list;
	}
}

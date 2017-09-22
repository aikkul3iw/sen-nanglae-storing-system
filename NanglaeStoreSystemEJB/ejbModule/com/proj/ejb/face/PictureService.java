package com.proj.ejb.face;

import java.util.List;

import com.proj.ejb.entity.Picture;

public interface PictureService {
	public void save(Picture pic);
	public void update(Picture pic);
	public void delete(long pic_id);
	public Picture findPictureById(long pic_id);
	public List<Picture> listAllPicture();
	public List<Picture> listAllPictureByTourOwner(long tour_owner);

}

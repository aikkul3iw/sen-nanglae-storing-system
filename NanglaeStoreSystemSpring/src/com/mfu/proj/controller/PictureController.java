package com.mfu.proj.controller;

import java.util.List;

import javax.ejb.EJB;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.proj.ejb.entity.Picture;
import com.proj.ejb.entity.User;
import com.proj.ejb.face.PictureService;

@Controller
public class PictureController {
	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//PictureServiceBean!com.proj.ejb.face.PictureService")
	PictureService picServ;

	@RequestMapping("/listPicture")
	public @ResponseBody List<Picture> listPicture(HttpServletRequest request) {

		List<Picture> agrList = null;
		try {
			agrList = picServ.listAllPicture();

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return agrList;
	}
	
	@RequestMapping("/listPictureByTour")
	public @ResponseBody List<Picture> listPictureByTour(HttpServletRequest request) {
		String owner = request.getParameter("owner");
		List<Picture> agrList = null;
		try {
			agrList = picServ.listAllPictureByTourOwner(Long.parseLong(owner));

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return agrList;
	}

	@RequestMapping("/savePicture")
	public @ResponseBody String savePicture(@RequestBody Picture Picture) {
		try {
			if (Picture.getPic_id() == 0) {
				picServ.save(Picture);
			} else {
				picServ.update(Picture);
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return "-1";
		}
		// 1 = sucess
		// -1 = failure
		return "1";
	}

	@RequestMapping("/deletePicture")
	public @ResponseBody String deletePicture(@RequestBody Picture Picture) {

		try {
			if (Picture.getPic_id() != 0) {
				picServ.delete(Picture.getPic_id());
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "-1";
		}
		return "1";
	}

	@RequestMapping("/findPicture")
	public @ResponseBody Picture findPicture(@RequestBody Picture Picture) {
		Picture result = null;
		try {

			result = picServ.findPictureById(Picture.getPic_id());

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

		return result;
	}

	@RequestMapping(value = "/userPicture", method = RequestMethod.GET)
	public ModelAndView displayuserPicture(HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		String getsession = "" + session.getAttribute("session");
		System.out.println("getdatasession " + getsession);

		if (!getsession.equals("null")) {
			ModelAndView model = new ModelAndView("userPicture");
			User loginBean = new User();
			model.addObject("loginBean", loginBean);
			return model;
		} else {

			System.out.println("Hello World 2");
			ModelAndView model = new ModelAndView("loginUser");
			User loginBean = new User();
			model.addObject("loginBean", loginBean);
			return model;
		}
	}

	@RequestMapping(value = "/nonPicture", method = RequestMethod.GET)
	public ModelAndView displaynonPicture(HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {

		
			ModelAndView model = new ModelAndView("nonPicture");
			
			return model;

		}
	

	@RequestMapping(value = "/superPicture", method = RequestMethod.GET)
	public ModelAndView displaysuperPicture(HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		String getsession = "" + session.getAttribute("session");
		System.out.println("getdatasession " + getsession);

		if (!getsession.equals("null")) {
			ModelAndView model = new ModelAndView("superPicture");
			User loginBean = new User();
			model.addObject("loginBean", loginBean);
			return model;
		} else {

			System.out.println("Hello World 2");
			ModelAndView model = new ModelAndView("loginUser");
			User loginBean = new User();
			model.addObject("loginBean", loginBean);
			return model;
		}
	}
	
	@RequestMapping("/listPictureByOwner2")
	public @ResponseBody List<String> listPictureByOwner2(HttpServletRequest request) {
		String ownerId = request.getParameter("owner");
		List<String> picList = null;
		try {
			List<Picture> pic = picServ.listAllPicture();
			for(Picture x:pic) {
				if(x.getPic_id()==Long.parseLong(ownerId)) {
					picList.add(x.getPic_name());
				}
			}

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return picList;
	}


}

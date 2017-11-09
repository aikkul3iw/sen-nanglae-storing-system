package com.mfu.proj.controller;

import java.util.Date;
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

import com.proj.ejb.entity.Activity;
import com.proj.ejb.entity.Localg;
import com.proj.ejb.entity.User;
import com.proj.ejb.face.ActivityService;
import com.proj.ejb.face.LocalgService;
import com.proj.ejb.face.UserService;

@Controller
public class LocalgController {
	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//LocalgServiceBean!com.proj.ejb.face.LocalgService")
	LocalgService grpServ;
	
	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//ActivityServiceBean!com.proj.ejb.face.ActivityService")
	ActivityService atvServ;
	
	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//UserServiceBean!com.proj.ejb.face.UserService")
	UserService userServ;

	@RequestMapping("/listLocalg")
	public @ResponseBody List<Localg> listLocalg(HttpServletRequest request) {

		List<Localg> grpList = null;
		try {
			grpList = grpServ.listAllLocalg();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return grpList;
	}

	@RequestMapping("/saveLocalg")
	public @ResponseBody String saveLocalg(@RequestBody Localg localg, HttpServletRequest request) {
		try {
			if (localg.getGrp_id() == 0) {
				String id = request.getParameter("user");
				grpServ.save(localg);
				Activity atv = new Activity();
				atv.setUser(userServ.findUserById(Long.parseLong(id)));
				atv.setAtv_date(new Date());
				atv.setAtc_action("เพิ่ม");
				atv.setAtv_data("กลุ่มในชุมชน");
				atvServ.save(atv);

			} else {
				String editid = request.getParameter("editUserId");
				grpServ.update(localg);
				Activity atv2 = new Activity();
				atv2.setUser(userServ.findUserById(Long.parseLong(editid)));
				atv2.setAtv_date(new Date());
				atv2.setAtc_action("แก้ไข");
				atv2.setAtv_data("กลุ่มในชุมชน");
				atvServ.save(atv2);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "-1";
		}
		return "1";
	}

	@RequestMapping("/deleteLocalg")
	public @ResponseBody String deleteLocalg(@RequestBody Localg localg) {

		try {
			if (localg.getGrp_id() != 0) {
				grpServ.delete(localg.getGrp_id());
				;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "-1";
		}
		return "1";
	}

	@RequestMapping("/findLocalg")
	public @ResponseBody Localg findLocalg(@RequestBody Localg localg) {
		Localg result = null;
		try {

			result = grpServ.findLocalgById(localg.getGrp_id());

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

		return result;
	}
	
	@RequestMapping(value="/userGroup",method=RequestMethod.GET)
	public ModelAndView displayuserGroup(HttpServletRequest request, HttpServletResponse response,HttpSession session) {
		String getsession = ""+ session.getAttribute("session");
		System.out.println("getdatasession "+getsession);

		if(!getsession.equals("null")){
					ModelAndView model = new ModelAndView("userGroup");
					User loginBean = new User();
					model.addObject("loginBean", loginBean);
					return model;
				}else{
					
					System.out.println("Hello World 2");
					ModelAndView model = new ModelAndView("loginUser");
					User loginBean = new User();
					model.addObject("loginBean", loginBean);
					return model;	
				}
		}
	@RequestMapping(value="/nonGroup",method=RequestMethod.GET)
	public ModelAndView displaynonGroup(HttpServletRequest request, HttpServletResponse response,HttpSession session) {
		
					ModelAndView model = new ModelAndView("nonGroup");
					return model;
		}
	@RequestMapping(value="/superGroup",method=RequestMethod.GET)
	public ModelAndView displaysuperGroup(HttpServletRequest request, HttpServletResponse response,HttpSession session) {
		String getsession = ""+ session.getAttribute("session");
		System.out.println("getdatasession "+getsession);

		if(!getsession.equals("null")){
					ModelAndView model = new ModelAndView("superGroup");
					User loginBean = new User();
					model.addObject("loginBean", loginBean);
					return model;
				}else{
					
					System.out.println("Hello World 2");
					ModelAndView model = new ModelAndView("loginUser");
					User loginBean = new User();
					model.addObject("loginBean", loginBean);
					return model;	
				}
		}
}

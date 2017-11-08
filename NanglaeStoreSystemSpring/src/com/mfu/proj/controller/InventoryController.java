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
import com.proj.ejb.entity.Inventory;
import com.proj.ejb.entity.User;
import com.proj.ejb.face.ActivityService;
import com.proj.ejb.face.InventoryService;
import com.proj.ejb.face.UserService;
@Controller
public class InventoryController {
	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//InventoryServiceBean!com.proj.ejb.face.InventoryService")
	InventoryService ivnServ;
	
	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//ActivityServiceBean!com.proj.ejb.face.ActivityService")
	ActivityService atvServ;
	
	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//UserServiceBean!com.proj.ejb.face.UserService")
	UserService userServ;

	@RequestMapping("/listInventory")
	public @ResponseBody List<Inventory> listInventory(HttpServletRequest request) {

		List<Inventory> ivnList = null;
		try {
			ivnList = ivnServ.listAllInventory();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return ivnList;
	}

	@RequestMapping("/saveInventory")
	public @ResponseBody String saveInventory(@RequestBody Inventory inventory, HttpServletRequest request) {
		try {
			if (inventory.getIvn_id() == 0) {
				String id = request.getParameter("user");
				ivnServ.save(inventory);
				Activity atv = new Activity();
				atv.setUser(userServ.findUserById(Long.parseLong(id)));
				atv.setAtv_date(new Date());
				atv.setAtc_action("เพิ่ม");
				atv.setAtv_data("การคลัง");
				atvServ.save(atv);
			} else {
				String editid = request.getParameter("editUserId");
				ivnServ.update(inventory);
				Activity atv2 = new Activity();
				atv2.setUser(userServ.findUserById(Long.parseLong(editid)));
				atv2.setAtv_date(new Date());
				atv2.setAtc_action("แก้ไข");
				atv2.setAtv_data("การคลัง");
				atvServ.save(atv2);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "-1";
		}
		return "1";
	}

	@RequestMapping("/deleteInventory")
	public @ResponseBody String deleteInventory(@RequestBody Inventory inventory) {

		try {
			if (inventory.getIvn_id() != 0) {
				ivnServ.delete(inventory.getIvn_id());
				;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "-1";
		}
		return "1";
	}

	@RequestMapping("/findInventory")
	public @ResponseBody Inventory findInventory(@RequestBody Inventory inventory) {
		Inventory result = null;
		try {

			result = ivnServ.findInventoryById(inventory.getIvn_id());

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

		return result;
	}
	
	@RequestMapping(value="/userInventory",method=RequestMethod.GET)
	public ModelAndView displayuserInventory(HttpServletRequest request, HttpServletResponse response,HttpSession session) {
		String getsession = ""+ session.getAttribute("session");
		System.out.println("getdatasession "+getsession);

		if(!getsession.equals("null")){
					ModelAndView model = new ModelAndView("userInventory");
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
	@RequestMapping(value="/nonInventory",method=RequestMethod.GET)
	public ModelAndView displaynonInventory(HttpServletRequest request, HttpServletResponse response,HttpSession session) {
		
					ModelAndView model = new ModelAndView("nonInventory");
					return model;
		}
	@RequestMapping(value="/superInventory",method=RequestMethod.GET)
	public ModelAndView displaysuperInventory(HttpServletRequest request, HttpServletResponse response,HttpSession session) {
		String getsession = ""+ session.getAttribute("session");
		System.out.println("getdatasession "+getsession);

		if(!getsession.equals("null")){
					ModelAndView model = new ModelAndView("superInventory");
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

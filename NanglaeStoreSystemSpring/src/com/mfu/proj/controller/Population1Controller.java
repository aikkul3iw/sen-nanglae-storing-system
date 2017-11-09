package com.mfu.proj.controller;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
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
import com.proj.ejb.entity.Population1;
import com.proj.ejb.entity.User;
import com.proj.ejb.face.ActivityService;
import com.proj.ejb.face.Population1Service;
import com.proj.ejb.face.UserService;
import com.proj.ejb.face.VillageService;

@Controller
public class Population1Controller {
	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//Population1ServiceBean!com.proj.ejb.face.Population1Service")
	Population1Service pop1Serv;
	
	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//VillageServiceBean!com.proj.ejb.face.VillageService")
	VillageService vilServ;
	
	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//ActivityServiceBean!com.proj.ejb.face.ActivityService")
	ActivityService atvServ;
	
	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//UserServiceBean!com.proj.ejb.face.UserService")
	UserService userServ;

	@RequestMapping("/listPopulation1")
	public @ResponseBody List<Population1> listPopulation1(HttpServletRequest request) {

		List<Population1> pop1List = null;
		try {
			pop1List = pop1Serv.listAllPopulation1();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return pop1List;
	}
	
	@RequestMapping("/searchAllPop2")
	public @ResponseBody List<Population1> searchAllPop2(HttpServletRequest request) {
		String year = request.getParameter("year");
		String vil = request.getParameter("vil");
		
		
		System.out.println(vil+" ctrl");
		
		List<Population1> pop1List = null;
		try {
			String vil2 = new String(vil.getBytes("UTF-8"),"UTF-8");
			System.out.println(vil2+" ตัวใหม่");
			pop1List = pop1Serv.searchPopulation1(year, vil);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return pop1List;
	}
	
	@RequestMapping("/searchAllPop")
	public @ResponseBody List<Population1> searchAllPop(HttpServletRequest request) {
		String year = request.getParameter("year");
		String vil = request.getParameter("vil");
		
		String driverName = "com.mysql.jdbc.Driver";

		String url = "jdbc:mysql://localhost:3306/";
		String db = "nanglaedb";
		String user = "root";
		String password = "1234";

		Connection connect = null;
		
		List<Population1> pop1List = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			connect = DriverManager.getConnection(url + db, user, password);
			if (connect != null) {
				System.out.println("Database Connected.");
				Statement st = connect.createStatement();
				
				System.out.print("Start Searching ...>>");
				
				String select = "";
				String from = "";
				String where = "";
				
				select = "SELECT pop";
				from = " FROM POPULATION1 pop";
				
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
					where += " pop.location.vil_number LIKE '%"+vil+"%'";
				}
				
				st.execute(select+from+where);
				
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return pop1List;
	}

	@RequestMapping("/savePopulation1")
	public @ResponseBody String savePopulation1(@RequestBody Population1 population1, HttpServletRequest request) {
		String pop = request.getParameter("id");
		try {
			if (population1.getPop_id() == 0) {
				String id = request.getParameter("user");
				population1.setLocation(vilServ.findVillageById(Long.parseLong(pop)));
				pop1Serv.save(population1);
				Activity atv = new Activity();
				atv.setUser(userServ.findUserById(Long.parseLong(id)));
				atv.setAtv_date(new Date());
				atv.setAtc_action("เพิ่ม");
				atv.setAtv_data("ประชากร");
				atvServ.save(atv);

			} else {
				String editid = request.getParameter("editUserId");
				population1.setLocation(vilServ.findVillageById(Long.parseLong(pop)));
				pop1Serv.update(population1);
				Activity atv2 = new Activity();
				atv2.setUser(userServ.findUserById(Long.parseLong(editid)));
				atv2.setAtv_date(new Date());
				atv2.setAtc_action("แก้ไข");
				atv2.setAtv_data("ประชากร");
				atvServ.save(atv2);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "-1";
		}
		return "1";
	}

	@RequestMapping("/deletePopulation1")
	public @ResponseBody String deletePopulation1(@RequestBody Population1 population1) {

		try {
			if (population1.getPop_id() != 0) {
				pop1Serv.delete(population1.getPop_id());
				;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "-1";
		}
		return "1";
	}

	@RequestMapping("/findPopulation1")
	public @ResponseBody Population1 findPopulation1(@RequestBody Population1 population1) {
		Population1 result = null;
		try {

			result = pop1Serv.findPopulation1ById(population1.getPop_id());

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

		return result;
	}
	
	@RequestMapping(value="/userPopulation",method=RequestMethod.GET)
	public ModelAndView displayuserPopulation(HttpServletRequest request, HttpServletResponse response,HttpSession session) {
		String getsession = ""+ session.getAttribute("session");
		System.out.println("getdatasession "+getsession);

		if(!getsession.equals("null")){
					ModelAndView model = new ModelAndView("userPopulation");
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
	@RequestMapping(value="/nonPopulation",method=RequestMethod.GET)
	public ModelAndView displaynonPopulation(HttpServletRequest request, HttpServletResponse response,HttpSession session) {
		
					ModelAndView model = new ModelAndView("nonPopulation");
					return model;
		}
	@RequestMapping(value="/superPopulation",method=RequestMethod.GET)
	public ModelAndView displaysuperPopulation(HttpServletRequest request, HttpServletResponse response,HttpSession session) {
		String getsession = ""+ session.getAttribute("session");
		System.out.println("getdatasession "+getsession);

		if(!getsession.equals("null")){
					ModelAndView model = new ModelAndView("superPopulation");
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

package com.mfu.proj.controller;

import java.util.List;

import javax.ejb.EJB;
import javax.jms.Session;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.proj.ejb.entity.Personnel;
import com.proj.ejb.entity.User;
import com.proj.ejb.face.PersonnelService;
import com.proj.ejb.face.UserService;

@Controller
public class UserController {
	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//UserServiceBean!com.proj.ejb.face.UserService")
	UserService userServ;

	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//PersonnelServiceBean!com.proj.ejb.face.PersonnelService")
	PersonnelService perServ;

	@RequestMapping(value = "/index", method = RequestMethod.GET)
	public ModelAndView displayIndex(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		session.setAttribute("session", null);
		System.out.println();
		ModelAndView model = new ModelAndView("index");

		return model;
	}

	@RequestMapping(value = "/superIndex", method = RequestMethod.GET)
	public ModelAndView displaysuperIndex(HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		String getsession = "" + session.getAttribute("session");
		System.out.println("getdatasession " + getsession);

		if (!getsession.equals("null")) {

			System.out.println("Hello World 1");
			ModelAndView model = new ModelAndView("superIndex");
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

	@RequestMapping(value = "/userIndex", method = RequestMethod.GET)
	public ModelAndView displayuserIndex(HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		String getsession = "" + session.getAttribute("session");
		System.out.println("getdatasession " + getsession);
		if (!getsession.equals("null")) {

			ModelAndView model = new ModelAndView("userIndex");
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

	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public ModelAndView displayLogin(HttpServletRequest request, HttpServletResponse response) {
		ModelAndView model = new ModelAndView("loginUser");
		User loginBean = new User();
		model.addObject("loginBean", loginBean);

		return model;
	}

	@RequestMapping(value = "/superCreateUser", method = RequestMethod.GET)
	public ModelAndView displaysuperCreateUser(HttpServletRequest request, HttpServletResponse response,
			HttpSession session) {
		String getsession = "" + session.getAttribute("session");

		if (!getsession.equals("null")) {
			System.out.println("Hello World 1");
			ModelAndView model = new ModelAndView("superCreateUser");
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

	@RequestMapping(value = "/logout", method = RequestMethod.GET)
	public ModelAndView displayLogout(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		ModelAndView model = new ModelAndView("index");

		session.setAttribute("session", null);
		session.setAttribute("Name",null);
	    session.setAttribute("user", null);
	    session.setAttribute("edituser", null);
	    session.setAttribute("userdelete", null);
		// String username = (String) request.getAttribute("loggedInUser");
		request.setAttribute("loggedInUser", null);
		User loginBean = new User();
		model.addObject("loginBean", loginBean);

		return model;
	}

	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public ModelAndView executeLogin(HttpServletRequest request, HttpServletResponse response, HttpSession session,
			@ModelAttribute("loginBean") User loginBean) {
		ModelAndView model = null;

		try {
			for (User user : userServ.listAllUser()) {
				System.out.println(user.getUser_id() + " ID " + user.getUsername() + " username " + user.getPassword()
						+ " password ");
			}

			List<User> isValidUser = userServ.login(loginBean.getUsername(), loginBean.getPassword());
			System.out.println(loginBean.getUsername() + " " + loginBean.getPassword());
			System.out.println("sssss : " + isValidUser);

			if (isValidUser.size() != 0) {
				System.out.println(isValidUser.get(0).getRole());
				Personnel map = isValidUser.get(0).getLocation();
				
			    session.setAttribute("Name",map.getPer_title() + map.getPer_firstname() + " " + map.getPer_lastname());

				if (isValidUser.get(0).getRole().equalsIgnoreCase("Superuser")) {
					
				    session.setAttribute("user", isValidUser.get(0).getUser_id());
				    session.setAttribute("edituser", isValidUser.get(0).getUser_id());
				    session.setAttribute("userdelete", isValidUser.get(0).getUser_id());
				    
					System.out.println("Login Superuser Successful");
					session.setAttribute("session", loginBean.getUsername());
					System.out.println("getdatasession" + session.getAttribute("session"));
					model = new ModelAndView("superIndex");

				} else if (isValidUser.get(0).getRole().equalsIgnoreCase("User")) {
					System.out.println("Login User Successful");
					session.setAttribute("session", loginBean.getUsername());
					model = new ModelAndView("userIndex");

				} else {
					System.out.println("Fail");
					model = new ModelAndView("loginUser");
					model.addObject("loginBean", loginBean);
					request.setAttribute("loginBean", "Invalid credentials!!");

				}
			} else {
				System.out.println("Fail");
				model = new ModelAndView("loginUser");
				model.addObject("loginBean", loginBean);
				request.setAttribute("loginBean", "Invalid credentials!!");
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return model;
	}

	@RequestMapping("/listUser")
	public @ResponseBody List<User> listUser(HttpServletRequest request) {

		List<User> user = null;
		try {
			user = userServ.listAllUser();

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return user;
	}

	@RequestMapping("/saveUser")
	public @ResponseBody String saveUser(@RequestBody User user, HttpServletRequest request) {
		String use = request.getParameter("id");

		try {
			if (user.getUser_id() == 0) {
				user.setLocation(perServ.findPersonnelById(Long.parseLong(use)));
				userServ.save(user);

			} else {
				user.setLocation(perServ.findPersonnelById(Long.parseLong(use)));
				userServ.update(user);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "-1";
		}
		return "1";
	}

	// 1 = sucess
	// -1 = failure

	@RequestMapping("/deleteUser")
	public @ResponseBody String deleteUser(@RequestBody User user) {

		try {
			if (user.getUser_id() != 0) {
				userServ.delete(user.getUser_id());
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "-1";
		}
		return "1";
	}

	@RequestMapping("/findUser")
	public @ResponseBody User findUser(@RequestBody User user) {
		User result = null;
		try {

			result = userServ.findUserById(user.getUser_id());

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

		return result;
	}

}

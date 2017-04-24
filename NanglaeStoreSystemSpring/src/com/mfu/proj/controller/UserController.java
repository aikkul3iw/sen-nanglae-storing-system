package com.mfu.proj.controller;

import java.util.List;

import javax.ejb.EJB;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.proj.ejb.entity.User;
import com.proj.ejb.face.UserService;


	@Controller
	public class UserController {
		@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//UserServiceBean!com.proj.ejb.face.UserService")
		UserService userServ;
		
		@RequestMapping(value="/login",method=RequestMethod.GET)
		public ModelAndView displayLogin(HttpServletRequest request, HttpServletResponse response) {
			ModelAndView model = new ModelAndView("loginUser.jsp");
			User loginBean = new User();
			model.addObject("loginBean", loginBean);
			
			return model;
		}
		
		@RequestMapping(value="/login",method=RequestMethod.POST)
		public ModelAndView executeLogin(HttpServletRequest request, HttpServletResponse response, 
				@ModelAttribute("loginBean")User loginBean){
			ModelAndView model= null;
			try{
			
				boolean isValidUser = userServ.login(loginBean.getUsername(),
						loginBean.getPassword());
				if(isValidUser){
					System.out.println("User Login Successful");
					request.setAttribute("loggedInUser", loginBean.getUsername());
					model = new ModelAndView("../pages/index.html");
				}
				else{
					model = new ModelAndView("agriculture.html");
					model.addObject("loginBean", loginBean);
					request.setAttribute("message", "Invalid credentials!!");
				}

			}
			catch(Exception e)
			{
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
		public @ResponseBody String saveAgriculture(@RequestBody User user) {
			try {
				if (user.getUser_id() == 0) {
					userServ.save(user);
				} else {
					userServ.update(user);
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

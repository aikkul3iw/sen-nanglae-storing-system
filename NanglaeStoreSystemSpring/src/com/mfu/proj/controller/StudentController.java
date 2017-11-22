package com.mfu.proj.controller;

import java.text.SimpleDateFormat;
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
import com.proj.ejb.entity.Student;
import com.proj.ejb.entity.User;
import com.proj.ejb.face.StudentService;
import com.proj.ejb.face.UserService;
import com.proj.ejb.face.ActivityService;
import com.proj.ejb.face.EducationService;

@Controller
public class StudentController {
	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//StudentServiceBean!com.proj.ejb.face.StudentService")
	StudentService comServ;

	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//EducationServiceBean!com.proj.ejb.face.EducationService")
	EducationService vilServ;
	
	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//ActivityServiceBean!com.proj.ejb.face.ActivityService")
	ActivityService atvServ;
	
	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//UserServiceBean!com.proj.ejb.face.UserService")
	UserService userServ;

	@RequestMapping("/listStudent")
	public @ResponseBody List<Student> listStudent(HttpServletRequest request) {

		List<Student> comList = null;
		try {
			comList = comServ.listAllStudent();

		} catch (Exception e) {
			e.printStackTrace();
		}

		return comList;
	}

	@RequestMapping("/saveStudent")
	public @ResponseBody String saveStudent(@RequestBody Student Student, HttpServletRequest request) {
		String mer = request.getParameter("id");
		try {
			if (Student.getStudentId() == 0) {
				String id = request.getParameter("user");;
				Student.setLocation(vilServ.findEducationById(Long.parseLong(mer)));
				comServ.save(Student);
				Activity atv = new Activity();
				atv.setUser(userServ.findUserById(Long.parseLong(id)));
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				String date = sdf.format(new Date());
				atv.setAtv_date(date);
				atv.setAtv_action("เพิ่ม");
				atv.setAtv_data("นักเรียน");
				atvServ.save(atv);

			} else {
				String editid = request.getParameter("editUserId");
				Student.setLocation(vilServ.findEducationById(Long.parseLong(mer)));
				comServ.update(Student);
				Activity atv2 = new Activity();
				atv2.setUser(userServ.findUserById(Long.parseLong(editid)));
				SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				String date = sdf.format(new Date());
				atv2.setAtv_date(date);
				atv2.setAtv_action("แก้ไข");
				atv2.setAtv_data("นักเรียน");
				atvServ.save(atv2);
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "-1";
		}
		return "1";
	}

	@RequestMapping("/deleteStudent")
	public @ResponseBody String deleteStudent(@RequestBody Student Student) {

		try {
			if (Student.getStudentId() != 0) {
				comServ.delete(Student.getStudentId());
				;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return "-1";
		}
		return "1";
	}

	@RequestMapping("/findStudent")
	public @ResponseBody Student findStudent(@RequestBody Student Student) {
		Student result = null;
		try {

			result = comServ.findStudentById(Student.getStudentId());

		} catch (Exception e) {
			e.printStackTrace();
			return null;
		}

		return result;
	}
	
	@RequestMapping(value="/userStudent",method=RequestMethod.GET)
	public ModelAndView displayuserStudent(HttpServletRequest request, HttpServletResponse response,HttpSession session) {
		String getsession = ""+ session.getAttribute("session");
		System.out.println("getdatasession "+getsession);

		if(!getsession.equals("null")){
					ModelAndView model = new ModelAndView("userStudent");
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
	@RequestMapping(value="/nonStudent",method=RequestMethod.GET)
	public ModelAndView displaynonStudent(HttpServletRequest request, HttpServletResponse response,HttpSession session) {
		
					ModelAndView model = new ModelAndView("nonStudent");
					
					return model;
				
		}
	@RequestMapping(value="/superStudent",method=RequestMethod.GET)
	public ModelAndView displaysuperStudent(HttpServletRequest request, HttpServletResponse response,HttpSession session) {
		String getsession = ""+ session.getAttribute("session");
		System.out.println("getdatasession "+getsession);

		if(!getsession.equals("null")){
					ModelAndView model = new ModelAndView("superStudent");
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

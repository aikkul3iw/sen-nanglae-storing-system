package com.mfu.proj.controller;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class DataController {
	
	@RequestMapping(value = "/testCopy", method = RequestMethod.GET)
	public ModelAndView testCopy(HttpServletRequest request, HttpServletResponse response) {
		String oldYear = request.getParameter("oldYear");
		String newYear = request.getParameter("newYear");

		System.out.println(oldYear + " " + newYear);

		String driverName = "com.mysql.jdbc.Driver";

		String url = "jdbc:mysql://localhost:3306/";
		String db = "nanglaedb";
		String user = "root";
		String password = "1234";

		Connection connect = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			connect = DriverManager.getConnection(url + db, user, password);
			if (connect != null) {
				System.out.println("Database Connected.");
				Statement st = connect.createStatement();
				/*
				System.out.print("Start copy Village ...>>");
				String sqlVil = "INSERT INTO nanglaedb.village (vil_chief, vil_name, vil_number, vil_year) SELECT vil_chief, vil_name, vil_number, '"
						+ newYear + "' FROM nanglaedb.village WHERE vil_year = '" + oldYear + "'";
				//System.out.println(sqlAgi);
				st.execute(sqlVil);
				System.out.println("Village was executed");
				
				System.out.print("Start copy Agriculture ...>>");
				String sqlAgi = "INSERT INTO nanglaedb.agriculture (agi_area, agi_description, agi_name, agi_year) SELECT agi_area, agi_description, agi_name, '"
						+ newYear + "' FROM nanglaedb.agriculture WHERE agi_year = '" + oldYear + "'";
				//System.out.println(sqlAgi);
				st.execute(sqlAgi);
				System.out.println("Agriculture was executed");
				
				System.out.print("Start copy Labor ...>>");
				String sqlLab = "INSERT INTO nanglaedb.labor (lab_amount, lab_type, lab_work, lab_year) SELECT lab_amount, lab_type, lab_work, '"
						+ newYear + "' FROM nanglaedb.labor WHERE lab_year = '" + oldYear + "'";
				//System.out.println(sqlLab);
				st.execute(sqlLab);
				System.out.println("Labor was executed");
				*/
				System.out.print("Start copy Health ...>>");
				String sqlHlt = "INSERT INTO nanglaedb.health (hlt_name, hlt_service_area, hlt_type, location_vil_id, hlt_year) SELECT hlt_name, hlt_service_area, hlt_type, location_vil_id, '"
						+ newYear + "' FROM nanglaedb.health WHERE hlt_year = '" + oldYear + "'";
				//System.out.println(sqlHlt);
				st.execute(sqlHlt);
				System.out.println("Health was executed");
				
				
			} else {
				System.out.println("Database Connect Failed.");
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		// Close
		try {
			if (connect != null) {
				connect.close();
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		ModelAndView model = new ModelAndView("copy");
		return model;
	}

}

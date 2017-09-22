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
	
	@RequestMapping(value = "/userCopyData", method = RequestMethod.GET)
	public ModelAndView userCopyData(HttpServletRequest request, HttpServletResponse response) {
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
				
				System.out.print("Start copy Health ...>>");
				String sqlHlt = "INSERT INTO nanglaedb.health (hlt_name, hlt_service_area, hlt_type, location_vil_id, hlt_year) SELECT hlt_name, hlt_service_area, hlt_type, location_vil_id, '"
						+ newYear + "' FROM nanglaedb.health WHERE hlt_year = '" + oldYear + "'";
				//System.out.println(sqlHlt);
				st.execute(sqlHlt);
				System.out.println("Health was executed");
				
				System.out.print("Start copy Commerce ...>>");
				String sqlCom = "INSERT INTO nanglaedb.commerce (com_description, com_house_number, com_name, com_type, location_vil_id, com_year) SELECT com_description, com_house_number, com_name, com_type, location_vil_id, '"
						+ newYear + "' FROM nanglaedb.commerce WHERE com_year = '" + oldYear + "'";
				//System.out.println(sqlCom);
				st.execute(sqlCom);
				System.out.println("Commerce was executed");
				
				System.out.print("Start copy Drainage ...>>");
				String sqlDrain = "INSERT INTO nanglaedb.drainage (drain_location_connected, drain_name, location_vil_id, drain_year) SELECT drain_location_connected, drain_name, location_vil_id, '"
						+ newYear + "' FROM nanglaedb.drainage WHERE drain_year = '" + oldYear + "'";
				//System.out.println(sqlDrain);
				st.execute(sqlDrain);
				System.out.println("Drainage was executed");
				
				System.out.print("Start copy Education ...>>");
				String sqlEdu = "INSERT INTO nanglaedb.education (edu_name, edu_type, student, location_vil_id, edu_year) SELECT edu_name, edu_type, student, location_vil_id, '"
						+ newYear + "' FROM nanglaedb.education WHERE edu_year = '" + oldYear + "'";
				//System.out.println(sqlEdu);
				st.execute(sqlEdu);
				System.out.println("Education was executed");
				
				System.out.print("Start copy Electricity ...>>");
				String sqlElec = "INSERT INTO nanglaedb.electricity (elec_area, elec_status, location_vil_id, elec_year) SELECT elec_area, elec_status, location_vil_id, '"
						+ newYear + "' FROM nanglaedb.electricity WHERE elec_year = '" + oldYear + "'";
				//System.out.println(sqlElec);
				st.execute(sqlElec);
				System.out.println("Electricity was executed");
				
				System.out.print("Start copy Industry ...>>");
				String sqlIns = "INSERT INTO nanglaedb.industry (ins_labor, ins_name, ins_size, ins_type, location_vil_id, ins_year) SELECT ins_labor, ins_name, ins_size, ins_type, location_vil_id, '"
						+ newYear + "' FROM nanglaedb.industry WHERE ins_year = '" + oldYear + "'";
				//System.out.println(sqlIns);
				st.execute(sqlIns);
				System.out.println("Industry was executed");
				
				System.out.print("Start copy Inventory ...>>");
				String sqlInv = "INSERT INTO nanglaedb.inventory (inv_outcome, ivn_collect, ivn_gor_purchase, ivn_gov_provide, ivn_year) SELECT inv_outcome, ivn_collect, ivn_gor_purchase, ivn_gov_provide, '"
						+ newYear + "' FROM nanglaedb.inventory WHERE ivn_year = '" + oldYear + "'";
				//System.out.println(sqlInv);
				st.execute(sqlInv);
				System.out.println("Inventory was executed");
				
				System.out.print("Start copy LandResource ...>>");
				String sqlLand = "INSERT INTO nanglaedb.landresource (land_name, land_usage, land_year) SELECT land_name, land_usage, '"
						+ newYear + "' FROM nanglaedb.landresource WHERE land_year = '" + oldYear + "'";
				//System.out.println(sqlLand);
				st.execute(sqlLand);
				System.out.println("LandResource was executed");
				
				System.out.print("Start copy Lascrity ...>>");
				String sqlSec = "INSERT INTO nanglaedb.lasucrity (sec_member, sec_name, sec_year) SELECT sec_member, sec_name, '"
						+ newYear + "' FROM nanglaedb.lasucrity WHERE sec_year = '" + oldYear + "'";
				//System.out.println(sqlSec);
				st.execute(sqlSec);
				System.out.println("Lasucrity was executed");
				
				System.out.print("Start copy Group ...>>");
				String sqlGrp = "INSERT INTO nanglaedb.localg (grp_member, grp_name, grp_year) SELECT grp_member, grp_name, '"
						+ newYear + "' FROM nanglaedb.localg WHERE grp_year = '" + oldYear + "'";
				//System.out.println(sqlGrp);
				st.execute(sqlGrp);
				System.out.println("Group was executed");
				
				System.out.print("Start copy Personnel ...>>");
				String sqlPer = "INSERT INTO nanglaedb.personnel (per_address, per_email, per_firstname, per_lastname, per_picture, per_position, per_salary, per_tel_number, per_title, report, per_year) SELECT per_address, per_email, per_firstname, per_lastname, per_picture, per_position, per_salary, per_tel_number, per_title, report, '"
						+ newYear + "' FROM nanglaedb.personnel WHERE per_year = '" + oldYear + "'";
				//System.out.println(sqlPer);
				st.execute(sqlPer);
				System.out.println("Personnel was executed");
				
				System.out.print("Start copy Pipeline ...>>");
				String sqlPipe = "INSERT INTO nanglaedb.pipeline (pipe_system, pipe_use_from, location_vil_id, pipe_year) SELECT pipe_system, pipe_use_from, location_vil_id, '"
						+ newYear + "' FROM nanglaedb.pipeline WHERE pipe_year = '" + oldYear + "'";
				//System.out.println(sqlPipe);
				st.execute(sqlPipe);
				System.out.println("Pipeline was pipeline");
				
				System.out.print("Start copy Population1 ...>>");
				String sqlPop = "INSERT INTO nanglaedb.population1 (pop_chinese_nation_f, pop_chinese_nation_m, pop_elect15_f, pop_elect15_m, pop_elect18_f, pop_elect18_m, pop_elect20_f, pop_elect20_m, pop_house_amount, pop_military_select_join, pop_military_select_reg, pop_other_nation_f, pop_other_nation_m, pop_thai_nation_f, pop_thai_nation_m, location_vil_id, pop_year) SELECT pop_chinese_nation_f, pop_chinese_nation_m, pop_elect15_f, pop_elect15_m, pop_elect18_f, pop_elect18_m, pop_elect20_f, pop_elect20_m, pop_house_amount, pop_military_select_join, pop_military_select_reg, pop_other_nation_f, pop_other_nation_m, pop_thai_nation_f, pop_thai_nation_m, location_vil_id, '"
						+ newYear + "' FROM nanglaedb.population1 WHERE pop_year = '" + oldYear + "'";
				//System.out.println(sqlPop);
				st.execute(sqlPop);
				System.out.println("Population1 was executed");
				
				System.out.print("Start copy Religion ...>>");
				String sqlRel = "INSERT INTO nanglaedb.religion (rel_name, rel_type, location_vil_id, rel_year) SELECT rel_name, rel_type, location_vil_id, '"
						+ newYear + "' FROM nanglaedb.religion WHERE rel_year = '" + oldYear + "'";
				//System.out.println(sqlRel);
				st.execute(sqlRel);
				System.out.println("Religion was executed");
				
				System.out.print("Start copy Service ...>>");
				String sqlSer = "INSERT INTO nanglaedb.service (ser_capacity, ser_name, ser_year) SELECT ser_capacity, ser_name, '"
						+ newYear + "' FROM nanglaedb.service WHERE ser_year = '" + oldYear + "'";
				//System.out.println(sqlSer);
				st.execute(sqlSer);
				System.out.println("Service was executed");
				
				System.out.print("Start copy Tourism ...>>");
				String sqlTour = "INSERT INTO nanglaedb.tourism (tour_description, tour_name, location_vil_id, tour_year) SELECT tour_description, tour_name, location_vil_id, '"
						+ newYear + "' FROM nanglaedb.tourism WHERE tour_year = '" + oldYear + "'";
				//System.out.println(sqlTour);
				st.execute(sqlTour);
				System.out.println("Tourism was executed");
				
				System.out.print("Start copy Transport ...>>");
				String sqlTran = "INSERT INTO nanglaedb.transport (description, tran_name, type, tran_year) SELECT description, tran_name, type, '"
						+ newYear + "' FROM nanglaedb.transport WHERE tran_year = '" + oldYear + "'";
				//System.out.println(sqlTran);
				st.execute(sqlTran);
				System.out.println("Transport was executed");
				
				System.out.print("Start copy Water ...>>");
				String sqlWater = "INSERT INTO nanglaedb.water (water_name, water_type, location_vil_id, water_year) SELECT water_name, water_type, location_vil_id, '"
						+ newYear + "' FROM nanglaedb.water WHERE water_year = '" + oldYear + "'";
				//System.out.println(sqlWater);
				st.execute(sqlWater);
				System.out.println("Water was executed");
				
				System.out.print("Start copy Polution ...>>");
				String sqlPol = "INSERT INTO nanglaedb.polution (pol_area, pol_effect, pol_name, pol_year) SELECT pol_area, pol_effect, pol_name, '"
						+ newYear + "' FROM nanglaedb.polution WHERE pol_year = '" + oldYear + "'";
				//System.out.println(sqlPol);
				st.execute(sqlPol);
				System.out.println("Polution was executed");
				
				System.out.print("Start copy Forest ...>>");
				String sqlFrs = "INSERT INTO nanglaedb.forest (frs_name, frs_usage, location_vil_id, frs_year) SELECT frs_name, frs_usage, location_vil_id, '"
						+ newYear + "' FROM nanglaedb.forest WHERE frs_year = '" + oldYear + "'";
				//System.out.println(sqlFrs);
				st.execute(sqlFrs);
				System.out.println("Forest was executed");
				
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

		ModelAndView model = new ModelAndView("userCopy");
		return model;
	}
	
	@RequestMapping(value = "/superCopyData", method = RequestMethod.GET)
	public ModelAndView superCopyData(HttpServletRequest request, HttpServletResponse response) {
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
				
				System.out.print("Start copy Health ...>>");
				String sqlHlt = "INSERT INTO nanglaedb.health (hlt_name, hlt_service_area, hlt_type, location_vil_id, hlt_year) SELECT hlt_name, hlt_service_area, hlt_type, location_vil_id, '"
						+ newYear + "' FROM nanglaedb.health WHERE hlt_year = '" + oldYear + "'";
				//System.out.println(sqlHlt);
				st.execute(sqlHlt);
				System.out.println("Health was executed");
				
				System.out.print("Start copy Commerce ...>>");
				String sqlCom = "INSERT INTO nanglaedb.commerce (com_description, com_house_number, com_name, com_type, location_vil_id, com_year) SELECT com_description, com_house_number, com_name, com_type, location_vil_id, '"
						+ newYear + "' FROM nanglaedb.commerce WHERE com_year = '" + oldYear + "'";
				//System.out.println(sqlCom);
				st.execute(sqlCom);
				System.out.println("Commerce was executed");
				
				System.out.print("Start copy Drainage ...>>");
				String sqlDrain = "INSERT INTO nanglaedb.drainage (drain_location_connected, drain_name, location_vil_id, drain_year) SELECT drain_location_connected, drain_name, location_vil_id, '"
						+ newYear + "' FROM nanglaedb.drainage WHERE drain_year = '" + oldYear + "'";
				//System.out.println(sqlDrain);
				st.execute(sqlDrain);
				System.out.println("Drainage was executed");
				
				System.out.print("Start copy Education ...>>");
				String sqlEdu = "INSERT INTO nanglaedb.education (edu_name, edu_type, student, location_vil_id, edu_year) SELECT edu_name, edu_type, student, location_vil_id, '"
						+ newYear + "' FROM nanglaedb.education WHERE edu_year = '" + oldYear + "'";
				//System.out.println(sqlEdu);
				st.execute(sqlEdu);
				System.out.println("Education was executed");
				
				System.out.print("Start copy Electricity ...>>");
				String sqlElec = "INSERT INTO nanglaedb.electricity (elec_area, elec_status, location_vil_id, elec_year) SELECT elec_area, elec_status, location_vil_id, '"
						+ newYear + "' FROM nanglaedb.electricity WHERE elec_year = '" + oldYear + "'";
				//System.out.println(sqlElec);
				st.execute(sqlElec);
				System.out.println("Electricity was executed");
				
				System.out.print("Start copy Industry ...>>");
				String sqlIns = "INSERT INTO nanglaedb.industry (ins_labor, ins_name, ins_size, ins_type, location_vil_id, ins_year) SELECT ins_labor, ins_name, ins_size, ins_type, location_vil_id, '"
						+ newYear + "' FROM nanglaedb.industry WHERE ins_year = '" + oldYear + "'";
				//System.out.println(sqlIns);
				st.execute(sqlIns);
				System.out.println("Industry was executed");
				
				System.out.print("Start copy Inventory ...>>");
				String sqlInv = "INSERT INTO nanglaedb.inventory (inv_outcome, ivn_collect, ivn_gor_purchase, ivn_gov_provide, ivn_year) SELECT inv_outcome, ivn_collect, ivn_gor_purchase, ivn_gov_provide, '"
						+ newYear + "' FROM nanglaedb.inventory WHERE ivn_year = '" + oldYear + "'";
				//System.out.println(sqlInv);
				st.execute(sqlInv);
				System.out.println("Inventory was executed");
				
				System.out.print("Start copy LandResource ...>>");
				String sqlLand = "INSERT INTO nanglaedb.landresource (land_name, land_usage, land_year) SELECT land_name, land_usage, '"
						+ newYear + "' FROM nanglaedb.landresource WHERE land_year = '" + oldYear + "'";
				//System.out.println(sqlLand);
				st.execute(sqlLand);
				System.out.println("LandResource was executed");
				
				System.out.print("Start copy Lascrity ...>>");
				String sqlSec = "INSERT INTO nanglaedb.lasucrity (sec_member, sec_name, sec_year) SELECT sec_member, sec_name, '"
						+ newYear + "' FROM nanglaedb.lasucrity WHERE sec_year = '" + oldYear + "'";
				//System.out.println(sqlSec);
				st.execute(sqlSec);
				System.out.println("Lasucrity was executed");
				
				System.out.print("Start copy Group ...>>");
				String sqlGrp = "INSERT INTO nanglaedb.localg (grp_member, grp_name, grp_year) SELECT grp_member, grp_name, '"
						+ newYear + "' FROM nanglaedb.localg WHERE grp_year = '" + oldYear + "'";
				//System.out.println(sqlGrp);
				st.execute(sqlGrp);
				System.out.println("Group was executed");
				
				System.out.print("Start copy Personnel ...>>");
				String sqlPer = "INSERT INTO nanglaedb.personnel (per_address, per_email, per_firstname, per_lastname, per_picture, per_position, per_salary, per_tel_number, per_title, report, per_year) SELECT per_address, per_email, per_firstname, per_lastname, per_picture, per_position, per_salary, per_tel_number, per_title, report, '"
						+ newYear + "' FROM nanglaedb.personnel WHERE per_year = '" + oldYear + "'";
				//System.out.println(sqlPer);
				st.execute(sqlPer);
				System.out.println("Personnel was executed");
				
				System.out.print("Start copy Pipeline ...>>");
				String sqlPipe = "INSERT INTO nanglaedb.pipeline (pipe_system, pipe_use_from, location_vil_id, pipe_year) SELECT pipe_system, pipe_use_from, location_vil_id, '"
						+ newYear + "' FROM nanglaedb.pipeline WHERE pipe_year = '" + oldYear + "'";
				//System.out.println(sqlPipe);
				st.execute(sqlPipe);
				System.out.println("Pipeline was pipeline");
				
				System.out.print("Start copy Population1 ...>>");
				String sqlPop = "INSERT INTO nanglaedb.population1 (pop_chinese_nation_f, pop_chinese_nation_m, pop_elect15_f, pop_elect15_m, pop_elect18_f, pop_elect18_m, pop_elect20_f, pop_elect20_m, pop_house_amount, pop_military_select_join, pop_military_select_reg, pop_other_nation_f, pop_other_nation_m, pop_thai_nation_f, pop_thai_nation_m, location_vil_id, pop_year) SELECT pop_chinese_nation_f, pop_chinese_nation_m, pop_elect15_f, pop_elect15_m, pop_elect18_f, pop_elect18_m, pop_elect20_f, pop_elect20_m, pop_house_amount, pop_military_select_join, pop_military_select_reg, pop_other_nation_f, pop_other_nation_m, pop_thai_nation_f, pop_thai_nation_m, location_vil_id, '"
						+ newYear + "' FROM nanglaedb.population1 WHERE pop_year = '" + oldYear + "'";
				//System.out.println(sqlPop);
				st.execute(sqlPop);
				System.out.println("Population1 was executed");
				
				System.out.print("Start copy Religion ...>>");
				String sqlRel = "INSERT INTO nanglaedb.religion (rel_name, rel_type, location_vil_id, rel_year) SELECT rel_name, rel_type, location_vil_id, '"
						+ newYear + "' FROM nanglaedb.religion WHERE rel_year = '" + oldYear + "'";
				//System.out.println(sqlRel);
				st.execute(sqlRel);
				System.out.println("Religion was executed");
				
				System.out.print("Start copy Service ...>>");
				String sqlSer = "INSERT INTO nanglaedb.service (ser_capacity, ser_name, ser_year) SELECT ser_capacity, ser_name, '"
						+ newYear + "' FROM nanglaedb.service WHERE ser_year = '" + oldYear + "'";
				//System.out.println(sqlSer);
				st.execute(sqlSer);
				System.out.println("Service was executed");
				
				System.out.print("Start copy Tourism ...>>");
				String sqlTour = "INSERT INTO nanglaedb.tourism (tour_description, tour_name, location_vil_id, tour_year) SELECT tour_description, tour_name, location_vil_id, '"
						+ newYear + "' FROM nanglaedb.tourism WHERE tour_year = '" + oldYear + "'";
				//System.out.println(sqlTour);
				st.execute(sqlTour);
				System.out.println("Tourism was executed");
				
				System.out.print("Start copy Transport ...>>");
				String sqlTran = "INSERT INTO nanglaedb.transport (description, tran_name, type, tran_year) SELECT description, tran_name, type, '"
						+ newYear + "' FROM nanglaedb.transport WHERE tran_year = '" + oldYear + "'";
				//System.out.println(sqlTran);
				st.execute(sqlTran);
				System.out.println("Transport was executed");
				
				System.out.print("Start copy Water ...>>");
				String sqlWater = "INSERT INTO nanglaedb.water (water_name, water_type, location_vil_id, water_year) SELECT water_name, water_type, location_vil_id, '"
						+ newYear + "' FROM nanglaedb.water WHERE water_year = '" + oldYear + "'";
				//System.out.println(sqlWater);
				st.execute(sqlWater);
				System.out.println("Water was executed");
				
				System.out.print("Start copy Polution ...>>");
				String sqlPol = "INSERT INTO nanglaedb.polution (pol_area, pol_effect, pol_name, pol_year) SELECT pol_area, pol_effect, pol_name, '"
						+ newYear + "' FROM nanglaedb.polution WHERE pol_year = '" + oldYear + "'";
				//System.out.println(sqlPol);
				st.execute(sqlPol);
				System.out.println("Polution was executed");
				
				System.out.print("Start copy Forest ...>>");
				String sqlFrs = "INSERT INTO nanglaedb.forest (frs_name, frs_usage, location_vil_id, frs_year) SELECT frs_name, frs_usage, location_vil_id, '"
						+ newYear + "' FROM nanglaedb.forest WHERE frs_year = '" + oldYear + "'";
				//System.out.println(sqlFrs);
				st.execute(sqlFrs);
				System.out.println("Forest was executed");
				
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

		ModelAndView model = new ModelAndView("superCopy");
		return model;
	}
	

}

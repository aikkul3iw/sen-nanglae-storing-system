package com.mfu.proj.controller;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.naming.NamingException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperCompileManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.JasperRunManager;
import net.sf.jasperreports.engine.export.HtmlExporter;
import net.sf.jasperreports.engine.util.JRLoader;
import net.sf.jasperreports.export.SimpleExporterInput;
import net.sf.jasperreports.export.SimpleHtmlExporterOutput;
import net.sf.jasperreports.export.SimpleHtmlReportConfiguration;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.proj.ejb.entity.Personnel;


@Controller
public class ReportPersonnelController {

	@ModelAttribute("jasperRptFormats")
	public ArrayList getJasperRptFormats() {
		ArrayList<String> jasperPersonRptFormats = new ArrayList<String>();
		jasperPersonRptFormats.add("Html");
		jasperPersonRptFormats.add("PDF");

		return jasperPersonRptFormats;
	}

	@RequestMapping(value = "/loadPersonnelJasper", method = RequestMethod.GET)
	public String loadSurveyPg(@ModelAttribute("jasperInputFormPerson") Personnel personnel, Model model) {
		model.addAttribute("jasperInputFormPerson", personnel);

		return "loadPersonnelJaspers";
	}

	@RequestMapping(value = "/generateReportPerson", method = RequestMethod.POST)
	public String generateReport(@Valid @ModelAttribute("jasperInputFormPerson") Personnel jasperInputFormPerson, BindingResult result,
			Model model, HttpServletRequest request, HttpServletResponse response) throws ParseException {

		if (result.hasErrors()) {
			System.out.println("validation error occured in jasper input form");
			return "loadPersonnelJaspers";

		}

		String reportFileName = "report4";

		Connection conn = null;
		try {
			try {

				Class.forName("com.mysql.jdbc.Driver");

			} catch (ClassNotFoundException e) {
				System.out.println("Please include Classpath Where your MySQL Driver is located");
				e.printStackTrace();
			}
			conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/nanglaedb", "root", "1234");

			if (conn != null) {
				System.out.println("Database Connected");
			} else {
				System.out.println(" connection Failed ");
			}

			String rptFormat = jasperInputFormPerson.getReport();
			int year = jasperInputFormPerson.getPer_year();

			System.out.println("report format " + rptFormat);
			System.out.println("Year " + year);

			// Parameters as Map to be passed to Jasper
			HashMap<String, Object> hmParams = new HashMap<String, Object>();

			hmParams.put("words", year);

			JasperReport jasperReport = getCompiledFile(reportFileName, request);

			if (rptFormat.equalsIgnoreCase("html")) {
				JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, hmParams, conn);
				System.out.println("006");
				generateReportHtml(jasperPrint, request, response); // For HTML
				// report

			}

			else if (rptFormat.equalsIgnoreCase("pdf")) {
				System.out.println("007");
				generateReportPDF(response, hmParams, jasperReport, conn); // For
																			// PDF
																			// report

			}

		} catch (Exception sqlExp) {
			System.out.println("001");
			System.out.println("Exception::" + sqlExp.toString());

		} finally {

			try {

				if (conn != null) {
					conn.close();
					conn = null;
				}

			} catch (SQLException expSQL) {
				System.out.println("005");
				System.out.println("SQLExp::CLOSING::" + expSQL.toString());

			}

		}

		return null;

	}

	private JasperReport getCompiledFile(String fileName, HttpServletRequest request) throws JRException {
		System.out.println("002");
		System.out.println(
				"path " + request.getSession().getServletContext().getRealPath("/jasper/" + fileName + ".jasper"));
		File reportFile = new File(
				request.getSession().getServletContext().getRealPath("/jasper/" + fileName + ".jasper"));
		// If compiled file is not found, then compile XML template
		if (!reportFile.exists()) {
			JasperCompileManager.compileReportToFile(
					request.getSession().getServletContext().getRealPath("/jasper/" + fileName + ".jrxml"),
					request.getSession().getServletContext().getRealPath("/jasper/" + fileName + ".jasper"));
		}
		JasperReport jasperReport = (JasperReport) JRLoader.loadObjectFromFile(reportFile.getPath());
		return jasperReport;
	}

	private void generateReportHtml(JasperPrint jasperPrint, HttpServletRequest req, HttpServletResponse resp)
			throws IOException, JRException {
		System.out.println("003");
		HtmlExporter exporter = new HtmlExporter();
		List<JasperPrint> jasperPrintList = new ArrayList<JasperPrint>();
		jasperPrintList.add(jasperPrint);
		exporter.setExporterInput(SimpleExporterInput.getInstance(jasperPrintList));
		exporter.setExporterOutput(new SimpleHtmlExporterOutput(resp.getWriter()));
		SimpleHtmlReportConfiguration configuration = new SimpleHtmlReportConfiguration();
		exporter.setConfiguration(configuration);
		exporter.exportReport();
		System.out.println("009");

	}

	private void generateReportPDF(HttpServletResponse resp, Map parameters, JasperReport jasperReport, Connection conn)
			throws JRException, NamingException, SQLException, IOException {
		byte[] bytes = null;

		System.out.println("004");
		bytes = JasperRunManager.runReportToPdf(jasperReport, parameters, conn);
		System.out.println("008");
		resp.reset();
		resp.resetBuffer();
		resp.setContentType("application/pdf");
		resp.setContentLength(bytes.length);
		ServletOutputStream ouputStream = resp.getOutputStream();
		ouputStream.write(bytes, 0, bytes.length);
		ouputStream.flush();
		ouputStream.close();

	}

}

package com.mfu.proj.controller;

import java.io.IOException;

import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import org.apache.commons.io.IOUtils;

import com.proj.ejb.entity.Picture;
import com.proj.ejb.entity.Tourism;
import com.proj.ejb.face.PictureService;
import com.proj.ejb.face.TourismService;

import java.util.*;

@WebServlet("/UploadServlet2")
@MultipartConfig(maxFileSize = 25177215)
public class UploadServlet2 extends HttpServlet {
	private static final long serialVersionUID = 1L;
	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//PictureServiceBean!com.proj.ejb.face.PictureService")
	PictureService picServ;
	
	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//TourismServiceBean!com.proj.ejb.face.TourismService")
	TourismService tourServ;
       
    public UploadServlet2() {
        super();
        // TODO Auto-generated constructor stub
    }
    
    @Override
	public void init() throws ServletException {
		super.init();
		System.out.println("init");
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter pw = response.getWriter();
		String id = request.getParameter("tourId");
		System.out.println(id);
		
		String afterpart = null;
		if (request.getPart("file") != null) {
			Part filePart = request.getPart("file");
			String fileName = getFileName(filePart);
			
			// String fileType = filePart.getContentType();
			InputStream fileContent = filePart.getInputStream();

			// Create folder if no existing folder
			File folderPart = new File("E:\\Git\\sen-nanglae-storing-system\\NanglaeStoreSystemSpring\\WebContent\\images\\");
			if (!folderPart.exists()) {
				folderPart.mkdir();
			}

			try {

				// Directory
				afterpart = "E:\\Git\\sen-nanglae-storing-system\\NanglaeStoreSystemSpring\\WebContent\\images\\"+ fileName;
				// Copy file to the part that we set before.
				FileOutputStream output = new FileOutputStream(afterpart);
				IOUtils.copy(fileContent, output);

				afterpart = fileName;
				
				System.out.println(afterpart);
				
				Tourism tour = tourServ.findTourismById(Long.parseLong(id));
				
				Picture pic = new Picture();
				pic.setPic_name(afterpart);
				pic.setTour_owner(tour);
				picServ.save(pic);
				

			} catch (Exception e) {
				afterpart = "http://www.taurus-bd.com/data/frontImages/news/page_thumb/no-imager.jpg";
			}

		}
		
		doGet(request, response);
		
		//getServletContext().getRequestDispatcher("/superTourism.do").forward(request, response);
	}
	
	private static String getFileName(Part part) {
	    for (String cd : part.getHeader("content-disposition").split(";")) {
	        if (cd.trim().startsWith("filename")) {
	            String fileName = cd.substring(cd.indexOf('=') + 1).trim().replace("\"", "");
	            return fileName.substring(fileName.lastIndexOf('/') + 1).substring(fileName.lastIndexOf('\\') + 1); // MSIE fix.
	        }
	    }
	    return null;
	}

}

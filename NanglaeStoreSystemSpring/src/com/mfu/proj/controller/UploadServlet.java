package com.mfu.proj.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.File;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;

import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

import com.itextpdf.text.log.SysoLogger;
import com.proj.ejb.entity.Picture;
import com.proj.ejb.face.PictureService;

@WebServlet("/UploadServlet")
public class UploadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private File file;
	@EJB(mappedName = "ejb:/NanglaeStoreSystemEJB//PictureServiceBean!com.proj.ejb.face.PictureService")
	PictureService picServ;
	
	public UploadServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		System.out.println("Upload is processing .. ");

		boolean isMultipart;
		String filePath;
		int maxFileSize = 900000 * 1024;
		int maxMemSize = 50 * 1024;
		filePath = getServletContext().getInitParameter("file_upload");

		isMultipart = ServletFileUpload.isMultipartContent(request);
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		if (!isMultipart) {
			out.print("file not uploaded");
			return;
		}
		DiskFileItemFactory factory = new DiskFileItemFactory();
		factory.setSizeThreshold(maxFileSize);
		factory.setRepository(new File(filePath));
		ServletFileUpload upload = new ServletFileUpload(factory);
		upload.setFileSizeMax(maxFileSize);

		try {
			List<FileItem> fileItems = upload.parseRequest(request);
			System.out.println("fileItems ; " + fileItems);
			Iterator<FileItem> i = fileItems.iterator();
			if (fileItems.isEmpty()) {
				System.out.println("Emtyyyy");
			}
			while (i.hasNext()) {
				System.out.println("In Loop");
				FileItem fi = i.next();
				if (!fi.isFormField()) {
					String fieldName = fi.getFieldName();
					String fileName;
					// check file name which send pass url not null 
					if (request.getParameter("fileName") == null) {
						// set file name to original name 
						fileName = fi.getName();
					} else {
						// set file name to the name that send via url
						fileName = request.getParameter("fileName");
						request.getSession().setAttribute("currentUser_photo", request.getParameter("fileName"));
					}

					String contentType = fi.getContentType();
					boolean isInMemory = fi.isInMemory();
					long sizeInBytes = fi.getSize();
					if (fileName.lastIndexOf("\\") >= 0) {
						file = new File(filePath + fileName.substring(fileName.lastIndexOf("\\")));
					} else {
						file = new File(filePath + fileName.substring(fileName.lastIndexOf("\\") + 1));
					}
					fi.write(file);
					System.out.println(file);
					System.out.println(fileName);
					System.out.println(filePath);
					Picture pic = new Picture();
					//pic.setPic_name(file);
					//picServ.save(pic);
				}
			}
			
			response.sendRedirect(request.getParameter("page"));
			System.out.println("out of loop");
			
		} catch (Exception e) {
			out.println(e);
			System.out.println(e);
		}
	}
}

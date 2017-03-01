<%@ page language="java" contentType="text/html; charset=ISO-8859-1"     pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<html>
<head>
<style>
.error {
    color: #ff0000;
}
 
</style>
</head>
 
<body>
    <h2>Generate report personnel!!</h2>
 
    <form:form method="POST" action="generateReportPerson.do" commandName="jasperInputFormPerson">
 
        <table id="reptbl" width="350px" border="1">
        <tr>
        <td colspan="2"><form:errors path="per_year" cssClass="error"/></td> </tr>
        <tr>
            <td>
                Year : <form:input path="per_year" id="per_year" name="per_year"/>
                <input type="submit"  value="Generate List"  />
            </td>
            <td>
                <form:radiobuttons path="report" items="${jasperRptFormats}"/>
            </td>
 
        </tr>
 
         </table>  
 
    </form:form>
 
</body>
</html>
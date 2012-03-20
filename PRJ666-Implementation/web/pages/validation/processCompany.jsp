<%-- 
    Document   : processCompany
    Created on : Jan 26, 2012, 8:36:46 PM
    Author     : matthewschranz
--%>

<%@page import="seneca.projectManagement.entity.Company"%>
<jsp:useBean id="userBean" class="seneca.projectManagement.entity.UserSession" scope="session" />
<jsp:setProperty name="userBean" property="*" />

  <%    
    boolean errorFound = false;
    
    if("true".equals(request.getParameter("UpdateCompanyInfo"))){
        Company company = userBean.getCompany();
        String errors="";
        String mCompanyName = request.getParameter("companyName");
        String mCompanyDescription = request.getParameter("companyDescription");
        String mBusinessAreas = request.getParameter("businessAreas");
        String mCompanyPhone = request.getParameter("companyPhone");

        if(mCompanyName == null || mCompanyName.isEmpty()){
            errorFound = true;
            errors += "&cname=1";
        }else if(mCompanyName.length() > 25){
            errorFound = true;
            errors += "&cname=2";                   
        }else{
            company.setCompanyName(mCompanyName);
        } 
                     
        if(mCompanyDescription == null || mCompanyDescription.isEmpty()){
            errorFound = true;
            errors += "&cdesc=1";
        }else if(mCompanyDescription.length() > 600){
            errorFound = true;      
            errors += "&cdesc=2";
        }else{
            company.setCompanyDescription(mCompanyDescription);
        }     

        if(mBusinessAreas == null || mBusinessAreas.isEmpty()){
            errorFound = true;
            errors += "&cbusa=1";
        }else if(mBusinessAreas.length() > 200){
            errorFound = true;
            errors += "&cbusa=2";
        }else{
            company.setBusinessAreas(mBusinessAreas);
        }  
               
        if(mCompanyPhone == null || mCompanyPhone.isEmpty()){
            errorFound = true;
            errors += "&cphon=1";
        }else if(mCompanyPhone.length() > 12){
            errorFound = true; 
            errors += "&cphon=2";
        }else{
            company.setCompanyPhone(mCompanyPhone);
        }
        
        if(!errorFound){
            if( userBean.updateCompany(company) == false){
                errorFound = true;
                response.sendRedirect("../Company/ManageCompanyInfo.jsp?failed=1");
            }else{
                response.sendRedirect("../Company/ManageCompanyInfo.jsp?updated=yes" );       
            }
                       
        }else{
            response.sendRedirect("../Company/ManageCompanyInfo.jsp?"+errors);
        }        
    }
  %>

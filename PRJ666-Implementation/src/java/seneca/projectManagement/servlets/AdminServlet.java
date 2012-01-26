/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package seneca.projectManagement.servlets;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import seneca.projectManagement.databaseClasses.Accounts;
import seneca.projectManagement.persistence.PersistenceController;

/**
 *
 * @author matthewschranz
 */

@WebServlet( urlPatterns = "/adserv" )
public class AdminServlet extends HttpServlet {
  /** 
   * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
   * @param request servlet request
   * @param response servlet response
   * @throws ServletException if a servlet-specific error occurs
   * @throws IOException if an I/O error occurs
   */
  protected void processRequest(HttpServletRequest request, HttpServletResponse response)
          throws ServletException, IOException {
    response.setContentType("text/html;charset=UTF-8");
    PrintWriter out = response.getWriter();
    
    /* This is statement basically checks to see if a particular hidden value is true
     * which will be if said page was the last one. 
     */
    if ("true".equals(request.getAttribute("testPage"))) {
      try {
        Accounts aAccount = new Accounts();
        aAccount.setUserfname("Chris");
        aAccount.setUserlname("De Cairos");
        aAccount.setUseremail("cdecairos@learn.senecac.on.ca");
        aAccount.setUseridentifier("PRJ566SUM2012");
        aAccount.setUserrole("TL");
        aAccount.setPassword("puppies");
        
        out.print("Before persistence call");
        if(PersistenceController.addAccount(aAccount)) {
          request.setAttribute("userAccount", aAccount);
          request.getRequestDispatcher("testServletResults.jsp").forward(request, response); 
        }
        else {
          out.print("Account was not successfully created");
        }
      } 
      catch (Exception e) {
        e.printStackTrace();
      }
      finally {
        out.close();
      }
    }
  }

  /** 
   * Handles the HTTP <code>GET</code> method.
   * @param request servlet request
   * @param response servlet response
   * @throws ServletException if a servlet-specific error occurs
   * @throws IOException if an I/O error occurs
   */
  @Override
  protected void doGet(HttpServletRequest request, HttpServletResponse response)
          throws ServletException, IOException {
    processRequest(request, response);
  }

  /** 
   * Handles the HTTP <code>POST</code> method.
   * @param request servlet request
   * @param response servlet response
   * @throws ServletException if a servlet-specific error occurs
   * @throws IOException if an I/O error occurs
   */
  @Override
  protected void doPost(HttpServletRequest request, HttpServletResponse response)
          throws ServletException, IOException {
    processRequest(request, response);
  }
}

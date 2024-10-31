package guest;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
@WebServlet("*.gu")
public class GuestController extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		GuestInterface command = null;
		String viewPage = "/WEB-INF/guest";
		
		String com = request.getRequestURI();
		com = com.substring(com.lastIndexOf("/"), com.lastIndexOf("."));
		
		if(com.equals("/GuestList")) {
			command = new GuestListCommand();
			command.execute(request, response);
			viewPage += "/guestList.jsp";
		}
		else if(com.equals("/GuestInput")) {
			viewPage += "/guestInput.jsp";
		}
		else if(com.equals("/GuestInputOk")) {
			command = new GuestInputOkCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		else if(com.equals("/GuestAdmin")) {
			viewPage += "/guestAdmin.jsp";
		}
		else if(com.equals("/GuestAdminOk")) {
			command = new GuestAdminOkCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		else if(com.equals("/GuestAdminOut")) {
			command = new GuestAdminOutCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		else if(com.equals("/GuestDeleteOk")) {
			command = new GuestDeleteOkCommand();
			command.execute(request, response);
			viewPage = "/include/message.jsp";
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}

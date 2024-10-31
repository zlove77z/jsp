package study2.database;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
@WebServlet("/study2/database/DbDeleteOk")
public class DbDeleteOk extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int idx = (request.getParameter("idx")==null || request.getParameter("idx").equals("")) ? 0 : Integer.parseInt(request.getParameter("idx"));
		
		DbTestDAO dao = new DbTestDAO();
		
		int res = dao.setDbDeleteOk(idx);

		if(res != 0) {
			request.setAttribute("message", "회원 정보가 삭제되었습니다.");
			request.setAttribute("url", "/study2/database/DbList");
		}
		else {
			request.setAttribute("message", "회원 정보삭제 실패~ 다시 가입해주세요.");
			request.setAttribute("url", "/study2/database/DbSearch?idx="+idx);
		}
		
		String viewPage = "/include/message.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);	
	}
}

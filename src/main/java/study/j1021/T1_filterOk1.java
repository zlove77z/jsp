package study.j1021;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@SuppressWarnings("serial")
@WebServlet("/1021/T1_filterOk1")
public class T1_filterOk1 extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		String content = request.getParameter("content")==null ? "" : request.getParameter("content");
		String introduce = request.getParameter("introduce")==null ? "" : request.getParameter("introduce");
		
		System.out.println("이곳은 /1021/introduce 입니다.");
		System.out.println("content : " + content);
		System.out.println("introduce : " + introduce);
		
		PrintWriter out = response.getWriter();
		out.println("이곳은 /1021/T1_filterOk1 컨트롤러 입니다.");
		
		request.setAttribute("msg", "T1_filterOk1에서 보내는 메세지 입니다.");
		
		String viewPage = "/study/1021_xml/t1_filterRes.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}

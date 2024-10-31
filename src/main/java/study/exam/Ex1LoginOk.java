package study.exam;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@SuppressWarnings("serial")
@WebServlet("/exam/Ex1LoginOk")
public class Ex1LoginOk extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String mid = request.getParameter("mid")==null ? "" : request.getParameter("mid");
		String pwd = request.getParameter("pwd")==null ? "" : request.getParameter("pwd");
		String idSave = request.getParameter("idSave")==null ? "off" : "on";
		
		// 넘어온 'mid/pwd'를 DB에서 검색후 확인이되면 로그인 처리한다.
		
		// 로그인 OK시에, idSave에 체크를 하였다면, 아이디를 쿠키에 저장처리한다. idSave에 체크해제되어 있다면 쿠키에서 제거한다.
		Cookie cookieMid = new Cookie("cMid", mid);
		cookieMid.setPath("/");
		if(idSave.equals("on")) {
			cookieMid.setMaxAge(60*60*24*7);
		}
		else {
			cookieMid.setMaxAge(0);
		}
		response.addCookie(cookieMid);
		
		
		// 모든 작업 처리후.... 회원 main창으로 보낸다.......
		HttpSession session = request.getSession();
		session.setAttribute("sMid", mid);
		
		request.setAttribute("message", mid + "님 로그인 되었습니다.....");
		
		String viewPage = "/study/exam/ex1_main.jsp";
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}

package admin;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import admin.member.MemberDetailViewCommand;
import admin.member.MemberLevelChangeCommand;
import admin.member.MemberListCommand;

@SuppressWarnings("serial")
@WebServlet("*.ad")
public class AdminController extends HttpServlet {
	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		AdminInterface command = null;
		String viewPage = "/WEB-INF/admin";
		
		String com = request.getRequestURI();
		com = com.substring(com.lastIndexOf("/"), com.lastIndexOf("."));
		
		// 인증처리.....(spring에서는 aop의 개념)
		HttpSession session = request.getSession();
		int level = session.getAttribute("sLevel")==null ? 999 : (int) session.getAttribute("sLevel");
		
		if(level != 0) {
			request.setAttribute("message", "로그인후 사용하세요");
			request.setAttribute("url", "/MemberLogin.mem");
			viewPage = "/include/message.jsp";
		}
		else if(com.equals("/AdminMain")) {
			viewPage += "/adminMain.jsp";
		}
		else if(com.equals("/AdminLeft")) {
			viewPage += "/adminLeft.jsp";
		}
		else if(com.equals("/AdminContent")) {
			viewPage += "/adminContent.jsp";
		}
		else if(com.equals("/MemberList")) {
			command = new MemberListCommand();
			command.execute(request, response);
			viewPage += "/member/memberList.jsp";
		}
		else if(com.equals("/MemberLevelChange")) {
			command = new MemberLevelChangeCommand();
			command.execute(request, response);
			return;
		}
		else if(com.equals("/MemberDetailView")) {
			command = new MemberDetailViewCommand();
			command.execute(request, response);
			viewPage += "/member/memberDetailView.jsp";
		}

		
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}

package board;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class BoardGoodCheck3Command implements BoardInterface {

	@Override
	public void execute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
			int idx = (request.getParameter("idx")==null || request.getParameter("idx").equals("")) ? 0 : Integer.parseInt(request.getParameter("idx"));
		
			BoardDAO dao = new BoardDAO();
			
			// 좋아요 증가처리(중복 불허)
			HttpSession session = request.getSession();
			ArrayList<String> contentGood = (ArrayList<String>) session.getAttribute("sContentGood");
			if(contentGood == null) contentGood = new ArrayList<String>();
			String imsicontentGood = "board" + idx;
			int res = 0;
			if(!contentGood.contains(imsicontentGood)) {
				res = dao.setBoardGoodCheck(idx, 1);
				contentGood.add(imsicontentGood);
			}
			session.setAttribute("sContentGood", contentGood);
			// 좋아요수 증가처리
			// int res = dao.setBoardGoodCheck(idx, 1);
			
			response.getWriter().write(res + "");
		}

}

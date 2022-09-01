package action;

import java.util.*;

import javax.servlet.http.*;

import svc.*;
import vo.*;

public class ServiceCenterMainAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = null;
		
		ServiceCenterMainService service = new ServiceCenterMainService();
		
		
		ArrayList<FAQDTO> faq5 = service.getSVFAQList(); 
		
		ArrayList<NoticeDTO> notice5 = service.getSVNoticeList();
		
		request.setAttribute("faq5", faq5);
		request.setAttribute("notice5", notice5);
		
		forward = new ActionForward();
		forward.setPath("serviceCenter/serviceCenterMain.jsp");
		forward.setRedirect(false);
		
		return forward;
	}

}

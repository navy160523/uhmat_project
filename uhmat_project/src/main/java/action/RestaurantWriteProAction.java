package action;

import java.io.PrintWriter;

import java.net.*;

import javax.servlet.http.*;


import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import svc.*;

import vo.*;

public class RestaurantWriteProAction implements Action {

	@Override
	public ActionForward execute(HttpServletRequest request, HttpServletResponse response) throws Exception {
		ActionForward forward = null;

		request.setCharacterEncoding("UTF-8");

		System.out.println("RestaurantWriteProAction");
		// 파일첨부를 위한 multipart request 사용
		String uploadPath = "/upload"; // 루트(webapp)의 하위 폴더 upload 에 저장

//	 	ServletContext context = request.getServletContext();
//	 	String realPath = context.getRealPath(uploadPath);
//	 	out.println(realPath);

		String realPath = request.getServletContext().getRealPath(uploadPath);
		int fileSize = 1024 * 1024 * 10; // byte -> MB -> 10MB
		MultipartRequest multi = new MultipartRequest(request, realPath, fileSize, "UTF-8",new DefaultFileRenamePolicy());

		RestaurantInfoDTO dto = new RestaurantInfoDTO();
		dto.setResName(multi.getParameter("res_name"));
		dto.setrPostcode(multi.getParameter("r_postcode"));
		dto.setAddress(multi.getParameter("address"));
		dto.setPhoneNumber(multi.getParameter("phone_number"));
		dto.setResInfo(multi.getParameter("res_info"));

		dto.setPhoto(multi.getFilesystemName("photo"));

		dto.setResLink(multi.getParameter("res_link"));
		
		//영업시간을 계산 및 합체
		//일단 한 컬럼에서 다 겹친 후 나중에 스플릿으로 "," 기준으로 나눔
		String[] opentime = multi.getParameterValues("opentime");
		String[] closetime = multi.getParameterValues("closetime");
		String workTime = "";
		for(int i=0;i<opentime.length;i++) {
			workTime += opentime[i]+"~"+closetime[i]+",";
		}
		dto.setOpentime(workTime);
		
		//식당의 위치정보를 입력하는 MAPDTO에 값을 저장 후 따로 입력
		MapDTO map = new MapDTO();
		map.setResName(multi.getParameter("res_name"));
		map.setLongitude(Double.parseDouble(multi.getParameter("longitude")));
		map.setLatitude(Double.parseDouble(multi.getParameter("latitude")));
		
		//Service 클래스를 호출하여 식당정보 입력!
		RestaurantWriteProService service = new RestaurantWriteProService();
		boolean isInsertSuccess = service.insertResInfo(dto);
		
		//SERVICE 클래스를 호출하여 식당 위치 정보 입력!
		MapWriteProService service2 = new MapWriteProService();
		service2.insertMapInfo(map);
		
		System.out.println(dto.getResName());
		if(isInsertSuccess) {
			forward = new ActionForward();
			//작업 후 상세보기 페이지로 이동!
			forward.setPath("restaurantDetail.re?resName="+URLEncoder.encode(dto.getResName(), "UTF-8"));
			forward.setRedirect(true);
		}else {
			PrintWriter out = response.getWriter(); 
			response.setContentType("text/html; charset=UTF-8");

			out.print("<script>alert('식당 입력 실패!');history.back();</script>");
		}
		
		return forward;
	}

}

package member;

import board.review.DetailReviewAction;
import board.review.GoReviewModify;
import board.review.ReviewDelete;
import board.review.ReviewMainAction;
import board.review.WriteReviewAction;
import room.SearchRoomAction;
import room.RoomLoginAction;
import room.ShowRoomAction;
import room.optionSelectAction;
import room.goWriteInfoACtion;
import room.reservationAction;
import board.EventNotice.*;

public class ActionFactory {
	private static final ActionFactory instance = new ActionFactory();
	private ActionFactory() {}
	public static ActionFactory getInstance() {
		return instance;
	}
	
	public Action getAction(String command) {
		Action action = null;
		switch(command) {
		case "RoomLoginAction":
			action = new RoomLoginAction();
			break;
		case "loginAction":
			action = new LoginAction();
			break;
		case "logoutAction":
			action = new LogoutAction();
			break;
		case "joinAction":
			action = new JoinAction();
			break;
		case "searchRoom":
			action = new SearchRoomAction();
			break;
		case "showRoom":
			action = new ShowRoomAction();
			break;
		case "adminMemberList":
			action = new AdminMemberList();
			break;
		case "optionSelect":
			System.out.println("optionSelectAction 클래스 실행");
			action = new optionSelectAction();
			break;
		case "goWriteInfo":
			System.out.println("gowriteInfoAction 클래스 실행");
			action = new goWriteInfoACtion();
			break;
		case "reservation":
			System.out.println("reservationAction 클래스 실행");
			action = new reservationAction();
			break;
		case "adminReservationList":
			action = new AdminReservationList();
			break;
		case "ModifyInfoAction":
			System.out.println("modifyInfoAction 클래스 실행");
			action = new ModifyInfoAction();
			break;
		case "updateMemberPw":
			System.out.println("updateMemberPw 클래스 실행");
			action = new updatePwAction();
			break;
		case "delInfo1Action":
			System.out.println("delInfo1 클래스 실행");
			action = new DelInfo1Action();
			break;
		case "delInfo2Action":
			System.out.println("delInfo2 클래스 실행");
			action = new DelInfo2Action();
			break;
		case "EnModifyAction" :
			System.out.println("이벤트 노티스 게시물 수정 클래스 실행");
			action = new EnModifyAction();
			break;
		case "EnWriteAction" :
			System.out.println("이벤트 노티스 게시글 쓰기 클래스 실행");
			action = new EnWriteAction();
			break;
		case "reviewmain":
			action = new ReviewMainAction();
			break;
		case "writeReview":
			action = new WriteReviewAction();
			break;
		case "detailReview":
			action = new DetailReviewAction();
			break;
		case "goReivewModifyPage":
			action = new GoReviewModify();
			break;
		case "reivewDelete":
			action = new ReviewDelete();
			break;
		}
		return action;
	}
}

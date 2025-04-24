package reply;

import java.util.ArrayList;
import java.util.List;

import db.DBManager;

public class ReplyDAO extends DBManager{
	
	//write
	public int write(ReplyVO vo) {
		String rauthor =vo.getReply_author();
		String no = vo.getBno();
		String rcontent = vo.getReply_content();
		
		driverLoad();
		DBConnect();
		
		String sql = "insert into reply(reply_author, board_no, reply_content)";
		sql += "values('"+rauthor+"', '"+no+"', '"+rcontent+"')";
		
		String selectSql = "select last_insert_id() as rno";
		executeUpdate(sql);
		executeQuery(selectSql);
		if(next()) {
			int rno = getInt("rno");
			DBDisConnect();
			return rno;
		}else {
			DBDisConnect();
			return 0;
		}
	}
	
	//modify
	public void modify(ReplyVO vo) {
		String rcontent = vo.getReply_content();
		String rno = vo.getRno();
		
		driverLoad();
		DBConnect();
		
		String sql = "update reply set reply_content = '"+rcontent+"',";
		sql += "reply_update_date = now() where reply_no = " + rno;
		
		executeUpdate(sql);
		DBDisConnect();
	}
	
	//delete
	public void delete(String rno) {
		driverLoad();
		DBConnect();
		
		String sql = "delete from reply where reply_no =" + rno;
		executeUpdate(sql);
		DBDisConnect();
	}
	
	//select
	public List<ReplyVO> select(String no){
		driverLoad();
		DBConnect();
		
		String sql = "select * from reply where board_no ="+ no;
		sql += " order by reply_no desc";
		
		executeQuery(sql);
		
		List<ReplyVO> list = new ArrayList<>();
		while(next()) {
			String rno = getString("reply_no");
			String rauthor = getString("reply_author");
			String rcontent = getString("reply_content");
			String createDate = getString("reply_create_date");
			String updateDate = getString("reply_update_date");
			
			ReplyVO vo = new ReplyVO();
			vo.setRno(rno);
			vo.setReply_author(rauthor);
			vo.setReply_content(rcontent);
			vo.setReply_create_date(createDate);
			vo.setReply_update_date(updateDate);
			list.add(vo);
			
		}
		DBDisConnect();
		return list;
	}
}

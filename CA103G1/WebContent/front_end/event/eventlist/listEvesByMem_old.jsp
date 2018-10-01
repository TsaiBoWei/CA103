<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.eventlist.model.*"%>
<%@ page import="com.mem.model.*"%>
<!DOCTYPE html>

<jsp:useBean id="eveSvc" scope="page" class="com.eve.model.EveService" />
<jsp:useBean id="evelistSvc" scope="page" class="com.eventlist.model.EventlistService" />
<jsp:useBean id="memSvc" scope="page" class="com.mem.model.MemService" />

<%	//���X�|����SESSION
	MemVO memVO = (MemVO) session.getAttribute("memVO"); 
%>
<%
	List<EventListVO> list=	evelistSvc.getEveListsByMem(memVO.getMem_id());
	pageContext.setAttribute("list",list);
%>



<html>
<head>
<title>�|�������ʲM�� - listEvesByMem.jsp</title>

  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>

<style>
  table#table-1 {
	background-color: #CCCCFF;
    border: 2px solid black;
    text-align: center;
  }
  table#table-1 h4 {
    color: red;
    display: block;
    margin-bottom: 1px;
  }
  h4 {
    color: blue;
    display: inline;
  }
</style>

<style>
  table {
	width: 800px;
	background-color: white;
	margin-top: 5px;
	margin-bottom: 5px;
  }
  table, th, td {
    border: 1px solid #CCCCFF;
  }
  th, td {
    padding: 5px;
    text-align: center;
  }
</style>

<style>
.myTable{
  width: 100%;
}
.myTable *{
  text-align: center;
}
</style>

</head>
<body bgcolor='white'>

<table id="table-1">
	<tr><td>
		 <h3>�|�������ʲM�� - listEvesByMem.jsp</h3>
		 <h4><a href="<%=request.getContextPath() %>/front_end/event/eventlist/select_page.jsp"><img src="images/back1.gif" width="100" height="32" border="0">�^����</a></h4>
	</td></tr>
</table>

<%-- ���~��C --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">�Эץ��H�U���~:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>
<% session.removeAttribute("errorMsgs"); %>

<table>
	<tr>
		<th>�|���W��</th>
		<th>���ʦW��</th>
		<th>���ʵ���</th>
		<th>���ʲM�檬�A</th>
		<th>���ʥI�ڪ��B</th>
		<th>���ʤ���</th>
		<th>���ʥI�ںI���</th>
		<th>�ק�</th>
		<th>�h�X</th>
	</tr>
	<%@ include file="page1.file" %> 
	<c:forEach var="eventListVO" items="${list}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
		
		<tr ${(eventListVO.mem_id==param.mem_id && eventListVO.eve_id==param.eve_id) ? 'bgcolor=#CCCCFF':''}>
			
			<td>
			 	<A href="<%=request.getContextPath() %>/eventlist/eventlist.do?mem_id=${eventListVO.mem_id}&eve_id=${eventListVO.eve_id}&action=getOne_modal&whichPage=<%=request.getParameter("whichPage")%>">
			    ${memSvc.getOneMem(eventListVO.mem_id).mem_name}
			    </A>			
			</td>
			<td>${eveSvc.getOneEve(eventListVO.eve_id).eve_title}</td>
			<td>
				<c:if test="${eveSvc.getOneEve(eventListVO.eve_id).eve_enddate.getTime()<System.currentTimeMillis()}">
					<c:if test="${eventListVO.eve_rating==0}">
						<input type='button' value='����'>
					</c:if>
					${(eventListVO.eve_rating==0)?"":eventListVO.eve_rating}				
				</c:if>	
			</td>
			<td>
				${eveListStatusMap.get(eventListVO.evelist_status)}
				<c:if test="${eventListVO.evelist_status=='EL1'}">
					<FORM METHOD="post" ACTION="<%=request.getContextPath() %>/eventlist/eventlist.do" style="margin-bottom: 0px;">
				     <input type="submit" value="�I��">
				     <input type="hidden" name="eve_id"  value="${eventListVO.eve_id}">
				     <input type="hidden" name="mem_id"  value="${eventListVO.mem_id}">
				     <input type="hidden" name="evelist_status"  value="${eventListVO.evelist_status}">
				     <input type="hidden" name="requestURL"	value="<%=request.getRequestURI()%>"><!--�e�X�����������|��Controller-->
				     <input type="hidden" name="whichPage"	value="<%=whichPage%>">
				     <input type="hidden" name="action"	value="Update_ELStatus"></FORM>	
			     </c:if>
			     
			     <c:if test="${eventListVO.evelist_status=='EL5'}">
					<FORM METHOD="post" ACTION="<%=request.getContextPath() %>/eventlist/eventlist.do" style="margin-bottom: 0px;">
				     <input type="submit" value="�T�{">
				     <input type="hidden" name="eve_id"  value="${eventListVO.eve_id}">
				     <input type="hidden" name="mem_id"  value="${eventListVO.mem_id}">
				     <input type="hidden" name="evelist_status"  value="${eventListVO.evelist_status}">
				     <input type="hidden" name="requestURL"	value="<%=request.getRequestURI()%>"><!--�e�X�����������|��Controller-->
				     <input type="hidden" name="whichPage"	value="<%=whichPage%>">
				     <input type="hidden" name="action"	value="Update_ELStatus"></FORM>	
			     </c:if>		
			</td>
			<td>${eventListVO.evepay_amount}</td>
			<td>
				<c:if test="${eventListVO.eve_share=='ES0'}">
						<BUTTON >
							<A href="<%=request.getContextPath() %>/eventlist/eventlist.do?mem_id=${eventListVO.mem_id}&eve_id=${eventListVO.eve_id}&action=update_ShareStatus&whichPage=<%=request.getParameter("whichPage")%>&sharestatus=ES1">
							����
							</A>
						</BUTTON>					
				</c:if>
				<c:if test="${eventListVO.eve_share=='ES1'}">
						<BUTTON >
						<A href="<%=request.getContextPath() %>/eventlist/eventlist.do?mem_id=${eventListVO.mem_id}&eve_id=${eventListVO.eve_id}&action=update_ShareStatus&whichPage=<%=request.getParameter("whichPage")%>&sharestatus=ES0">
							��������
							</A>
						</BUTTON>
				</c:if>
			
			</td> 
	
			
			<td>${eventListVO.evepay_deadline}</td>
			
			<td>
			  	<Button>
			  		<A href="<%=request.getContextPath() %>/eventlist/eventlist.do?mem_id=${eventListVO.mem_id}&eve_id=${eventListVO.eve_id}&action=update_modal&whichPage=<%=request.getParameter("whichPage")%>&requestURL=<%=request.getServletPath()%>">
			  		�ק�
			  		</A>
			  	</Button>
			     
			</td>
<!-- 			<td> -->
<%-- 			  <FORM METHOD="post" ACTION="<%=request.getContextPath() %>/eventlist/eventlist.do" style="margin-bottom: 0px;"> --%>
<!-- 			     <input type="submit" value="�ק�"> -->
<%-- 			     <input type="hidden" name="mem_id"  value="${eventListVO.mem_id}"> --%>
<%-- 			     <input type="hidden" name="eve_id"  value="${eventListVO.eve_id}"> --%>
<%-- 			     <input type="hidden" name="requestURL"	value="<%=request.getServletPath()%>"><!--�e�X�����������|��Controller--> --%>
<%-- 			     <input type="hidden" name="whichPage"	value="<%=whichPage%>">               <!--�e�X��e�O�ĴX����Controller--> --%>
<!-- 			     <input type="hidden" name="action"	value="getOne_For_Update"></FORM> -->
<!-- 			</td> -->
			<td>				
				<c:if test="${eventListVO.evelist_status=='EL0'|| eventListVO.evelist_status=='EL1'|| eventListVO.evelist_status=='EL3'}">
				
				  <FORM METHOD="post" ACTION="<%=request.getContextPath() %>/eventlist/eventlist.do" style="margin-bottom: 0px;">
				     <input type="submit" value="�h�X">
				     <input type="hidden" name="mem_id"  value="${eventListVO.mem_id}">
				     <input type="hidden" name="eve_id"  value="${eventListVO.eve_id}">
				     <input type="hidden" name="requestURL"	value="<%=request.getRequestURI()%>"><!--�e�X�����������|��Controller-->
				     <input type="hidden" name="whichPage"	value="<%=whichPage%>">
				     <input type="hidden" name="action" value="delete_By_Participant"></FORM>
				</c:if>
				
<%-- 				<c:if test="${eventListVO.evelist_status =='EL6'}"> --%>
				
<%-- 				  <FORM METHOD="post" ACTION="<%=request.getContextPath() %>/eventlist/eventlist.do" style="margin-bottom: 0px;"> --%>
<!-- 				     <input type="submit" value="�R��"> -->
<%-- 				     <input type="hidden" name="mem_id"  value="${eventListVO.mem_id}"> --%>
<%-- 				     <input type="hidden" name="eve_id"  value="${eventListVO.eve_id}"> --%>
<%-- 				     <input type="hidden" name="requestURL"	value="<%=request.getRequestURI()%>"><!--�e�X�����������|��Controller--> --%>
<%-- 				     <input type="hidden" name="whichPage"	value="<%=whichPage%>"> --%>
<!-- 				     <input type="hidden" name="action" value="delete_By_Participant"></FORM> -->
<%-- 				</c:if> --%>
			</td>
			
		</tr>
	</c:forEach>
</table>


<%@ include file="page2.file" %>



  <!-- The Modal -->
<c:if test="${openModal!=null}">

<div class="modal fade" id="basicModal" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
							
			<div class="modal-body">
          		 <jsp:include page="listOneEvelist.jsp" />
        	</div>
        	
			<div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary">Save changes</button>
            </div>
		
		</div>
	</div>
</div>
        <script>
    		 $("#basicModal").modal({show: true});
        </script>
 </c:if>
 
 
 <!-- The Modal -->
<c:if test="${openupModal!=null}">

<div class="modal fade" id="basicModal2" tabindex="-1" role="dialog" aria-labelledby="basicModal" aria-hidden="true">
	<div class="modal-dialog ">
		<div class="modal-content">
							
			<div class="modal-body">
          		 <jsp:include page="update_evelist_modal.jsp" />
        	</div>
        			
		</div>
	</div>
</div>
        <script>
    		 $("#basicModal2").modal({show: true});
        </script>
 </c:if>
 

<!-- <br>�����������|:<br><b> -->
<%--    <font color=blue>request.getServletPath():</font> <%=request.getServletPath()%><br> --%>
<%--    <font color=blue>request.getRequestURI(): </font> <%=request.getRequestURI()%> </b> --%>
</body>
</html>
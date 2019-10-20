<% @ Page Language="C#" Inherits="PageAdmin.issue_list"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server" Type="bs_issue"/> 
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr><td height=10 colspan="2"></td></tr>
 <tr>
  <td class=table_style1><a href="javascript:location.reload(true)" title="点击刷新"><b>签发信息</b></a></td>
  <td class=table_style1 style="text-align:right">【<a href='javascript:IssueLog()'>我的签发记录</a>】</td>
</tr>
 <tr><td height=10 colspan="2"></td></tr>
</table>

<table border=0 cellpadding=0 cellspacing=0 width=95% >
<tr>
<td valign=top align="left">
<form runat="server">
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top align="left">
<table border=0 cellpadding=0 cellspacing=0 width=95%  style="table-layout:fixed;" align=center>
<tr>
<td align="left" width="110px">
每页<asp:TextBox id="Tb_pagesize" style="width:30px" maxlength="10"  Runat="server"/>条记录
</td>
<td align="right">
<select id="s_order" onchange="Go()">
<option value="thedate desc">按提交时间↓</option>
<option value="thedate asc">按提交时间↑</option>
</select>
按日期
<input name="StartDate" id="StartDate" Maxlength="10" size="10" value="<%=Start_Date_Text%>" ><a href="javascript:open_calendar('StartDate')"><img src=images/calendar_bnt.gif border=0 height=20 hspace=2 align=absbottom></a> 
到 
<input name="EndDate" id="EndDate" Maxlength="10" size="10" value="<%=End_Date_Text%>" ><a href="javascript:open_calendar('EndDate')"><img src=images/calendar_bnt.gif border=0 height=20 hspace=2 align=absbottom></a> 
<input type="button" value="确定" class="button" onclick="Go()">
 </td>
 </tr>
</table>

<table border=0 cellpadding=0 cellspacing=2 width=95% align=center>
      <tr>
        <td  align="left">
            <table border=0 cellpadding=0 cellspacing=0 width=100% class=tablestyle id="tb_list">
                <tr>
                  <td align=center width=50% class=white>标题</td>
                  <td align=center width=10% class=white>所属表</td>
                  <td align=center width=10% class=white height=20>发布人</td>
                  <td align=center width=10% class=white height=20>提交时间</td>
                  <td align=center width=10% class=white height=20>状态</td>
                  <td align=center width=10% class=white>操作</td>
                </tr>
          <asp:Repeater id="P1" runat="server" OnItemDataBound="Data_Bound">         
             <ItemTemplate>
                 <tr id="issue_item" name="issue_item" class="listitem">
                  <td align=left class="tdstyle"><input type="checkbox" id="CK" Name="CK" Value="<%#DataBinder.Eval(Container.DataItem,"id")%>"><asp:Label id="Lb_Title" runat="server" /><span id="errorinfo" name="errorinfo" style="color:#ff0000;display:block"></span></td>
                  <td align=center class=tdstyle><asp:Label id="Lb_Table" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"thetable")%>'/></td>
                  <td align=center class=tdstyle><asp:Label id="Lb_UserName" runat="server" /></td>
                  <td align=center class="tdstyle" title="<%#DataBinder.Eval(Container.DataItem,"thedate","{0:yyyy-MM-dd HH:mm:ss}")%>"><%#DataBinder.Eval(Container.DataItem,"thedate","{0:yyyy-MM-dd}")%></td>
                  <td align=center class=tdstyle style="color:#ff0000"><%#DataBinder.Eval(Container.DataItem,"work_state")%></td>
                  <td align=center class="tdstyle">
                     <asp:Label id="Lb_DetailId" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"detail_id")%>' visible="false"/>
                     <asp:Label id="Lb_WorkNode" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"work_node")%>' visible="false"/>
                     <a href="javascript:Issue_Data('<%#DataBinder.Eval(Container.DataItem,"thetable")%>','<%#DataBinder.Eval(Container.DataItem,"detail_id")%>','<%#DataBinder.Eval(Container.DataItem,"work_id")%>',<%=xuhao++%>)">签发</a>
                     <asp:Label id="Lb_Edit" runat="server"><a href="javascript:EditInfo('<%#DataBinder.Eval(Container.DataItem,"site_id")%>','<%#DataBinder.Eval(Container.DataItem,"thetable")%>','<%#DataBinder.Eval(Container.DataItem,"detail_id")%>','<%#DataBinder.Eval(Container.DataItem,"work_node")%>','<%#DataBinder.Eval(Container.DataItem,"thetable")%>')">编辑</a></asp:Label>
                    <input type="hidden" id="issue_cs_<%#DataBinder.Eval(Container.DataItem,"id")%>" value="<%#DataBinder.Eval(Container.DataItem,"thetable")%>,<%#DataBinder.Eval(Container.DataItem,"detail_id")%>,<%#DataBinder.Eval(Container.DataItem,"work_id")%>,<%=xuhao-1%>">
                  </td>
                </tr>
             </ItemTemplate>
          </asp:Repeater>

<td class=tdstyle colspan="6">
<table border=0 width=100%>
 <tr><td>
<input type="button" class="button" value="反选" onclick="CheckBox_Inverse('CK')"/>
[<a href="javascript:p_issue('pass')" id="p_pass">批量通过</a>]
[<a href="javascript:p_issue('rework')" id="p_rework">批量退回</a>]
[<a href="javascript:p_issue('delete')" id="p_delete">批量删除</a>]
</td></tr>
</table>
</td></tr>

</table>
</td></tr>
</table> 

<table border=0 cellpadding=0 cellspacing=2 width=95% align=center>
      <tr>
        <td  align="left">
共<asp:Label id="Lblrecordcount"  Text=0 runat="server" />条待签发信息 
&nbsp;当前页次: <asp:Label id="Lblcurrentpage"  runat="server" />/<asp:Label id="LblpageCount"  runat="server" />&nbsp;
<asp:Button  text="上一页"  id="LblPrev" cssclass="button" runat="server" CommandName="Prev" OnCommand="Bt_Click" />&nbsp;
<asp:Button  text="下一页"  id="LblNext" cssclass="button" runat="server" CommandName="Next" OnCommand="Bt_Click" />&nbsp;
转到:&nbsp;<asp:DropDownList id="DLpage" runat="server" AutoPostBack="true" OnSelectedIndexChanged="Page_Changed"  /> 页&nbsp;
</td></tr></table>

       </td>
    </tr>
   </table>

  </td>
  <tr>
 </table>
</form>
</td>
</tr>
</table>
</center>
<script type="text/javascript">
 MouseoverColor("tb_list");
 var obj_pagesize=document.getElementById("Tb_pagesize");
 var obj_order=document.getElementById("s_order");
 var obj_date1=document.getElementById("StartDate");
 var obj_date2=document.getElementById("EndDate");

 var Order="<%=Request.QueryString["order"]%>";
 var StartDate="<%=Request.QueryString["startdate"]%>";
 var EndDate="<%=Request.QueryString["enddate"]%>";

 if(obj_order!=null && Order!=""){obj_order.value=Order;}
 if(obj_date1!=null){obj_date1.value=StartDate;}
 if(obj_date2!=null){obj_date2.value=EndDate;}


 function Go()
  { 
   location.href="?order="+obj_order.value+"&startdate="+escape(obj_date1.value)+"&enddate="+escape(obj_date2.value)+"&pagesize="+obj_pagesize.value;
  }

 var issue_item=document.getElementsByName("issue_item");
 var CK=document.getElementsByName("CK");
 var errorinfo=document.getElementsByName("errorinfo");
 var Act="",Aids,idx,cs,Acs,sto;

 function p_issue(act)
 {
   if(Act!="")
    {
     alert("操作正在进行中，不能进行其他操作。");
     return;
    }
   document.getElementById("p_pass").style.color="#333333";
   document.getElementById("p_rework").style.color="#333333";
   document.getElementById("p_delete").style.color="#333333";
   actname="";
   var Ids=Get_Checked("CK");
   if(Ids=="0" || Ids=="")
    {
      alert("请选择要操作的信息!");
      return;
    }
  Act=act;
  switch(Act)
   {
     case "pass":
      actname="批量通过审核";
      document.getElementById("p_pass").style.color="#ff0000";
     break;
     case "rework":
      actname="批量退回";
      document.getElementById("p_rework").style.color="#ff0000";
     break;
     case "delete":
      actname="批量删除";
      document.getElementById("p_delete").style.color="#ff0000";
     break;
   }
   if(!confirm("您选择了"+actname+"，是否继续!"))
    {
       document.getElementById("p_pass").style.color="#333333";
       document.getElementById("p_rework").style.color="#333333";
       document.getElementById("p_delete").style.color="#333333";
       Act="";
       return;
    }
   Aids=Ids.split(',');
   idx=0;
   sto=setTimeout("issue_post()",500);
 }

 function issue_post()
  {
    if(Aids[idx]!="")
    {     cs=document.getElementById("issue_cs_"+Aids[idx]).value;
     Acs=cs.split(',');
     x=new PAAjax();
     x.setarg("get",true);
     x.send("p_issue.aspx","table="+Acs[0]+"&detailid="+Acs[1]+"&workid="+Acs[2]+"&xuhao="+Acs[3]+"&act="+Act,function(v){issue_back(v,Acs[3])});
     //window.open("p_issue.aspx?id="+Acs[0]+"&table="+Acs[1]+"&detailid="+Acs[2]+"&workid="+Acs[3]+"&xuhao="+Acs[4]+"&act="+Act);
    }
  }
 
function issue_back(v,xuhao)
 {
   switch(v)
    {
      case "success":
       issue_item[xuhao].style.display="none";
       CK[xuhao].style.display="none";
       CK[xuhao].checked=false;
     break;

      case "buile_html_false":
       errorinfo[xuhao].innerHTML="[生成静态文件出错]";
      break;

      case "del_html_false":
       errorinfo[xuhao].innerHTML="[删除静态文件出错]";
      break;

      case "different_domain":
       errorinfo[xuhao].innerHTML="[信息不在同一个域名下不可操作]";
      break;

      case "error":
       errorinfo[xuhao].innerHTML="[参数错误]";
      break;
   }
  idx++;
  if(idx<Aids.length)
  {
    sto=setTimeout("issue_post()",500);
  }
 else
  {
    clearTimeout(sto);
    document.getElementById("p_pass").style.color="#333333";
    document.getElementById("p_rework").style.color="#333333";
    document.getElementById("p_delete").style.color="#333333";
    Act="";
  }
 }

function EditInfo(sid,table,detail_id,worknode,tablename)
 {
   IDialog("信息编辑","data_add.aspx?siteid="+sid+"&id="+detail_id+"&table="+table+"&worknode="+worknode+"&name="+encodeURI(tablename),"95%","90%");
 }
               
function IssueLog()
  {
   var Url="/e/member/issuelog.aspx?from=master";
   IDialog("签发记录",Url,"90%","90%");
  } 
</script>
</body>
</html>  

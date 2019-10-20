<% @ Page Language="C#" Inherits="PageAdmin.member_list"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server" Type="member_list" /> 
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr><td height=10></td></tr>
 <tr><td class=table_style1><a href="javascript:location.reload()" title="点击刷新"><b>会员查看<%=Mtype_Name%></b></a></td></tr>
 <tr><td height=10 ></td></tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=95%>
 <tr>
<td valign=top align="left">
<form runat="server" >
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top align="left">
<table border=0 cellpadding=0 cellspacing=0 width=95%  style="table-layout:fixed;" align=center>
<tr>
<td align="left" width="110px">
每页<asp:TextBox id="Tb_pagesize" style="width:30px" maxlength="10"  Runat="server"/>条记录
</td>
<td align="right">
<select id="s_checked" onchange="Go()">
<option value="">所有属性</option>
<option value="nomail">待激活</option>
<option value="nochecked">未审核</option>
</select>
<select id="s_demartment" onchange="Go()">
<option value="">所有部门</option>
<%=DepartMentList%>
</select>
<select id="s_order" onchange="Go()">
<option value="id desc">按注册时间↓</option>
<option value="id asc">按注册时间↑</option>
<option value="lastdate desc">按最后登录时间↓</option>
<option value="logins desc">按登录次数↓</option>
<option value="fnc_rk desc">按入款金额↓</option>
<option value="fnc_xf desc">按消费金额↓</option>
<option value="fnc_fk desc">按返款金额↓</option>
<option value="point_rk desc">按充值积分数↓</option>
<option value="point_xf desc">按消费积分数↓</option>
<option value="point_fk desc">按返点积分数↓</option>
</select>
搜索：<input text="text" id="s_keyword" style="width:80px" title="需要精确搜索在关键词前面加=号，如：=关键词">
<select id="s_field">
<option value="">选择搜索字段</option>
<option value="username">会员名</option>
<option value="truename">姓名</option>
<option value="email">email</option>
<%=Fields_Str%>
<option value="reg_ip">注册IP</option>
<option value="lst_ip">登录IP</option>
<option value="thedate">注册日期</option>
<option value="lastdate">登录日期</option>
<option value="logins">登录次数</option>
</select>
<input type="button" value="确定" class="button" onclick="Go()">
 </td>
 </tr>
</table>

 <table border=0 cellpadding=0 cellspacing=2 width=95% align=center>
      <tr>
        <td align="left">
            <table border=0 cellpadding=0 cellspacing=0 width=100% class=tablestyle id="tb_memberlist">
                <tr>
                 <td align=center width=5% class=white height=25>选择</td>
                  <td align=center width=10% class=white>会员名</td>
                  <td align=center width=10% class=white>会员类型</td>
                  <td align=center width=10% class=white>所在部门</td>
                  <td align=center width=10% class=white>注册时间</td>
                  <td align=center width=13% class=white>最后登陆</td>
                  <td align=center width=10% class=white>会员状态</td>
                  <td align=center width=7% class=white>登录次数</td>
                  <td align=center width=15% class=white>管理</td>
                </tr>
          <asp:Repeater id="P1" runat="server" OnItemDataBound="Data_Bound">        
             <ItemTemplate>
                 <tr class="listitem">
                  <td align=center class="tdstyle"><input type="checkbox" id="CK<%#DataBinder.Eval(Container.DataItem,"username").ToString()=="admin"?"1":""%>" Name="CK<%#DataBinder.Eval(Container.DataItem,"username").ToString()=="admin"?"1":""%>" Value="<%#DataBinder.Eval(Container.DataItem,"id")%>" <%#DataBinder.Eval(Container.DataItem,"username").ToString()=="admin"?"disabled":""%>></td>
                  <td align=center class="tdstyle"><a href="member_info.aspx?username=<%#Server.UrlEncode(DataBinder.Eval(Container.DataItem,"username").ToString())%>&typeid=<%=Request.QueryString["tid"]%>"><%#DataBinder.Eval(Container.DataItem,"username")%></a></td>
                  <td align=center class="tdstyle"><%#Get_Type(DataBinder.Eval(Container.DataItem,"mtype_id").ToString())%></td>
                  <td align=center class="tdstyle"><%#Get_Department(DataBinder.Eval(Container.DataItem,"department_id").ToString())%></td>
                  <td align=center class="tdstyle"><%#DataBinder.Eval(Container.DataItem,"thedate","{0:yyyy-MM-dd}")%></td>
                  <td align=center class="tdstyle"><%#DataBinder.Eval(Container.DataItem,"lastdate","{0:yyyy-MM-dd HH:mm:ss}")%></td>
                  <td align=center class="tdstyle"><%#Get_State(DataBinder.Eval(Container.DataItem,"checked").ToString())%></td>
                  <td align=center class="tdstyle"><%#DataBinder.Eval(Container.DataItem,"logins")%></td>
                  <td align=center class="tdstyle">
                   <asp:Label id="Lb_UserName" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"username")%>' visible="false" />
                    <asp:Label id="M_Group" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"m_group")%>' visible="false" />
                    <a href="member_info.aspx?username=<%#Server.UrlEncode(DataBinder.Eval(Container.DataItem,"username").ToString())%>&typeid=<%=Request.QueryString["typeid"]%>">会员资料</a>
                    <a href='msgsend.aspx?receiver=<%#DataBinder.Eval(Container.DataItem,"username")%>' style='display:none'>发信</a>
                    <asp:Label id="lb_Permissions" runat="server" Visible="false"><a href="javascript:Set('<%#DataBinder.Eval(Container.DataItem,"username")%>','<%#DataBinder.Eval(Container.DataItem,"id")%>','basic')">管理权限设置</a>
                    </asp:Label>
                    <%if(Can_Delete=="1"){%><a href="javascript:del('<%#DataBinder.Eval(Container.DataItem,"username")%>')">删除</a><%}%>
                  </td>
                </tr>
             </ItemTemplate>
          </asp:Repeater>
<tr>
<td colspan="9" align="left" class="tdstyle">

<table border=0 width=100%>
 <tr><td>
<input type="hidden" name="dusername" id="dusername" value="">
<input type="hidden" name="act" id="act" value="">
<input type="hidden" name="ids" id="ids" value="">
<input type="button" class="button" value="反选" onclick="CheckBox_Inverse('CK')"/>
<a href="javascript:set('checked')">[审核]</a><a href="javascript:set('unchecked')">[取消审核]</a>
<a href="javascript:set('sendmsg')">[发信]</a>
[<a href="javascript:set('import_excle')" title="从excle文件中导入数据，注意格式，参考导出的excle文件格式">导入</a>/<a href="javascript:set('export_excle')" title="导出excle文件">导出</a>]
<a href="javascript:set('pdelete')" style="display:<%=Can_Delete=="0"?"none":""%>">[删除]</a>
</td>
<td align=right>
<input type="radio" name="transfer_type" value="1" checked onclick="change_type(1)">类别转移 <input type="radio" name="transfer_type" value="2" onclick="change_type(2)">部门设置
<select name="totype" id="totype"><option value="0">==目标类别==</option><%=Type_List_Str%></select>
<select name="todepartment" id="todepartment" style="display:none"><option value="0">==选择部门==</option><%=DepartMentList%></select>
<input type="button" class="button" value="确定" onclick="set('transfer')"/>
</td></tr></table>

</td>
</tr>
</table> 
<br>
&nbsp;共<asp:Label id="Lblrecordcount"  Text=0 runat="server" />条记录 
&nbsp;当前页次: <asp:Label id="Lblcurrentpage"  runat="server" />/<asp:Label id="LblpageCount"  runat="server" />&nbsp;
<asp:Button  text="上一页"  id="LblPrev"  cssclass="button"  runat="server"  CommandName="Prev"   OnCommand="Bt_Click" />&nbsp;
<asp:Button  text="下一页"  id="LblNext"  cssclass="button"  runat="server"  CommandName="Next"   OnCommand="Bt_Click" />&nbsp;
转到:&nbsp;<asp:DropDownList id="DLpage" runat="server" AutoPostBack="true" OnSelectedIndexChanged="Page_Changed"  /> 页&nbsp;

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
</body>
<script type="text/javascript">
 MouseoverColor("tb_memberlist");
 var t_type=1;
 var obj_checked=document.getElementById("s_checked");
 var obj_demartment=document.getElementById("s_demartment");
 var obj_field=document.getElementById("s_field");
 var obj_order=document.getElementById("s_order");
 var obj_keyword=document.getElementById("s_keyword");
 var obj_pagesize=document.getElementById("Tb_pagesize");

 var Tid="<%=Request.QueryString["typeid"]%>";
 var Group="<%=Request.QueryString["group"]%>";
 var checked="<%=Request.QueryString["checked"]%>";
 var Department="<%=Request.QueryString["department"]%>";
 var Field="<%=Request.QueryString["field"]%>";
 var Order="<%=Request.QueryString["order"]%>";
 var Keyword="<%=Request.QueryString["keyword"]%>";

 if(obj_checked!=null){obj_checked.value=checked;}
 if(obj_checked.selectedIndex==-1){obj_checked.value=""}
 if(obj_demartment!=null && Department!=""){obj_demartment.value=Department}
 if(obj_field!=null && Field!=""){obj_field.value=Field;}
 if(obj_order!=null && Order!=""){obj_order.value=Order;}
 if(obj_keyword!=null){obj_keyword.value=Keyword;}

function check_permissions()
 {
   var username="<%=UserName%>";
   if(username!="admin" && Group=="admin")
    {
      alert("对不起，您没有操作管理员用户的权限");
      return false;
    }
   return true;
 }

function del(dname)
 {
   if(!check_permissions()){return;}
   if(dname=="admin")
    {
      alert("系统用户不能删除!");
      return;
    }
   else if(confirm("确定删除吗?"))
   {
     document.getElementById("dusername").value=dname;
     document.getElementById("act").value="delete";
     document.forms[0].submit();
   }
 }

function set(act)
 {
   var Ids=Get_Checked("CK");
   if(act!="sendmsg")
    {
     if(!check_permissions()){return;}
    }
   if(act=="import_excle")
    {
      IDialog("导入Excel数据","data_import.aspx?table=pa_member&sortid=<%=Request.QueryString["typeid"]%>&group="+Group,660,230);
      return ;
    }
   if(act=="export_excle")
    {
      var sql="<%=ViewState["sql"]%>";
      sql=sql.split("order by")[0];
      window.open("/e/zdyform/pa_member/master/data_export.aspx?act=buildfile&siteid=<%=SiteId%>&table=pa_member&ids="+Ids+"&sql="+encodeURI(sql),"export_excle");
      return ;
    }
   if(Ids=="")
    {
      alert("请选择要操作的会员!");
      return;
    }
   if(act=="sendmsg")
    {
     IDialog("发送信息","msg_single.aspx?receiverids="+encodeURI(Ids),600,360);
     return;
    }

   if(act=="pdelete")
    {
      if(!confirm("确定删除吗?"))
       {
         return;
       }
    }
   if(act=="transfer")
    {
       if(t_type==1)
        {
          if(document.getElementById("totype").value=="0")
          {
           alert("请选择要转移的目标类别!");
           document.getElementById("totype").focus();
           return ;
          }
        }
       else
        {
          if(document.getElementById("todepartment").value=="0")
          {
           alert("请选择要转移的部门!");
           document.getElementById("todepartment").focus();
           return ;
          }

        }
    if(!confirm("是否确定?"))
      {
         return;
      }
    }
  document.getElementById("act").value=act;
  document.getElementById("ids").value=Ids;
  document.forms[0].submit();
 }

function change_type(t)
 {
  var obj1=document.getElementById("totype");
  var obj2=document.getElementById("todepartment");
  if(t==1)
   {
    obj1.style.display="";
    obj2.style.display="none";
    t_type=1;
   }
  else
   {
    obj1.style.display="none";
    obj2.style.display="";
    t_type=2;
   }

 }

 function Go()
  { 
   if(obj_keyword.value!="")
    {
     if(obj_field.value=="")
      {
        obj_field.value="username";
        //alert("请选择搜索字段!");
        //obj_field.focus();
        //return;
      }
    }
   location.href="?typeid="+Tid+"&group="+Group+"&checked="+obj_checked.value+"&department="+obj_demartment.value+"&field="+obj_field.value+"&order="+obj_order.value+"&keyword="+escape(obj_keyword.value)+"&pagesize="+obj_pagesize.value;
  }

function Member_Dialog(username,url)
 {
  General_Set("会员信息("+username+")",url);
 }
function Set(username,uid)
 {
  General_Set("管理员权限设置["+username+"]","admin_permissions.aspx?uid="+uid);
 }
</script>
</html>
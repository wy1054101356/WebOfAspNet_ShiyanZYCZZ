<% @ Page Language="C#" Inherits="PageAdmin.member_list"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server"/> 
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0><!--群发站内短信，邮件选择界面-->
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=95% >
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
<select id="s_checked" onchange="Go()" style="display:none">
<option value="">所有属性</option>
<option value="checked">已审核</option>
<option value="nomail">待激活</option>
<option value="nochecked">未审核</option>
</select>
<select id="s_mtype" onchange="Go()">
<option value="">所有类别</option>
<%=MtypetList%>
</select>
<select id="s_demartment" onchange="Go()">
<option value="">所有部门</option>
<%=DepartMentList%>
</select>

搜索：<select id="s_field">
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
<input text="text" id="s_keyword" style="width:80px">
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
                  <td align=center width=20% class=white>会员名</td>
                  <td align=center width=20% class=white>姓名</td>
                  <td align=center width=15% class=white>会员类型</td>
                  <td align=center width=15% class=white>所在部门</td>
                  <td align=center width=10% class=white>选择</td>
                </tr>
          <asp:Repeater id="P1" runat="server" OnItemDataBound="Data_Bound">        
             <ItemTemplate>
                 <tr class="listitem">
                  <td align=center class="tdstyle"><input type="checkbox" id="CK" Name="CK" Value="<%#DataBinder.Eval(Container.DataItem,"username")%>"></td>
                  <td align=center class="tdstyle" onclick="select_ck('<%#DataBinder.Eval(Container.DataItem,"username")%>')" style="cursor:pointer"><%#DataBinder.Eval(Container.DataItem,"username")%></td>
                  <td align=center class="tdstyle"><%#DataBinder.Eval(Container.DataItem,"truename")%></td>
                  <td align=center class="tdstyle"><%#Get_Type(DataBinder.Eval(Container.DataItem,"mtype_id").ToString())%></td>
                  <td align=center class="tdstyle"><%#Get_Department(DataBinder.Eval(Container.DataItem,"department_id").ToString())%></td>
                  <td align=center class="tdstyle"><input type="button" value="选择" onclick="Select_User('<%#DataBinder.Eval(Container.DataItem,"username")%>')" class="f_bt"></td>
                </tr>
                 <asp:Label id="Lb_UserName" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"username")%>' visible="false" />
                 <asp:Label id="M_Group" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"m_group")%>' visible="false" />
                 <asp:HyperLink id="Permissions_set" runat="server" visible="false" />
                 <asp:Label id="lb_Permissions" runat="server" Visible="false"/>
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
</td>
<td align=right></td></tr>
</table>

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
<div align="center" style="padding:5px">
<input type="button" value="确定" onclick="Get_Select()"> &nbsp; <input type="button" value="关闭" onclick="closewin()">
</div>
</center>
</body>
<script type="text/javascript">
 MouseoverColor("tb_memberlist");
 var t_type=1;
 var obj_checked=document.getElementById("s_checked");
 var obj_mtype=document.getElementById("s_mtype");
 var obj_demartment=document.getElementById("s_demartment");
 var obj_field=document.getElementById("s_field");
 var obj_keyword=document.getElementById("s_keyword");
 var obj_pagesize=document.getElementById("Tb_pagesize");

 var Tid="<%=Request.QueryString["typeid"]%>";
 var Group="<%=Request.QueryString["group"]%>";
 var checked="<%=Request.QueryString["checked"]%>";
 var Department="<%=Request.QueryString["department"]%>";
 var Field="<%=Request.QueryString["field"]%>";
 var Keyword="<%=Request.QueryString["keyword"]%>";

 if(obj_checked!=null){obj_checked.value=checked;}
 if(obj_checked.selectedIndex==-1){obj_checked.value=""}
 if(obj_mtype!=null && Tid!=""){obj_mtype.value=Tid}
 if(obj_demartment!=null && Department!=""){obj_demartment.value=Department}
 if(obj_field!=null && Field!=""){obj_field.value=Field;}
 if(obj_keyword!=null){obj_keyword.value=Keyword;}

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
   location.href="?typeid="+obj_mtype.value+"&checked="+obj_checked.value+"&department="+obj_demartment.value+"&field="+obj_field.value+"&keyword="+escape(obj_keyword.value)+"&pagesize="+obj_pagesize.value;
  }

function Get_Select()
 {
  var UserNames=Get_Checked("CK");
  if(UserNames=="")
   {
     alert("请选择用户!");
     return;
   }
 var AUserNames=UserNames.split(',');
 var obj=parent.document.getElementById("receiver_users");
 if(obj==null){return;}
 for(var i=0;i<AUserNames.length;i++)
    {
       if(!CheckRepeat(obj,AUserNames[i]))
        {
          parent.AddUsers(AUserNames[i],AUserNames[i]);
        }
     }
  closewin();
 }

function Select_User(username)
 {
  var obj=parent.document.getElementById("receiver_users");
   if(!CheckRepeat(obj,username))
     {
       parent.AddUsers(username,username);
     }
 }


function CheckRepeat(op_obj,username)
 {
   for(var i=0;i<op_obj.length;i++)
     {
       if(op_obj[i].value==username)
        {
          return true;
        }
     }
  return false;
 }


function closewin()
{
 parent.CloseDialog();
}

function select_ck(id)
{
   var Obj=document.getElementsByName("CK");
   for(i=0;i<Obj.length;i++)
     {
      if(Obj[i].value==id)
       {
           if(Obj[i].checked)
            {
              Obj[i].checked=false;
            }
           else
            {
              Obj[i].checked=true;
            }
       }
      else
       {
        continue;
       }
     }
}
</script>
</html>
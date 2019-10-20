<% @ Page Language="C#" Inherits="PageAdmin.site_list"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server" Type="site_list" />
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr><td height=10></td></tr>
 <tr><td class=table_style1><a href="javascript:location.reload()" title="点击刷新"><b>站点管理</b></a></td></tr>
 <tr><td height=10></td></tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr>
<td valign=top align="left">
<form runat="server" >
<div id="tabdiv">
<ul>
<li id="tab" name="tab" style="font-weight:bold">站点管理</li>
<li id="tab" name="tab" onclick="location.href='site_add.aspx'">增加新站</li>
</ul>
</div>
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top>
<table border=0 cellpadding=0 cellspacing=0 width=95%  style="table-layout:fixed;" align=center>
<tr>
<td align="left" width="150px">每页<asp:TextBox id="Tb_pagesize" size="3" maxlength="10"  Runat="server"/>条记录</td>
<td align="right">
语种：<asp:DropDownList id="s_language" runat="server" onchange="Go()">
<asp:listitem value="">所有语种</asp:listitem>
</asp:DropDownList>
静态：<select id="s_html" onchange="Go()">
<option value="">所有类型</option>
<option value="1">是</option>
<option value="0">否</option>
</select>
搜索：<select id="s_field">
<option value="">选择搜索字段</option>
<option value="sitename">站点名称</option>
<option value="domain">绑定域名</option>
<option value="directory">站点目录</option>
</select>
<input text="text" id="s_keyword" size="12">
<input type="button" value="搜索" class="button" onclick="Go()">
 </td>
 </tr>
</table>

  <table border=0 cellpadding=0 cellspacing=0 width=95% align=center>
      <tr>
        <td  colspan=2 height=25>
          <table border=0 cellpadding=0 cellspacing=0 width=100% class=tablestyle >
                <tr>
                 <td align=center width=5% class=white height=25px>选择</td>
                  <td align=center width=8% class=white height=25px>ID</td>
                  <td align=center width=15% class=white height=25px>站点名称</td>
                  <td align=center width=10% class=white height=25px>站点目录</td>
                  <td align=center width=10% class=white height=25px>站点语种</td>
                  <td align=center width=10% class=white height=25px>生成静态</td>
                  <td align=center width=20% class=white>绑定子域名</td>
                  <td align=center width=7% class=white>序号</td>
                  <td align=center width=15% class=white>操作</td>
                </tr>
             <asp:Repeater id="List" runat="server"  OnItemDataBound="Data_Bound">            
             <ItemTemplate>
                <tr title="<%#DataBinder.Eval(Container.DataItem,"sitename")%>">
                  <td align=center class=tdstyle><input type="checkbox" id="CK" Name="CK" value="<%#DataBinder.Eval(Container.DataItem,"id")%>" <%#CkDisabled(DataBinder.Eval(Container.DataItem,"html").ToString(),DataBinder.Eval(Container.DataItem,"domain").ToString())%>></td>
                  <td align=center class=tdstyle><%#DataBinder.Eval(Container.DataItem,"id")%></td>
                  <td align=center class=tdstyle><a href="javascript:ViewSite('<%#DataBinder.Eval(Container.DataItem,"domain")%>','<%#DataBinder.Eval(Container.DataItem,"directory")%>')"><%#DataBinder.Eval(Container.DataItem,"sitename")%></a></td>
                  <td align=center class=tdstyle><%#GetDir(DataBinder.Eval(Container.DataItem,"directory").ToString())%></td>
                  
                  <td align=center class=tdstyle><%#DataBinder.Eval(Container.DataItem,"language")%></td>
                  <td align=center class=tdstyle><%#(DataBinder.Eval(Container.DataItem,"html").ToString())=="1"?"是":"否"%></td>
                  <td align=center class=tdstyle><%#DataBinder.Eval(Container.DataItem,"domain")%></td>
                  <td align=center class=tdstyle><%#DataBinder.Eval(Container.DataItem,"xuhao")%></td>
                  <td align=center class=tdstyle>
                   <asp:Label id="Lb_id" Text='<%#DataBinder.Eval(Container.DataItem,"id")%>' visible="false" runat="server"/>
                   <asp:Label id="Lb_dir" Text='<%#DataBinder.Eval(Container.DataItem,"directory")%>' visible="false" runat="server"/>
                   <a href="javascript:Set('<%#DataBinder.Eval(Container.DataItem,"sitename")%>','<%#DataBinder.Eval(Container.DataItem,"id")%>')">修改</a>
                   <asp:LinkButton runat="server" Text="删除" id="Delete" CommandName='<%#DataBinder.Eval(Container.DataItem,"id")%>' CommandArgument='<%#DataBinder.Eval(Container.DataItem,"directory")%>' oncommand="Data_Delete"/>
                  </td>
                </tr>
             </ItemTemplate>
         </asp:Repeater>
           <tr><td colspan=9  class="tdstyle">
 <input type="button" class="button" value="反选" onclick="CheckBox_Inverse('CK')"/>
<asp:DropDownList id="D_htmltype" Runat="server" onchange="c_htmltype()">
<asp:ListItem value="">请选择生成的页面类型</asp:ListItem>
<asp:ListItem value="pa_lanmu">栏目页</asp:ListItem>
<asp:ListItem value="pa_sublanmu">子栏目页</asp:ListItem>
<asp:ListItem value="pa_zt">专题页</asp:ListItem>
<asp:ListItem value="pa_zt_sublanmu">专题子栏目页</asp:ListItem>
</asp:DropDownList><span id="s_date" style="display:none">日期范围：<input type="text" name='b_date' id='b_date' size=10 maxlength=10><a href="javascript:open_calendar('b_date')"><img src=images/calendar_bnt.gif border=0 height=20 hspace=2 align=absbottom></a>到<input type="text" name='e_date' id='e_date' size=10 maxlength=10><a href="javascript:open_calendar('e_date')"><img src=images/calendar_bnt.gif border=0 height=20 hspace=2 align=absbottom></a></span>
<input type="button" class="button" value="生成" onclick="html()">
           </td>
           </tr>
        </table>
<div style="padding:5px 0 0 0">
共<asp:Label id="Lblrecordcount"  Text=0 runat="server" />条记录 
&nbsp;当前页次: <asp:Label id="Lblcurrentpage"  runat="server" />/<asp:Label id="LblpageCount"  runat="server" />&nbsp;
<asp:Button  text="上一页"  id="LblPrev"  cssclass=button runat="server"  CommandName="Prev"   OnCommand="Bt_Click" />&nbsp;
<asp:Button  text="下一页"  id="LblNext"  cssclass=button runat="server"  CommandName="Next"   OnCommand="Bt_Click" />&nbsp;
转到:&nbsp;<asp:DropDownList id="DLpage" runat="server" AutoPostBack="true" OnSelectedIndexChanged="Page_Changed"  /> 页&nbsp;
</div>
       </td>
    </tr>
   </table>
  </td>
  <tr>
 </table>
<br>
<asp:Label id="LblErr" runat="server" />
</form>
</td>
</tr>
</table>
</center>
<script type="text/javascript">
 var obj_language=document.getElementById("s_language");
 var obj_html=document.getElementById("s_html");
 var obj_field=document.getElementById("s_field");
 var obj_keyword=document.getElementById("s_keyword");
 var obj_pagesize=document.getElementById("Tb_pagesize");

 var Html="<%=Request.QueryString["html"]%>";
 var Language="<%=Request.QueryString["language"]%>";
 var Field="<%=Request.QueryString["field"]%>";
 var Keyword="<%=Request.QueryString["keyword"]%>";

 if(obj_html!=null && Html!=""){obj_html.value=Html;}
 if(obj_language!=null && Language!=""){obj_language.value=Language;}
 if(obj_field!=null && Field!=""){obj_field.value=Field;}
 if(obj_keyword!=null){obj_keyword.value=Keyword;}

function ViewSite(domain,dir)
 {
   if(domain=="")
    {
      window.open((dir==""?"":"/"+dir)+"/index.aspx","vsite");
    }
  else
   {
     window.open("http://"+domain+(dir==""?"":"/"+dir)+"/index.aspx","vsite");
   }
 }
function Set(name,Id)
 {
  var Width=680;
  var Height=380;
  IDialog(name,"site_add.aspx?act=edit&id="+Id,Width,Height);
 }

 function Go()
  { 
   if(obj_keyword.value!="")
    {
     if(obj_field.value=="")
      {
        alert("请选择搜索字段!");
        obj_field.focus();
        return;
      }
    }
   location.href="?language="+obj_language.value+"&html="+obj_html.value+"&field="+obj_field.value+"&keyword="+escape(obj_keyword.value)+"&pagesize="+obj_pagesize.value;
  }

 var D_htmltype=document.getElementById("D_htmltype");
 var s_date=document.getElementById("s_date");

function c_htmltype()
 {
   var thetable=D_htmltype.value;
   if(thetable!="pa_lanmu" && thetable!="pa_sublanmu" && thetable!="")
    {
     s_date.style.display="";
    }
   else
    {
     s_date.style.display="none";
    }
 }

function html()
 {
  var Ids=Get_Checked("CK");
  if(Ids=="")
    {
     alert("请选择站点!");
     return;
    }
  if(D_htmltype.value=="")
   {
     alert("请选择生成的页面类型!");
     D_htmltype.focus();
     return;
   }
  var b_date=document.getElementById("b_date");
  var e_date=document.getElementById("e_date");
  var datexz="";
  if(s_date.style.display=="")
  {
  if(b_date.value.length==10 && e_date.value.length!=10)
   {
     alert("请正确填写结束日期!");
     e_date.focus();
     return;
   }
  if(b_date.value.length!=10 && e_date.value.length==10)
   {
     alert("请正确填写开始日期!");
     b_date.focus();
     return;
   }
  if(b_date.value.length==10 && e_date.value.length==10)
   {
     datexz="&d1="+b_date.value+"&d2="+e_date.value;
   }
  }
  var Width=400;
  var Height=180;
  IDialog("站点静态生成","static_panel.aspx?table="+D_htmltype.value+"&siteid="+Ids+datexz,Width,Height);
 }

function reset(sid,html)
 {
   top.frames['m_head'].location.href=top.frames['m_head'].location.href;
   var Obj=document.getElementsByName("CK");
   for(i=0;i<Obj.length;i++)
     {
      if(Obj[i].value==sid.toString())
       {
         if(html==1)
          {
            Obj[i].disabled=false;
          }
         else
          {
            Obj[i].disabled=true;
            Obj[i].checked=false;
          }
       }
     }
 }
</script>
</body>
</html>  
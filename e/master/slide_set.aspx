<% @ Page Language="C#" Inherits="PageAdmin.slide_set"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server" Type="js_slide"/> 
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr><td height=10></td></tr>
 <tr><td class=table_style1><b>幻灯片设置</b></td></tr>
 <tr><td height=10></td></tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr>
<td valign=top align="left">
<form runat="server">
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top align="left">
<table border=0 cellpadding=3 cellspacing=0 width=98% align=center>
<tr>
  <td height=25 width=100>幻灯风格</td>
  <td> <asp:DropDownList id="Dl_Style" runat="server" OnChange="Style_Change()">
       <asp:ListItem Value="1">Js幻灯(带圆形按钮)</asp:ListItem>
       <asp:ListItem Value="2">Js幻灯(带数字按钮)</asp:ListItem>
       <asp:ListItem Value="3">Js幻灯(主要用于制作横幅)</asp:ListItem>
       <asp:ListItem Value="4">Flash焦点幻灯</asp:ListItem>
       <asp:ListItem Value="5">Flash轮播幻灯(Bcastr)</asp:ListItem>
       <asp:ListItem Value="0">自定义代码</asp:ListItem>
       </asp:DropDownList> <span style="color:#999">注：手机设备上不显示Flash类型的幻灯。</span>
 </tr>
</table>
<table border=0 cellpadding=3 cellspacing=0 width=98% align=center id="tb_set">
<tr>
  <td height=25>信息数据表</td>
  <td><asp:DropDownList id="Dl_Table" runat="server" DataTextField="table_name" DataValueField="thetable" AutoPostBack="true" OnSelectedIndexChanged="Table_Change"></asp:DropDownList></td>
 </tr>
<asp:PlaceHolder id="p_1" runat="server">
<tr>
  <td  height=25>调用类别</td>
  <td>
<select name="data_site" id="data_site" onchange="c_siteofsort('<%=TheTable%>')" style="display:<%=ShareSites==""?"none":""%>">
 <%=Site_List%>
</select>



<select name="s_sort" id="s_sort" onchange="c_sort(<%=Request.Cookies["SiteId"].Value%>,1,'<%=TheTable%>','admin')">
<option  value="0">---所有类别---</option>
<%=Sort_List%>
</select>
<input type="hidden" name="sort" id="sort" value="<%=Sort_Id%>">
<script type="text/javascript">
var Sort_Type="all";
Write_Select(<%=Request.Cookies["SiteId"].Value%>,'<%=TheTable%>');
Load_Sort(<%=Request.Cookies["SiteId"].Value%>,"<%=P_Sorts%>,<%=Sort_Id%>",'<%=TheTable%>');
</script>
</td>
 </tr>
<tr>
  <td  height=25>属性筛选</td>
  <td><asp:DropDownList id="D_ShowType" runat="server">
       <asp:ListItem value="">选择类型</asp:ListItem>
       <asp:ListItem value="istop=1">设为"置顶"的信息</asp:ListItem>
       <asp:ListItem value="isgood=1">设为"推荐"的信息</asp:ListItem>
       <asp:ListItem value="isnew=1">设为"最新"的信息</asp:ListItem>
       <asp:ListItem value="ishot=1">设为"热门"的信息</asp:ListItem>
   </asp:DropDownList>

<asp:DropDownList  id="D_NotShowType"   Runat="server">
<asp:ListItem value="">选择排除类型</asp:ListItem>
<asp:ListItem value="istop=0">排除"置顶"的信息</asp:ListItem>
<asp:ListItem value="isgood=0">排除"推荐"的信息</asp:ListItem>
<asp:ListItem value="isnew=0">排除"最新"的信息</asp:ListItem>
<asp:ListItem value="ishot=0">排除"热门"的信息</asp:ListItem>
<asp:ListItem value="source_id=0">排除"推送"的信息</asp:ListItem>
<asp:ListItem value="reply_state>=1">排除"未回复"的信息</asp:ListItem>
</asp:DropDownList>
自定义条件：<asp:TextBox id="zdy_condition" Runat="server" size="30" Maxlength="50"/>

</td>
 </tr>


<tr>
  <td  height=30>专题筛选</td>
  <td>
<select name="zt_list" id="zt_list">
<option value="0">选择所属专题</option>
</select> <input type="button" value="选择专题" class="f_bt" onclick="open_ztlist(0)"> 注：表示只调用属于对应专题的信息，不选择则不限制
</td>
</tr>

<tr>
  <td  height=25>排序方式</td>
  <td><asp:DropDownList id="Dl_list_order" runat="server">
	<asp:ListItem value="">默认排序</asp:ListItem>
	<asp:ListItem value="order by thedate desc">按发布时间↓</asp:ListItem>
	<asp:ListItem value="order by thedate">按发布时间↑</asp:ListItem>
	<asp:ListItem value="order by id desc">按ID↓</asp:ListItem>
	<asp:ListItem value="order by id">按ID↑</asp:ListItem>
	<asp:ListItem value="order by clicks desc">按点击量↓</asp:ListItem>
	<asp:ListItem value="order by downloads desc">按下载量↓</asp:ListItem>
	<asp:ListItem value="order by comments desc">按评论量↓</asp:ListItem>
   </asp:DropDownList></td>
 </tr>

<tr>
  <td  height=25>标题显示字数</td>
  <td><asp:TextBox id="Pic_title_num" runat="server"  Maxlength="3" size="5"/> 个字符 
 <asp:RequiredFieldValidator   ControlToValidate="Pic_title_num" display="Dynamic" type="integer"  runat="server">
显示字数不能为空</asp:RequiredFieldValidator>
<asp:RangeValidator   ControlToValidate="Pic_title_num" display="Dynamic" type="integer" MinimumValue="0" MaximumValue="100" runat="server">
请输入0—100之间的数字</asp:RangeValidator></td>
 </tr>

<tr>
  <td  height=25>图片总显示数</td>
  <td><asp:TextBox id="Show_num" runat="server"  Maxlength=3 size=5/> 张图片
 <asp:RequiredFieldValidator   ControlToValidate="Show_num" display="Dynamic" type="integer"  runat="server">
不能为空</asp:RequiredFieldValidator>
<asp:RangeValidator   ControlToValidate="Show_num" display="Static" type="integer" MinimumValue="1" MaximumValue="100" runat="server">
请输入1—100之间的数字</asp:RangeValidator></td>
 </tr>
</asp:PlaceHolder>

<asp:PlaceHolder id="p_2" runat="server" Visible="false">
<tr>
  <td height=25>图片地址</td>
  <td><asp:TextBox id="Zdy_image" runat="server"  TextMode="multiLine"  style="width:95%;height:80px"/><br>多个图片请用"|"分开
 <asp:RequiredFieldValidator   ControlToValidate="zdy_image" display="Dynamic" type="integer"  runat="server">
不能为空</asp:RequiredFieldValidator>
 </td>
 </tr>


<tr>
  <td  height=25>图片链接</td>
  <td><asp:TextBox id="Zdy_link" runat="server"  TextMode="multiLine"  style="width:95%;height:80px"/><br>多个链接请用"|"分开
  </td>
 </tr>
<tr>
  <td  height=25>图片标题</td>
  <td><asp:TextBox id="Zdy_title" runat="server"  TextMode="multiLine"  style="width:95%;height:80px"/> <br>多个链接请用"|"分开
  </td>
 </tr>

 <tr>
   <td height=25>图片内容</td>
   <td><asp:TextBox id="Zdy_content" runat="server"  TextMode="multiLine"  style="width:95%;height:100px"/>
     <br>内容放在&lt;P&gt;标签中，建议样式格式：.slide_focus .slide_focus_zdycontent p{}
  </td>
 </tr>
</asp:PlaceHolder>

<tr>
  <td height=25>轮换效果</td>
  <td><asp:DropDownList id="Dl_Effect" runat="server" >
     <asp:ListItem value="0">显隐轮换</asp:ListItem>
     <asp:ListItem value="1">左右轮换</asp:ListItem>
     <asp:ListItem value="2">上下轮换</asp:ListItem>
     </asp:DropDownList>
     间隔时间：<asp:TextBox id="Tb_time"  runat="server" size="4" maxlength="2"/>秒
  </td>
 </tr>

<tr>
  <td  height=25>图片尺寸</td>
  <td>宽：<asp:TextBox id="Tb_width"  runat="server" size="4" maxlength="4"/>px
高：<asp:TextBox id="Tb_height" runat="server" size="4" maxlength="4" />px
&nbsp;&nbsp;注：宽设置为0时则根据容器宽度自动适应。
</td>
 </tr>

<tr>
 <td height=25 width=100>链接窗口</td>
  <td><asp:RadioButton id="RB_target_1" GroupName="Target" runat="server" />原窗口&nbsp;&nbsp;<asp:RadioButton id="RB_target_2" GroupName="Target" runat="server" />新窗口</td>
</tr>
</table>

<table border=0 cellpadding=3 cellspacing=0 width=98% align=center id="tb_code" style="display:none">
<tr>
 <td height=25 width=100>内容区</td>
  <td><div><a href="javascript:show_var('js')">&gt;&gt;预设变量及方法</a></div>
<asp:TextBox id="Zdy_Code" runat="server"  TextMode="multiLine"  style="width:95%;height:300px"/></td>
</tr>
</table>
<br>
<div align=center>
<asp:Button Text="提交" CssClass="button" Runat="server" OnClick="Data_Update" id="Bt_Submit"/>
<input type="button" class=button  value="关闭" onclick="parent.CloseDialog()">
</div>
</td>
</tr>
</table>
<br>
注意："链接窗口"仅对JS幻灯片有效,flash焦点幻灯只能为jpg格式。

<asp:Label id="LblErr" runat="server" />
</form>
</td>
</tr>
</table>
</center>
<script type="text/javascript">
var obj1=document.getElementById("D_ShowType");
var obj2=document.getElementById("D_NotShowType");
var obj3=document.getElementById("zdy_condition");
var Dl_Effect=document.getElementById("Dl_Effect");
if(obj1!=null){obj1.onchange=change_showtype;}
if(obj2!=null){obj2.onchange=change_showtype;}
function change_showtype()
 {
   var v1=obj1.value;
   var v2=obj2.value;
   if(v2!="")
    {
      if(v1=="")
       {
        obj3.value="and "+v2;
       }
      else
       {
        obj3.value="and "+v1+" and "+v2;
       }
    }
  else
    {
      obj3.value="and "+v1;
    }
  if(v2=="" && v1=="")
   {
    obj3.value="";
   }
 }

function change_notshowtype()
 {
  change_showtype();
 }
function Set_ShowTypeSelect()
 {
  var v=document.getElementById("zdy_condition").value;
  for(i=1;i<obj1.options.length;i++)
   {
     if(v.indexOf(obj1.options[i].value)>=0)
      {
       obj1.options[i].selected=true;
       break;
      }
   }
  for(i=1;i<obj2.options.length;i++)
   {
     if(v.indexOf(obj2.options[i].value)>=0)
      {
       obj2.options[i].selected=true;
       break;
      }
   }
 }
Set_ShowTypeSelect();
function AddSelect(txt,value,id) //填充专题
 {
   var obj=document.getElementById(id);
   if(obj==null){return;}
   obj.options.add(new Option(txt,value));
   obj[obj.options.length-1].selected=true;
 }
 var Slide_Ztid="<%=Slide_Ztid%>";
 if(Slide_Ztid!="" && Slide_Ztid!="0")
 {
  AddSelect("<%=Slide_Zttitle%>","<%=Slide_Ztid%>","zt_list");
 }

Style_Change();
function Style_Change()
 {
  var style=document.getElementById("Dl_Style").value;
  var tb_set=document.getElementById("tb_set");
  var tb_code=document.getElementById("tb_code");
  if(style=="0")
   {
     tb_set.style.display="none";
     tb_code.style.display="";
   }
  else
   {
     if(style=="4" || style=="5")
      {
        Dl_Effect.style.display="none";
      }
    else
      {
         Dl_Effect.style.display="";
      }
     tb_set.style.display="";
     tb_code.style.display="none";
   }

 }
function show_var(Type)
 {
   IDialog('预设变量及方法',"tag_var.aspx?type="+Type,800,400,false,"tagvar");
 }

</script>
</body>
</html>
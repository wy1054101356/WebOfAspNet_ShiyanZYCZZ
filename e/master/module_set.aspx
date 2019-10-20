<% @ Page Language="C#" Inherits="PageAdmin.module_set"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server" Type="lanmu_module"/>  
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr><td height=10></td></tr>
 <tr><td class=table_style1><b>模块设置</b></td></tr>
 <tr><td height=10></td></tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr>
<td valign=top  align="left">
<iframe name="post_iframe" id="post_iframe" src="" frameborder=0 scroling=no height=1px width=1px marginwidth=0 marginheight=0 style="display:none"></iframe>
<form runat="server" target="post_iframe">
<div id="tabdiv">
<ul>
<li id="tab" name="tab"  onclick="showtab(0)" style="font-weight:bold">内容设置</li>
<li id="tab" name="tab"  onclick="showtab(1)">相关参数</li>
<li id="tab" name="tab"  onclick="showtab(2)">html布局辅助</li>
</ul>
</div>
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top>
<table border=0 cellpadding=2 cellspacing=0 width=95% align=center>
<tr>
  <td  height=25><b>当前模块</b>：<%=ModuleName%></td>
 </tr>
</table>

<div name="tabcontent" id="tabcontent">
<table border=0 cellpadding=2 cellspacing=0 width=95% align=center>
<asp:PlaceHolder id="P1" runat="server" Visible="false">
<tr>
  <td width=100px>代码模式</td>
  <td>
   <input name="ZdyTag_Open" id="ZdyTag_Open"  type="checkbox" value="1" onclick="C_Mode()" <%=Zdy_Tag_Open=="1"?"checked":""%>>启用 
   <span id="lb_tagvar"  style="display:none"><a href="javascript:Open_TagWin()">&gt;&gt;点击生成标签</a>
   &nbsp;<a href="javascript:show_var('module')">&gt;&gt;其他预设变量及方法</a>
   </span>
  <td>
 </tr>

<tr>
  <td width=100px>内容编辑</td>
  <td>
     <div id="dcontent" name="dcontent">
      <asp:TextBox  id="Content"  TextMode="MultiLine"  runat="server" style="width:100%;height:350px;"/>
<script charset="utf-8" src="/e/incs/kindeditor/kindeditor.js"></script>
<script type="text/javascript">
        KindEditor.ready(function(K) {
                window.editor = K.create('#Content',
                    {
                      uploadJson :kindeditor_uploadJson,
                      fileManagerJson :kindeditor_fileManagerJson,
                      allowFileManager :false,
                      items :kindeditor_NormalItems,
                      newlineTag:"p",
                      filterMode :false,
                      extraFileUploadParams:{siteid:'<%=Request.Cookies["SiteId"].Value%>'}
                    }
                );
        });
</script>



     </div>
     <div id="dcontent" name="dcontent"  style="display:none">
     <asp:TextBox  id="Zdy_Tag" TextMode="MultiLine" runat="server" style="width:95%;height:300px"/>
   </div>
  </td>
 </tr>

 </tr>
</asp:PlaceHolder>

<asp:PlaceHolder id="P2" runat="server" Visible="false">

<tr>
  <td width=100px height=30>信息来源</td>
  <td>
    <select name="data_site" id="data_site" onchange="c_siteofsort('<%=TheTable%>')" style="display:<%=ShareSites==""?"none":""%>">
    <option  value="0">---所属站点---</option>
    <%=Site_List%>
    </select>

<select name="s_sort" id="s_sort" onchange="c_sort(<%=Request.Cookies["SiteId"].Value%>,1,'<%=TheTable%>','admin')">
<option  value="0">---所有分类---</option>
<%=Sort_List%>
</select>
<script type="text/javascript">
var Sort_Type="all";
Write_Select(<%=Request.Cookies["SiteId"].Value%>,'<%=TheTable%>')
</script>
<input type="hidden" name="sort" id="sort" value="<%=Sort_Id%>">
  </td>
 </tr>

<tr>
  <td height=30>显示模型</td>
  <td>
     <asp:DropDownList  id="D_Model"  DataTextField="name" DataValueField="id"  Runat="server"/>
  </td>
 </tr>

 <tr>
  <td  height=30>属性筛选</td>
  <td><asp:DropDownList  id="D_ShowType"   Runat="server">
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
<asp:ListItem value="has_titlepic=1">排除不带"标题图片"的信息</asp:ListItem>
</asp:DropDownList>
自定义条件：<asp:TextBox id="zdy_condition" Runat="server" size="40" Maxlength="50"/>
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
  <td  height=30>信息排序</td>
  <td>
<asp:DropDownList id="D_SortStr" Runat="server">
<asp:ListItem value="">默认排序</asp:ListItem>
</asp:DropDownList>
</td>
 </tr>

  <tr>
  <td height=30>目标窗口</td>
  <td><asp:DropDownList id="D_Target" Runat="server"><asp:ListItem value="_self">本窗口</asp:ListItem><asp:ListItem value="_blank">新窗口</asp:ListItem></asp:DropDownList></td>
 </tr>

  <tr>
  <td  height=30>显示信息数</td>
  <td><asp:TextBox id="Show_Num" runat="server" Value="5" Maxlength="3" size=5/> 条记录</td>
 </tr>

  <tr>
  <td  height=30>标题显示数</td>
  <td><asp:TextBox id="Title_Num" runat="server" Value="50" Maxlength="3" size=5/> 个字符</td>
 </tr>

  <tr>
  <td  height=30>标题图片</td>
  <td>宽：<asp:TextBox id="TitlePic_Width" runat="server"  Maxlength="5" size=4/>px 高：<asp:TextBox id="TitlePic_Height" runat="server" Maxlength="5" size=4/>px 注：图片尺寸也可以通过css样式文件来控制</td>
 </tr>

</asp:PlaceHolder>

<tr>
  <td height=30>模块布局</td>
  <td>
<asp:RadioButton id="Layout_1" GroupName="site" runat="server" onclick="Show_ModuleBox()" Title="等同于css里的清除浮动(clear:both)" />默认
<asp:RadioButton id="Layout_2" GroupName="site" runat="server" onclick="Show_ModuleBox()" Title="等同于css里的左浮动(float:left)，多个模块同行显示时，可以选择靠左" />靠左
<asp:RadioButton id="Layout_3" GroupName="site" runat="server" onclick="Show_ModuleBox()" Title="等同于css里的右浮动(float:right)，多个模块同行显示时，最后一个模块建议选择靠右"/>靠右</td>
 </tr>

<tr id="tr_width">
  <td height=30>模块宽度</td>
  <td><asp:TextBox id="Module_Width" runat="server"  size="7" maxlength="12" Text="100%" Title="模块布局为默认时此设置无效" />(如：500，默认单位为px，也可定义百分比，如：100%)</td>
</tr>

<tr id="tr_height">
  <td height=30>内容区高度</td>
  <td><asp:TextBox id="Module_Height" runat="server"  size="7" maxlength="12" Text="auto"/>(如：200，默认单位为px，留空或设为auto则自动适应内容高度)</td>
</tr>

<tr title="相对上一个模块的位置，选择'是'则从新的一行开始显示">
  <td height=30>换行显示</td>
  <td><asp:RadioButton id="Wrap_1" GroupName="wrap" runat="server"  />否<asp:RadioButton id="Wrap_2" GroupName="wrap" runat="server" />是</td>
 </tr>
</table>
</div>

<div name="tabcontent" id="tabcontent" style="display:none">

<table border=0 cellpadding=2 cellspacing=0 width=95% align=center>
<tr>
  <td width=100px>模块简化</td>
  <td><asp:RadioButton id="CleanContainer_0" GroupName="CleanContainer" runat="server" />默认&nbsp;
<asp:RadioButton id="CleanContainer_1" GroupName="CleanContainer" runat="server" title="选中后标题的html标签及标题都不显示"/>清除标题标签&nbsp;
<asp:RadioButton id="CleanContainer_2" GroupName="CleanContainer" runat="server" title="选中后只显示内容，外层的div容器标签将不显示，此功能主要用于标签模式下消除外层冗余div标签"/>清除外部容器标签
 </tr>

<tr>
  <td>替换名称</td>
  <td><asp:textBox TextMode="singleLine" id="tb_showname" runat="server" maxlength="200" style="width:450px" /> 用于前台替换默认模块名称，支持html标签
  </td>
</tr>

<tr>
  <td>目标地址</td>
  <td><asp:TextBox id="Url" runat="server" maxlength="250" style="width:450px"/></td>
 </tr>

<tr>
  <td>模块风格</td>
  <td><asp:DropDownList id="D_Style" DataTextField="name" DataValueField="id" Runat="server" /> </td>
</tr>

<tr>
  <td>自定义头信息<br>
  <a href="javascript:Open_Editor('pa_module','zdy_header','<%=Request.QueryString["id"]%>','HeadContent','头信息内容编辑')"><img src=images/edit.gif width=20 height=20 align=absmiddle vspace=5 hspace=5 border=0 alt="可视化编辑"></a>
</td>
  <td align="left"><asp:TextBox  id="HeadContent" TextMode="MultiLine" runat="server" style="width:90%;height:120px"/>
</td>
 </tr>
</table>

</div>

<div name="tabcontent" id="tabcontent" style="display:none">

<table border=0 cellpadding=2 cellspacing=0 width=92% align=center>
<tr>
  <td width=100px>模块开始处</td>
  <td align="left"><asp:TextBox id="StartHtml" TextMode="MultiLine" runat="server" Columns="60" rows="5"/>
</td>
 </tr>

<tr>
  <td>模块结束处</td>
  <td align="left"><asp:TextBox id="EndHtml" TextMode="MultiLine" runat="server" Columns="60" rows="5"/>
</td>
 </tr>
</table>
</div>
<div align=center style="padding:5px">
<span id="post_area">
<input type="hidden" name="ModuleName" value="<%=ModuleName%>">
<asp:Button Cssclass=button id="Bt_Submit" text="提交" runat="server" onclick="Data_Update" />
<input type="button" class=button  value="关闭"  onclick="parent.CloseDialog()">
</span>
<span id="post_loading" style="display:none"><img src=images/loading.gif vspace="5" align=absmiddle>Loading...</span>
</div>
</td>
</tr>
</table>
<asp:Label id="LblErr" runat="server" />
</form>
</td>
</tr>
</table>
<br>
</center>
</body>
<script language="javascript"> 
var Sort_Id="<%=Sort_Id%>";
Load_Sort(<%=Request.Cookies["SiteId"].Value%>,"<%=P_Sorts%>,<%=Sort_Id%>",'<%=TheTable%>');

var obj1=document.getElementById("D_ShowType");
var obj2=document.getElementById("D_NotShowType");
var obj3=document.getElementById("zdy_condition");

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

function c_f()
  {
   <% if(TheTable!="zdy")
     {
   %>
    var obj=document.getElementById("data_site")
    if(obj.selectedIndex==0)
     {
       showtab(0);
       alert("请选择信息所属站点!");
       obj.focus();
       return false;
     }
    obj=document.getElementById("D_Model")
    if(obj.selectedIndex==0)
     {
       showtab(0);
       alert("请选择模块模型!");
       obj.focus();
       return false;
     }

    obj=document.getElementById("Show_Num")
    if(obj.value=="" || isNaN(obj.value))
     {
       showtab(0);
       alert("显示信息数填写错误!");
       obj.focus();
       return false;
     }
  <%}%>
  startpost();
 }
document.getElementById("Bt_Submit").onclick=c_f;

function C_Mode()
 {
   var Obj=document.getElementById("ZdyTag_Open");
   if(Obj.checked)
    {
      document.getElementsByName("dcontent")[0].style.display="none";
      document.getElementsByName("dcontent")[1].style.display="";
      document.getElementById("lb_tagvar").style.display="";
    } 
  else
    {
      document.getElementsByName("dcontent")[0].style.display="";
      document.getElementsByName("dcontent")[1].style.display="none";
      document.getElementById("lb_tagvar").style.display="none";
    }
 }


function Open_TagWin()
 {
  if(document.getElementById("ZdyTag_Open").checked)
   {
    IDialog("模块标签生成界面","get_tag.aspx?type=module&iszt=<%=Request.QueryString["iszt"]%>&lanmuid=<%=Request.QueryString["lanmuid"]%>","90%","90%");
   }
  else
   {
    alert("只有代码模式下才可以调用标签,可点击左侧的单选框开启。")
   }
 }

   <% if(TheTable=="zdy" && Zdy_Tag_Open=="1")
     {
   %>
     C_Mode();
   <%}%>
function show_var(Type)
 {
   IDialog('预设变量及方法',"tag_var.aspx?type="+Type,"90%","90%",false,"tagvar");
 }

function AddSelect(txt,value,id) //填充专题
 {
   var obj=document.getElementById(id);
   if(obj==null){return;}
   obj.options.add(new Option(txt,value));
   obj[obj.options.length-1].selected=true;
 }

 <% if(Module_Ztid!="" && Module_Ztid!="0")
     {
   %>
    AddSelect("<%=Module_Zttitle%>","<%=Module_Ztid%>","zt_list");
 <%}%>
</script>
</html>  
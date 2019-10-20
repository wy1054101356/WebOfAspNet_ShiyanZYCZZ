<% @ Page Language="C#" Inherits="PageAdmin.sublanmu_set"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server" type="lanmu_nav"/> 
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=96% >
 <tr><td height=10></td></tr>
 <tr><td class=table_style1><b>子栏目设置</b></td></tr>
 <tr><td height=10></td></tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=96% align=center >
 <tr>
<td valign=top  align="left">
<iframe name="post_iframe" id="post_iframe" src="" frameborder=0 scroling=no height=1px width=1px marginwidth=0 marginheight=0 style="display:none"></iframe>
<form runat="server" target="post_iframe">
<div id="tabdiv">
<ul>
<li id="tab" name="tab"  onclick="showtab(0)" style="font-weight:bold">内容设置</li>
<li id="tab" name="tab"  onclick="showtab(1)">相关设置</li>
<li id="tab" name="tab"  onclick="showtab(2)">页面参数</li>
</ul>
</div>
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center class=table_style2>
<tr>
  <td valign=top>
<table border=0 cellpadding=2 cellspacing=0 width=98% align=center>
<tr>
  <td  colspan=2 height=25><b>当前子栏目</b>：<%=Sublanmu_Site%> &gt; <asp:Label id="Lb_Name" runat="server"/></td>
 </tr>
</table>

<asp:PlaceHolder id="Place_1" runat="server"  Visible="false">
<div name="tabcontent" id="tabcontent">
<table border=0 cellpadding=2 cellspacing=0 width=95% align=center>
<tr>
  <td width=80px>代码模式</td>
  <td>
   <input name="ZdyTag_Open" id="ZdyTag_Open"  type="checkbox" value="1" onclick="C_Mode()" <%=Zdy_Tag_Open=="1"?"checked":""%>>启用
   <a href="javascript:show_var('sublanmu')" id="a_tagvar" style="display:none">&gt;&gt;预设变量及方法</a>
  <td>
 </tr>

<tr>
  <td width=80px><b>内容编辑</b></td>
  <td>
     <div id="dcontent" name="dcontent">
      <asp:TextBox  id="Content"  TextMode="MultiLine"  runat="server" style="width:100%;height:390px;"/>
<script charset="utf-8"  src="/e/incs/kindeditor/kindeditor.js" type="text/javascript"></script>
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
     <asp:TextBox  id="Zdy_Tag" TextMode="MultiLine" runat="server" style="width:95%;height:450px"/>
   </div>
  </td>
 </tr>
</table>
</div>
</asp:PlaceHolder>

<asp:PlaceHolder id="Place_2" runat="server" Visible="false">
<div name="tabcontent" id="tabcontent">
<table border=0 cellpadding=3 cellspacing=0 width=95% align=center>
<tr>
  <td height=30 width=80px>信息来源</td>
  <td>
 <select name="data_site" id="data_site" onchange="c_siteofsort('<%=TheTable%>')" style="display:<%=ShareSites==""?"none":""%>">
    <option  value="0">---所属站点---</option>
    <%=Site_List%>
    </select>

<select name="s_sort" id="s_sort" onchange="c_sort(<%=SiteId%>,1,'<%=TheTable%>','admin')">
<option  value="0">---所有类别---</option>
<%=Sort_List%>
</select>
<script type="text/javascript">
var Sort_Type="all";
Write_Select(<%=SiteId%>,'<%=TheTable%>')
</script>
<input type="hidden" name="sort" id="sort" value="<%=Sort_Id%>"><br>
<asp:CheckBox id="Cb_SortSubLanmu" Runat="server" Checked/>是否作为调用分类的目标子栏目
  </td>
</tr>

<tr>
  <td height=30>子栏目模型</td>
  <td><asp:DropDownList  id="D_Model"  DataTextField="name" DataValueField="id"  Runat="server"/>
     内容页模型：<asp:DropDownList  id="D_Model_Detail"  DataTextField="name" DataValueField="id"  Runat="server"/>
  </td>
 </tr>


 <tr>
  <td  height=30>信息筛选</td>
  <td>
<asp:DropDownList  id="D_ShowType"   Runat="server">
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

自定义条件：<asp:TextBox id="zdy_condition" Runat="server" size="30" Maxlength="50"/>

</td>
 </tr>

 <tr>
  <td  height=30>专题筛选</td>
  <td>
<select name="zt_list" id="zt_list"><option value="0">选择所属专题</option></select><input type="button" value="选择专题" class="f_bt" onclick="open_ztlist(0)"> 注：表示只调用属于对应专题的信息，不选择则不限制
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
  <td  height=30>每页显示数</td>
  <td><asp:TextBox id="Show_Num" runat="server" Text="20" Maxlength="5" size=5/> 条记录</td>
 </tr>

  <tr>
  <td  height=30>标题显示数</td>
  <td><asp:TextBox id="Title_Num" runat="server" Value="100" Maxlength="3" size=5/> 个字符</td>
 </tr>

  <tr>
  <td  height=30>标题图片</td>
  <td>宽：<asp:TextBox id="TitlePic_Width" runat="server"  Maxlength="5" size=5/>px 高：<asp:TextBox id="TitlePic_Height" runat="server" Maxlength="5" size=5/>px 注：图片尺寸也可以通过css样式文件来控制</td>
 </tr>
</table>
</div>
</asp:PlaceHolder>

<div name="tabcontent" id="tabcontent" style="display:none">
 <table border=0 cellpadding=3 cellspacing=0 width=98% align=center>
 <tr style="display:<%=(Is_Static=="1")?"":"none"%>">
  <td align="left" width=120px>子栏目页生成设置</td>
  <td align="left">
<asp:RadioButton id="List_Html_1" GroupName="listhtml" runat="server"/>动态页面&nbsp;
<%if(TheTable!="zdy" && TheTable!=""){%><asp:RadioButton id="List_Html_2" GroupName="listhtml" runat="server"/>伪静态&nbsp;<%}%>
<asp:RadioButton id="List_Html_3" GroupName="listhtml" runat="server"/>静态 <%if(TheTable!="zdy" && TheTable!=""){%>(只生成前<asp:TextBox id="List_Html_Num" size="5" runat="server" maxlength="10" Text="5" />页)<%}%>
</td>
 </tr>

<tr style="display:<%=(Is_Static=="1" && TheTable!="zdy" && TheTable!="")?"":"none"%>">
  <td align="left">内容页生成设置</td>
 <td align="left">
<asp:RadioButton id="Detail_Html_1" GroupName="detailhtml" runat="server"/>动态页面&nbsp;
<asp:RadioButton id="Detail_Html_2" GroupName="detailhtml" runat="server"/>伪静态&nbsp;
<asp:RadioButton id="Detail_Html_3" GroupName="detailhtml" runat="server"/>静态页面&nbsp;&nbsp;
</td>
</tr>
<tr>
  <td>替换名称</td>
  <td><asp:textBox TextMode="singleLine" id="tb_showname" runat="server" maxlength="200" style="width:400px" /> 用于前台替换默认子栏目名，支持html标签。
  </td>
</tr>

<tr>
  <td align="left" width=120px>自定义Url</td>
  <td align="left"><asp:textBox TextMode="singleLine"  id="tb_zdyurl" runat="server"  maxlength="150"  style="width:400px" />
</td>
</tr>

<tr id="Tr_Dir">
  <td  height=25 width=100px>静态文件生成目录</td>
  <td title="必填项，只能由字母、数字或下划线组成"><select name="Lanmu_Dir" id="Lanmu_Dir">
   <option value="/">请选择父目录</option>
   <option value="<%=Lanmu_Dir%>" <%=Lanmu_Dir==CLanmu_Dir?"selected":""%>><%=Lanmu_Dir%></option>
   <option value="" <%=CLanmu_Dir==""?"selected":""%>>空</option></select>/<input name="SubLanmu_Dir" type="text" maxlength="30" id="SubLanmu_Dir" size="15" value="<%=SubLanmu_Dir%>"> 注：只能由字母，数字和下划线组成，如需减少目录层次，父目录可设置为空</td>
</tr>


<%if(TheTable!="zdy"){%>
<tr>
  <td>子栏目页头<br>
  <a href="javascript:Open_Editor('pa_sublanmu','content','<%=Request.QueryString["id"]%>','HeadContent','页头内容编辑')"><img src=images/edit.gif width=20 height=20 align=absmiddle vspace=5 hspace=5 border=0 alt="可视化编辑"></a>
</td>
  <td align="left"><asp:TextBox id="HeadContent" TextMode="MultiLine" runat="server" style="width:90%;height:120px"/>
</td>
</tr>
<%}%>
<tr>
<td align=left>浏览权限</td>
<td>
  <select id="Perms_MemberType" name="Perms_MemberType" size="5" style="width:250px" multiple>
   <option value="">所有用户组</option>
   <%=MemberTypeList%>
  </select>
  <br><span style="color:#999">按住Ctrl键可实现多选或取消选择。</span>
</td>
</tr>
</table>
</div>

<div name="tabcontent" id="tabcontent" style="display:none">
<table border=0 cellpadding=3 cellspacing=0 width=95% align=center>
<tr>
  <td style="width:100px">自定义样式路径<br></td>
  <td><asp:textBox TextMode="singleLine" id="tb_csspath" runat="server" maxlength="150" style="width:300px" /> 如：/e/template/01/diy.css，留空则继承网站参数设置的样式或上级栏目的设置
  </td>
 </tr>

<tr>
  <td>Seo标题</td>
  <td align="left"><asp:textBox TextMode="singleLine" id="tb_title" runat="server" maxlength="150" style="width:600px"/>
</td>
 </tr>

<tr>
  <td>Seo关键字</td>
 <td align="left" title="关键字之间用半角逗号分开"><asp:textBox TextMode="singleLine" id="tb_keywords" runat="server" maxlength="150" style="width:600px" />
</td>
 </tr>

<tr>
  <td>Seo描述</td>
 <td align="left" title="控制在250字以内"><asp:TextBox TextMode="multiLine" id="tb_description" runat="server" onkeyup="if(this.value.length>250)this.value=this.value.substring(0,250)" style="width:90%;height:80px"/>
</td>
 </tr>

<tr>
  <td>head区自定义<br></td>
  <td><asp:TextBox  id="Headzdy" TextMode="MultiLine" runat="server" style="width:90%;height:80px" />
  </td>
</tr>

<tr>
  <td>顶部信息自定义<br><a href="javascript:Open_Editor('pa_partparameter','zdy_wztop','<%=FieldId%>','Wztopzdy','顶部信息自定义')"><img src=images/edit.gif width=20 height=20 align=absmiddle vspace=5 hspace=5 border=0 alt="可视化编辑"></a></td>
  <td><asp:TextBox  id="Wztopzdy"  TextMode="MultiLine"  runat="server" style="width:90%;height:80px" />
  </td>
 </tr>
<tr>
<tr>
 <td colspan=2 height="20">注:自动替换网站顶部信息，留空则显示默认。</td>
</tr>

<tr>
  <td>栏目自定义<br><a href="javascript:Open_Editor('pa_partparameter','zdy_lanmu','<%=FieldId%>','Lanmuzdy','栏目自定义')"><img src=images/edit.gif width=20 height=20 align=absmiddle vspace=5 hspace=5 border=0 alt="可视化编辑"></a></td>
  <td><asp:TextBox id="Lanmuzdy" TextMode="MultiLine"  runat="server" style="width:90%;height:80px"/>
  </td>
 </tr>
<tr>
 <td colspan=2 height="20">注:自动替换网站默认栏目条，留空则显示默认。</td>
</tr>

<tr>
  <td width=100px>横幅自定义<br><a href="javascript:Open_Editor('pa_partparameter','zdy_banner','<%=FieldId%>','Banner','banner横幅自定义')"><img src=images/edit.gif width=20 height=20 align=absmiddle vspace=5 hspace=5 border=0 alt="可视化编辑"></a></td>
  <td><asp:TextBox  id="Banner"  TextMode="MultiLine"  runat="server" style="width:90%;height:80px" />
  </td>
 </tr>
<tr>
 <td colspan=2 height="20">注:留空则默认通栏Banner，不显示默认banner可以输入&lt;!--hide--&gt;等注释标签</td>
</tr>
<tr>
  <td>小幅banner自定义<br><a href="javascript:Open_Editor('pa_partparameter','zdy_smallbanner','<%=FieldId%>','SmallBanner','小幅banner自定义')"><img src=images/edit.gif width=20 height=20 align=absmiddle vspace=5 hspace=5 border=0 alt="可视化编辑"></a></td>
  <td><asp:TextBox  id="SmallBanner"  TextMode="MultiLine"  runat="server" style="width:90%;height:80px" />
  </td>
 </tr>

<tr>
    <td>当前位置自定义</td>
    <td><asp:TextBox  id="Tb_Zdy_Locaiton"  TextMode="MultiLine"  runat="server" style="width:90%;height:80px" />
  </td>
 </tr>
<tr>
 <td colspan=2 height="20">注:自动替换当前位置信息，留空则显示默认。</td>
</tr>

<tr>
  <td>底部信息自定义<br><a href="javascript:Open_Editor('pa_partparameter','zdy_bottom','<%=FieldId%>','Wzbottomzdy','底部信息自定义')"><img src=images/edit.gif width=20 height=20 align=absmiddle vspace=5 hspace=5 border=0 alt="可视化编辑"></a></td>
  <td><asp:TextBox  id="Wzbottomzdy"  TextMode="MultiLine"  runat="server" style="width:90%;height:80px" />
  </td>
 </tr>
<tr>
<tr>
 <td colspan=2 height="20">注:留空则显示默认底部内，开头加&lt;!--prepend--&gt;或&lt;!--append--&gt;可在默认内容前或后实现插入自定义内容。</td>
</tr>
</table>
</div>
<div align=center style="padding:5px">
<asp:Label  id="Lb_sitedir" runat="server" visible="false"/>
<asp:Label  id="Lb_parentids" runat="server" visible="false"/>
<asp:Label  id="Lb_parentdir" runat="server" visible="false"/>
<asp:Label  id="Lb_sublanmufile" runat="server" visible="false"/>
<asp:Label  id="Lb_language" runat="server" visible="false"/>
<asp:Label  id="Lb_prefix" runat="server" visible="false"/>

<span id="post_area">
<asp:Button Cssclass=button text="提交" id="Bt_Submit" runat="server" onclick="Data_Update" />
<input type="button" class=button  value="关闭"  onclick="parent.CloseDialog();">
</span>
<span id="post_loading" style="display:none"><img src=images/loading.gif vspace="5" align=absmiddle>Loading...</span>
</div>
</td>
</tr>
</table>
</form>
</td>
</tr>
</table>
<br>
</center>
</body>
<script type="text/javascript">

<% if(TheTable=="zdy"){%>
//document.getElementsByName("tab")[1].style.display="none";
if(document.getElementsByName("tabcontent")[1].style.display=="")
 {
  showtab(0);
 }
<%}%>

<% if(TheTable==""){%>
document.getElementsByName("tab")[0].style.display="none";
showtab(1);
<%}%>

Load_Sort(<%=SiteId%>,"<%=P_Sorts%>,<%=Sort_Id%>",'<%=TheTable%>');
Set_Selected("<%=Permissions%>","Perms_MemberType");

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

var IsRepeat="";
function c_f()
  {
   <% if(TheTable!="zdy" && TheTable!="")
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
       alert("请选择子栏目模型!");
       obj.focus();
       return false;
     }

    obj=document.getElementById("D_Model_Detail")
    if(obj.selectedIndex==0)
     {
       showtab(0);
       alert("请选择内容页模型!");
       obj.focus();
       return false;
     }
    obj=document.getElementById("Show_Num")
    if(obj.value=="" || isNaN(obj.value))
     {
       showtab(0);
       alert("每页显示数填写错误!");
       obj.focus();
       return false;
     }
    var Cb_SortSubLanmu=document.getElementById("Cb_SortSubLanmu");
    if(Cb_SortSubLanmu.checked)
     {
        var s_objs=document.getElementsByName("s_sort");
        var s_objs_last=s_objs[0];
        for(i=0;i<s_objs.length;i++)
         {
           if(s_objs[i].style.display=="none")
            {
              s_objs_last=s_objs[i-1];
              break;
            }
         }
       var sort=s_objs_last.value;
       if(sort=="" || sort=="0")
       {
          sort=document.getElementById("sort").value;
          RepeatCheck(sort);
          if(IsRepeat!="")
           {
             alert("请取消”是否作为调用分类的目标子栏目”属性的选择!\n\n此调用分类的子分类已经被其他子栏目调用，并已作为目标子栏目存在。");
             return false;
           }
       }
     }
  <%}%>
     obj=document.getElementById("Lanmu_Dir");
     if(obj.value=="/")
     {
       showtab(1);
       alert("请选择父目录");
       obj.focus();
       return false;
     }
     obj=document.getElementById("SubLanmu_Dir")
      if(obj.value=="")
       {
       showtab(1);
       alert("静态文件生成目录必须填写!");
       obj.focus();
       return false;
       }
      else if(!IsStr(obj.value))
       {
        showtab(1);
        alert("目录名称只能由字母、数字和下划线组成");
        obj.focus();
        return false;
       }

  var Format_Fck=true;
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
      document.getElementById("a_tagvar").style.display="";
    } 
  else
    {
      document.getElementsByName("dcontent")[0].style.display="";
      document.getElementsByName("dcontent")[1].style.display="none";
      document.getElementById("a_tagvar").style.display="none";
    }
 }
   <% if(TheTable=="zdy" && Zdy_Tag_Open=="1")
     {
   %>
     C_Mode();
   <%}%>

function AddSelect(txt,value,id) //填充专题
 {
   var obj=document.getElementById(id);
   if(obj==null){return;}
   obj.options.add(new Option(txt,value));
   obj[obj.options.length-1].selected=true;
 }

 <% if(Sublanmu_Ztid!="" && Sublanmu_Ztid!="0")
     {
   %>
    AddSelect("<%=Sublanmu_Zttitle%>","<%=Sublanmu_Ztid%>","zt_list");
 <%}%>

function RepeatCheck(sortid) //检查子栏目是否调用重复。
 {
   if(sortid==""){return;}
   var R=Math.random();
   var x=new PAAjax();
   x.setarg("get",false);
   x.send("sublanmu_repeatcheck.aspx","siteid=<%=SiteId%>&datasiteid="+document.getElementById("data_site").value+"&table=<%=TheTable%>&sublanmuid=<%=Id%>&sortid="+sortid+"&r="+R,function(v){IsRepeat=v});
 }

function show_var(Type)
 {
   IDialog('预设变量及方法',"tag_var.aspx?type="+Type,800,400,false,"tagvar");
 }
</script>
</html>  
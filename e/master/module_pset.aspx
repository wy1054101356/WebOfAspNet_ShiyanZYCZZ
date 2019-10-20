<% @ Page Language="C#"%>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<% @ Import NameSpace="PageAdmin"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<script language="c#" runat="server">
 OleDbConnection conn;
 int SiteId;
 string UserName;
 protected void Page_Load(Object src,EventArgs e)
    {
     Master_Valicate YZ=new Master_Valicate();
     YZ.Master_Check();
     UserName=YZ._UserName;
     SiteId=int.Parse(Request.Cookies["SiteId"].Value);
     Conn Myconn=new Conn();
     conn=Myconn.OleDbConn();//获取OleDbConnection
     if(!Page.IsPostBack)
     {
       conn.Open();
       Get_Site(SiteId);
       Module_Style();
       conn.Close();
     }
   }

protected void Data_Update(Object src,EventArgs e)
 {
   int CleanContainer=0,Layout=0,ShowNum=0,TitleNum=0,Titlepic_Width=0,Titlepic_Height=0;
   string T_Width="",T_Height="";
   if(Show_Num.Text!="0" && IsNum(Show_Num.Text.Trim()))
    {
      ShowNum=int.Parse(Show_Num.Text.Trim());
    }
   else
    {
      ShowNum=20;
    }
   if(IsNum(Title_Num.Text.Trim()))
    {
      TitleNum=int.Parse(Title_Num.Text.Trim());
    }
   else
    {
      TitleNum=100;
    }
   if(IsNum(TitlePic_Width.Text.Trim()))
    {
      Titlepic_Width=int.Parse(TitlePic_Width.Text.Trim());
    }
   if(IsNum(TitlePic_Height.Text.Trim()))
    {
      Titlepic_Height=int.Parse(TitlePic_Height.Text.Trim());
    }
   if(CleanContainer_2.Checked)
     {
      CleanContainer=2;
     }
   else if(CleanContainer_1.Checked)
     {
      CleanContainer=1;
     } 
  if(Layout_3.Checked)
   {
     Layout=2;
   }
  if(Layout_2.Checked)
   {
     Layout=1;
   }
   T_Width=Module_Width.Text;
   if(T_Width!="")
    {
    if(!IsNum(T_Width.Replace("%","").Replace("px","")) || T_Width=="0")
     {
      T_Width="";
     }
    if(T_Width.IndexOf("%")<1 && T_Width.IndexOf("px")<1)
     {
      T_Width=T_Width+"px";
     }
    if(T_Width.IndexOf("%")>0 && T_Width.IndexOf("px")>0)
     {
      T_Width="100%";
     }
   }

   T_Height=Module_Height.Text;
   if(!IsNum(T_Height.Replace("%","").Replace("px","")))
    {
     T_Height="";
    }
   if(T_Height!="")
   {
    if(T_Height.IndexOf("%")<1 && T_Height.IndexOf("px")<1)
    {
      T_Height=T_Height+"px";
    }
   }
   if(T_Height.IndexOf("%")>0 && T_Height.IndexOf("px")>0)
    {
     T_Height="";
    }
   int IsWrap=0;
   if(Wrap_2.Checked)
    {
     IsWrap=1;
    }
    string sql_str="";
    if(Request.Form["ck_show"]=="1")
     {
      sql_str+=",show="+Sql_Format(Request.Form["show"]);
     }

    if(Request.Form["showtype_set"]=="1")
     {
      sql_str+=",zdy_condition='"+Sql_Format(Request.Form["zdy_condition"])+"'";
     }
    if(Request.Form["showsort_set"]=="1")
     {
      sql_str+=",zdy_sort='"+Request.Form["D_SortStr"]+"'";
     }
    if(Request.Form["target_set"]=="1")
     {
      sql_str+=",Target='"+Request.Form["D_Target"]+"'";
     }
    if(Request.Form["show_num_set"]=="1")
     {
      sql_str+=",show_num="+ShowNum;
     }
    if(Request.Form["title_num_set"]=="1")
     {
      sql_str+=",title_num="+TitleNum;
     }
    if(Request.Form["titlepic_set"]=="1")
     {
      sql_str+=",titlepic_width="+Titlepic_Width+",titlepic_height="+Titlepic_Height;
     }
   if(Request.Form["ck_clean_container"]=="1")
    {
     sql_str+=",clean_container="+CleanContainer;
    }
    if(Request.Form["ck_showname"]=="1")
     {
      sql_str+=",showname='"+Sql_Format(tb_showname.Text.Trim())+"'";
     }
   if(Request.Form["ck_url"]=="1")
    {
     sql_str+=",tourl='"+Sql_Format(Url.Text)+"'";
    }
   if(Request.Form["ck_style"]=="1")
    {
     sql_str+=",zdy_style="+D_Style.SelectedItem.Value;
    }
   if(Request.Form["ck_head"]=="1")
    {
     sql_str+=",zdy_header='"+Sql_Format(HeadContent.Text)+"'";
    }
   if(Request.Form["ck_layout"]=="1")
    {
     sql_str+=",layout="+Layout;
    }
   if(Request.Form["ck_width"]=="1")
    {
     sql_str+=",width='"+T_Width+"'";
    }
   if(Request.Form["ck_height"]=="1")
    {
     sql_str+=",height='"+T_Height+"'";
    }
   if(Request.Form["ck_wrap"]=="1")
    {
     sql_str+=",iswrap="+IsWrap;
    }
   string Ids=Request.Form["ids"];
   string[] AIds=Ids.Split(',');
   string TheTable,sql;
   conn.Open();
   OleDbCommand comm;
   OleDbDataReader dr;
   for(int i=0;i<AIds.Length;i++)
    {
     if(AIds[i]==""){continue;}
     sql="update pa_module set xuhao=xuhao"+sql_str+" where id="+AIds[i];
     comm=new OleDbCommand(sql,conn);
     comm.ExecuteNonQuery();
    }
   conn.Close();
   PageAdmin.Log log=new PageAdmin.Log();
   log.Save(int.Parse(Request.Cookies["SiteId"].Value),1,"edit",1,UserName,"模块批量设置属性(所属栏目："+Request.QueryString["lanmuname"]+")");
   Response.Write("<scri"+"pt type='text/javascript'>parent.postover('提交成功!');</"+"script>"); 
   Response.End(); 
 }

private void Get_Site(int sid)
 {
   string sql="select * from pa_site where id="+sid;
   OleDbCommand  comm=new OleDbCommand(sql,conn);
   OleDbDataReader dr=comm.ExecuteReader();
   if(!dr.Read())
    {
     dr.Close();
     conn.Close();
     Response.Write("<"+"script>alert('无效站点id');</"+"script>");
     Response.End();
    }
   dr.Close();
 }


private void Module_Style()
 {
   string sql="select id,name from pa_style where thetype='module' order by xuhao";
   DataSet ds=new DataSet();
   OleDbDataAdapter myAdapter=new OleDbDataAdapter(sql,conn);
   myAdapter.Fill(ds,"table1");
   D_Style.DataSource= ds.Tables["table1"].DefaultView;
   D_Style.DataBind(); 
   D_Style.Items.Insert(0,new ListItem("默认风格","0"));
 }

private string Sql_Format(string str)
 {
   string Res=str.Replace("'","''");
   Res=Res.Replace("\"","\""); 
   return Res;
 }


private bool IsNum(string str)
 {
  if(str=="" || str==null)
   {
    return false;
   }
  string str1="0123456789";
  string str2=str.ToLower();

  for(int i=0;i<str2.Length;i++)
   {
    if(str1.IndexOf(str2[i])==-1)
     {
       return false;
     }
   }
  return true;
 }
</script>
<aspcn:uc_head runat="server" /> 
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table border=0 cellpadding=10 cellspacing=0 width=98%>
 <tr>
<td valign=top  align="left">
<iframe name="pframe" id="pframe" src="" frameborder=0 scroling=no height=1px width=1px marginwidth=0 marginheight=0 style="display:none"></iframe>
<div id="tabdiv">
<ul>
<li id="tab" name="tab"  onclick="showtab(0)" style="font-weight:bold">内容属性</li>
<li id="tab" name="tab"  onclick="showtab(1)">其他属性</li>
</ul>
</div>
<form runat="server" target="pframe">
<table border=0 cellpadding=0 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top style="padding:10px 0 0 0">
<div name="tabcontent" id="tabcontent">
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center>

<tr>
    <td width="110px"><input type="checkbox" name="ck_show" value="1">显示属性</td>
    <td><input type="radio" name="show" value="1" checked>显示
        <input type="radio" name="show" value="0">隐藏
  </td>
 </tr>

 <tr>
  <td><input type="checkbox" name="showtype_set" value="1">信息筛选</td>
  <td><select name="D_ShowType" id="D_ShowType" onchange="change_showtype()">
	<option selected="selected" value="">所有信息</option>
	<option value="istop=1">&quot;置顶&quot;信息</option>
	<option value="isgood=1">&quot;推荐&quot;信息</option>
	<option value="isnew=1">&quot;最新&quot;信息</option>
	<option value="ishot=1">&quot;热门&quot;信息</option>

</select><select name="D_NotShowType" id="D_NotShowType" onchange="change_notshowtype()">
	<option selected="selected" value="">无排除信息</option>
	<option value="istop=0">排除&quot;置顶&quot;信息</option>
	<option value="isgood=0">排除&quot;推荐&quot;信息</option>
	<option value="isnew=0">排除&quot;最新&quot;信息</option>
	<option value="ishot=0">排除&quot;热门&quot;信息</option>
	<option value="source_id=0">排除&quot;推送&quot;信息</option>
	<option value="reply_state=1">排除&quot;未回复&quot;信息</option>
	<option value="titlepic&lt;>''">排除&quot;标题图片&quot;为空信息</option>

</select> 条件：<input name="zdy_condition" type="text" maxlength="50" id="zdy_condition" size="25" />
</td>
 </tr>

  <tr>
  <td  height=26><input type="checkbox" name="showsort_set" value="1">信息排序</td>
  <td>
<select name="D_SortStr" id="D_SortStr">
	<option selected="selected" value="">默认排序</option>
	<option value="order by thedate desc">按发布日期↓</option>
	<option value="order by thedate asc">按发布日期↑</option>
	<option value="order by id desc">按ID↓</option>
	<option value="order by id">按ID↑</option>
	<option value="order by clicks desc">按点击量↓</option>
	<option value="order by downloads desc">按下载量↓</option>
	<option value="order by comments desc">按评论量↓</option>
</select>
</td>
 </tr>

  <tr>
  <td height=26><input type="checkbox" name="target_set" value="1">目标窗口</td>
  <td><select name="D_Target" id="D_Target"><option value="_self">本窗口</option><option value="_blank">新窗口</asp:ListItem></option></td>
 </tr>

  <tr>
  <td  height=26><input type="checkbox" name="show_num_set" value="1">信息显示数</td>
  <td><asp:TextBox id="Show_Num" runat="server" Text="6" Maxlength="5" size=5/> 条记录</td>
 </tr>

  <tr>
  <td height=26><input type="checkbox" name="title_num_set" value="1">标题显示数</td>
  <td><asp:TextBox id="Title_Num" runat="server" Value="100" Maxlength="3" size=5/> 个字符</td>
 </tr>

  <tr>
  <td  height=26><input type="checkbox" name="titlepic_set" value="1">标题图片</td>
  <td>宽：<asp:TextBox id="TitlePic_Width" runat="server"  Maxlength="5" size=5 text="100"/>px 高：<asp:TextBox id="TitlePic_Height" runat="server" Maxlength="5" size=5 text="100"/>px 注：其中一个设置0表示自动缩放</td>
 </tr>
<tr>
  <td height=26><input type="checkbox" name="ck_layout" value="1">模块布局</td>
  <td>
<asp:RadioButton id="Layout_1" GroupName="site" runat="server" Title="一个模块一行" checked/>整行
<asp:RadioButton id="Layout_2" GroupName="site" runat="server" Title="多个模块同行显示时，可以选择靠左" />靠左
<asp:RadioButton id="Layout_3" GroupName="site" runat="server" Title="如果是同行中最右边的模块，务必选择靠右，以保证各种浏览器正常显示"/>靠右 (说明：模块布局只有选择靠左时,模块宽度定义有才效)</td>
 </tr>

<tr>
  <td height=26><input type="checkbox" name="ck_width" value="1">模块宽度</td>
  <td><asp:TextBox id="Module_Width" runat="server"  size="6" maxlength="10" value=""/>(填写数字或百分比,留空则默认宽度)</td>
 </tr>

<tr>
  <td height=26><input type="checkbox" name="ck_height" value="1">内容区高度</td>
  <td><asp:TextBox id="Module_Height" runat="server"  size="6" maxlength="10" value=""/>(填写数值，自动适应高度则留空)</td>
 </tr>

<tr title="相对上一个模块的位置，选择'是'则从新的一行开始显示">
  <td height=26><input type="checkbox" name="ck_wrap" value="1">换行显示</td>
  <td><asp:RadioButton id="Wrap_1" GroupName="wrap" runat="server"  checked/>否<asp:RadioButton id="Wrap_2" GroupName="wrap" runat="server" />是</td>
 </tr>
</table>
</div>

<div name="tabcontent" id="tabcontent" style="display:none">
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center>
<tr>
  <td width=100px><input type="checkbox" name="ck_clean_container" value="1">模块简化</td>
  <td>
<asp:RadioButton id="CleanContainer_0" GroupName="CleanContainer" runat="server" checked/>默认&nbsp;
<asp:RadioButton id="CleanContainer_1" GroupName="CleanContainer" runat="server" title="选中后标题的html标签及标题都不显示"/>清除标题标签&nbsp;
<asp:RadioButton id="CleanContainer_2" GroupName="CleanContainer" runat="server" title="选中后只显示内容，外层的div容器标签将不显示，此功能主要用于标签模式下消除外层冗余div标签"/>清除外部容器标签

 </td>
 </tr>

<tr title="用于前台替换默认模块名称，支持html标签">
  <td><input type="checkbox" name="ck_showname" value="1">替换名称</td>
  <td><asp:TextBox id="tb_showname" runat="server" maxlength="200" style="width:400px" /></td>
</tr>

<tr>
  <td><input type="checkbox" name="ck_url" value="1">目标地址</td>
  <td><asp:TextBox id="Url" runat="server"  maxlength="250" style="width:400px" /></td>
</tr>

<tr>
  <td><input type="checkbox" name="ck_style" value="1">模块风格</td>
  <td><asp:DropDownList id="D_Style" DataTextField="name" DataValueField="id" Runat="server" /></td>
</tr>
<tr>
  <td><input type="checkbox" name="ck_head" value="1">自定义头信息</td>
  <td align="left"><asp:TextBox  id="HeadContent" TextMode="MultiLine" runat="server" style="width:90%;height:100px"/>
</td>
 </tr>
</table>
</div>
<div align=center style="padding:10px">
<span id="post_area">
<input type="hidden" value="" name="ids" id="ids">
<asp:Button Cssclass=button text="提交" id="Submit" runat="server" onclick="Data_Update" onclientclick="startpost()"/>
<input type="button" value="关闭" class="button" onclick="parent.CloseDialog()">
</span>
<span id="post_loading" style="display:none"><img src=images/loading.gif vspace="5" align=absmiddle>Loading...</span>
</div>
<br>
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
document.getElementById("ids").value=parent.document.getElementById("ids").value;
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
</script>
</html>  




<% @ Page Language="C#"%>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<% @ Import NameSpace="System.IO"%>
<% @ Import NameSpace="PageAdmin"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<script language="c#" Runat="server">
OleDbConnection conn;
string Is_Static,TheTable,Sort_Id,UserName,MemberTypeList;
int SiteId;
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
       MemberType_Bind();
       conn.Close();
     }
   }

protected void Data_Update(Object src,EventArgs e)
 {
 
   int ShowNum=0,TitleNum=0,Titlepic_Width=150,Titlepic_Height=150,List_html,List_html_page=0,Detail_html=0;
   string Show_Type="",NotShow_Type="",Sort_Str="",Target="";

   Show_Type=Request.Form["D_ShowType"];
   NotShow_Type=Request.Form["D_NotShowType"];
   Sort_Str=Request.Form["D_SortStr"];
   Target=Request.Form["D_Target"];

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

  //其他属性
       List_html=0;
      if(List_Html_3.Checked)
       {
         List_html=2;
       }
      if(List_Html_2.Checked)
       {
         List_html=1;
       }
      if(IsNum(List_Html_Num.Text.Trim()))
        {
          List_html_page=int.Parse(List_Html_Num.Text.Trim());
        }
      else
        {
          List_html_page=10;
        }
      Detail_html=0;
      if(Detail_Html_3.Checked)
       {
        Detail_html=2;
       }
      if(Detail_Html_2.Checked)
       {
        Detail_html=1;
       }


    string sublanmu_str="",sql_str="";
    if(Request.Form["ck_show"]=="1")
     {
      sublanmu_str+=",show="+Sql_Format(Request.Form["show"]);
     }
    if(Request.Form["showtype_set"]=="1")
     {
      sublanmu_str+=",zdy_condition='"+Sql_Format(Request.Form["zdy_condition"])+"'";
     }
    if(Request.Form["showsort_set"]=="1")
     {
      sublanmu_str+=",zdy_sort='"+Sort_Str+"'";
     }
    if(Request.Form["target_set"]=="1")
     {
      sublanmu_str+=",Target='"+Target+"'";
     }
    if(Request.Form["show_num_set"]=="1")
     {
      sublanmu_str+=",show_num="+ShowNum;
     }
    if(Request.Form["title_num_set"]=="1")
     {
      sublanmu_str+=",title_num="+TitleNum;
     }
    if(Request.Form["titlepic_set"]=="1")
     {
      sublanmu_str+=",titlepic_width="+Titlepic_Width+",titlepic_height="+Titlepic_Height;
     }

    if(Request.Form["list_html_set"]=="1")
     {
      sublanmu_str+=",list_html="+List_html+",list_html_page="+List_html_page;
     }

    if(Request.Form["detail_html_set"]=="1")
     {
      sublanmu_str+=",detail_html="+Detail_html;
     }

    if(Request.Form["permissions_set"]=="1")
     {
      sublanmu_str+=",permissions='"+Sql_Format(Request.Form["Perms_MemberType"])+"'";
     }
    if(Request.Form["ck_showname"]=="1")
     {
      sublanmu_str+=",showname='"+Sql_Format(tb_showname.Text.Trim())+"'";
     }
    if(Request.Form["ck_zdyurl"]=="1")
     {
      sublanmu_str+=",zdy_url='"+Sql_Format(tb_zdyurl.Text.Trim())+"'";
     }
    if(Request.Form["ck_headcontent"]=="1")
     {
      sublanmu_str+=",content='"+Sql_Format(tb_headcontent.Text.Trim())+"'";
     }
    if(Request.Form["ck_zdy_location"]=="1")
     {
      sublanmu_str+=",zdy_location='"+Sql_Format(Tb_ZdyLocation.Text.Trim())+"'";
     }

   if(Request.Form["ck_css"]=="1")
     {
      sql_str+=",zdy_csspath='"+Sql_Format(tb_csspath.Text.Trim())+"'";
     }
    if(Request.Form["ck_seotitle"]=="1")
     {
      sql_str+=",zdy_title='"+Sql_Format(tb_title.Text.Trim())+"'";
     }
    if(Request.Form["ck_seokeywords"]=="1")
     {
      sql_str+=",zdy_keywords='"+Sql_Format(tb_keywords.Text.Trim())+"'";
     }
     if(Request.Form["ck_seodescription"]=="1")
     {
       string Description=tb_description.Text;
       if(Description.Length>250)
        {
         Description=Description.Substring(0,250);
        }
       sql_str+=",zdy_description='"+Sql_Format(Description)+"'";
     }
    if(Request.Form["ck_zdyhead"]=="1")
     {
       sql_str+=",zdy_head='"+Sql_Format(Headzdy.Text.Trim())+"'";
     }
    if(Request.Form["ck_topzdy"]=="1")
     {
       sql_str+=",zdy_wztop='"+Sql_Format(Wztopzdy.Text.Trim())+"'";
     }
    if(Request.Form["ck_lanmuzdy"]=="1")
     {
       sql_str+=",zdy_lanmu='"+Sql_Format(Lanmuzdy.Text.Trim())+"'";
     }
    if(Request.Form["ck_banner"]=="1")
     {
       sql_str+=",zdy_banner='"+Sql_Format(Banner.Text.Trim())+"'";
     }
    if(Request.Form["ck_smallbanner"]=="1")
     {
       sql_str+=",zdy_smallbanner='"+Sql_Format(SmallBanner.Text.Trim())+"'";
     }
    if(Request.Form["ck_bottomzdy"]=="1")
     {
       sql_str+=",zdy_bottom='"+Sql_Format(Wzbottomzdy.Text.Trim())+"'";
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

     if(Request.Form["detail_html_set"]=="1")
      {
        sql="select sort_id,thetable from pa_sublanmu where is_sortsublanmu=1 and thetable<>'zdy' and thetable<>'' and id="+AIds[i];
        comm=new OleDbCommand(sql,conn);
        dr=comm.ExecuteReader();
        if(dr.Read())
        {
          Sort_Id=dr["sort_id"].ToString();
          TheTable=dr["thetable"].ToString();
          if(Sort_Id=="0")
           {
            sql="update "+TheTable+" set [html]="+Detail_html+" where site_id="+SiteId;
           }
          else
           {
            sql="update "+TheTable+" set [html]="+Detail_html+" where site_id="+SiteId+" and sort_id in ("+SortIds(int.Parse(Sort_Id))+")";
           }
         comm=new OleDbCommand(sql,conn);
         comm.ExecuteNonQuery();
        }
       dr.Close();
      }

     sql="update pa_sublanmu set xuhao=xuhao"+sublanmu_str+" where id="+AIds[i];
     comm=new OleDbCommand(sql,conn);
     comm.ExecuteNonQuery();
    }
 
   int LanmuId=int.Parse(Request.Form["lanmuid"]);
   for(int i=0;i<AIds.Length;i++)
    {
     if(AIds[i]==""){continue;}
     sql="select id from pa_partparameter where lanmu_id="+LanmuId+"and sublanmu_id="+AIds[i]+" and sublanmu_id=0";
     comm=new OleDbCommand(sql,conn);
     dr=comm.ExecuteReader();
     if(!dr.Read())
      {
       sql="insert into pa_partparameter(site_id,lanmu_id,sublanmu_id) values("+SiteId+","+LanmuId+","+AIds[i]+")";
       comm=new OleDbCommand(sql,conn);
       comm.ExecuteNonQuery();
      }
     dr.Close();
     sql="update pa_partparameter set ismember=0"+sql_str+" where lanmu_id="+LanmuId+" and sublanmu_id="+AIds[i];
     comm=new OleDbCommand(sql,conn);
     comm.ExecuteNonQuery();
    }

   conn.Close();
   PageAdmin.Log log=new PageAdmin.Log();
   log.Save(int.Parse(Request.Cookies["SiteId"].Value),1,"edit",1,UserName,"子栏目批量设置属性(所属栏目："+Request.QueryString["lanmuname"]+")");
   Response.Write("<scri"+"pt type='text/javascript'>parent.postover('提交成功!');</"+"script>"); 
   Response.End(); 
 }

private string SortIds(int SortId)
 {
     string Ids=SortId.ToString(); 
     string sql="select id from pa_sort where parent_ids like '%,"+SortId+",%'";
     OleDbCommand comm=new OleDbCommand(sql,conn);
     OleDbDataReader dr=comm.ExecuteReader();
     while(dr.Read())
      {
        Ids+=","+dr["id"].ToString();
      }
    dr.Close();
    return Ids;
 }
private void Get_Site(int sid)
 {
   string sql="select * from pa_site where id="+sid;
   OleDbCommand  comm=new OleDbCommand(sql,conn);
   OleDbDataReader dr=comm.ExecuteReader();
   if(dr.Read())
    {
     Is_Static=dr["html"].ToString();

    }
   else
    {
     Is_Static="0";
     dr.Close();
     conn.Close();
     Response.Write("<"+"script>alert('无效站点id');history.back()</"+"script>");
     Response.End();
    }
   dr.Close();
 }

private void MemberType_Bind()
 {
   string sql="select id,name from pa_member_type where site_id in(0,"+SiteId+") order by xuhao";
   OleDbCommand comm=new OleDbCommand(sql,conn);
   OleDbDataReader dr=comm.ExecuteReader();
   while(dr.Read())
    {
     MemberTypeList+="<option value='"+dr["id"].ToString()+"'>"+dr["name"].ToString()+"</option>";
    }
   dr.Close();
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
<table border=0 cellpadding=10 cellspacing=0 width=98% >
 <tr>
<td valign=top  align="left">
<iframe name="post_iframe" id="post_iframe" src="" frameborder=0 scroling=no height=1px width=1px marginwidth=0 marginheight=0 style="display:none"></iframe>
<form runat="server" target="post_iframe">
<div id="tabdiv">
<ul>
<li id="tab" name="tab"  onclick="showtab(0)" style="font-weight:bold">内容设置</li>
<li id="tab" name="tab"  onclick="showtab(1)">相关设置</li>
<li id="tab" name="tab"  onclick="showtab(2)">页面设置</li>
</ul>
</div>
<table border=0 cellpadding=0 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top>
<br>
<div name="tabcontent" id="tabcontent">
<table border=0 cellpadding=5 cellspacing=0 width=98% align=center>
 <tr>
    <td align="left" width="120px"><input type="checkbox" name="ck_show" value="1">显示属性</td>
    <td><input type="radio" name="show" value="1" checked>显示
        <input type="radio" name="show" value="0">隐藏
  </td>
 </tr>

 <tr>
  <td  height=30 width="100px"><input type="checkbox" name="showtype_set" value="1">信息筛选</td>
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
  <td  height=30><input type="checkbox" name="showsort_set" value="1">信息排序</td>
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
  <td height=30><input type="checkbox" name="target_set" value="1">目标窗口</td>
  <td><select name="D_Target" id="D_Target"><option value="_self">本窗口</option><option value="_blank">新窗口</asp:ListItem></option></td>
 </tr>

  <tr>
  <td  height=30><input type="checkbox" name="show_num_set" value="1">每页显示数</td>
  <td><asp:TextBox id="Show_Num" runat="server" Text="20" Maxlength="5" size=5/> 条记录</td>
 </tr>

  <tr>
  <td  height=30><input type="checkbox" name="title_num_set" value="1">标题显示数</td>
  <td><asp:TextBox id="Title_Num" runat="server" Value="100" Maxlength="3" size=5/> 个字符</td>
 </tr>

  <tr>
  <td  height=30><input type="checkbox" name="titlepic_set" value="1">标题图片</td>
  <td>宽：<asp:TextBox id="TitlePic_Width" runat="server"  Maxlength="5" size=5 text="100"/>px 高：<asp:TextBox id="TitlePic_Height" runat="server" Maxlength="5" size=5 text="100"/>px 注：其中一个设置0表示自动缩放</td>
 </tr>
</table>
</div>

<div name="tabcontent" id="tabcontent" style="display:none">
<table border=0 cellpadding=5 cellspacing=0 width=98% align=center>

<tr style="display:<%=Is_Static=="1"?"":"none"%>" width="110px">
  <td align="left"><input type="checkbox" name="list_html_set" value="1">子栏目页生成设置</td>
  <td align="left">
<asp:RadioButton id="List_Html_1" GroupName="listhtml" runat="server" checked/>动态页面
<asp:RadioButton id="List_Html_2" GroupName="listhtml" runat="server"/>伪静态
<asp:RadioButton id="List_Html_3" GroupName="listhtml" runat="server"/>静态(列表页只生成前<asp:TextBox id="List_Html_Num" size="5" runat="server" maxlength="10" Text="10" />页)

</td>
 </tr>

<tr style="display:<%=Is_Static=="1"?"":"none"%>">
  <td align="left"><input type="checkbox" name="detail_html_set" value="1">内容页生成设置</td>
 <td align="left">
<asp:RadioButton id="Detail_Html_1" GroupName="detailhtml" runat="server" checked/>动态页面
<asp:RadioButton id="Detail_Html_2" GroupName="detailhtml" runat="server"/>伪静态
<asp:RadioButton id="Detail_Html_3" GroupName="detailhtml" runat="server"/>静态页面
</td>
</tr>

<tr title="用于前台替换默认子栏目名称，支持html标签">
  <td><input type="checkbox" name="ck_showname" value="1">替换名称</td>
  <td><asp:TextBox id="tb_showname" runat="server" maxlength="200" style="width:400px" /></td>
</tr>

<tr>
  <td align="left" width=120px><input type="checkbox" name="ck_zdyurl" value="1">自定义Url</td>
  <td align="left"><asp:textBox TextMode="singleLine"  id="tb_zdyurl" runat="server" maxlength="150" style="width:500px"/>
</td>
</tr>

<tr>
  <td align="left" width=120px><input type="checkbox" name="ck_headcontent" value="1">页头&内容</td>
  <td><asp:TextBox  id="tb_headcontent"  TextMode="MultiLine"  runat="server" style="width:500px;height:70px"/>
  </td>
</td>
</tr>

<tr>
<td align=left><input type="checkbox" name="permissions_set" value="1">浏览权限</td>
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
<table border=0 cellpadding=5 cellspacing=0 width=98% align=center>
<tr>
 <td align="left" width=130px><input type="checkbox" name="ck_css" value="1">风格样式</td>
 <td><asp:textBox TextMode="singleLine" id="tb_csspath" runat="server" maxlength="150" style="width:250px" /></td>
</tr>


<tr>
<td><input type="checkbox" name="ck_seotitle" value="1">seo标题</td>
<td align="left"><asp:textBox TextMode="singleLine" id="tb_title" runat="server" maxlength="150" style="width:500px;" /></td>
</tr>

<tr>
<td><input type="checkbox" name="ck_seokeywords" value="1">seo关键字</td>
<td align="left" title="关键字之间用半角逗号分开"><asp:textBox TextMode="singleLine" id="tb_keywords" runat="server" maxlength="150" style="width:500px;" />
</td>
</tr>

<tr>
<td><input type="checkbox" name="ck_seodescription" value="1">seo描述</td>
<td align="left" title="控制在250字以内"><asp:TextBox TextMode="multiLine" id="tb_description"  runat="server" onkeyup="if(this.value.length>250)this.value=this.value.substring(0,250)" style="width:500px;height:70px"/>
</td>
</tr>

<tr>
  <td><input type="checkbox" name="ck_zdyhead" value="1">head头信息自定义</td>
  <td><asp:TextBox  id="Headzdy" TextMode="MultiLine" runat="server" style="width:500px;height:70px"/>
  </td>
</tr>

<tr>
  <td width=120px><input type="checkbox" name="ck_topzdy" value="1">顶部信息自定义</td>
  <td><asp:TextBox  id="Wztopzdy"  TextMode="MultiLine"  runat="server" style="width:500px;height:70px" />
  </td>
</tr>

<tr>
  <td><input type="checkbox" name="ck_lanmuzdy" value="1">栏目自定义</td>
  <td><asp:TextBox id="Lanmuzdy" TextMode="MultiLine"  runat="server" style="width:500px;height:70px"/>
  </td>
 </tr>

<tr>
  <td><input type="checkbox" name="ck_dropmenuzdy" value="1">下拉菜单自定义</td>
  <td><asp:TextBox  id="Dropmenuzdy" TextMode="MultiLine"  runat="server" style="width:500px;height:70px" />
  </td>
 </tr>

<tr>
  <td width=100px><input type="checkbox" name="ck_banner" value="1">横幅自定义</td>
  <td><asp:TextBox  id="Banner"  TextMode="MultiLine"  runat="server" style="width:500px;height:70px"/>
  </td>
 </tr>

<tr>
  <td><input type="checkbox" name="ck_smallbanner" value="1">小幅banner自定义</td>
  <td><asp:TextBox  id="SmallBanner"  TextMode="MultiLine"  runat="server" style="width:500px;height:70px"/>
  </td>
 </tr>

<tr>
  <td><input type="checkbox" name="ck_zdy_location" value="1">当前位置自定义</td>
  <td><asp:TextBox  id="Tb_ZdyLocation"  TextMode="MultiLine" runat="server" style="width:500px;height:70px"/>
  </td>
</tr>

<tr>
  <td><input type="checkbox" name="ck_bottomzdy" value="1">底部信息自定义</td>
  <td><asp:TextBox  id="Wzbottomzdy"  TextMode="MultiLine"  runat="server" style="width:500px;height:70px" />
  </td>
 </tr>
<tr>
</table>
</div>
<div align=center style="padding:10px">
<span id="post_area">
<input type="hidden" value="" name="ids" id="ids">
<input type="hidden" value="<%=Request.QueryString["lanmuid"]%>" name="lanmuid" id="lanmuid">
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
</center>
</body>
<script type="text/javascript">
document.forms[0].action="sublanmu_pset.aspx?lanmuname=<%=Server.UrlEncode(Request.QueryString["lanmuname"])%>";
document.getElementById("ids").value=parent.document.getElementById("ids").value;
<% if(TheTable=="zdy")
     {
%>
 document.getElementsByName("tab")[1].style.display="none";
<%}%>
var Sort_Id="<%=Sort_Id%>";
var Sort_obj=document.getElementById("Sort");
if(Sort_obj!=null && Sort_Id!="")
{
 document.getElementById("Sort").value=Sort_Id;
 var I=document.getElementById("Sort").selectedIndex;
 if(I==-1){document.getElementById("Sort").selectedIndex=0}
}

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
    var obj=document.getElementById("D_Model")
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
  <%}%>
 }
</script>
</html>  




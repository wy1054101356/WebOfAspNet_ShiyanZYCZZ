<% @ Page Language="C#"%>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<% @ Import NameSpace="System.IO"%>
<% @ Import NameSpace="PageAdmin"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<script language="c#" runat="server">
 OleDbConnection conn;
 string UserName,Is_Static,IsZt;
 int SiteId;
 protected void Page_Load(Object src,EventArgs e)
    {
     Master_Valicate YZ=new Master_Valicate();
     YZ.Master_Check();
     UserName=YZ._UserName;
     SiteId=int.Parse(Request.Cookies["SiteId"].Value);
     IsZt=Request.QueryString["zt"];
     Conn Myconn=new Conn();
     conn=Myconn.OleDbConn();//获取OleDbConnection
     if(!Page.IsPostBack)
     {
       conn.Open();
       Get_Site(SiteId);
       conn.Close();
     }
   }

protected void Data_Update(Object src,EventArgs e)
 {
    string sql_str="",sql_lanmu="";

    if(Request.Form["ck_show"]=="1")
     {
      sql_lanmu+=",show="+Sql_Format(Request.Form["lanmu_show"]);
     }

    if(Request.Form["ck_html"]=="1")
     {
      sql_lanmu+=",html="+Sql_Format(D_Html.SelectedItem.Value);
     }
    if(Request.Form["ck_showname"]=="1")
     {
      sql_lanmu+=",showname='"+Sql_Format(tb_showname.Text.Trim())+"'";
     }
    if(Request.Form["ck_zdyurl"]=="1")
     {
      sql_lanmu+=",zdy_url='"+Sql_Format(tb_url.Text.Trim())+"'";
     }
    if(Request.Form["ck_dropmenuzdy"]=="1")
     {
       sql_lanmu+=",zdy_dropmenu='"+Sql_Format(Dropmenuzdy.Text.Trim())+"'";
     }
    if(Request.Form["ck_zdy_location"]=="1")
     {
       sql_lanmu+=",zdy_location='"+Sql_Format(Tb_ZdyLocation.Text.Trim())+"'";
     }
    if(Request.Form["ck_location_style"]=="1")
     {
       sql_lanmu+=",location_style="+Sql_Format(Request.Form["location_style"]);
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
   string sql;
   conn.Open();
   OleDbCommand comm;
   OleDbDataReader dr;
   for(int i=0;i<AIds.Length;i++)
    {
     if(AIds[i]==""){continue;}
     sql="update pa_lanmu set xuhao=xuhao"+sql_lanmu+" where id="+AIds[i];
     comm=new OleDbCommand(sql,conn);
     comm.ExecuteNonQuery();
    }
   for(int i=0;i<AIds.Length;i++)
    {
     if(AIds[i]==""){continue;}
     sql="select id from pa_partparameter where lanmu_id="+AIds[i]+" and sublanmu_id=0";
     comm=new OleDbCommand(sql,conn);
     dr=comm.ExecuteReader();
     if(!dr.Read())
      {
       sql="insert into pa_partparameter(site_id,lanmu_id) values("+SiteId+", "+AIds[i]+")";
       comm=new OleDbCommand(sql,conn);
       comm.ExecuteNonQuery();
      }
     dr.Close();
     sql="update pa_partparameter set ismember=0"+sql_str+" where lanmu_id="+AIds[i]+" and sublanmu_id=0";
     comm=new OleDbCommand(sql,conn);
     comm.ExecuteNonQuery();
    }
   conn.Close();
   PageAdmin.Log log=new PageAdmin.Log();
   log.Save(int.Parse(Request.Cookies["SiteId"].Value),1,"edit",1,UserName,"栏目批量属性设置");
   Response.Write("<scri"+"pt type='text/javascript'>parent.postover('提交成功!');</"+"script>"); 
   Response.End(); 
 }

private void Get_Site(int sid)
 {
   string sql="select html from pa_site where id="+sid;
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
     Response.Write("<"+"script>alert('无效站点id');history.back()<"+"/script>");
     Response.End();
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
<table border=0 cellpadding=10 cellspacing=0 width=98%>
 <tr>
<td valign=top  align="left">
<iframe name="post_iframe" id="post_iframe" src="" frameborder=0 scroling=no height=1px width=1px marginwidth=0 marginheight=0 style="display:none"></iframe>
<form runat="server" target="post_iframe">
<div id="tabdiv">
<ul>
<li id="tab" name="tab"  onclick="showtab(0)" style="font-weight:bold">常用设置</li>
<li id="tab" name="tab"  onclick="showtab(1)">其他设置</li>
</ul>
</div>
<table border=0 cellpadding=2 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top>
<br>
<div name="tabcontent" id="tabcontent">
<table border=0 cellpadding=2 cellspacing=0 width=100% align=center>
<tr>
    <td width="130px"><input type="checkbox" name="ck_show" value="1">显示属性</td>
    <td><input type="radio" name="lanmu_show" value="1" checked>显示
        <input type="radio" name="lanmu_show" value="0">隐藏
  </td>
 </tr>

<tr style="display:<%=Is_Static=="0"?"none":""%>">
  <td width=100px><input type="checkbox" name="ck_html" value="1">封面页静态<br></td>
  <td>
    <asp:DropDownList id="D_Html" runat="server">
    <asp:ListItem value="1">静态文件</asp:ListItem>
    <asp:ListItem value="0">动态文件</asp:ListItem>
    </asp:DropDownList>
  </td>
 </tr>


<tr style="display:<%=IsZt=="1"?"none":""%>">
  <td><input type="checkbox" name="ck_showname" value="1">替换名称</td>
  <td><asp:textBox TextMode="singleLine" id="tb_showname" runat="server" maxlength="200" style="width:500px;"/>
  </td>
</tr>

<tr>
  <td><input type="checkbox" name="ck_css" value="1">自定义样式</td>
  <td><asp:textBox TextMode="singleLine" id="tb_csspath" runat="server" maxlength="150" style="width:500px;"/></td>
</tr>

<tr>
  <td><input type="checkbox" name="ck_zdyurl" value="1">自定义链接</td>
  <td align="left"><asp:textBox TextMode="singleLine" id="tb_url" runat="server" maxlength="150"  style="width:500px;"/>
</td>
</tr>

<tr>
  <td><input type="checkbox" name="ck_seotitle" value="1">seo标题</td>
  <td align="left"><asp:textBox TextMode="singleLine" id="tb_title" runat="server" maxlength="150" style="width:500px;" />
</td>
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
  <td><asp:TextBox  id="Headzdy" TextMode="MultiLine" runat="server" style="width:500px;height:70px" />
  </td>
</tr>
<tr>
  <td><input type="checkbox" name="ck_location_style" value="1">当前位置样式</td>
  <td><input type="radio" name="location_style" value="0" checked>显示栏目名称（首页 &gt; 栏目名 &gt; 子栏目名）
    <input type="radio"  name="location_style" value="1">不显示栏目名称（首页 &gt; 子栏目名）
  </td>
</tr>
<tr>
  <td><input type="checkbox" name="ck_zdy_location" value="1">当前位置自定义</td>
  <td><asp:TextBox  id="Tb_ZdyLocation"  TextMode="MultiLine" runat="server" style="width:500px;height:70px"/>
  </td>
</tr>
</table>
</div>
<div name="tabcontent" id="tabcontent" style="display:none">
<table border=0 cellpadding=2 cellspacing=0 width=98% align=center>
<tr>
  <td width=120px><input type="checkbox" name="ck_topzdy" value="1">顶部信息自定义</td>
  <td><asp:TextBox  id="Wztopzdy"  TextMode="MultiLine"  runat="server" style="width:500px;height:70px"/>
  </td>
 </tr>
<tr>

<tr>
  <td><input type="checkbox" name="ck_lanmuzdy" value="1">栏目自定义</td>
  <td><asp:TextBox id="Lanmuzdy" TextMode="MultiLine"  runat="server" style="width:500px;height:70px" />
  </td>
 </tr>


<tr>
  <td><input type="checkbox" name="ck_dropmenuzdy" value="1">下拉菜单自定义</td>
  <td><asp:TextBox  id="Dropmenuzdy" TextMode="MultiLine"  runat="server" style="width:500px;height:70px"/>
  </td>
 </tr>


<tr>
  <td width=100px><input type="checkbox" name="ck_banner" value="1">横幅自定义</td>
  <td><asp:TextBox  id="Banner"  TextMode="MultiLine"  runat="server" style="width:500px;height:70px" />
  </td>
 </tr>

<tr>
  <td><input type="checkbox" name="ck_smallbanner" value="1">小幅banner自定义</td>
  <td><asp:TextBox  id="SmallBanner"  TextMode="MultiLine"  runat="server" style="width:500px;height:70px"/>
  </td>
 </tr>

<tr>
  <td><input type="checkbox" name="ck_bottomzdy" value="1">底部信息自定义</td>
  <td><asp:TextBox  id="Wzbottomzdy"  TextMode="MultiLine"  runat="server" style="width:500px;height:70px"/>
  </td>
 </tr>
<tr>
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
if(GetCookie("tab")!="")
 {
  showtab(GetCookie("tab"));
 }  
</script>
</html>
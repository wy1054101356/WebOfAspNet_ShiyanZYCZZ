<% @ Page Language="C#"%>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<% @ Import NameSpace="System.IO"%>
<% @ Import NameSpace="System.Text"%>
<% @ Import NameSpace="System.Text.RegularExpressions"%>
<% @ Import NameSpace="PageAdmin"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<script language="c#" runat="server">
 OleDbConnection conn;
 string CurrentSiteId,CurrentLanmuId,UserName,SiteList,LanmuList,ZtList,SubLanmuList,Admin_Sites,Admin_Lanmuids,Sql_Admin_Lanmuids,List_Space,currentstyle,sql;
 int UID,List_Level;
 protected void Page_Load(Object src,EventArgs e)
    {
     Master_Valicate YZ=new Master_Valicate();
     YZ.Master_Check();
     UserName=YZ._UserName;
     UID=YZ._UID;
     if(!IsNum(Request.QueryString["c_lanmuid"]) || Request.QueryString["c_sublanmuid"]==null)
     {
      Response.Write("参数错误");
      Response.End();
     }

     if(IsNum(Request.QueryString["siteid"]))
     {
      CurrentSiteId=Request.QueryString["siteid"];
     }
    else
     {
     CurrentSiteId=Request.Cookies["SiteId"].Value;
     }
    if(IsNum(Request.QueryString["lanmuid"]))
     {
       CurrentLanmuId=Request.QueryString["lanmuid"];
     }
    else
     {
      CurrentLanmuId="0";
     }

     Conn Myconn=new Conn();
     conn=Myconn.OleDbConn();//获取OleDbConnection
     if(!Page.IsPostBack)
     {
       conn.Open();
       if(UserName!="admin")
        {
         Get_AdminSites();
        }
       Site_List();
       Lanmu_List();
       Zt_List();
       SubLanmu_List(0);
       conn.Close();
     }
    else
     {
       Data_Copy();
     }
   }

private void Get_AdminSites()
 {
   sql="select admin_sites from pa_member where username='"+UserName+"'";
   OleDbCommand comm=new OleDbCommand(sql,conn);
   OleDbDataReader dr=comm.ExecuteReader();
   if(dr.Read())
    {
      Admin_Sites=dr["admin_sites"].ToString();
    }
   else
    {
     Admin_Sites="0";
    }
   dr.Close();
  sql="select admin_lanmuids,basic_permissions from pa_adminpermission where site_id="+CurrentSiteId+" and uid="+UID;
  comm=new OleDbCommand(sql,conn);
  dr=comm.ExecuteReader();
  if(dr.Read())
   {
     Admin_Lanmuids=dr["admin_lanmuids"].ToString();
   }
  else
   {
     Admin_Lanmuids="-1";
   }
  if(Admin_Lanmuids!="0")
   {
     Sql_Admin_Lanmuids=" and id in("+Admin_Lanmuids+") ";
   }
 }

private void Site_List()
  {
  
  if(UserName=="admin")
    {
      sql="select sitename,id from pa_site order by xuhao";
    }
  else
    {
      sql="select sitename,id from pa_site where id in ("+Admin_Sites+") order by xuhao";
    }
    OleDbCommand comm=new OleDbCommand(sql,conn);
    OleDbDataReader dr=comm.ExecuteReader();
    while(dr.Read())
     {
      if(dr["id"].ToString()==CurrentSiteId)
       {
        SiteList+="<option value=\""+dr["id"].ToString()+"\" selected>"+dr["sitename"].ToString()+"</option>";
       }
      else
       {
        SiteList+="<option value=\""+dr["id"].ToString()+"\">"+dr["sitename"].ToString()+"</option>";
       }
     }
    dr.Close();
  }

 private void Lanmu_List()
  {
    sql="select id,name from pa_lanmu where iszt=0 and site_id="+CurrentSiteId+Sql_Admin_Lanmuids+" order by xuhao";
    OleDbCommand comm=new OleDbCommand(sql,conn);
    OleDbDataReader dr=comm.ExecuteReader();
    while(dr.Read())
     {
      if(dr["id"].ToString()==Request.QueryString["c_lanmuid"])
       {
         currentstyle=" class='rootnode' ";
       } 
       else
       {
         currentstyle="";
       }
      if(dr["id"].ToString()==CurrentLanmuId)
       {
        LanmuList+="<option value=\""+dr["id"].ToString()+"\" selected"+currentstyle+">"+dr["name"].ToString()+"</option>";
       }
      else
       {
        LanmuList+="<option value=\""+dr["id"].ToString()+"\""+currentstyle+">"+dr["name"].ToString()+"</option>";
       }
     }
    dr.Close();
  }

 private void Zt_List()
  {
    sql="select id,name from pa_lanmu where iszt=1 and id="+CurrentLanmuId;
    OleDbCommand comm=new OleDbCommand(sql,conn);
    OleDbDataReader dr=comm.ExecuteReader();
    if(dr.Read())
     {
      if(dr["id"].ToString()==Request.QueryString["c_lanmuid"])
       {
         currentstyle=" class='rootnode' ";
       } 
       else
       {
         currentstyle="";
       }
      if(dr["id"].ToString()==CurrentLanmuId)
       {
        ZtList+="<option value=\""+dr["id"].ToString()+"\" selected"+currentstyle+">"+dr["name"].ToString()+"</option>";
       }
      else
       {
        ZtList+="<option value=\""+dr["id"].ToString()+"\""+currentstyle+">"+dr["name"].ToString()+"</option>";
       }
     }
    dr.Close();
  }

private void SubLanmu_List(int Parentid)
 {
   sql="select id,[name],[level],isfinal from pa_sublanmu where parent_id="+Parentid+" and site_id="+CurrentSiteId+" and lanmu_id="+CurrentLanmuId+" order by nav_id,xuhao";
   OleDbCommand comm=new OleDbCommand(sql,conn);
   OleDbDataReader dr=comm.ExecuteReader();
   while(dr.Read())
    {
      List_Space="";
      List_Level=int.Parse(dr["level"].ToString());
      for(int i=0;i<List_Level-1;i++)
       {
        List_Space+="&nbsp;&nbsp;&nbsp;";
       }
      if(List_Level>1)
       {
       List_Space+="|-";
       }
      if(dr["isfinal"].ToString()=="0") 
       {
        SubLanmuList+="<option value='"+dr["id"].ToString()+"'>"+List_Space+dr["name"].ToString()+"</option>\r\n";
        SubLanmu_List(int.Parse(dr["id"].ToString()));
       }
      else
       {
        SubLanmuList+="<option value='0' disabled>"+List_Space+dr["name"].ToString()+"</option>\r\n";
       }
    }
   dr.Close();
 }


private void Data_Copy()
 {
    string ids=Request.Form["ids"];
    string[] Aids=ids.Split(',');
    string LanmuId=Request.Form["lanmuid"];
    string SubLanmuId=Request.Form["sublanmuid"];
    int ZtId=0;
    if(Request.Form["ltype"]=="1")
     {
      LanmuId=Request.Form["zt_list"];
      ZtId=int.Parse(LanmuId);
     }
    if(!IsNum(LanmuId) || LanmuId=="0" || ids=="")
     {
      Response.Write("<scri"+"pt type='text/javascript'>parent.postover('参数错误!');</"+"script>"); 
      Response.End(); 
     }
    if(!IsNum(SubLanmuId))
     {
      SubLanmuId="0";
     }
    conn.Open();
    OleDbCommand comm;
    string Fields="name,thetable,sort_id,model_id,show_type,notshow_type,zdy_sort,zdy_condition,title_num,titlepic_width,titlepic_height,show_num,starthtml,endhtml,iswrap,tourl,clean_container,zdy_style,zdy_header,layout,width,height,target,show,zdy_tag_open,zdy_tag,content,xuhao";
    for(int i=0;i<Aids.Length;i++)
     {
       sql="insert into pa_module(lanmu_id,sublanmu_id,zt_id,"+Fields+")  select  "+LanmuId+","+SubLanmuId+","+ZtId+","+Fields+" from pa_module where id="+int.Parse(Aids[i]);
       comm=new OleDbCommand(sql,conn);
       comm.ExecuteNonQuery();
     }

    //更新标签文件
   sql="select id,zdy_tag from pa_module where zdy_tag_open=1 and lanmu_id="+LanmuId+" and sublanmu_id="+SubLanmuId+" and zt_id="+ZtId;
   comm=new  OleDbCommand(sql,conn);
   OleDbDataReader dr=comm.ExecuteReader();
   while(dr.Read())
    {
      Create_File(dr["zdy_tag"].ToString(),dr["id"].ToString());
    }
   dr.Close();

   conn.Close();
   PageAdmin.Log log=new PageAdmin.Log();
   log.Save(int.Parse(Request.Cookies["SiteId"].Value),1,"add",1,UserName,"模块复制");
   Response.Write("<scri"+"pt type='text/javascript'>parent.postover('复制成功!');</"+"script>"); 
   Response.End(); 
 }



//更新标签
private void Create_File(string Tag_Content,string ModuleId)
 {
   string File_Path=Server.MapPath("/e/zdytag/template.ascx");
   Encoding encoding=Encoding.GetEncoding("UTF-8"); 
   FileStream fs=new FileStream(File_Path,FileMode.Open,FileAccess.Read);
   StreamReader Re=new StreamReader(fs,encoding);
   string F_Content=Re.ReadToEnd();
   Re.Close();

   string t_rules=@"{pa:model}(?<siteid>\d+),(?<modelid>\d+),(?<sortid>\d+),(?<sqlcondition>[^{}]*),(?<ztid>\d+),(?<sqlsort>[^{},]*),(?<target>[^{},]*),(?<shownum>\d+),(?<titlenum>\d+),(?<picwidth>\d+),(?<picheight>\d+){/pa:model}";
   Tag_Content=Get_Template(Tag_Content,t_rules,ModuleId);
   F_Content=F_Content.Replace("{pa:ReplaceContent}",Tag_Content);
   File_Path=Server.MapPath("/e/zdytag/module/"+ModuleId+".ascx");

   fs=new FileStream(File_Path,FileMode.Create,FileAccess.Write);
   StreamWriter rw=new StreamWriter(fs,encoding);
   rw.Write(F_Content);
   rw.Flush();
   rw.Close();
   fs.Close();
 }

private string Get_Template(string content,string rules,string ModuleId)
 {
  Regex Reg=new Regex(rules,RegexOptions.IgnoreCase);
  MatchCollection Ms=Regex.Matches(content,rules,RegexOptions.IgnoreCase); 
  int i=0;
  foreach (Match M in Ms)
   {
    content=new Regex(M.Value).Replace(content,Get_Content(ModuleId,(i++).ToString(),M.Groups["siteid"].Value,M.Groups["modelid"].Value,M.Groups["sortid"].Value,M.Groups["sqlcondition"].Value,M.Groups["ztid"].Value,M.Groups["sqlsort"].Value,M.Groups["target"].Value,M.Groups["shownum"].Value,M.Groups["titlenum"].Value,M.Groups["picwidth"].Value,M.Groups["picheight"].Value),1);
   }
  return content;
 }

private string Get_Content(string ModuleId,string TagNameId,string Site_Id,string Model_Id,string SortId,string SqlCondition,string ZtId,string SqlOrder,string Target,string ShowNum,string TitleNum,string PicWidth,string PicHeight)
 {
   OleDbDataReader dr;
   OleDbCommand comm;
   string Rv="",sql;
   if(IsNum(Model_Id))
    {
     sql="select thetable from pa_model where id="+int.Parse(Model_Id);
     comm=new OleDbCommand(sql,conn);
     dr=comm.ExecuteReader();
     if(dr.Read())
      { 
        Rv="<% @ Register TagPrefix=\"ascx\" TagName=\"M_"+TagNameId+"\" src=\"/e/zdymodel/"+dr["thetable"].ToString()+"/module/"+Model_Id+".ascx\"%>"; 
        if(!IsNum(SortId))
         {
           SortId="0";
         }
        Rv+="<ascx:M_"+TagNameId+" runat=\"server\" TagSiteId="+Site_Id.ToString()+" SiteId="+CurrentSiteId+" ZdyTag=1 ModuleId=\""+ModuleId.ToString()+"_"+TagNameId+"\" TagTable=\""+dr["thetable"].ToString()+"\" TagSortId="+SortId+" SqlOrder=\"order by "+SqlOrder+"\" SqlCondition=\""+ZH_Tag(SqlCondition)+"\" ShowNum="+ShowNum+" TagZtId="+ZtId.ToString()+" TitleNum="+TitleNum+" TitlePicWidth="+PicWidth+" TitlePicHeight="+PicHeight+" TheTarget=\""+Target+"\"/>";
      }
     dr.Close();
   }
   return Rv;
 }

private string ZH_Tag(string content)
 {
   content=content.Replace("/fxg/","\\");
   content=content.Replace("/xh/","*");
   content=content.Replace("/jh/","+");
   content=content.Replace("/wh/","?");
   content=content.Replace("/my/","$");
   content=content.Replace("/lykh/","(");
   content=content.Replace("/rykh/",")");
   content=content.Replace("/lfkh/","[");
   content=content.Replace("/rfkh/","]");
   content=content.Replace("/ldkh/","{");
   content=content.Replace("/rdkh/","}");
   return content;
 }
//更新标签

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
<td valign=top align="left">
<iframe name="post_iframe" id="post_iframe"  src="" frameborder=0 scroling=no height=1px width=1px marginwidth=0 marginheight=0 style="display:none"></iframe>
<form  target="post_iframe" runat="server">
<table border=0 cellpadding=0 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top style="padding:10px 0 0 0">

<table border=0 cellpadding=5 cellspacing=0 width=100% align=center>
 <tr>
  <td  height=25 width="100px">选择站点</td>
  <td><select name="sites" id="sites" onchange="c_site(this.value)">
      <%=SiteList%>
      </select>
</td>
 </tr>

 <tr>
  <td height=25>目标栏目类型</td>
  <td>
     <input type="radio" name="ltype" id="ltype_1" value=0 onclick="ctype(0)">网站栏目
     <input type="radio" name="ltype" id="ltype_2" value=1 onclick="ctype(1)">专题栏目
</td>
 </tr>

 <tr id="tr_lanmu" style="display:none">
  <td height=25>目标栏目</td>
  <td>
     <select name="lanmuid" id="lanmuid" onchange="c_lanmu(this.value)">
      <option value="0">请选择要复制的目标栏目</option>
      <%=LanmuList%>
      </select>
</td>
 </tr>

 <tr id="tr_zt" style="display:none">
  <td height=25>目标专题</td>
  <td><select id="zt_list" name="zt_list" onchange="c_lanmu(this.value)">
    <option value="0">请选择要复制的目标专题</option>
    <%=ZtList%>
   </select>
   <input type="button" value="选择专题" class="bt" onclick="open_ztlist(0)">
</td>
 </tr>

 <tr id="tr_sublanmu">
  <td height=25>目标子栏目</td>
  <td><select name="sublanmuid" id="sublanmuid" onchange="change_showtype()">
      <option value="0">请选择要复制的目标子栏目</option>
      <%=SubLanmuList%>
      </select> 注：如不选择，则默认仅复制到上级栏目
</td>

</tr>

</table>

<div align=center style="padding:10px">
<span id="post_area">
<input type="hidden" value="" name="ids" id="ids">
<input type="submit" value="提交" class="button" onclick="return c_k()"/>
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
<script type="text/javascript">
document.getElementById("ids").value=parent.document.getElementById("ids").value;
var c_lanmuid="<%=Request.QueryString["c_lanmuid"]%>";
var c_sublanmuid="<%=Request.QueryString["c_sublanmuid"]%>";
var c_ltype="<%=Request.QueryString["ltype"]%>";
var tr_lanmu=document.getElementById("tr_lanmu");
var tr_zt=document.getElementById("tr_zt");
var tr_sublanmu=document.getElementById("tr_sublanmu");
var lanmuid=document.getElementById("lanmuid");
var zt_list=document.getElementById("zt_list");
var sublanmuid=document.getElementById("sublanmuid");

if(c_ltype=="1")
 {
  document.getElementById("ltype_2").checked=true;
  tr_lanmu.style.display="none";
  tr_zt.style.display="";
 }
else
 {
  document.getElementById("ltype_1").checked=true;
  tr_lanmu.style.display="";
  tr_zt.style.display="none";
 }

if(c_sublanmuid=="")
 {
   c_sublanmuid="0";
 }
function c_site(siteid)
 {
  var LType=0;
  if(document.getElementById("ltype_2").checked)
   {
    LType=1;
   }
   location.href="?ltype="+LType+"&c_lanmuid=<%=Request.QueryString["c_lanmuid"]%>&c_sublanmuid=<%=Request.QueryString["c_sublanmuid"]%>&siteid="+siteid;
 }
function c_lanmu(lanmuid)
 {
  var LType=0;
  if(document.getElementById("ltype_2").checked)
   {
    LType=1;
   }
   location.href="?ltype="+LType+"&c_lanmuid=<%=Request.QueryString["c_lanmuid"]%>&c_sublanmuid=<%=Request.QueryString["c_sublanmuid"]%>&siteid=<%=CurrentSiteId%>&lanmuid="+lanmuid;
 }


function ctype(c_ltype)
{
if(c_ltype=="0")
 {
  tr_lanmu.style.display="";
  tr_zt.style.display="none";
  lanmuid.value="0";
  zt_list.value="0";
  sublanmuid.options.length=1;
 }
else
 {
  tr_lanmu.style.display="none";
  tr_zt.style.display="";
  lanmuid.value="0";
  zt_list.value="0";
  sublanmuid.options.length=1;
 }
}

function c_k()
 {
   if(document.getElementById("ltype_1").checked)
   {
   if(lanmuid.value=="0")
    {
      alert("请选择要复制的目标栏目!");
      lanmuid.focus();
      return false;
    }
   if(lanmuid.value==c_lanmuid && sublanmuid.value==c_sublanmuid)
    {
      if(!confirm("你选择的目标栏目(子栏目)和要复制的模块所在的栏目(子栏目)完全一样，是否继续复制？"))
       {
         return false;
       }
    }

   }
  else
   {
    if(zt_list.value=="0")
    {
      alert("请选择要复制的专题栏目!");
      zt_list.focus();
      return false;
    }
   if(zt_list.value==c_lanmuid && sublanmuid.value==c_sublanmuid)
    {
      if(!confirm("你选择的目标专题栏目(子栏目)和要复制的模块所在的专题栏目(子栏目)完全一样，是否继续复制？"))
       {
         return false;
       }
    }

   }

   if(document.getElementById("ids").value=="")
    {
      alert("没有要操作的源模块!");
      return false;
    }

  startpost();
  return true;
 }

function AddSelect(txt,value,id)
 {
   var obj=document.getElementById(id);
   obj.options.add(new Option(txt,value));
 }
</script>
</body>
</html>  


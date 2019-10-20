<% @ Page language="c#"%>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<% @ Import NameSpace="System.IO"%>
<% @ Import NameSpace="System.Xml"%>
<% @ Import NameSpace="PageAdmin"%>
<script Language="C#" Runat="server">
   string UserName,Table,Field,FieldType,Post,TheTitle,Url,T_Url,FileSize,Content,perms_membertype,Point,Xuhao,IsMaster,Thumbnail_MinWidth,Thumbnail_MinHeight,MaxNum,Allow_Upload,The_Ext,The_Maxlength;
   string M_Type,DepartmentId,DepartMentList,MemberTypeList,sql;
   int SiteId,InforId;
   OleDbConnection conn;
   protected void Page_Load(Object sender,EventArgs e)
    {
     if(Request.QueryString["from"]=="master")
      {
        Master_Valicate Master=new Master_Valicate();
        Master.Master_Check();
        UserName=Master._UserName;
        IsMaster="1";
        M_Type="0";
      }
     else
      {
        Member_Valicate Member=new Member_Valicate();
        Member.Member_Check();
        M_Type=(Member._MemberTypeId).ToString();
        DepartmentId=(Member._DepartmentId).ToString();
        UserName=Member._UserName;
        IsMaster="0";
      }
       FieldType=Request.QueryString["type"];
       Table=Request.QueryString["table"];
       Field=Request.QueryString["field"];
       if(!IsStr(Table) || !IsStr(Field) || !IsStr(FieldType) || !IsNum(Request.QueryString["inforid"]) || !IsNum(Request.QueryString["sid"]))
       {
         Response.Write("<"+"script type='text/javascript'>alert('invalid table or field or fieldtype or InforId or SiteId!')</"+"script>");
         Response.End();
       }

      SiteId=int.Parse(Request.QueryString["sid"]);
      InforId=int.Parse(Request.QueryString["inforid"]);
      Conn Myconn=new Conn();
      conn=Myconn.OleDbConn();//获取OleDbConnection
      conn.Open();
       
        Read_Xml();
        if(IsMaster=="0")
         {
          Get_Perrmission(int.Parse(DepartmentId),int.Parse(M_Type));//非管理员判断
         }
        else
         {
          Allow_Upload="1";
         }
        Get_Field();
        MemberType_List();
        Department_List(0);
        if(IsNum(Request.QueryString["id"]) && Request.QueryString["id"]!="0")
        {
          Get_Data(int.Parse(Request.QueryString["id"]));
          Post="edit";
          MaxNum="1";
        }
       else
        {
          Post="add";
          Url="";
        }

    conn.Close();
    }

 private void Get_Data(int Id)
   {
     sql="select * from pa_file where thetable='"+Table+"' and [field]='"+Field+"' and id="+Id;
     OleDbCommand comm=new OleDbCommand(sql,conn);
     OleDbDataReader dr=comm.ExecuteReader();
     if(dr.Read())
      {
       TheTitle=HTMLEncode(dr["title"].ToString());
       Url=HTMLEncode(dr["url"].ToString());
       T_Url=HTMLEncode(dr["thumbnail"].ToString());
       FileSize=dr["filesize"].ToString();
       perms_membertype=dr["permissions"].ToString();
       Point=dr["point"].ToString();
       Content=HTMLEncode(dr["introduction"].ToString());
       Xuhao=dr["xuhao"].ToString();
      }
     else
      {
        Response.Write("文件不存在");
        Response.End();
      }
     dr.Close();
   }

 private void Get_Field()
   {
     sql="select max_num,file_ext,maxfilesize from pa_field where thetable='"+Table+"' and [field]='"+Field+"'";
     OleDbCommand comm=new OleDbCommand(sql,conn);
     OleDbDataReader dr=comm.ExecuteReader();
     if(dr.Read())
      {
         MaxNum=dr["max_num"].ToString();
         The_Ext=dr["file_ext"].ToString().ToLower().Replace(".","*.");
         if(IsNum(dr["maxfilesize"].ToString()))
          {
           The_Maxlength=(float.Parse(dr["maxfilesize"].ToString())/1024).ToString("f2");
          }
      }
     else
      {
        MaxNum="1";
      }
     dr.Close();
   }

private void Get_Perrmission(int DId,int MtypeId)
 {
    Allow_Upload="0";
    string sql;
    OleDbCommand comm;
    OleDbDataReader dr;
    if(Table=="pa_member") //如果是会员表，判断是否开启上传权限
      {
       string Mcenter_Permissions="";
       if(DId>0)
        {
         sql="select m_set from pa_department where id="+DId;
        }
       else
        {
         sql="select m_set from pa_member_type where id="+MtypeId;
        }
       comm=new OleDbCommand(sql,conn);
       dr=comm.ExecuteReader();
       if(dr.Read())
       {
        Mcenter_Permissions=dr["m_set"].ToString();
       }
      dr.Close();
      if(Mcenter_Permissions.IndexOf(",upload_memberform,")>=0)
       {
        Allow_Upload="1";
       }
       return;
     }

    if(DId>0)
     {
      sql="select up_field_images,up_field_files from pa_member_tgset where site_id="+SiteId+" and thetable='"+Table+"' and department_id="+DId;
     }
    else
     {
      sql="select up_field_images,up_field_files from pa_member_tgset where site_id="+SiteId+" and thetable='"+Table+"' and mtype_id="+MtypeId;
     }
    comm=new OleDbCommand(sql,conn);
    dr= comm.ExecuteReader();
    if(dr.Read())
      {
       if(FieldType=="files")
        {
         if(dr["up_field_files"].ToString()=="1")
         {
          Allow_Upload="1";
         }
        }
       else if(FieldType=="images")
        {
         if(dr["up_field_images"].ToString()=="1")
         {
         Allow_Upload="1";
         }
        }
      } 
    dr.Close();
 }

private void MemberType_List()
 {
   string sql="select id,name from pa_member_type order by xuhao";
   OleDbCommand comm=new OleDbCommand(sql,conn);
   OleDbDataReader dr=comm.ExecuteReader();
   while(dr.Read())
    {
      MemberTypeList+="<option value='"+dr["id"].ToString()+"'>"+dr["name"].ToString()+"</option>";
    }
   dr.Close();
 }
private void Department_List(int Parentid)
 {
   string List_Space="";
   int List_Level=1;
   string sql="select id,parent_id,name,xuhao,list_level from pa_department where parent_id="+Parentid+" order by xuhao";
   OleDbCommand comm=new OleDbCommand(sql,conn);
   OleDbDataReader dr=comm.ExecuteReader();
   while(dr.Read())
    {
      List_Space="";
      List_Level=int.Parse(dr["list_level"].ToString());
      for(int i=1;i<List_Level;i++)
      {
       List_Space+="&nbsp;&nbsp;&nbsp;";
      }
      if(List_Level>1)
       {
       List_Space+="|-";
       }
      DepartMentList+="<option value='"+dr["id"].ToString()+"'>"+List_Space+dr["name"].ToString()+"</option>\r\n";
      Department_List(int.Parse(dr["id"].ToString()));
    }
   dr.Close();
 }  
private void Read_Xml()
 {
    string XmLFile="/e/incs/site_"+Request.QueryString["sid"]+".xml";
    Thumbnail_MinWidth="400";
    Thumbnail_MinHeight="400";
    if(File.Exists(Server.MapPath(XmLFile)))
     {
      XmlDocument   XMLFile=new XmlDocument(); 
      XMLFile.Load(Server.MapPath(XmLFile));
      XmlElement xe;
      XmlNodeList  xnlist;
      xnlist=XMLFile.SelectSingleNode("PageAdminConfig/Thumbnail").ChildNodes;
      foreach (XmlNode xn in xnlist) 
        { 
          xe=(XmlElement)(xn); 
          switch(xe.Name)
           {
              case "MinWidth":
                  Thumbnail_MinWidth=xe.InnerText;
              break;

             case "MinHeight":
                  Thumbnail_MinHeight=xe.InnerText;
              break;
           }
       } 
     }
 }

private void Check_Post()
 {
    string PostUrl=Request.ServerVariables["HTTP_REFERER"];
    string LocalUrl=Request.ServerVariables["SERVER_NAME"];
    if(PostUrl!=null)
      {
         if(PostUrl.Replace("http://","").Split('/')[0].Split(':')[0]!=LocalUrl)
          {
           Response.Write("<"+"script type='text/javascript'>alert('invalid submit!')</"+"script>");
           Response.End();
          }
      }
 }

private string HTMLEncode(string str)
 {
  if(string.IsNullOrEmpty(str)){return "";}
  str=str.Replace("&","&amp;");
  str=str.Replace("\"","&quot;");
  return str;
 }
private bool IsStr(string str)
 {
  if(string.IsNullOrEmpty(str)){return false;}
  string str1="abcdefghijklmnopqrstuvwxyz0123456789_";
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

private bool IsNum(string str)
 {
  if(string.IsNullOrEmpty(str)){return false;}
  int rv=0;
  if(Int32.TryParse(str,out rv))
   {
    return true;  
   }
  else
   {
    return false;
   }
 }
</script><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>PageAdmin Cms文件组发布界面</title>
<style type="text/css">
body{word-wrap:break-word;font:12px/1.6em Tahoma,Helvetica,Arial,\5b8b\4f53;color:#333333;background-color:#ffffff;padding:0px;margin:10px auto 0px auto;width:95%;}
button,input,select,textarea{font-size:12px}
form,ul,li{list-style-type:none;margin:0 0 0 0;padding:0 0 0 0;}
#list{border:0px solid menu;background-color:#cccccc}
#list td{background-color:menu;}
a:link{color:#333333;text-decoration:none}
a:visited{color:#333333;text-decoration:none}
a:hover{color:#333333;text-decoration:underline}
.main{border:1px solid #999999;text-align:cetner;padding:10px 0 5px 0;background-color:#D1EAFE;margin-top:-1px}
.main table td{padding:3px 3px 4px 3px;}
.button{
	width:55px;
	font-size:9pt;
	height:19px;
	cursor: hand;
	background-image: url(/e/images/public/button.gif);
	background-position: center center;
	border-top: 0px outset #eeeeee;
	border-right: 0px outset #888888;
	border-bottom: 0px outset #888888;
	border-left: 0px outset #eeeeee;
	padding-top: 2px;
	background-repeat: repeat-x;
	}

.tabhead{}
.tabhead ul{height:20px;clear:both;overflow:hidden}
.tabhead ul li{float:left;width:100px;height:20px;text-align:center;border:1px solid #999999;border-bottom:0px;margin-right:5px;line-height:20px;cursor:pointer}
.tabhead ul li.current{background-color:#D1EAFE;}
</style>
<script type="text/javascript">
 function Set_Selected(selectvalue,objname) //根据值设置select表单
 {
  var obj=document.getElementById(objname);
  var Avalue=selectvalue.split(',');
  for(i=0;i<Avalue.length;i++)
   {
     for(k=0;k<obj.options.length;k++)
      {
        if(obj.options[k].value==Avalue[i] || selectvalue=="select-all")
         {
          obj.options[k].selected=true;
         }
      }
   }
 }
 var CurrentNums=parent.document.getElementById("<%=Field%>").value;
 if(isNaN(CurrentNums)){CurrentNums="0";}
 CurrentNums=parseInt(CurrentNums);
 var AuotTitlePic="";
 var PostType="<%=Post%>";
 var PostFile="/e/aspx/uploads.aspx";
 var TypeFile = ["(<%=The_Ext%>)","<%=The_Ext.Replace(",",";")%>"];
 var NewTypeFile = ["(<%=The_Ext%>)","<%=The_Ext.Replace(",",";")%>"];
 var FileNum =<%=MaxNum%>;//可限制待传文件的数量，0或负数为不限制
 var Size = <%=The_Maxlength%>;//上传单个文件限制大小，单位MB，可以填写小数类型
 var FormID = ['swf_upload','file_source','Perms_MemberType','rename','watermark','filesize','title','beizhu','point','xuhao','autotitlepic','Visiter_all','username','oldurl','thumbnail','width','height','sid','inforid','id','type','table','field','post','from'];//设置每次上传时将注册了ID的表单数据以POST形式发送到服务器需要设置的FORM表单中checkbox,text,textarea,radio,select项目的ID值,radio组只需要一个设置ID即可参数为数组类型，注意使用此参数必须有 challs_flash_FormData() 函数支持
 var ListShowType =<%=FieldType=="files"?"1":"2"%>;//文件列表显示类型：1 = 传统列表显示，2 = 缩略图列表显示（适用于图片专用上传）,3 = 单列模式4 = MP3播放模式
</script>
<script language="javascript" src="/e/incs/swfupload/upload.js"></script>
</head>
<body id="bodybox">
<center>
<iframe name="uframe" id="uframe" src="" frameborder=0 scroling=no height=1px width=1px marginwidth=0 marginheight=0 style="display:none"></iframe>
<%if(Allow_Upload=="1"){%><div class="tabhead"><ul><li class="current" onclick="showtab(0)" id="tab" name="tab">普通上传</li><li onclick="showtab(1)" id="tab" name="tab">批量上传</li></ul></div><%}%>
<div class="main" name="tabcontent" id="tabcontent">
<table cellspacing="0" cellpadding="0" width="100%" border="0" align="center">
<form method="post" name="f" target="uframe" action="uploads.aspx" Enctype="multipart/form-data">
<tr id="tr_source" style="display:none">
<td align=right>文件来源</td>
<td align=left><span id="lb_source_1" style="display:none"><input type="radio" value="0" name="file_source" id="file_source_1" checked onclick="C_Srorce()">本地上传 &nbsp;</span><input type="radio" value="1" name="file_source" id="file_source_2" onclick="C_Srorce()">网络文件</td>
</tr>

<tr id="tr_upload" style="display:none">
<td align=right>文件上传</td>
<td align=left><input type="file" name="file" id="file" size="30" contentEditable="false"> &nbsp;<span id="postarea" style="display:<%=IsMaster=="1"?"":"none"%>"><input type="checkbox" name="rename" id="rename" value="1" checked>重命名<%if(FieldType=="images"){%>&nbsp;<input type="checkbox" name="watermark" id="watermark" value="1" checked>加水印<%}%></span><span id="UploadState" style="display:none"><img src="/e/images/public/uploading.gif" align="absmiddle">上传中...</span></td>
</tr>

<tr id="tr_url" style="display:none">
<td align=right><%=FieldType=="images"?"图片":"文件"%>地址</td>
<td align=left><input type="textbox" id="url" name="url" style="width:80%" maxlength="200" ondblclick="ViewUrl(this.value)" value="<%=Url%>" <%=(Url.ToLower().IndexOf("http://")==0 || Url=="")?"":"readonly onkeydown=\"alert('禁止直接修改!');return false\""%> title="格式如：http://www.pageadmin.net/image.jpg"><%if(IsMaster=="1"){%>&nbsp;<input class="bt" type="button" id="bt_url" value="浏览服务器" onclick="open_select('','<%=FieldType%>','<%=Request.QueryString["table"]%>','<%=Request.QueryString["field"]%>','url')" style="height:22px;display:none"><%}%></td>
</tr>

<tr id="tr_size" style="display:none">
<td align=right>文件大小</td>
<td align=left><input type="textbox" name="filesize" id="filesize" value="<%=FileSize%>" onkeyup="if(isNaN(value))execCommand('undo')" style="width:100px" maxlength="20">kb</td>
</tr>


<tr>
<td width="80px" align=right><%=FieldType=="images"?"图片":"文件"%>名称</td>
<td align=left><input type="textbox" name="title" id="title"  style="width:80%" Maxlength="50" value="<%=TheTitle%>"></td>
</tr>

<tr>
<td align=right><%=FieldType=="images"?"图片":"文件"%>说明</td>
<td align=left><textarea  id="beizhu" name="beizhu" style="width:80%;height:60px;"><%=Content%></textarea></td>
</tr>

<tr style="display:<%=FieldType=="files"?"":"none"%>">
<td align=right width="80px">下载权限</td>
<td align=left>
 <select name="Perms_MemberType" id="Perms_MemberType" style="width:80%" size="5" multiple>
   <option value="">所有用户组</option>
  <%=MemberTypeList%>
 </select>
<br><span style="color:#999">按住Ctrl键可实现多选或取消选择</span>
<script type="text/javascript">
Set_Selected("<%=perms_membertype%>","Perms_MemberType");
</script>
</td>
</tr>

<tr style="display:<%=FieldType=="files"?"":"none"%>">
<td align=right>下载积分</td>
<td align=left><input type="textbox" name="point" id="point"  size="10" Maxlength="10" value="<%=Point==null?"0":Point%>" onkeyup="if(isNaN(value))execCommand('undo')"></td>
</tr>

<tr>
<td align=right>排序</td>
<td align=left><input type="textbox" name="xuhao" id="xuhao" size="5" Maxlength="10" value="<%=Xuhao==null?"1":Xuhao%>" onkeyup="if(isNaN(value))execCommand('undo')"></td>
</tr>

<tr>
<td align="center" colspan="2">
<input type="button" id="postbt" value=" <%=Post=="add"?"增加":"更新"%> "  onclick="return c_form()">
<span id="showautotitlepic" style="display:none"><input name='autotitlepic' id='autotitlepic' type='checkbox' value='1'>同时存为标题图片</span>
</td>
</tr>
<input type="hidden" id="username" name="username" value="<%=UserName%>">
<input type="hidden" id="oldurl" name="oldurl" value="<%=Url%>">
<input type="hidden" id="thumbnail" name="thumbnail" value="<%=T_Url%>">
<input type="hidden" id="width" name="width" value="<%=Thumbnail_MinWidth%>">
<input type="hidden" id="height" name="height" value="<%=Thumbnail_MinHeight%>">
<input type="hidden" id="sid" name="sid" value="<%=Request.QueryString["sid"]%>">
<input type="hidden" id="inforid" name="inforid" value="<%=Request.QueryString["inforid"]%>">
<input type="hidden" id="id"  name="id" value="<%=Request.QueryString["id"]%>">
<input type="hidden" id="type"  name="type" value="<%=FieldType%>">
<input type="hidden" id="table"  name="table" value="<%=Table%>">
<input type="hidden" id="field" name="field" value="<%=Field%>">
<input type="hidden" id="post" name="post" value="<%=Post%>">
<input type="hidden" id="from" name="from" value="<%=Request.QueryString["from"]%>">
</form>
</table>
</div><div class="main" name="tabcontent" id="tabcontent" style="padding:0px;display:none">
<table cellspacing="0" cellpadding="0" width="100%" border="0">
<tr>
<td>
<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=11,0,0,0" width="500" height="<%=Post=="add"?"250":"250"%>" id="update" align="middle">
<param name="allowFullScreen" value="false" />
    <param name="allowScriptAccess" value="always" />
	<param name="movie" value="/e/incs/swfupload/upload.swf" />
    <param name="quality" value="high" />
    <param name="bgcolor" value="#ffffff" />
    <embed src="/e/incs/swfupload/upload.swf" quality="high" bgcolor="#ffffff" width="500" height="<%=Post=="add"?"250":"250"%>" name="update" align="middle" allowScriptAccess="always" allowFullScreen="false" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" />
	</object>
<div id="show" style="margin-top:5px;width:480px;text-align:left;"></div>
<input type="hidden" id="swf_upload" value="1">
<input type="hidden" id="file_source" value="0">
</td>
</tr>
</table>
</div>

</center>
<script type="text/javascript">
window.onload=function(){document.getElementsByName("tabcontent")[1].style.display="none";}
if(parent.document.getElementById("<%=Field%>")==null)
 {
  document.getElementById("bodybox").innerHTML="参数错误";
 }

//变更类型
var lb_source_1=document.getElementById("lb_source_1");
var tr_source=document.getElementById("tr_source");
var radio_source_1=document.getElementById("file_source_1");
var radio_source_2=document.getElementById("file_source_2");
var tr_upload=document.getElementById("tr_upload");
var tr_url=document.getElementById("tr_url");
var tr_size=document.getElementById("tr_size");
var FieldType="<%=FieldType%>";
var Post="<%=Post%>";
if(Post=="edit"){document.getElementsByName("tab")[1].innerHTML="大文件上传"};
var IsMaster=<%=IsMaster%>;
function C_Srorce()
 {
  if(radio_source_1.checked)
   {
    tr_upload.style.display="";
    tr_url.style.display="none";
    tr_size.style.display="none";
   }
  else
   {
    tr_upload.style.display="none";
    tr_url.style.display="";
    if(FieldType=="files")
     {
      tr_size.style.display="";
     }
   }
 }

var TitlePic=parent.document.getElementById("titlepic");
if(FieldType=="images")
 {
  var showautotitlepic=document.getElementById("showautotitlepic");
  if(TitlePic!=null)
   {
     if(TitlePic.value=="")
      {
       showautotitlepic.style.display="";
       document.getElementById("autotitlepic").checked=true;
      }
   }
 }

if(IsMaster==1)
 {
   tr_source.style.display="";
   lb_source_1.style.display="";
   tr_upload.style.display="";
 }
else
 {
   var Allow_Upload="<%=Allow_Upload%>" //是否允许上传
   if(Allow_Upload=="1")
    {
      tr_source.style.display="";
      lb_source_1.style.display="";
      tr_upload.style.display="";
    }
   else
    {
      tr_source.style.display="none";
      radio_source_2.checked=true;
      tr_url.style.display="";
    }
 }

if(Post=="edit")
 {
  radio_source_2.checked=true;
  C_Srorce();
 }

var CurrentId="<%=Request.QueryString["id"]%>";
if(CurrentId=="0" || CurrentId=="")
{
 document.getElementById("xuhao").value=parseInt(CurrentNums)+1;
}
function c_form()
 {
   if("<%=Request.QueryString["table"]%>"=="" || "<%=Field%>"=="")
     {
      alert("参数错误!");
      return false;
     }
   var MaxNum=<%=MaxNum%>;
   if(document.forms["f"].post.value=="add" && !isNaN(CurrentNums) && MaxNum>0)
    {
      if(CurrentNums>=MaxNum)
      {
        if(FieldType=="images")
         {
          alert("对不起，只能发布"+MaxNum+"张图片!");
         }
        else
         {
          alert("对不起，只能发布"+MaxNum+"组文件!");
         }
        return false;
      }
    }

   var obj;
   if(radio_source_1.checked)
    {
     obj=document.forms["f"].file;
     if(obj.value=="")
     {
      alert("请选择上传文件!");
      obj.focus();
      return false;
     }
    }
   else
    {
     obj=document.forms["f"].url;
     if(obj.value=="" || obj.value.indexOf(".")<=0)
     {
      alert("请正确填写<%=FieldType=="images"?"图片":"文件"%>地址!");
      obj.focus();
      return false;
     }
     else if(obj.value.indexOf(":\\")>=0)
     {
      alert("您填写的地址可能是本地电脑的路径，请填写网络地址!");
      obj.focus();
      return false;
     }
   }

   obj=document.forms["f"].title;
   if(obj.value=="")
    {
      //alert("请填写<%=FieldType=="images"?"图片":"文件"%>名称!");
      //obj.focus();
      //return false;
    }

   var objstate=document.getElementById("UploadState");
   var objpostarea=document.getElementById("postarea");
   var postbt=document.getElementById("postbt");

   objstate.style.display="";
   objpostarea.style.display="none";
   postbt.disabled=true;
   document.forms["f"].submit();
   return true;
 }

function  ViewUrl(url)
 {
    if(url!="" && url.indexOf(".")>0)
    {
      window.open(url,"view");
    } 
 }


function ReFresh_Parent(Tpic)
 {
  if(Tpic!="" && TitlePic!=null)
   {
    TitlePic.value=Tpic;
    var p_delete=parent.document.getElementById("delete_titlepic");
    var p_upload=parent.document.getElementById("upload_titlepic");
    p_delete.style.display="";
    p_upload.style.display="none";
   }
   if(Post=="add")
   {
     parent.Iframe_ReFresh('iframe_<%=Field%>');
     parent.CloseDialog();
   }
  else
   {
     parent.Iframe_ReFresh('iframe_<%=Field%>');
     location.href=location.href;
   }
 }

function open_select(path,type,table,field,id)
 {
  var Width=540;
  var Height=580;
  var Left=(window.screen.availWidth-10-Width)/2
  var Top=(window.screen.availHeight-30-Height)/2
  var Val=window.open("/e/aspx/file_select.aspx?sid=<%=Request.QueryString["sid"]%>&filepath="+path+"&type="+type+"&table="+table+"&field="+field+"&objid="+id+"&from=<%=Request.QueryString["from"]%>","upload","width="+Width+",height="+Height+",top="+Top+",left="+Left+",toolbar=no,menubar=no,scrollbars=no,resizable=yes,location=no,status=yes");
 }
function showtab(num)
 {
    var Obj=document.getElementsByName("tabcontent");
    var Objhead=document.getElementsByName("tab");
    if(document.getElementById("tab")==null){return;}
    for(i=0;i<Objhead.length;i++)
     {
      Obj[i].style.display="none";
      Objhead[i].className="";
     }
    Obj[num].style.display="";
    Objhead[num].className="current";
 }
</script>
</body>
</html>
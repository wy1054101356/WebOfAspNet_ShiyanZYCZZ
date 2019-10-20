<% @ Page Language="C#"%>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<% @ Import NameSpace="PageAdmin"%>
<script language="c#" Runat="server">
  OleDbConnection conn;
  string SourceSites,DataSiteId,SiteId,TgTable,TheTable,SiteList,Sort_List,List_Space,List_style,IsMultiple,SortChoiceType,ObjId;
  int List_Level;
  protected  void Page_Load(Object src,EventArgs e)
   {
   if(!Page.IsPostBack)
    {
       Conn Myconn=new Conn();
       conn=Myconn.OleDbConn();//获取OleDbConnection
       SiteId=Request.QueryString["SiteId"];
       TheTable=Request.QueryString["table"];
       TgTable=Request.QueryString["tgtable"];
       ObjId=Request.QueryString["id"];
       IsMultiple=Request.QueryString["ismultiple"];
       SortChoiceType=Request.QueryString["sortchoicetype"];
       ObjId=Request.QueryString["objid"];
       SourceSites=Request.QueryString["sourcesites"];
       if(IsNum(Request.QueryString["datasiteid"])) //却换站点跳转时候增加的参数
       {
       DataSiteId=Request.QueryString["datasiteid"];
       }
      else if(IsNum(SourceSites))
      {
       DataSiteId=SourceSites;
      }
     else if(IsNums(SourceSites))
      {
       DataSiteId=SourceSites.Split(',')[0];
      }
     else if(SourceSites=="all")
     {
       DataSiteId=SiteId;
      }
     else
     {
      Response.Write("无效的SourceSites参数!");
      Response.End();
      }

      if(!IsNum(SiteId) || !IsStr(TheTable) || !IsStr(TgTable) ||  !IsStr(IsMultiple) || !IsNum(SortChoiceType) || !IsStr(ObjId))
         {
          Response.Write("<"+"script type='text/javascript'>alert('无效参数!');parent.ymPrompt.close()</"+"script>");
          Response.End();
          return;
         }
       conn.Open();
       if(Request.QueryString["from"]=="master")
        {
         Master_Valicate YZ=new Master_Valicate();
         YZ.Master_Check();
        }
       else
       {
         if(Request.Cookies["Member"]==null)
         {
          Response.Write("未登录或登录失效!");
          Response.End();
         }
         Member_Valicate MCheck=new Member_Valicate();
         MCheck.Member_Check();
         Check_TG(int.Parse(SiteId),MCheck._MemberTypeId,MCheck._DepartmentId);//检查是否具有投稿权限
        }
        Get_Site();
        Get_Sort(0);
      conn.Close();
    }
  }


private void Get_Site()
 {
  SiteList="";
  string sql="";
  if(SourceSites=="all")
   {
    sql="select sitename,id from pa_site order by xuhao";
   }
  else if(IsNum(SourceSites))
   {
    sql="select sitename,id from pa_site where id="+SourceSites+" order by xuhao";
   }
  else if(IsNums(SourceSites))
   {
    sql="select sitename,id from pa_site where id in("+SourceSites+") order by xuhao";
   }
  else
   {
     Response.Write("无效的SourceSites参数!");
     Response.End();
   }
  OleDbCommand comm=new OleDbCommand(sql,conn);
  OleDbDataReader dr=comm.ExecuteReader();
  while(dr.Read())
     {
      if(dr["id"].ToString()==DataSiteId)
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


private void Get_Sort(int Parentid)
 {
   string sql="select id,sort_level,sort_name,final_sort from pa_sort where parent_id="+Parentid+" and thetable='"+TheTable+"' and site_id="+DataSiteId+" order by xuhao";
   OleDbCommand comm=new OleDbCommand(sql,conn);
   OleDbDataReader dr=comm.ExecuteReader();
   while(dr.Read())
    {
      List_Space="";
      List_Level=int.Parse(dr["sort_level"].ToString());
      for(int i=0;i<List_Level-1;i++)
       {
        List_Space+="&nbsp;&nbsp;&nbsp;";
       }
      if(List_Level>1)
      {
       List_Space+="|-";
      }
      if(dr["final_sort"].ToString()=="1") 
       {
         Sort_List+="<option value='"+dr["id"].ToString()+"'>"+List_Space+dr["sort_name"].ToString()+"</option>\r\n";
       }
      else
       {
        if(List_Level==1)
         {
           List_style=" class='rootnode' ";
         }
        else
         {
           List_style=" class='childnode' ";
         }
        Sort_List+="<option "+List_style+" value='"+dr["id"].ToString()+"'"+(SortChoiceType=="1"?" disabled":"")+">"+List_Space+dr["sort_name"].ToString()+"</option>\r\n";
        Get_Sort(int.Parse(dr["id"].ToString()));
       }
    }
   dr.Close();
 }

private void Check_TG(int SiteId,int M_typeid,int DepartmentId )
 {
   int v=0;
   string sql;
   if(DepartmentId>0)
    {
      sql="select id from pa_member_tgset where site_id="+SiteId+" and department_id="+DepartmentId+" and thetable='"+TgTable+"'";
    }
   else
    {
      sql="select id from pa_member_tgset where site_id="+SiteId+" and mtype_id="+M_typeid+" and thetable='"+TgTable+"'";
    }
    OleDbCommand comm=new OleDbCommand(sql,conn);
    OleDbDataReader dr=comm.ExecuteReader();
    if(dr.Read())
      {
        v=1;
      }
    dr.Close();
   if(v==0)
    { 
      Response.Write("您不具备投稿权限!");
      Response.End();
    }
}

private bool IsNums(string str)
 {
  if(string.IsNullOrEmpty(str)){return false;}
  string[] Astr=str.Split(',');
  for(int i=0;i<Astr.Length;i++)
   {
     if(!IsNum(Astr[i]))
      {
        return false;
      }
   }
  return true;
 }

private bool IsNum(string str)
 {
  if(string.IsNullOrEmpty(str)){return false;}
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

private bool IsStr(string str)
 {
  if(string.IsNullOrEmpty(str)){return false;}
  string str1="abcdefghijklmnopqrstuvwxyz0123456789_";
  string str2=str.ToLower();;
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
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta name="Author" content="PageAdmin CMS" />
<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/ >
<style type="text/css">
body{word-wrap:break-word;margin:0px;padding:0px;font:12px/18px Tahoma,Verdana,Arial,\5b8b\4f53;}
button,input,select,textarea{font-size:13px}
table{word-wrap:break-word;word-break:break-all}
p{padding:0 0 0 0;margin:0 0 0 0;}
td,div{font-size:9pt;color:#000000;font-family:宋体,Arial;}
a{color:#000000;text-decoration:none;}
a:hover{color:#000000;text-decoration: none;}
.table_style{background-color: #ffffff;}
.table_style2{
	border-width: 1px;
	border-left-style: solid;
	border-right-style: solid;
	border-bottom-style: solid;
	border-top-style: solid;
	border-color:#808080;
        background-color:#D1EAFE;
}
.tdstyle{
        border:0 solid  #4388A9;
        border-width:1px 1px 1px 1px;
	font-size: 12px;
	color: #333333;
        height:25px;
        padding:2px 5px 2px 5px;
        background-color:#ffffff;
       }   

.tablestyle{
        border:0 solid  #4388A9;
        border-width:0 1px 0 1px;
	background-color: #4388A9;
	border-collapse:collapse; 
        color: #FFFFFF;
 }

.tablestyle tr.header td{text-align:center;color:#fff;font-size:12px;height:25px;} 
.tablestyle tr.listitem td{border:1px solid  #4388A9;
	font-size: 12px;
	color: #333333;
        height:25px;
        padding:2px 5px 2px 5px;
        background-color:#ffffff;
}
.tablestyle tr.overcolor td{background-color:#E0F0FE}
.tablestyle tr.listitem td a{text-decoration: none;}   
.tablestyle tr.listitem td a:hover{text-decoration:underline;} 
.white{color:white;font-size:9pt;}
select .rootnode{background-color:#8AC9FD}
select .childnode{background-color:#D1EAFE}
.bt{border:1px solid #4388A9;padding:0px 10px;height:20px;line-height:18px;cursor:pointer;margin:1px 0px;font-size:12px;background-color:#4388A9;color:#fff}
.bt:hover{background-color:#D1EAFE;color:#4388A9}
</style>
</head>
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table border=0 cellpadding=0 cellspacing=0 width=99% >
 <tr>
<td valign=top  align="left" style="padding:5px">
<form method="post" target="post_iframe" >
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center class=table_style2>
  <tr>
  <td valign=top>

<table border=0 cellpadding=2 cellspacing=0 width=95% align=center>
  <tr>
  <td height=25 width=100px>选择站点</td>
  <td><select name="SiteId" onchange="c_site(this.value)"><%=SiteList%></select></td>
 </tr>
 <tr>
  <td  height=25>选择类别</td>
  <td> <select name="Sort" id="Sort" multiple style="width:600px;height:350px;">
	<option value="0">选择类别</option>
        <%=Sort_List%>
       </select>
       <%if(IsMultiple=="1"){%><br>按住Ctrl键可实现多选或取消选择。<%}%>
  </td>
 </tr>
 
</table>
</td>
</tr>
</table>
<br>
<div align=center>
<input type="button" value="选择" onclick="Get_Select()">
<input type="button" value="取消"  onclick="parent.CloseDialog()"> 
</div>
</form>
</td>
</tr>
</table>
<script type="text/javascript">
var op_obj=parent.document.getElementById("<%=ObjId%>");
var obj_sort=document.getElementById("Sort");
var HasSelect="";
if(op_obj!=null)
 {
   for(var i=0;i<op_obj.options.length;i++)
     {
       HasSelect+=op_obj.options[i].value+",";
     }
   var AHasSelect=HasSelect.split(",");
   for(var k=0;k<AHasSelect.length;k++)
   {
    for(var i=0;i<obj_sort.options.length;i++)
     {
         if(obj_sort.options[i].value==AHasSelect[k])
          {
            obj_sort.options[i].text=obj_sort.options[i].text+"√";
          }
     }
   }

 }

function Get_Select()
 {
  if(op_obj==null){alert("id不存在");return;}
  var Ids=Get_SelectValue();
  var txt;
  if(Ids=="0")
   {
    <%if(Request.QueryString["autoclose"]=="true"){%>
      parent.CloseDialog();
    <%}%>
     return;
   }
 var AIds=Ids.split(',');
 <%if(IsMultiple=="0"){%>
   clear_select(op_obj);
 <%}%>
 parent.load_ajaxdata("pa_sort",Ids,"<%=ObjId%>");
 <%if(Request.QueryString["autoclose"]=="true"){%>
    parent.CloseDialog();
 <%}%>
 }


function CheckRepeat(id)
 {
   for(var i=0;i<op_obj.options.length;i++)
     {
       if(op_obj.options[i].value==id)
        {
          return true;
        }
     }
  return false;
 }

function Get_SelectValue(id)
 {

   var ID="0";
   for(var i=0;i<obj_sort.options.length;i++)
     {
       if(obj_sort.options[i].selected)
       {
         if(!CheckRepeat(obj_sort.options[i].value))
          {
           ID+=","+obj_sort.options[i].value;
          }
       }
     }
   return ID.replace("0,","");
 }

function clear_select(obj)
 {
  if(obj.options.length==0){return;}
  for(i=0;i<obj.options.length;i++)
   {
    if(obj.options[i].value!="0" && obj.options[i].value!="")
     {
       obj.remove(i);
       clear_select(obj);
     }
   }
 }

function c_site(sid)
 {
   location.href="?datasiteid="+sid+"&siteid=<%=SiteId%>&sourcesites=<%=Request.QueryString["sourcesites"]%>&tgtable=<%=TgTable%>&table=<%=TheTable%>&ismultiple=<%=IsMultiple%>&sortchoicetype=<%=SortChoiceType%>&objid=<%=ObjId%>&autoclose=<%=Request.QueryString["autoclose"]%>&from=<%=Request.QueryString["from"]%>";
 }
</script>
</center>
</body>
</html>  
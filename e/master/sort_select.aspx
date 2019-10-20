<% @ Page Language="C#"%>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<% @ Import NameSpace="PageAdmin"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<script language="c#" Runat="server">
  OleDbConnection conn;
  string Thetable;
  string SiteList,Sort_List,List_Space,List_style;
  int CurrentSiteId,List_Level;

  protected  void Page_Load(Object src,EventArgs e)
   {
   if(!Page.IsPostBack)
    {
       Master_Valicate YZ=new Master_Valicate();
       YZ.Master_Check();
       Conn Myconn=new Conn();
       conn=Myconn.OleDbConn();//获取OleDbConnection
       Thetable=Request.QueryString["table"];
       if(!IsStr(Thetable))
         {
          Response.Write("<"+"script type='text/javascript'>alert('无效table!');parent.ymPrompt.close()</"+"script>");
          Response.End();
          return;
         }
       conn.Open();
        Get_Site();
        Get_Sort(0);
      conn.Close();
    }
  }

private void Get_Site()
 {

  if(IsNum(Request.QueryString["siteid"]))
   {
     CurrentSiteId=int.Parse(Request.QueryString["siteid"]);
   }
  else
   {
     CurrentSiteId=int.Parse(Request.Cookies["SiteId"].Value);
   }
  string Thetable=Request.QueryString["table"];
  SiteList="";
    
  string sql="select sitename,id from pa_site order by xuhao";
  OleDbCommand comm=new OleDbCommand(sql,conn);
  OleDbDataReader dr=comm.ExecuteReader();
  while(dr.Read())
     {
      if(dr["id"].ToString()==CurrentSiteId.ToString())
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
   string sql="select id,sort_level,sort_name,final_sort from pa_sort where parent_id="+Parentid+" and thetable='"+Thetable+"' and site_id="+CurrentSiteId+" order by xuhao";
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
        Sort_List+="<option "+List_style+" value='"+dr["id"].ToString()+"' disabled>"+List_Space+dr["sort_name"].ToString()+"</option>\r\n";
        Get_Sort(int.Parse(dr["id"].ToString()));
       }
    }
   dr.Close();
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
<aspcn:uc_head runat="server" /> 
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr><td height=10></td></tr>
 <tr><td class=table_style1><b>推送分类</b></td></tr>
 <tr><td height=10></td></tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr>
<td valign=top  align="left">
<form method="post" target="post_iframe" >
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center class=table_style2>
  <tr>
  <td valign=top>

<table border=0 cellpadding=2 cellspacing=0 width=95% align=center>
 </tr>
  <tr>
  <td height=25 width=100px>选择站点</td>
  <td><select name="SiteId" onchange="c_site(this.value)"><%=SiteList%></select></td>
 </tr>

 <tr>
  <td  height=25>选择类别</td>
  <td> <select size="15" name="Sort" id="Sort" multiple style="width:400px;">
	<option value="0">选择类别</option>
        <%=Sort_List%>
       </select>
       <br>按住Ctrl键可实现多选。
  </td>
 </tr>
 
</table>
</td>
</tr>
</table>

<br>
<div align=center>

<input type="button" class=button   value="选择" onclick="Get_Select()">
<input type="button" class=button  value="关闭"  onclick="parent.CloseDialog()"> 


</div>
</form>
</td>
</tr>
</table><br>
</center>
</body>
<script type="text/javascript">

function Get_Select()
 {
  var Ids=Get_SelectValue();
  var txt;
  if(Ids=="0")
   {
     //alert("请选择推送分类!");
     return;
   }
 var AIds=Ids.split(',');
 var obj=parent.document.getElementById("push_list");
 if(obj==null){return;}
 parent.load_list("pa_sort",Ids,"push_list")
 //parent.CloseDialog();
 }

function CheckRepeat(id)
 {
   var op_obj=parent.document.getElementById("push_list");
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
   var obj=document.getElementById("Sort");
   var ID="0";
   for(var i=0;i<obj.options.length;i++)
     {
       if(obj.options[i].selected)
       {
         if(!CheckRepeat(obj.options[i].value))
          {
           ID+=","+obj.options[i].value;
          }
       }
     }
   return ID.replace("0,","");
 }


function c_site(sid)
 {
   location.href="?siteid="+sid+"&table=<%=Request.QueryString["table"]%>";
 }
</script>
</html>  

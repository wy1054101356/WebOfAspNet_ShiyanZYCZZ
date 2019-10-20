<% @ Page language="c#"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<% @ Import NameSpace="System.IO"%>
<% @ Import NameSpace="PageAdmin"%>
<script language="c#" runat="server">
 string UserName,Table,Field,FieldType,sql,IsMaster;
 int SiteId,InforId,RecordCount;
 OleDbConnection conn;
 protected void Page_Load(Object src,EventArgs e)
  {
     Conn Myconn=new Conn();
     conn=Myconn.OleDbConn();//获取OleDbConnection
     if(!Page.IsPostBack)
     {
      if(Request.QueryString["from"]=="master")
      {
        Master_Valicate Master=new Master_Valicate();
        Master.Master_Check();
        UserName=Master._UserName;
        IsMaster="1";
      }
     else
      {
        Member_Valicate Member=new Member_Valicate();
        Member.Member_Check();
        UserName=Member._UserName;
        IsMaster="0";
      }
      Get_Data();
     }
    else
     {
      if(Request.Form["post"]=="update")
       {
       if(Lb_Ftype.Text=="images")
        {
         Data_Update(Image_List);
        }
       else
        {
         Data_Update(File_List);
        }
       }
     }
  }

private void Get_Data()
  {
    FieldType=Request.QueryString["fieldtype"];
    Table=Request.QueryString["table"];
    Field=Request.QueryString["field"];
    if(IsNum(Request.QueryString["sid"]))
     {
      SiteId=int.Parse(Request.QueryString["sid"]);
     }
    else
     {
      SiteId=0;
     }
    if(IsNum(Request.QueryString["id"]))
     {
      InforId=int.Parse(Request.QueryString["id"]);
     }
    else
     {
      InforId=0;
     }
    Lb_Ftype.Text=FieldType;
    OleDbCommand comm;
    conn.Open();
    if(IsStr(Table) && IsStr(Field) && IsStr(FieldType))
    {
      //检测信息发布会员是否匹配，避免恶意操作
       if(InforId>0 && IsMaster=="0") 
       {
         OleDbDataReader dr;
         if(Table!="pa_member")
          {
          sql="select id from pa_table where thetable='"+Table+"'";
          comm=new OleDbCommand(sql,conn);
          dr=comm.ExecuteReader();
          if(!dr.Read())
          {  
            dr.Close();
            conn.Close();
            Response.Write("error table!");
            Response.End();
          }
           dr.Close();
          }

         sql="select id from pa_field where thetable='"+Table+"' and [field]='"+Field+"'";
         comm=new OleDbCommand(sql,conn);
         dr=comm.ExecuteReader();
         if(!dr.Read())
         {  
          dr.Close();
          conn.Close();
          Response.Write("error field!");
          Response.End();
         }
         dr.Close();
        int IsIssueUser=0;
 
        sql="select id from pa_issuedata where detail_checked=0 and work_username='"+UserName+"' and thetable='"+Table+"' and detail_id="+InforId; //检查是否是签发人员
        comm=new OleDbCommand(sql,conn);
        dr=comm.ExecuteReader();
        if(dr.Read())
         { 
          IsIssueUser=1;
         }
        dr.Close();
    
        if(IsIssueUser==0) //如果不是签发人员则检测用户名是否和信息匹配
        {
         sql="select id from "+Table+" where id="+InforId+" and username='"+UserName+"'";
         comm=new OleDbCommand(sql,conn);
         dr=comm.ExecuteReader();
         if(!dr.Read())
         {  
          dr.Close();
          conn.Close();
          Response.Write("no permission!");
          Response.End();
         }
         dr.Close();
        }
      }
      //检测信息发布会员是否匹配，避免恶意操作


      if(InforId==0)
       {
         sql="select id,title,url,thumbnail,thetable,field,detail_id,username,xuhao from pa_file where username='"+UserName+"' and thetable='"+Table+"' and field='"+Field+"' and detail_id="+InforId+" order by xuhao";
       }
      else
       {
         sql="select id,title,url,thumbnail,thetable,field,detail_id,username,xuhao from pa_file where thetable='"+Table+"' and field='"+Field+"' and detail_id="+InforId+" order by xuhao";
       }
    DataSet ds=new DataSet();
    OleDbDataAdapter AD=new OleDbDataAdapter(sql,conn);
    AD.Fill(ds,"tb");
    RecordCount=ds.Tables["tb"].Rows.Count;
    if(FieldType=="images")
     {
       Image_List.DataSource=ds.Tables["tb"].DefaultView;
       Image_List.DataBind();
     }
    else
     {
       File_List.DataSource=ds.Tables["tb"].DefaultView;
       File_List.DataBind();
     }

    sql="update "+Table+" set "+Field+"='"+RecordCount+"' where id="+InforId;
    comm=new OleDbCommand(sql,conn);
    comm.ExecuteNonQuery();

    conn.Close();
   }
  }

protected void Data_Update(DataList Dl)
 {
  string Title;
  int Id,Xuhao;
  conn.Open();
  OleDbCommand comm;
  for(int i=0;i<Dl.Items.Count;i++)
   {
     Id=int.Parse(((Label)Dl.Items[i].FindControl("Lb_Id")).Text);
     Title=Sql_Format(((TextBox)Dl.Items[i].FindControl("Tb_title")).Text.Trim());
     if(!IsNum( ((TextBox)Dl.Items[i].FindControl("Tb_xuhao")).Text ))
     {
      Xuhao=0;
     }
    else
     {
       Xuhao=int.Parse(((TextBox)Dl.Items[i].FindControl("Tb_xuhao")).Text);
     }
     sql="update pa_file set title='"+Sql_Format(Title)+"',xuhao="+Xuhao+" where id="+Id;
     comm=new  OleDbCommand(sql,conn);
     comm.ExecuteNonQuery();
   }
   conn.Close();
   Response.Write("<"+"script type='text/javascript'>location.href=location.href</scrip"+"t>");
   Response.End();
 }


protected void Data_Delete(Object sender,DataListCommandEventArgs e)
 {
    int Id=int.Parse(((Label)e.Item.FindControl("Lb_Id")).Text);
    string Tb=((Label)e.Item.FindControl("Lb_Thumbnail")).Text;
    string Url=((Label)e.Item.FindControl("Lb_Url")).Text;
    UserName=((Label)e.Item.FindControl("Lb_UserName")).Text;
    Del_File(Tb);
    Del_File(Url);
    conn.Open();
    sql="delete from pa_file where id="+Id;
    OleDbCommand mycomm=new OleDbCommand(sql,conn);
    mycomm.ExecuteNonQuery();
    conn.Close();
    Response.Write("<"+"script type='text/javascript'>location.href=location.href</scrip"+"t>");
    Response.End();
 }


private void Del_File(string FilePath)
 {
   if(FilePath!="" && FilePath.IndexOf(":")<0 && FilePath.IndexOf("/e/upload/")==0)
    {
     if(FilePath.IndexOf("/zdy/")<0)
       {
         FilePath=Server.MapPath(FilePath);
         if(File.Exists(FilePath))
          {
            File.Delete(FilePath);
          }
      }
   }
 }

protected void Data_Bound(Object sender,DataListItemEventArgs e)
 { 
  if (e.Item.ItemType   ==   ListItemType.Item   ||   e.Item.ItemType   ==   ListItemType.AlternatingItem) 
    { 
      LinkButton lkbt=(LinkButton)e.Item.FindControl("Delete");
      lkbt.Attributes.Add("onclick","return confirm('确定删除吗?');");
    }
 }

private string Sql_Format(string str)
 {
   if(string.IsNullOrEmpty(str)){return "";}
   str=str.Replace("'","''");
   str=str.Replace("\"","\""); 
   return str;
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
</script>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta name="Author" content="PageAdmin CMS" />
<meta http-equiv="X-UA-Compatible" content="IE=7" />
<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/ >
<style type=text/css>
body div td{margin:0px;padding:0px;word-wrap:break-word;text-align:center;font:12px/20px Verdana,Helvetica,Arial,\5b8b\4f53;color:#333333;}
button,input,select,textarea{font-size:13px}
table{border-collapse:collapse;border-spacing:0;}
td{font-size:12px}
#Image_List td{padding:5px 8px 5px 8px;border:1px solid #eeeeee;border-width:0 1px 0 0;}
#File_List td{padding:5px 10px 5px 10px;border:1px solid #eeeeee;width:100%}
a:link{color:#333333;text-decoration:underline;font-size:12px}
a:visited{color:#333333;text-decoration:underline;font-size:12px}
a:hover{color:#333333;text-decoration:none;font-size:12px}
.bt{height:20px;font-size:12px;border:0 solid #333333;border-width:0 1px 1px 0;background-color:#dddddd;cursor:pointer;}
</style>
</head>
<body onload="Set_Height()">
<form Runat="server">
  <asp:DataList id="Image_List" RepeatColumns="5" RepeatDirection="Horizontal" runat="server" border=0 RepeatLayout="Table" cellspacing=0 cellpadding=0 OnItemDataBound="Data_Bound"  OnDeleteCommand="Data_Delete">
   <ItemTemplate>
    <a href='<%#DataBinder.Eval(Container.DataItem,"url")%>' target="url"><img src="<%#DataBinder.Eval(Container.DataItem,"thumbnail")%>" border=0 width=110px height=100px></a><br><asp:TextBox id="Tb_title" Text='<%#DataBinder.Eval(Container.DataItem,"title")%>' Runat="server" style="width:110px;height:16px;border:1px solid #999999" Maxlength="50" onfocus="changedata()"/><br>序号<asp:TextBox id="Tb_xuhao" Text='<%#DataBinder.Eval(Container.DataItem,"xuhao")%>' Runat="server"  style="width:25px;height:16px;border:1px solid #999999" Maxlength="5" onfocus="changedata()"/>&nbsp;<a href="javascript:Edit_File('<%#DataBinder.Eval(Container.DataItem,"id")%>','<%#DataBinder.Eval(Container.DataItem,"thetable")%>','<%#DataBinder.Eval(Container.DataItem,"field")%>','<%=FieldType%>','<%#DataBinder.Eval(Container.DataItem,"detail_id")%>','<%=SiteId%>')">修改</a>
    <asp:Label id="Lb_Id" Text='<%#DataBinder.Eval(Container.DataItem,"id")%>' runat="server" Visible="false" />
    <asp:Label id="Lb_Thumbnail" Text='<%#DataBinder.Eval(Container.DataItem,"thumbnail")%>' runat="server" Visible="false" />
    <asp:Label id="Lb_Url" Text='<%#DataBinder.Eval(Container.DataItem,"url")%>' runat="server" Visible="false" />
    <asp:Label id="Lb_UserName" Text='<%#DataBinder.Eval(Container.DataItem,"username")%>' runat="server" Visible="false" />
    <asp:LinkButton  id="Delete" CommandName="Delete" runat="server" Text="删除" />
   </ItemTemplate>
  </asp:DataList>

<asp:DataList id="File_List" RepeatColumns="1" RepeatDirection="Horizontal" runat="server" border=0 RepeatLayout="Table"  cellspacing=0 cellpadding=0 OnItemDataBound="Data_Bound"  OnDeleteCommand="Data_Delete">
   <ItemTemplate>
    序号：<asp:TextBox id="Tb_xuhao" Text='<%#DataBinder.Eval(Container.DataItem,"xuhao")%>' Runat="server" style="width:25px;height:16px;border:1px solid #999999" Maxlength="5" onfocus="changedata()"/> 名称：<asp:TextBox id="Tb_title" Text='<%#DataBinder.Eval(Container.DataItem,"title")%>' Runat="server" style="width:160px;height:16px;border:1px solid #999999" Maxlength="50" onfocus="changedata()"/> 路径：<a href="<%#DataBinder.Eval(Container.DataItem,"url")%>" target="url"><%#DataBinder.Eval(Container.DataItem,"url")%></a>&nbsp;&nbsp;<a href="javascript:Edit_File('<%#DataBinder.Eval(Container.DataItem,"id")%>','<%#DataBinder.Eval(Container.DataItem,"thetable")%>','<%#DataBinder.Eval(Container.DataItem,"field")%>','<%=FieldType%>','<%#DataBinder.Eval(Container.DataItem,"detail_id")%>','<%=SiteId%>')">修改</a>
    <asp:Label id="Lb_Id" Text='<%#DataBinder.Eval(Container.DataItem,"id")%>' runat="server" Visible="false" />
    <asp:Label id="Lb_Thumbnail" Text='<%#DataBinder.Eval(Container.DataItem,"thumbnail")%>' runat="server" Visible="false" />
    <asp:Label id="Lb_Url" Text='<%#DataBinder.Eval(Container.DataItem,"url")%>' runat="server" Visible="false" />
    <asp:Label id="Lb_UserName" Text='<%#DataBinder.Eval(Container.DataItem,"username")%>' runat="server" Visible="false" />
    <asp:LinkButton  id="Delete" CommandName="Delete" runat="server" Text="删除" />
   </ItemTemplate>
</asp:DataList>
<asp:Label id="Lb_Ftype" Runat="server" Visible="false"/>
<input Type="hidden" name="post" value="">
</form>
<script type="text/javascript">
var haschange=0;
var RC=<%=RecordCount%>;
window.parent.document.getElementById("<%=Field%>").value=RC;
function Set_Height()
 {
 var IFrame = window.parent.document.getElementById("iframe_<%=Field%>");
 var scrollHeight = parseInt(document.body.scrollHeight);
 var offsetHeight = parseInt(document.body.offsetHeight);
 var height;
 var isIE = document.all && window.external;
 if(isIE)
 {
   height=scrollHeight;
 }
else
 {
   height = scrollHeight < offsetHeight?scrollHeight:offsetHeight;
 }
if(RC==0)
 {
  height="100";
  window.parent.document.getElementById("Edit_<%=Field%>").style.display="none";
 }
else
 {
  window.parent.document.getElementById("Edit_<%=Field%>").style.display="";
 }
 IFrame.style.height=height+"px";
}

var IsMaster="<%=IsMaster%>";
function Edit_File(Id,table,field,FieldType,detail_id,Sid)
 {
  parent.open_files(Sid,Id,table,field,FieldType,detail_id);
 }

function changedata()
 {
   haschange=1;
 }

function autosubmit(actfrom)
 {
   var obj=document.forms[0];
   obj.post.value="update";
   if(actfrom=="1" && haschange==0)
    {
      return false;
    }
   obj.submit();
 }
</script>
</body>
</html>

<% @ Page Language="C#"%>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<% @ Import NameSpace="PageAdmin"%>
<script Language="c#" Runat="server">
  OleDbConnection conn;
  int SiteId,PageSize,List_Level;
  string Ismultiple,objId,SiteDir,Is_Static,TheTable,List_Space,sql_str,order_str,Url_Prefix,TheMaster,Site_List,Sort_List;

  protected void Page_Load(Object src,EventArgs e)
   {
    Master_Valicate YZ=new Master_Valicate();
    YZ.Master_Check();
    TheMaster=YZ._UserName;
    SiteId=int.Parse(Request.Cookies["SiteId"].Value);
    Ismultiple=Request.QueryString["multiple"];
    objId=Request.QueryString["objid"];
    TheTable="pa_lanmu";
    if(IsNum(Tb_pagesize.Text.Trim()))
     {
      PageSize=int.Parse(Tb_pagesize.Text.Trim());
     }
    else
     {
      PageSize=20;
     }

   Conn Myconn=new Conn();
   conn=Myconn.OleDbConn();//获取OleDbConnection
   if(!Page.IsPostBack)
    {
      ViewState["CurrentPage"]=0;
      if(IsNum(Request.QueryString["pagesize"]))
       {
         PageSize=int.Parse(Request.QueryString["pagesize"]);
         Tb_pagesize.Text=PageSize.ToString();
       }
      sql_str="";
      if(IsNum(Request.QueryString["siteid"]) && Request.QueryString["siteid"]!="0")
       {
         sql_str+=" and site_id="+int.Parse(Request.QueryString["siteid"]);
         SiteId=int.Parse(Request.QueryString["siteid"]);
       }
      else
       {
         sql_str+=" and site_id="+SiteId;
       }

      if(IsNum(Request.QueryString["sortid"]))
       {
         sql_str+=" and sort_id="+int.Parse(Request.QueryString["sortid"]);
       }
      if(IsStr(Request.QueryString["type"]))
       {
          switch(Request.QueryString["type"])
           {
             case "isgood":
                sql_str+=" and isgood=1";
             break;
           }
       }

      if(Request.QueryString["keyword"]!=null && Request.QueryString["keyword"]!="")
        {
          sql_str+=" and name like '%"+Sql_Format(Request.QueryString["keyword"])+"%'";
        }
      if(IsDate(Request.QueryString["startdate"]) && IsDate(Request.QueryString["enddate"]))
      {
       if(System.Configuration.ConfigurationManager.AppSettings["DbType"]=="1")
        {
         sql_str+=" and (thedate between '"+Request.QueryString["startdate"]+"' and '"+Request.QueryString["enddate"]+" 23:59:59')";
        }
      else
        {
         sql_str+=" and (thedate between #"+Request.QueryString["startdate"]+"# and #"+Request.QueryString["enddate"]+" 23:59:59#)";
        }
      }
       order_str="id desc"; 
       if(Request.QueryString["order"]!=null && Request.QueryString["order"]!="")
       {
         order_str=Sql_Format(Request.QueryString["order"]);
        }
      ViewState["order_str"]=order_str;
      ViewState["Calculatesql"]="select count(id) as co from "+TheTable+" where iszt=1"+sql_str;
      ViewState["sql"]="select id from "+TheTable+" where iszt=1"+sql_str+"  order by "+order_str;
      conn.Open();
        Get_Site(SiteId);
        Tongji();
        Data_Bind();
        Get_Site();
        Get_Sort(0);
     conn.Close();
     Tb_pagesize.Text=PageSize.ToString();
    }
   else
    {
      conn.Open();
       Get_Site();
       Get_Sort(0);
      conn.Close();
    }
  }

private void Data_Bind()
 {
  string sql=(string)ViewState["sql"];
  int CurrentPage=(int)ViewState["CurrentPage"];
  int PageCount=(int)ViewState["PageCount"];
  LblPrev.Enabled=true;
  LblNext.Enabled=true;

  if(CurrentPage<=0)   //控制转页按纽
   {
   LblPrev.Enabled=false;
   }
   if(CurrentPage>=(PageCount-1))
   {
   LblNext.Enabled=false;
   }
  Lblcurrentpage.Text=(CurrentPage+1).ToString();

//填充下拉单
  DLpage.Items.Clear();
  int StartPage,EndPage;
  int JS=200,MB=100;
  if(CurrentPage<JS)
   {
     StartPage=0;
     EndPage=JS;
   }
  else
   {
     StartPage=CurrentPage-MB;
     EndPage=CurrentPage+MB;
     DLpage.Items.Add(new ListItem("1","0"));
     DLpage.Items.Add(new ListItem("...",(StartPage-1).ToString()));
   }
  if(EndPage>=PageCount)
   {
     EndPage=PageCount;
   }

  for(int i=StartPage;i<EndPage;i++)
    {
     DLpage.Items.Add(new ListItem((i+1).ToString(),i.ToString()));
    }

  if(PageCount>JS && EndPage<PageCount-1)
   {
     DLpage.Items.Add(new ListItem("...",EndPage.ToString()));
   }
  if(EndPage<PageCount)
   {
     DLpage.Items.Add(new ListItem(PageCount.ToString(),(PageCount-1).ToString()));
   }
   
  DLpage.SelectedIndex=DLpage.Items.IndexOf(DLpage.Items.FindByValue(CurrentPage.ToString()));
 //填充下拉单
  
  int StartIndex=CurrentPage*PageSize;
  DataSet ds=new DataSet();
  OleDbDataAdapter myAdapter=new OleDbDataAdapter(sql,conn);//在数据库和DataSet之间建立桥接。
  myAdapter.Fill(ds,StartIndex,PageSize,"default");
  ds=Optimize_DataSet(ds,(string)ViewState["order_str"]);
  P1.DataSource=ds.Tables["default"].DefaultView;
  P1.DataBind();
 }

private DataSet Optimize_DataSet(DataSet SourceDs,string Order)
 {
   int RCount=SourceDs.Tables["default"].Rows.Count;
   string Ids="0";
   if(RCount>0)
    {
      DataRow dr;
      for(int i=0;i<RCount;i++)
       {
         dr=SourceDs.Tables["default"].Rows[i];
         Ids+=","+dr["id"].ToString();
       }
    }
   SourceDs.Clear();
   string sql="select * from pa_lanmu where iszt=1 and id in("+Ids+") order by "+Order;
   OleDbDataAdapter myAdapter=new OleDbDataAdapter(sql,conn);
   myAdapter.Fill(SourceDs,"default");
   return SourceDs;
 }

private void Tongji()
{
//计算总记录
 string sql=(string)ViewState["Calculatesql"];
 OleDbCommand myComm=new OleDbCommand(sql,conn);
 OleDbDataReader dr=myComm.ExecuteReader();
 int Rcount;
  if(dr.Read())
   {
    Rcount=(int)dr["co"];
   }
  else
   {
   Rcount=0;
   }
 Lblrecordcount.Text=Rcount.ToString();

//计算总页数
 int PageCount;
 if(Rcount%PageSize==0)
  {
   PageCount=Rcount/PageSize;
  }
 else
 {
  PageCount=Rcount/PageSize+1;
 }

 ViewState["PageCount"]=PageCount;
 LblpageCount.Text=PageCount.ToString();
}


private void Get_Site()
 {
   string sql="select id,sitename from pa_site order by xuhao,id";
   OleDbCommand comm=new OleDbCommand(sql,conn);
   OleDbDataReader dr=comm.ExecuteReader();
   while(dr.Read())
    {
     Site_List+="<option value='"+dr["id"].ToString()+"'>"+dr["sitename"].ToString()+"</option>\r\n";
    }
   dr.Close();
 }

private void Get_Sort(int Parentid)
 {
   string sql="select id,sort_level,sort_name,final_sort from pa_sort where parent_id="+Parentid+" and site_id="+SiteId+" and thetable='"+TheTable+"' order by xuhao,id";
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
      if(dr["final_sort"].ToString()=="1") 
       {
         Sort_List+="<option value='"+dr["id"].ToString()+"'>"+List_Space+dr["sort_name"].ToString()+"</option>\r\n";
       }
      else
       {
        Sort_List+="<optgroup Label='"+List_Space+dr["sort_name"].ToString()+"'></optgroup>\r\n";
       }
      Get_Sort(int.Parse(dr["id"].ToString()));
    }
   dr.Close();
 }

protected string GetSortName(string sortid)
 {
   string Rv="";
   string sql="select sort_name from pa_sort where id="+int.Parse(sortid);
   OleDbCommand  myComm=new OleDbCommand(sql,conn);
   OleDbDataReader dr=myComm.ExecuteReader();
   if(dr.Read())
    {
      Rv="["+dr["sort_name"].ToString()+"]";
    }
   dr.Close();
   return Rv;
 }

protected void Bt_Click(Object sender,CommandEventArgs e)
 {
   string CName=e.CommandName;
   switch(CName)
    {
      case "Prev":
       if((int)ViewState["CurrentPage"]>0)
        {
          ViewState["CurrentPage"]=(int)ViewState["CurrentPage"]-1;
        }
      break;

     case "Next":
       if((int)ViewState["CurrentPage"]<(int)ViewState["PageCount"]-1)
        {
          ViewState["CurrentPage"]=(int)ViewState["CurrentPage"]+1;
        }
     break;
    }

  conn.Open();
   Data_Bind();
  conn.Close();

 }


protected void Page_Changed(Object sender,EventArgs e)
 {
  int CurrentPage=int.Parse(DLpage.SelectedItem.Value);
  ViewState["CurrentPage"]=CurrentPage;
  conn.Open();
   Data_Bind();
  conn.Close();
 }

protected string Get_Url(string LanmuId,string thetype,string LanmuDir,string ZdyUrl)
  {
    string RV;
    if(ZdyUrl!="")
     {
       RV=ZdyUrl;
     }
    else
     {
       if(Is_Static=="1")
       {
         RV=Url_Prefix+(LanmuDir==""?"":LanmuDir+"/");
       }
       else
        {
          if(thetype=="home")
           {
             RV=Url_Prefix+"index.aspx";
           }
         else
          {
            RV=Url_Prefix+"index.aspx?lanmuid="+LanmuId;
          }
        }
    }
    return RV;
  }

private void Get_Site(int sid)
 {
   string sql="select [directory],[domain],[html] from pa_site where id="+sid;
   OleDbCommand comm=new OleDbCommand(sql,conn);
   OleDbDataReader dr=comm.ExecuteReader();
   if(dr.Read())
    {
     SiteDir=dr["directory"].ToString();
     string TheDomain=dr["domain"].ToString();
     Is_Static=dr["html"].ToString();
     if(TheDomain!="")
      {
        Url_Prefix=TheDomain+"/";
      }
     else
      {
       if(SiteDir=="")
        {
         Url_Prefix="/";
        }
       else
        {
         Url_Prefix="/"+SiteDir+"/";
        }
      }

    }
   else
    {
     Is_Static="0";
     Url_Prefix="/";
     dr.Close();
     conn.Close();
     Response.Write("<"+"script language=javascript>alert('无效的siteid!');location.href=location.href</"+"script>");
     Response.End();
    }
   dr.Close();
 }

protected void Data_Bound(Object sender,RepeaterItemEventArgs e)
 { 
 if (e.Item.ItemType   ==   ListItemType.Item   ||   e.Item.ItemType   ==   ListItemType.AlternatingItem) 
    { 
   }
 }

private bool IsDate(string str)
 {
  //日期
  if(System.Text.RegularExpressions.Regex.IsMatch((str==null?"":str), @"^((((1[6-9]|[2-9]\d)\d{2})-(0?[13578]|1[02])-(0?[1-9]|[12]\d|3[01]))|(((1[6-9]|[2-9]\d)\d{2})-(0?[13456789]|1[012])-(0?[1-9]|[12]\d|30))|(((1[6-9]|[2-9]\d)\d{2})-0?2-(0?[1-9]|1\d|2[0-9]))|(((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))-0?2-29-))$"))
   {
     return true;
   }
  else
   {
    //日期+时间
    return System.Text.RegularExpressions.Regex.IsMatch((str==null?"":str), @"^(((((1[6-9]|[2-9]\d)\d{2})-(0?[13578]|1[02])-(0?[1-9]|[12]\d|3[01]))|(((1[6-9]|[2-9]\d)\d{2})-(0?[13456789]|1[012])-(0?[1-9]|[12]\d|30))|(((1[6-9]|[2-9]\d)\d{2})-0?2-(0?[1-9]|1\d|2[0-8]))|(((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))-0?2-29-)) (20|21|22|23|[0-1]?\d):[0-5]?\d:[0-5]?\d)$");
   }
 }

protected bool Get_Bool(string str)
 {
   if(str=="1") 
    { 
      return true;
    }
   else
    {
      return false;
    }
 }

private string Sql_Format(string str)
 {
  if(str=="" || str==null)
   {
    return "";
   }
   str=str.Replace("'","''");
   str=str.Replace("\"","\""); 
   str=str.Replace("_","[_]");
   str=str.Replace("%","[%]");
   return str;
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

private bool IsStr(string str)
 { 
   if(str==null || str=="")
    {
     return false;
    }
  string str1="0123456789abcdefghijklmnopqrstuvwxyz_";
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
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server"/> 
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=98% >
 <tr><td height=10></td></tr>
 <tr><td class=table_style1><b>专题列表</b></td></tr>
 <tr><td height=10 ></td></tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=98% >
 <tr>
<td valign=top align="left">

<form runat="server">
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top align="left">
<table border=0 cellpadding=0 cellspacing=0 width=98%  style="table-layout:fixed;" align=center>
<tr>
<td align="left" width="110px">
每页<asp:TextBox id="Tb_pagesize" style="width:30px" maxlength="10"  Runat="server"/>条记录
</td>
<td align="right">
<select name="siteid" id="siteid" style="display:<%=TheMaster=="admin"?"":"none"%>"  onchange="Go()"><%=Site_List%></select>

按日期
<input name="StartDate" id="StartDate" Maxlength="10" size="6"><a href="javascript:open_calendar('StartDate')"><img src=images/calendar_bnt.gif border=0 height=20 hspace=2 align=absbottom></a> 
到 
<input name="EndDate" id="EndDate" Maxlength="10" size="6"><a href="javascript:open_calendar('EndDate')"><img src=images/calendar_bnt.gif border=0 height=20 hspace=2 align=absbottom></a> 

搜索：<input text="text" id="s_keyword" style="width:80px" >
<input type="button" value="确定" class="button" onclick="Go()">
 </td>
 </tr>
</table>
<table border=0 cellpadding=2 cellspacing=0 width=98% align=center>
      <tr>
        <td  align="left">
            <table border=0 cellpadding=0 cellspacing=0 width=100% class=tablestyle style="table-layout:fixed;">
                <tr>
                  <td align=center width=75% class=white>专题</td>
                  <td align=center width=15% class=white height=20>提交时间</td>
                  <td align=center width=10% class=white height=20>发布人</td>
                </tr>
          <asp:Repeater id="P1" runat="server" OnItemDataBound="Data_Bound">         
             <ItemTemplate>
                 <tr>
                  <td align=left class="tdstyle"><input type="<%=Ismultiple=="1"?"checkbox":"radio"%>" id="CK" Name="CK" Value="<%#DataBinder.Eval(Container.DataItem,"id")%>"><input type="hidden" id="Title_<%#DataBinder.Eval(Container.DataItem,"id")%>" value="<%#Server.HtmlEncode(DataBinder.Eval(Container.DataItem,"name").ToString())%>"><a href="<%#Get_Url(DataBinder.Eval(Container.DataItem,"id").ToString(),DataBinder.Eval(Container.DataItem,"thetype").ToString(),DataBinder.Eval(Container.DataItem,"lanmu_dir").ToString(),DataBinder.Eval(Container.DataItem,"zdy_url").ToString())%>" target=_blank><%#Server.HtmlEncode(DataBinder.Eval(Container.DataItem,"name").ToString())%></a></td>
                  <td align=center class="tdstyle" title="<%#DataBinder.Eval(Container.DataItem,"thedate")%>"><%#DataBinder.Eval(Container.DataItem,"thedate","{0:yyyy-MM-dd}")%></td>
                  <td align=center class=tdstyle><a href='member_info.aspx?username=<%#DataBinder.Eval(Container.DataItem,"username")%>'><%#DataBinder.Eval(Container.DataItem,"username")%></a></td>
                </tr>
             </ItemTemplate>
          </asp:Repeater>
<tr>
<td colspan="3" class=tdstyle>
共<asp:Label id="Lblrecordcount"  Text=0 runat="server" />条记录 
&nbsp;当前页次: <asp:Label id="Lblcurrentpage"  runat="server" />/<asp:Label id="LblpageCount"  runat="server" />&nbsp;
<asp:Button  text="上一页"  id="LblPrev"  cssclass="button"  runat="server"  CommandName="Prev"   OnCommand="Bt_Click" />&nbsp;
<asp:Button  text="下一页"  id="LblNext"  cssclass="button"  runat="server"  CommandName="Next"   OnCommand="Bt_Click" />&nbsp;
转到:&nbsp;<asp:DropDownList id="DLpage" runat="server" AutoPostBack="true" OnSelectedIndexChanged="Page_Changed" /> 页&nbsp;

       </td>
    </tr>
   </table>

  </td>
  <tr>
 </table>
  </td>
  <tr>
 </table>
</form>
     </td>
    </tr>
 </table>
<div align="center" style="padding:10px">
<input type="button" class="button" value="确定" onclick="GetCheckItem()">&nbsp;&nbsp;
<input type="button" class="button" value="关闭" onclick="closewin()">
</div>
</center>
<script type="text/javascript">

 var obj_site=document.getElementById("siteid");
 var obj_type=document.getElementById("s_type");
 var obj_field=document.getElementById("s_field");
 var obj_order=document.getElementById("s_order");
 var obj_keyword=document.getElementById("s_keyword");
 var obj_pagesize=document.getElementById("Tb_pagesize");
 var obj_date1=document.getElementById("StartDate");
 var obj_date2=document.getElementById("EndDate");

 var Table="pa_zt";
 var name="专题列表";

 var multiple="<%=Ismultiple%>";
 var Sitetid="<%=SiteId%>";
 var Type="<%=Request.QueryString["type"]%>";
 var Field="<%=Request.QueryString["field"]%>";
 var Order="<%=Request.QueryString["order"]%>";
 var Keyword="<%=Request.QueryString["keyword"]%>";

 var StartDate="<%=Request.QueryString["startdate"]%>";
 var EndDate="<%=Request.QueryString["enddate"]%>";

 if(obj_site!=null && Sitetid!=""){obj_site.value=Sitetid;}
 if(obj_type!=null){obj_type.value=Type;}
 if(obj_field!=null && Field!=""){obj_field.value=Field;}
 if(obj_order!=null && Order!=""){obj_order.value=Order;}
 if(obj_keyword!=null){obj_keyword.value=Keyword;}
 if(obj_date1!=null){obj_date1.value=StartDate;}
 if(obj_date2!=null){obj_date2.value=EndDate;}


function Go()
  { 
   location.href="?multiple="+multiple+"&siteid="+obj_site.value+"&startdate="+escape(obj_date1.value)+"&enddate="+escape(obj_date2.value)+"&keyword="+escape(obj_keyword.value)+"&pagesize="+obj_pagesize.value+"&objid=<%=objId%>";
  }

var op_obj=parent.document.getElementById("zt_list");

function GetCheckItem()
 {
   var Ids=Get_Checked("CK");
   parent.load_ajaxdata("zt",Ids,"<%=objId%>");
   closewin();
 }


function closewin()
 {
  parent.CloseDialog();
 }

function Set_Disabled(ckvalue,objname)
 {
  var obj=document.getElementsByName(objname);
  var Ackvalue=ckvalue.split(',');
  for(i=0;i<Ackvalue.length;i++)
   {
     for(k=0;k<obj.length;k++)
      {
        if(obj[k].value==Ackvalue[i])
         {
          obj[k].disabled=true;
         }
      }
   }
}
var parentobj=parent.document.getElementById("<%=objId%>");
var parentids="";
for(i=0;i<parentobj.length;i++)
 {
   parentids+=parentobj[i].value+",";
 }
Set_Disabled(parentids,"CK");
</script>
</body>
</html>  




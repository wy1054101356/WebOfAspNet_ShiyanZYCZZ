<% @ Page Language="C#"%>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<% @ Import NameSpace="PageAdmin"%>
<script Language="c#" Runat="server">
  OleDbConnection conn;
  int Site_Id,PageSize,Is_Static,Is_Static_1;
  string Ismultiple,SiteDir,TheTable,List_Space,sql_str,order_str,Url_Prefix,Url_Prefix_1,TheMaster,Site_List,Table_List,Sort_List,ZtId;

  protected void Page_Load(Object src,EventArgs e)
   {
    Master_Valicate YZ=new Master_Valicate();
    YZ.Master_Check();
    TheMaster=YZ._UserName;
    TheTable=Request.QueryString["table"];
    ZtId=Request.QueryString["id"];
    if(string.IsNullOrEmpty(ZtId))
     {
       Response.End();
       return;
     }
    if(!IsStr(TheTable))
     {
      TheTable="";
     }
      if(IsNum(Request.QueryString["siteid"]))
       {
         Site_Id=int.Parse(Request.QueryString["siteid"]);
       }
      else
       {
         Site_Id=int.Parse(Request.Cookies["SiteId"].Value);
       }
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
         sql_str+=" and site_id="+Site_Id;
       }
      
      if(IsNum(ZtId))
      {
        sql_str+=" and zt_ids like '%,"+ZtId+",%'";
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
      if(Request.QueryString["keyword"]!=null && Request.QueryString["keyword"]!="")
        {
          sql_str+=" and title like '%"+Sql_Format(Request.QueryString["keyword"])+"%'";
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
        Get_Site();
        Get_Tables();
       if(TheTable!="")
       {
        Tongji();
        Data_Bind();
       }
     conn.Close();
     Tb_pagesize.Text=PageSize.ToString();
    }
   else
    {
      conn.Open();
       Get_Site();
       Get_Tables();
       Set(Request.Form["act"]);
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

//填充下页面下拉单
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
  //填充下页面下拉单

  int StartIndex=CurrentPage*PageSize;
  DataSet ds=new DataSet();
  OleDbDataAdapter myAdapter=new OleDbDataAdapter(sql,conn);//在数据库和DataSet之间建立桥接。
  myAdapter.Fill(ds,StartIndex,PageSize,"default");
  ds=Optimize_DataSet(ds);
  ds.Tables["default"].DefaultView.Sort=(string)ViewState["order_str"];
  P1.DataSource=ds.Tables["default"].DefaultView;
  P1.DataBind(); 
 }

private DataSet Optimize_DataSet(DataSet SourceDs)
 {
   int RCount=SourceDs.Tables["default"].Rows.Count;
   string Ids="0";
   if(RCount>0)
    {
      DataRow dtr;
      for(int i=0;i<RCount;i++)
       {
         dtr=SourceDs.Tables["default"].Rows[i];
         Ids+=","+dtr["id"].ToString();
       }
    }
   SourceDs.Clear();
   string sql="select id,title,thedate,username,site_id,static_dir,static_file,lanmu_id,sublanmu_id,zdy_url,permissions,html,checked,istg,sort_id from "+TheTable+" where iszt=1 and id in("+Ids+")";
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
   string sql="select id,sitename from pa_site order by xuhao";
   OleDbCommand comm=new OleDbCommand(sql,conn);
   OleDbDataReader dr=comm.ExecuteReader();
   while(dr.Read())
    {
     Site_List+="<option value='"+dr["id"].ToString()+"'>"+dr["sitename"].ToString()+"</option>\r\n";
    }
   dr.Close();

   Url_Prefix="/";
   Is_Static=0;
   sql="select [html],[directory],[domain],[html] from pa_site where id="+Site_Id;
   comm=new OleDbCommand(sql,conn);
   dr=comm.ExecuteReader();
   if(dr.Read())
    {
     Is_Static=int.Parse(dr["html"].ToString());
     string SiteDir=dr["directory"].ToString();
     string TheDomain=dr["domain"].ToString();
     if(TheDomain!="")
      {
        Url_Prefix="http://"+TheDomain.Replace("http://","")+"/";
      }
     if(SiteDir!="")
        {
          if(TheDomain=="")
           {
             Url_Prefix="/"+SiteDir+"/";
           }
          else
           {
             Url_Prefix+=SiteDir+"/";
           }
        }
    }
   dr.Close();

 }

private void Get_Tables()
 {
   string sql="select thetable,table_name from pa_table where inlanmu=1 order by xuhao";
   OleDbCommand comm=new OleDbCommand(sql,conn);
   OleDbDataReader dr=comm.ExecuteReader();
   while(dr.Read())
    {
     Table_List+="<option value='"+dr["thetable"].ToString()+"'>"+dr["table_name"].ToString()+"</option>\r\n";
    }
   dr.Close();
 }

private void Set(string Act)
 {
   if(Act=="")
    {
      return;
    }
   string Ids=Request.Form["ids"];
   if(Ids=="")
    {
      return;
    }
   string[] Aids=Ids.Split(',');
   string sql;
   OleDbCommand comm;
   OleDbDataReader dr;
   PageAdmin.Log log=new PageAdmin.Log();
   string IDS="";
   switch(Act)
    {
      case "delete":
       for(int i=0;i<Aids.Length;i++)
        {
          if(Aids[i]==""){continue;}
          sql="select zt_ids from "+TheTable+" where id="+Aids[i];
          comm=new OleDbCommand(sql,conn);
          dr=comm.ExecuteReader();
          if(dr.Read())
          {  
           IDS=dr["zt_ids"].ToString();
           if(IDS==","+ZtId+",")
            {
              sql="update "+TheTable+" set iszt=0,zt_ids='' where id="+Aids[i];
            }
           else
            {
              sql="update "+TheTable+" set zt_ids='"+IDS.Replace(","+ZtId+",",",")+"' where id="+Aids[i];
            }
           comm=new OleDbCommand(sql,conn);
           comm.ExecuteNonQuery();
          }
          dr.Close();
        }
      log.Save(int.Parse(Request.Cookies["SiteId"].Value),1,"delete",1,TheMaster,"移除专题信息");
      break;

      case "transfer":

      break;
    }
  conn.Close();

   conn.Open();
    Tongji();
    Data_Bind();
   conn.Close();
 }

private string GetSortName(string sortid)
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

string GetUserName(string str,string Istg)
 {
   if(str!="") 
    { 
      if(Istg=="0")
       {
         return "<a href='member_info.aspx?username="+Server.UrlEncode(str)+"'>"+str+"</a>";
       }
      else
       {
         return "<a href='member_info.aspx?username="+Server.UrlEncode(str)+"' title='会员投稿'>"+str+"</a>";
       }
    }
   else
    {
      return "<span title='匿名投稿'>匿名</span>";
    }
 }

private void Bt_Click(Object sender,CommandEventArgs e)
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


private void Page_Changed(Object sender,EventArgs e)
 {
  int CurrentPage=int.Parse(DLpage.SelectedItem.Value);
  ViewState["CurrentPage"]=CurrentPage;
  conn.Open();
   Data_Bind();
  conn.Close();
 }

private string DetailUrl(string SiteId,string Static_dir,string Static_file,string Lanmu_Id,string SubLanmu_Id,string Id,string ZdyUrl,string Permissions,string Checked,string Html)
 {
  string Rv;
  if(ZdyUrl!="")
   {
     Rv=ZdyUrl;
   }
  else
   {
    if(Site_Id==int.Parse(SiteId))
    {
     Url_Prefix_1=Url_Prefix;
     Is_Static_1=Is_Static;
    }
   else
    {
     Get_Site(int.Parse(SiteId));
    }
    if(Is_Static_1==1)
     {
       switch(Html)
        {
          case "2":
           if(Permissions=="" && Checked=="1")
            {Rv=Url_Prefix_1+(Static_dir==""?"":Static_dir+"/")+(Static_file==""?Id+".html":Static_file);}
           else
            {Rv=Url_Prefix_1+"index.aspx?lanmuid="+Lanmu_Id+"&sublanmuid="+SubLanmu_Id+"&id="+Id;}
          break;

          case "1":
            Rv=Url_Prefix_1+TheTable+"/detail_"+Id+".html";
          break;

          default:
           Rv=Url_Prefix_1+"index.aspx?lanmuid="+Lanmu_Id+"&sublanmuid="+SubLanmu_Id+"&id="+Id;
          break;
        }
     }
    else
     {
       Rv=Url_Prefix_1+"index.aspx?lanmuid="+Lanmu_Id+"&sublanmuid="+SubLanmu_Id+"&id="+Id;
     }
   }
  return Rv;
 }

private void Get_Site(int sid)
 {
   Url_Prefix_1="/";
   Is_Static_1=0;
   string sql="select [html],[directory],[domain],[html] from pa_site where id="+sid;
   OleDbCommand comm=new OleDbCommand(sql,conn);
   OleDbDataReader dr=comm.ExecuteReader();
   if(dr.Read())
    {
     Is_Static_1=int.Parse(dr["html"].ToString());
     string SiteDir=dr["directory"].ToString();
     string TheDomain=dr["domain"].ToString();
     if(TheDomain!="")
      {
        Url_Prefix_1="http://"+TheDomain.Replace("http://","")+"/";
      }
     if(SiteDir!="")
        {
          if(TheDomain=="")
           {
             Url_Prefix_1="/"+SiteDir+"/";
           }
          else
           {
             Url_Prefix_1+=SiteDir+"/";
           }
        }
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
<table  border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr><td height=10></td></tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=98% >
 <tr>
<td valign=top align="left">
<div id="tabdiv">
<ul>
<li id="tab" name="tab" style="font-weight:bold">专题信息</li>
<li id="tab" name="tab" onclick="location.href='zt_data_zh.aspx?id=<%=Request.QueryString["id"]%>&table=<%=Request.QueryString["table"]%>'">组合专题</li>
</ul>
</div>
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
<select name="siteid" id="siteid"  onchange="Go()">
<option value=0>选择站点</option>
<%=Site_List%>
</select>
<select name="thetable" id="thetable" onchange="Go()">
<option value="">选择数据来源</option>
<%=Table_List%>
</select>
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
            <table border=0 cellpadding=0 cellspacing=0 width=100% class=tablestyle style="table-layout:fixed;" id="tb_list">
                <tr>
                  <td align=center width=65% class=white>标题</td>
                  <td align=center width=15% class=white height=20>提交时间</td>
                  <td align=center width=10% class=white height=20>发布人</td>
                  <td align=center width=10% class=white height=20>移除</td>
                </tr>
          <asp:Repeater id="P1" runat="server" OnItemDataBound="Data_Bound">         
             <ItemTemplate>
                 <tr class="listitem">
                  <td align=left class="tdstyle"><input type="checkbox" id="CK" Name="CK" Value="<%#DataBinder.Eval(Container.DataItem,"id")%>"><%#GetSortName(DataBinder.Eval(Container.DataItem,"sort_id").ToString())%><a href='<%#DetailUrl(DataBinder.Eval(Container.DataItem,"site_id").ToString(),DataBinder.Eval(Container.DataItem,"static_dir").ToString(),DataBinder.Eval(Container.DataItem,"static_file").ToString(),DataBinder.Eval(Container.DataItem,"lanmu_id").ToString(),DataBinder.Eval(Container.DataItem,"sublanmu_id").ToString(),DataBinder.Eval(Container.DataItem,"id").ToString(),DataBinder.Eval(Container.DataItem,"zdy_url").ToString(),DataBinder.Eval(Container.DataItem,"permissions").ToString(),DataBinder.Eval(Container.DataItem,"checked").ToString(),DataBinder.Eval(Container.DataItem,"html").ToString())%>' target="dataview"><%#Server.HtmlEncode(DataBinder.Eval(Container.DataItem,"title").ToString())%></a></td>
                  <td align=center class="tdstyle" title="<%#DataBinder.Eval(Container.DataItem,"thedate")%>"><%#DataBinder.Eval(Container.DataItem,"thedate","{0:yyyy-MM-dd}")%></td>
                  <td align=center class=tdstyle><%#GetUserName(DataBinder.Eval(Container.DataItem,"username").ToString(),DataBinder.Eval(Container.DataItem,"istg").ToString())%></td>
                  <td align=center class=tdstyle><input type="button" class="button" value="移除" onclick="del(<%#DataBinder.Eval(Container.DataItem,"id")%>)"></td>
                </tr>
             </ItemTemplate>
          </asp:Repeater>
        <tr>
       </table>
<table border=0 width=100% class="tablestyle" align="center" style="margin-top:-1px">
<tr><td class="tdstyle" style="border-right:0px"> 
<input type="hidden" value="" name="ids" id="ids">
<input type="hidden" value="" name="act" id="act">
<input type="button" class="button" value="反选" onclick="CheckBox_Inverse('CK')"/>
<a href="javascript:set('delete')">[从本专题移除]</a>
</td>
<td class="tdstyle" style="border-left:0px" align=right>
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
<input type="button" class="button" value="关闭" onclick="closewin()">
</div>
</center>
<script type="text/javascript">
 MouseoverColor("tb_list");
 var obj_site=document.getElementById("siteid");
 var obj_thetable=document.getElementById("thetable");
 var obj_field=document.getElementById("s_field");
 var obj_order=document.getElementById("s_order");
 var obj_keyword=document.getElementById("s_keyword");
 var obj_pagesize=document.getElementById("Tb_pagesize");
 var obj_date1=document.getElementById("StartDate");
 var obj_date2=document.getElementById("EndDate");


 var multiple="<%=Ismultiple%>";
 var Sitetid="<%=Site_Id%>";
 var Table="<%=TheTable%>";
 var Field="<%=Request.QueryString["field"]%>";
 var Order="<%=Request.QueryString["order"]%>";
 var Keyword="<%=Request.QueryString["keyword"]%>";

 var StartDate="<%=Request.QueryString["startdate"]%>";
 var EndDate="<%=Request.QueryString["enddate"]%>";

 if(obj_site!=null && Sitetid!=""){obj_site.value=Sitetid;}
 if(obj_thetable!=null){obj_thetable.value=Table;}
 if(obj_field!=null && Field!=""){obj_field.value=Field;}
 if(obj_order!=null && Order!=""){obj_order.value=Order;}
 if(obj_keyword!=null){obj_keyword.value=Keyword;}
 if(obj_date1!=null){obj_date1.value=StartDate;}
 if(obj_date2!=null){obj_date2.value=EndDate;}


function Go()
  { 
   location.href="?id=<%=ZtId%>&table="+obj_thetable.value+"&siteid="+obj_site.value+"&startdate="+escape(obj_date1.value)+"&enddate="+escape(obj_date2.value)+"&keyword="+escape(obj_keyword.value)+"&pagesize="+obj_pagesize.value;
  }

function del(did)
 {
   if(confirm("是否确定从专题移除?"))
   {
     document.getElementById("ids").value=did;
     document.getElementById("act").value="delete";
     document.forms[0].submit();
   }
 }


function set(act)
 {
   var Ids=Get_Checked("CK");
   var A_Ids=Ids.split(",");
   if(Ids=="")
    {
      alert("请选择要操作的信息!");
      return;
    }
   switch(act)
    {
     case "delete":
     if(!confirm("是否确定从专题移除?"))
      {
        return;
      }
     break;

    case "pset":

    break;

    case "update":

    break;
    }

  document.getElementById("act").value=act;
  document.getElementById("ids").value=Ids;
  document.forms[0].submit();
 }

function closewin()
 {
  parent.CloseDialog();
 }
</script>
</body>
</html>  




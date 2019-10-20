<% @ Page Language="C#"%>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<% @ Import NameSpace="PageAdmin"%>
<script Language="c#" Runat="server">
  OleDbConnection conn;
  int SiteId,PageSize,List_Level;
  string DataSiteId,SourceSites,SiteList,Sort_Ids,Is_Static,TgTable,TheTable,ID,List_Space,sql_str,order_str,Url_Prefix,Sort_List,Query_Sql,Count_Sql,List_style;
  protected void Page_Load(Object src,EventArgs e)
   {
    Conn Myconn=new Conn();
    conn=Myconn.OleDbConn();//获取OleDbConnection
    TheTable=Request.QueryString["table"];
    TgTable=Request.QueryString["tgtable"];
    ID=Request.QueryString["field"];
    SourceSites=Request.QueryString["sourcesites"];
    if(IsNum(Request.QueryString["datasiteid"]))
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
   else
    {
     Response.Write("无效的SourceSites参数!");
     Response.End();
    }
    if(IsNum(Request.QueryString["siteid"]))
     {
      SiteId=int.Parse(Request.QueryString["siteid"]);
     }
    else
     {
      SiteId=0;
     }
    if(IsNum(Tb_pagesize.Text.Trim()))
     {
      PageSize=int.Parse(Tb_pagesize.Text.Trim());
     }
    else
     {
      PageSize=12;
     }
    if(!IsStr(TheTable) || !IsStr(TgTable) || !IsStr(ID) || SiteId==0)
     {
     Response.Write("无效的参数!");
     Response.End();
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
       Check_TG(SiteId,MCheck._MemberTypeId,MCheck._DepartmentId);//检查是否具有投稿权限
     }
    sql_str="";
    if(IsNum(Request.QueryString["sortid"]))
      {
          Sort_Ids=SortIds(int.Parse(Request.QueryString["sortid"]));
          if(IsNum(Sort_Ids))
           {
            sql_str+=" and sort_id="+Sort_Ids;
           }
         else
           {
            sql_str+=" and sort_id in ("+Sort_Ids+") ";
           }  
       }
      string order_str="thedate desc";
      if(!string.IsNullOrEmpty(Request.QueryString["order"]))
         {
           if(IsStr(Request.QueryString["order"].Replace(" ","")))
           {
             order_str=Request.QueryString["order"];
           }
         }
      else
         {
          order_str=Get_DefaultSort(TheTable);
         }
     if(Request.QueryString["keyword"]!=null && Request.QueryString["keyword"]!="")
       {
         sql_str+=" and title like '%"+Sql_Format(Request.QueryString["keyword"])+"%'";
       }
    Query_Sql="select site_id,sort_id,id,title,static_dir,static_file,lanmu_id,sublanmu_id,zdy_url,permissions,checked,[html],thedate from "+TheTable+" where site_id="+DataSiteId+" and checked=1 and source_id=0"+sql_str+" order by "+order_str;
    Count_Sql="select count(id) as co from "+TheTable+" where site_id="+DataSiteId+" and checked=1 and source_id=0"+sql_str;
    if(!Page.IsPostBack)
    {
      ViewState["CurrentPage"]=0;
      if(IsNum(Request.QueryString["pagesize"]))
       {
         PageSize=int.Parse(Request.QueryString["pagesize"]);
         Tb_pagesize.Text=PageSize.ToString();
       }
        Check_Table();
        Get_Site(SiteId);
        Get_Fields();
        Tongji();
        Data_Bind();
        Get_Site();
        Get_Sort(0);
     Tb_pagesize.Text=PageSize.ToString();
    }
   else
    {
       Check_Table();
       Get_Site();
       Get_Site(SiteId);
       Get_Sort(0);
    }
    conn.Close();
  }

private void Data_Bind()
 {
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
  OleDbDataAdapter myAdapter=new OleDbDataAdapter(Query_Sql,conn);//在数据库和DataSet之间建立桥接。
  myAdapter.Fill(ds,StartIndex,PageSize,"default");
  P1.DataSource=ds.Tables["default"].DefaultView;
  P1.DataBind();
 }

private void Tongji()
{
//计算总记录
 OleDbCommand myComm=new OleDbCommand(Count_Sql,conn);
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
  SiteList="";
  string sql="";
  if(IsNum(SourceSites))
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
   string sql="select id,sort_level,sort_name,final_sort from pa_sort where parent_id="+Parentid+" and site_id="+DataSiteId+" and thetable='"+TheTable+"' order by xuhao,id";
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
         Sort_List+="<option "+List_style+" value='"+dr["id"].ToString()+"'>"+List_Space+dr["sort_name"].ToString()+"</option>\r\n";
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

private void Get_Fields()
  {
    string TitleName="标题";
    string sql="select [field_name] from pa_field where thetable='"+TheTable+"' and field='title'";
    OleDbCommand comm=new OleDbCommand(sql,conn);
    OleDbDataReader dr=comm.ExecuteReader();
    if(dr.Read())
     {
       TitleName=dr["field_name"].ToString();
     }
    dr.Close();
   lb_title.Text=TitleName;
  }

private void Check_Table()
 {
   string sql="select id from pa_table where thetable='"+TheTable+"'";
   OleDbCommand comm=new OleDbCommand(sql,conn);
   OleDbDataReader dr=comm.ExecuteReader();
   if(!dr.Read())
    {
      dr.Close();
      conn.Close();
      Response.Write("无效的table参数!");
      Response.End();
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

private string SortIds(int SortId)
 {
     string Ids=SortId.ToString(); 
     string sql="select id from pa_sort where site_id="+DataSiteId+" and thetable='"+TheTable+"' and final_sort=1 and parent_ids like '%,"+SortId+",%'";
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
   Url_Prefix="/";
   string sql="select [directory],[domain],[html] from pa_site where id="+sid;
   OleDbCommand comm=new OleDbCommand(sql,conn);
   OleDbDataReader dr=comm.ExecuteReader();
   if(dr.Read())
    {
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
   else
    {
     Url_Prefix="/";
     dr.Close();
     conn.Close();
     Response.Write("无效的siteid!");
     Response.End();
    }
   dr.Close();
 }

private string DetailUrl(string Static_dir,string Static_file,string Lanmu_Id,string SubLanmu_Id,string Id,string ZdyUrl,string Permissions,string Checked,string Html)
 {
  string Rv;
  if(ZdyUrl!="")
   {
     Rv=ZdyUrl;
   }
  else
   {
    if(Is_Static=="1")
     {
       switch(Html)
        {
          case "2":
           if(Permissions=="" && Checked=="1")
            {Rv=Url_Prefix+(Static_dir==""?"":Static_dir+"/")+(Static_file==""?Id+".html":Static_file);}
           else
            {Rv=Url_Prefix+"index.aspx?lanmuid="+Lanmu_Id+"&sublanmuid="+SubLanmu_Id+"&id="+Id;}
          break;

          case "1":
            Rv=Url_Prefix+TheTable+"/detail_"+Id+".html";
          break;

          default:
            Rv=Url_Prefix+"index.aspx?lanmuid="+Lanmu_Id+"&sublanmuid="+SubLanmu_Id+"&id="+Id;
          break;
        }
     }
    else
     {
       Rv=Url_Prefix+"index.aspx?lanmuid="+Lanmu_Id+"&sublanmuid="+SubLanmu_Id+"&id="+Id;
     }
   }
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

private string Get_DefaultSort(string Table)
 {
   string rv="";
   string sql="select default_sort from pa_table where thetable='"+Table+"'";
   OleDbCommand comm=new OleDbCommand(sql,conn);
   OleDbDataReader dr=comm.ExecuteReader();
   if(dr.Read())
      {
        rv=dr["default_sort"].ToString();
      }
   dr.Close();
   if(rv==""){rv="actdate desc";}
   return rv;
 }

protected void Page_Changed(Object sender,EventArgs e)
 {
  int CurrentPage=int.Parse(DLpage.SelectedItem.Value);
  ViewState["CurrentPage"]=CurrentPage;
  conn.Open();
   Data_Bind();
  conn.Close();
 }


protected void Data_Bound(Object sender,RepeaterItemEventArgs e)
 { 
 if (e.Item.ItemType   ==   ListItemType.Item   ||   e.Item.ItemType   ==   ListItemType.AlternatingItem) 
    { 
   }
 }

protected string SubStr(string Title,int Title_Num,bool HtmlEncode) 
{ 
   if(Title_Num==0)
    {
      return "";
    }
   else
    {
       Regex regex = new Regex("[\u4e00-\u9fa5]+", RegexOptions.Compiled); 
       char[] stringChar = Title.ToCharArray(); 
       StringBuilder sb = new StringBuilder(); 
       int nLength = 0; 
      for(int i = 0; i < stringChar.Length; i++) 
       { 
          if (regex.IsMatch((stringChar[i]).ToString())) 
           { 
            nLength += 2; 
           } 
         else 
           { 
             nLength = nLength + 1; 
           } 
         if(nLength <= Title_Num) 
          { 
           sb.Append(stringChar[i]); 
          } 
        else 
         { 
          break; 
         } 
      } 

     if(sb.ToString() != Title) 
      { 
         sb.Append("..."); 
      } 

    if(HtmlEncode)
      {
        return Server.HtmlEncode(sb.ToString());
      }
    else
      {
        return sb.ToString(); 
      }  }
}



protected string Sql_Format(string str)
 {
    if(string.IsNullOrEmpty(str)){return string.Empty;}
    str=Server.UrlDecode(Server.UrlEncode(str).Replace("%00",""));
    str=str.Replace("'","''");
    str=str.Replace("\"","\"");
    str=str.Replace("[]","[[]]");
    str=str.Replace("[","[[]");
    str=str.Replace("]","[]]");
    str=str.Replace("_","[_]");
    str=str.Replace("%","[%]");
    str=str.Replace("^","[^]");
    return str;
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
.bt{border:1px solid #ccc;padding:0px 10px;height:20px;line-height:18px;cursor:pointer;margin:1px 0px;font-size:12px;background-color:#fff;color:#333}
.bt:hover{border-color:#FF9900;background-color:#FF9900;color:#fff}
</style>
</head>
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table border=0 cellpadding=0 cellspacing=0 width=99% >
 <tr>
<td valign=top align="left" style="padding:5px">
<form runat="server">
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top align="left">
<table border=0 cellpadding=0 cellspacing=0 width=98%  style="table-layout:fixed;" align=center>
<tr>
<td align="left" width="110px">
每页<asp:TextBox id="Tb_pagesize" style="width:30px" maxlength="12"  Runat="server"/>条记录
</td>
<td align="right">
选择站点：<select name="SiteId" onchange="c_site(this.value)"><%=SiteList%></select>
<select  name="sortid" id="sortid" onchange="Go()"><option value="">所有类别</option><%=Sort_List%><option value="0" style="color:#ff0000">未分类信息</option></select>
<select id="s_order" onchange="Go()">
<option value="thedate desc">按发布时间↓</option>
<option value="thedate asc">按发布时间↑</option>
<option value="id desc">按ID↓</option>
<option value="id asc">按ID↑</option>
<option value="clicks desc">按点击次数↓</option>
<option value="clicks asc">按点击次数↑</option>
<option value="comments desc">按评论次数↓</option>
<option value="comments asc">按评论次数↑</option>
<option value="downloads desc">按下载次数↓</option>
<option value="downloads asc">按下载次数↑</option>
</select>
搜索：<input text="text" id="s_keyword" style="width:80px" >
<input type="button" value="确定"   onclick="Go()" class="bt">
 </td>
 </tr>
</table>
<table border=0 cellpadding=2 cellspacing=0 width=98% align=center>
      <tr>
        <td align="left">
            <table border=0 cellpadding=0 cellspacing=0 width=100% class="tablestyle" id="tb_datalist">
                <tr class="header">
                  <td noWrap><input type="checkbox" onclick="CheckBox_Inverse('CK')" title="反选"/></td>
                  <td noWrap style="width:99%"><asp:Label id="lb_title" runat="server"/></td>
                </tr>
          <asp:Repeater id="P1" runat="server" OnItemDataBound="Data_Bound">         
             <ItemTemplate>
                 <tr class="listitem">
                   <td noWrap class="tdstyle" style="width:10px"><input type="<%=Request.QueryString["multiple"]=="1"?"checkbox":"radio"%>" id="CK" Name="CK" Value="<%#DataBinder.Eval(Container.DataItem,"id")%>"></td>
                  <td noWrap class="tdstyle"><input type="hidden" id="Title_<%#DataBinder.Eval(Container.DataItem,"id")%>"  value="<%#Server.HtmlEncode(DataBinder.Eval(Container.DataItem,"title").ToString())%>"><%#GetSortName(DataBinder.Eval(Container.DataItem,"sort_id").ToString())%><a href='<%#DetailUrl(DataBinder.Eval(Container.DataItem,"static_dir").ToString(),DataBinder.Eval(Container.DataItem,"static_file").ToString(),DataBinder.Eval(Container.DataItem,"lanmu_id").ToString(),DataBinder.Eval(Container.DataItem,"subLanmu_id").ToString(),DataBinder.Eval(Container.DataItem,"id").ToString(),DataBinder.Eval(Container.DataItem,"zdy_url").ToString(),DataBinder.Eval(Container.DataItem,"permissions").ToString(),DataBinder.Eval(Container.DataItem,"checked").ToString(),DataBinder.Eval(Container.DataItem,"html").ToString())%>' target="_blank"><%#SubStr(DataBinder.Eval(Container.DataItem,"title").ToString(),50,true)%></a></td>
                </tr>
             </ItemTemplate>
          </asp:Repeater>
<tr>
<td colspan="3" class=tdstyle>

共<asp:Label id="Lblrecordcount"  Text=0 runat="server" />条记录 
&nbsp;当前页次: <asp:Label id="Lblcurrentpage"  runat="server" />/<asp:Label id="LblpageCount"  runat="server" />&nbsp;
<asp:Button  text="上一页"  id="LblPrev" cssclass="bt"  runat="server"  CommandName="Prev"  OnCommand="Bt_Click" />&nbsp;
<asp:Button  text="下一页"  id="LblNext" cssclass="bt"  runat="server"  CommandName="Next"  OnCommand="Bt_Click" />&nbsp;
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
<div align="center" style="padding:2px">

<input type="button" value="确定" onclick="Get_Select()"/>

<input type="button"  value="取消" onclick="parent.CloseDialog()">
</div>
</center>
<script type="text/javascript">
 var obj_sort=document.getElementById("sortid");
 var obj_order=document.getElementById("s_order");
 var obj_keyword=document.getElementById("s_keyword");
 var obj_pagesize=document.getElementById("Tb_pagesize");
 var obj_order=document.getElementById("s_order");

 var Sortid="<%=Request.QueryString["sortid"]%>";
 var Keyword="<%=Request.QueryString["Keyword"]%>";
 var Order="<%=Request.QueryString["order"]%>";
 if(obj_sort!=null && Sortid!=""){obj_sort.value=Sortid;}
 if(obj_order!=null && Order!=""){obj_order.value=Order;}
 if(obj_keyword!=null){obj_keyword.value=Keyword;}

 function Go()
  { 
   location.href="?datasiteid=<%=DataSiteId%>&siteid=<%=SiteId%>&sourcesites=<%=Request.QueryString["sourcesites"]%>&tgtable=<%=TgTable%>&table=<%=Request.QueryString["table"]%>&field=<%=Request.QueryString["field"]%>&multiple=<%=Request.QueryString["multiple"]%>&autoclose=<%=Request.QueryString["autoclose"]%>&from=<%=Request.QueryString["from"]%>&sortid="+obj_sort.value+"&order="+obj_order.value+"&keyword="+escape(obj_keyword.value)+"&pagesize="+obj_pagesize.value;
  }

function c_site(sid)
 {
   location.href="?datasiteid="+sid+"&siteid=<%=SiteId%>&sourcesites=<%=Request.QueryString["sourcesites"]%>&tgtable=<%=TgTable%>&table=<%=Request.QueryString["table"]%>&field=<%=Request.QueryString["field"]%>&multiple=<%=Request.QueryString["multiple"]%>&autoclose=<%=Request.QueryString["autoclose"]%>&from=<%=Request.QueryString["from"]%>";
 }
var multiple="<%=Request.QueryString["multiple"]%>";
if(multiple!="1"){multiple=="0"}

function Get_Select()
 {
  var Ids=Get_Checked("CK");
  var txt;
  if(Ids=="")
   {
    <%if(Request.QueryString["autoclose"]=="true"){%>
      parent.CloseDialog();
    <%}%>
     return;
   }
  var AIds=Ids.split(',');
  var obj=parent.document.getElementById("<%=ID%>");
 if(obj==null){return;}
 if(obj.nodeName.toLowerCase()!="select"){alert("此功能只对select标签有效!");return;}
 if(multiple=="0")//单选择则清空所有数据
  {
   clear_select(obj);
  }
 parent.load_ajaxdata("<%=TheTable%>",Ids,"<%=ID%>");
 <%if(Request.QueryString["autoclose"]=="true"){%>
    parent.CloseDialog();
 <%}%>
 }

function CheckRepeat(op_obj,id)
 {
   for(i=0;i<op_obj.length;i++)
     {
       if(op_obj[i].value==id)
        {
          return true;
        }
     }
  return false;
 }

function Get_Checked(Name) //获取checkbox或radio组信息
 {
   var Obj=document.getElementsByName(Name);
   var ID="";
   for(i=0;i<Obj.length;i++)
     {
      if(Obj[i].checked)
       {
         ID+=","+Obj[i].value;
       }
     }
   return ID.replace(",","");
 }

function select_ck(id)
{
   var Obj=document.getElementsByName("CK");
   for(i=0;i<Obj.length;i++)
     {
      if(Obj[i].value==id)
       {
           if(Obj[i].checked)
            {
              Obj[i].checked=false;
            }
           else
            {
              Obj[i].checked=true;
            }
       }
      else
       {
        continue;
       }
     }

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

function CheckBox_Inverse(Name) //反选checkbox
 {
   var Obj=document.getElementsByName(Name);
   for(i=0;i<Obj.length;i++)
     {
      if(Obj[i].disabled){continue;}
      if(Obj[i].checked)
       {
          Obj[i].checked=false;
       }
      else
       {
          Obj[i].checked=true;
       }
     }
 }

function MouseoverColor(id)
{
 var trs=document.getElementById(id).getElementsByTagName("tr");
 for(var i=0 ;i<trs.length;i++)
  {
   if(trs[i].className.indexOf("listitem")>=0)
   {
   trs[i].onmouseover=function(){this.className+=" overcolor";}
   trs[i].onmouseout=function(){this.className=this.className.replace(" overcolor","")}
   }
  }
}
MouseoverColor("tb_datalist");

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
var parentobj=parent.document.getElementById("<%=ID%>");
var parentids="";
for(i=0;i<parentobj.length;i++)
 {
   parentids+=parentobj[i].value+",";
 }
Set_Disabled(parentids,"CK");
</script>
</body>
</html>
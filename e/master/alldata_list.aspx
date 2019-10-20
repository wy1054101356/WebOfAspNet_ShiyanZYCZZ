<% @ Page Language="C#"%>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<% @ Import NameSpace="PageAdmin"%>
<script Language="c#" Runat="server">
  OleDbConnection conn;
  int Site_Id,PageSize,List_Level,Is_Static;
  string SiteName,TheTable,TableName,TableType,TableId,AllData_Fields,List_Space,sql_str,order_str,Url_Prefix,Url_Prefix_1,TheMaster,Sort_List,List_style,sql;
  protected void Page_Load(Object src,EventArgs e)
   {
    Master_Valicate YZ=new Master_Valicate();
    YZ.Master_Check();
    TheMaster=YZ._UserName;
    TheTable=Request.QueryString["table"];
    if(!IsStr(TheTable))
     {
      TheTable="article";
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
      conn.Open();
      sql_str="";
      sql_str+=" and site_id="+Site_Id;
      if(IsNum(Request.QueryString["sortid"]))
       {
         if(Request.QueryString["sortid"]=="0")
          {
           sql_str+=" and sort_id=0 ";
          }
         else
          {
            string Sort_Ids=SortIds(int.Parse(Request.QueryString["sortid"]));
            if(IsNum(Sort_Ids))
             {
              sql_str+=" and sort_id="+Sort_Ids+" ";
             }
            else
             {
              sql_str+=" and  sort_id in ("+Sort_Ids+") ";
             }  
           }
       }
    if(IsStr(Request.QueryString["from"]))
       {
          switch(Request.QueryString["from"])
           {
             case "master":
                sql_str+=" and istg=0";
             break;

             case "member":
               sql_str+=" and istg=1 and username<>''";
             break;

             case "guest":
               sql_str+=" and istg=1 and username=''";
             break;

           }
       }

      if(IsStr(Request.QueryString["type"]))
       {
          switch(Request.QueryString["type"])
           {
             case "unchecked":
                sql_str+=" and checked=0";
             break;

             case "haschecked":
                sql_str+=" and checked=1";
             break;

             case "noreply":
                sql_str+=" and reply_state=0";
             break;

             case "hasreply":
                sql_str+=" and reply_state>=1";
             break;

             case "istop":
                sql_str+=" and istop=1";
             break;
             case "isgood":
                sql_str+=" and isgood=1";
             break;
             case "isnew":
                sql_str+=" and isnew=1";
             break;

             case "ishot":
                sql_str+=" and ishot=1";
             break;

            case "istg":
                sql_str+=" and istg=1";
             break;

           }
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
      if(Request.QueryString["keyword"]!=null && Request.QueryString["keyword"]!="" && Request.QueryString["field"]!=null && Request.QueryString["field"]!="")
        {
          sql_str+=" and "+Request.QueryString["field"]+" like '%"+Sql_Format(Request.QueryString["keyword"])+"%'";
        }
       ViewState["sql_str"]=sql_str;
       order_str="id desc"; 
       if(Request.QueryString["order"]!=null && Request.QueryString["order"]!="")
       {
         order_str=Sql_Format(Request.QueryString["order"]);
        }
      else
        {
          order_str=Get_DefaultSort(TheTable);
        }

      ViewState["order_str"]=order_str;
      ViewState["Calculatesql"]="select count(id) as co from "+TheTable+" where source_id=0 "+sql_str;
      ViewState["sql"]="select id from "+TheTable+" where source_id=0 "+sql_str+"  order by "+order_str;
        Get_Table();
        Get_Site();
        Get_Sort(0);
        Tongji();
        Data_Bind();
     Tb_pagesize.Text=PageSize.ToString();
    }
   else
    {
      conn.Open();
       Get_Table();
       Get_Site();
       Get_Sort(0);
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
   sql="select id,sort_id,title,actdate,checked,[html],static_dir,static_file,lanmu_id,sublanmu_id,zdy_url,permissions,titlepic,istop,isgood,isnew,ishot,username,istg,clicks,thedate,reply_state,iscg from "+TheTable+" where id in("+Ids+")";
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

private string SortIds(int SortId)
 {
     string Ids=SortId.ToString(); 
     string sql="select id from pa_sort where site_id="+Site_Id+" and thetable='"+TheTable+"' and final_sort=1 and parent_ids like '%,"+SortId+",%'";
     OleDbCommand comm=new OleDbCommand(sql,conn);
     OleDbDataReader dr=comm.ExecuteReader();
     while(dr.Read())
      {
        Ids+=","+dr["id"].ToString();
      }
    dr.Close();
    return Ids;
 }


private void Get_Table()
 {
   string sql="select id,table_name,alldata_fields,thetype from pa_table where thetable='"+TheTable+"'";
   OleDbCommand comm=new OleDbCommand(sql,conn);
   OleDbDataReader dr=comm.ExecuteReader();
   if(dr.Read())
    {
     TableType=dr["thetype"].ToString();
     TableName=dr["table_name"].ToString();
     TableId=dr["id"].ToString();
     AllData_Fields=dr["alldata_fields"].ToString();
    }
   else
    {
      Response.Write("参数错误");
      Response.End();
    }
   dr.Close();
 }

private void Get_Site()
 {
   OleDbCommand comm;
   OleDbDataReader dr;
   Url_Prefix="/";
   Is_Static=0;
   sql="select [sitename],[html],[directory],[domain],[html] from pa_site where id="+Site_Id;
   comm=new OleDbCommand(sql,conn);
   dr=comm.ExecuteReader();
   if(dr.Read())
    {
     SiteName=dr["sitename"].ToString();
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
   else
    {
      Response.Write("参数错误");
      Response.End();
    }
   dr.Close();
 }

private void Get_Sort(int Parentid)
 {
   string sql="select id,sort_level,sort_name,final_sort from pa_sort where parent_id="+Parentid+" and thetable='"+TheTable+"' and site_id="+Site_Id+" order by xuhao";
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
        Get_Sort(int.Parse(dr["id"].ToString()));
       }
    }
   dr.Close();
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

private void Set(string Act)
 {
   if(Act=="")
    {
      return;
    }
   string Ids=Request.Form["ids"];
   string[] Aids=Ids.Split(',');
   string sql;
   OleDbCommand comm;
   OleDbDataReader dr;
   PageAdmin.Log log=new PageAdmin.Log();
   string IDS="";
   string fields=Request.Form["fields"];
   switch(Act)
    {
      case "add":
      if(Ids=="")
       {
        return;
       }
       if(string.IsNullOrEmpty(fields))
        {
         fields="[title],[zdy_description],[content]";
        }
       for(int i=0;i<Aids.Length;i++)
        {
          if(Aids[i]==""){continue;}
          sql="select id from pa_alldata where thetable='"+TheTable+"' and detail_id="+Aids[i];
          comm=new OleDbCommand(sql,conn);
          dr=comm.ExecuteReader();
          if(dr.Read())
          {  
           sql="delete from pa_alldata where thetable='"+TheTable+"' and detail_id="+Aids[i];
           comm=new OleDbCommand(sql,conn);
           comm.ExecuteNonQuery();
          }
          dr.Close();

          sql="insert into pa_alldata([site_id],[thetable],[detail_id],[checked],[username],[clicks],[titlepic],[thedate],[actdate],[title],[introduction],[content]) select [site_id],'"+TheTable+"',"+Aids[i]+",[checked],[username],[clicks],[titlepic],[thedate],[actdate],"+fields+" from "+TheTable+" where id="+Aids[i];
          comm=new OleDbCommand(sql,conn);
          comm.ExecuteNonQuery();
        }
       log.Save(int.Parse(Request.Cookies["SiteId"].Value),1,"add",1,TheMaster,"添加全站搜索数据(数据源："+TableName+")");
      break;

      case "del":
       if(Ids=="")
       {
         return;
       }
       for(int i=0;i<Aids.Length;i++)
        {
          if(Aids[i]==""){continue;}
          sql="delete from pa_alldata where thetable='"+TheTable+"' and detail_id="+Aids[i];
          comm=new OleDbCommand(sql,conn);
          comm.ExecuteNonQuery();
        }
      log.Save(int.Parse(Request.Cookies["SiteId"].Value),1,"delete",1,TheMaster,"移除全站搜索数据(数据源："+TableName+")");
      break;

      case "load":
          int detailid=0;
          sql="select id from "+TheTable+" where source_id=0 "+(string)ViewState["sql_str"];
          comm=new OleDbCommand(sql,conn);
          dr=comm.ExecuteReader();
          while(dr.Read())
          {  
           detailid=int.Parse(dr["id"].ToString());
           sql="delete from pa_alldata where  thetable='"+TheTable+"' and detail_id="+detailid;
           comm=new OleDbCommand(sql,conn);
           comm.ExecuteNonQuery();

           sql="insert into pa_alldata([site_id],[thetable],[detail_id],[checked],[username],[clicks],[titlepic],[thedate],[actdate],[title],[introduction],[content]) select [site_id],'"+TheTable+"',"+detailid+",[checked],[username],[clicks],[titlepic],[thedate],[actdate],"+fields+" from "+TheTable+" where id="+detailid;
          comm=new OleDbCommand(sql,conn);
           comm.ExecuteNonQuery();
          }
          dr.Close();
       log.Save(int.Parse(Request.Cookies["SiteId"].Value),1,"add",1,TheMaster,"一键加入全站搜索数据(数据源："+TableName+")");
      break;

      case "clear":
       sql="delete from pa_alldata where site_id="+Site_Id+" and thetable='"+TheTable+"'";
       comm=new OleDbCommand(sql,conn);
       comm.ExecuteNonQuery();
       log.Save(int.Parse(Request.Cookies["SiteId"].Value),1,"delete",1,TheMaster,"清空全站搜索数据(数据源："+TableName+")");
      break;

    }
  conn.Close();

   conn.Open();
    Tongji();
    Data_Bind();
   conn.Close();
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

private string DetailUrl(string Static_dir,string Static_file,string Lanmu_Id,string SubLanmu_Id,string Id,string ZdyUrl,string Permissions,string Checked,string Html)
 {
  string Rv;
  if(ZdyUrl!="")
   {
     Rv=ZdyUrl;
   }
  else if(SubLanmu_Id=="0")
   {
    Rv="";
   }
  else
   {
    if(Is_Static==1)
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
  if(Rv!="")
   {
      Rv="href='"+Rv+"'";
   }
  return Rv;
 }


private bool Get_Bool(string str)
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


private string Get_Exists(string detail_id)
 {
   string rv="x.gif";
   string sql="select id from pa_alldata where thetable='"+TheTable+"' and detail_id="+detail_id;
   OleDbCommand comm=new OleDbCommand(sql,conn);
   OleDbDataReader dr=comm.ExecuteReader();
   if(dr.Read())
    {
     rv="g.gif";
    }
   dr.Close();
   return rv;
 }

 void Data_Bound(Object sender,RepeaterItemEventArgs e)
 { 
 if (e.Item.ItemType   ==   ListItemType.Item   ||   e.Item.ItemType   ==   ListItemType.AlternatingItem) 
    { 
     Literal lt=(Literal)e.Item.FindControl("iconsrc");
     lt.Text=Get_Exists(((Label)e.Item.FindControl("lbid")).Text);
    }
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

private string Get_CheckState(string thechecked)
 {
    switch(thechecked)
     {
      case "1":
        return "已审核";
      break;

     default:
        return "<span style='color:#ff0000'>待审核</span>";
      break;
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
        sb.Append(""); 
      } 
    if(HtmlEncode)
      {
        return Server.HtmlEncode(sb.ToString());
      }
    else
      {
        return sb.ToString(); 
      }

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

private string Sql_Format(string str)
 {
   if(string.IsNullOrEmpty(str)){return "";}
   str=str.Replace("'","''");
   return str;
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
<aspcn:uc_head runat="server" Type="data_list"/> 
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=98% >
 <tr><td height=10></td></tr>
 <tr>
  <td align=left class=table_style1 height=22px><a href="javascript:location.reload()" title="点击刷新">数据源：<%=SiteName%> &gt; <%=TableName%>(<%=TheTable%>)</a></td>
 </tr>
 <tr><td height=10></td></tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=98% >
 <tr>
<td valign=top align="left">
<form runat="server">
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top align="left">
<table border=0 cellpadding=0 cellspacing=0 width=98% align=center>
<tr>
<td align="left" width="110px" nowrap>
每页<asp:TextBox id="Tb_pagesize" style="width:30px" maxlength="10"  Runat="server"/>条记录
</td>
<td align="right" nowrap>
<select name="sortid" id="sortid" onchange="Go()">
<option value="">选择信息分类</option>
<%=Sort_List%>
</select>
<select id="s_from" onchange="Go()">
<option value="">所有来源</option>
<option value="master">后台发布</option>
<option value="member">会员投稿</option>
<option value="guest">匿名投稿</option>
</select>

<select id="s_type" onchange="Go()">
<option value="">所有属性</option>
<option value="haschecked">已审核</option>
<option value="unchecked">未审核</option>
<%if(TableType=="feedback"){%><option value="hasreply">已回复</option>
<option value="noreply">未回复</option><%}%>
<option value="istop">置顶</option>
<option value="isgood">推荐</option>
<option value="isnew">最新</option>
<option value="ishot">热门</option>
</select>

按日期
<input name="StartDate" id="StartDate" Maxlength="10" size="6"><a href="javascript:open_calendar('StartDate')"><img src=images/calendar_bnt.gif border=0 height=20 hspace=2 align=absbottom></a> 
到 
<input name="EndDate" id="EndDate" Maxlength="10" size="6"><a href="javascript:open_calendar('EndDate')"><img src=images/calendar_bnt.gif border=0 height=20 hspace=2 align=absbottom></a> 
搜索：<select name="s_field" id="s_field">
<option value="title">按标题</option>
<option value="content">按内容</option>
<option value="username">按发布人</option>
<option value="code">按信息编号</option>
<option value="ip">按ip</option>
</select>
<input text="text" id="s_keyword" style="width:80px" >
<input type="button" value="确定" class="button" onclick="Go()">
 </td>
 </tr>
</table>
<table border=0 cellpadding=2 cellspacing=0 width=98% align=center>
      <tr>
        <td  align="left">
            <table border=0 cellpadding=0 cellspacing=0 width=100% class="tablestyle tb_datalist" id="tb_datalist">
                <tr class="header">
                  <td nowrap style="width:10px">选择</td>
                  <td nowrap>标题</td>
                  <td nowrap>提交时间</td>
                  <td nowrap>发布人</td>
                  <td nowrap>状态</td>
                  <td nowrap>已加入全站搜索</td>
                </tr>
          <asp:Repeater id="P1" runat="server" OnItemDataBound="Data_Bound">         
             <ItemTemplate>
                 <tr class="listitem">
                  <td nowrap style="width:10px"><input type="checkbox" id="CK" Name="CK" Value="<%#DataBinder.Eval(Container.DataItem,"id")%>"></td>
                  <td nowrap><%#GetSortName(DataBinder.Eval(Container.DataItem,"sort_id").ToString())%><a <%#DetailUrl(DataBinder.Eval(Container.DataItem,"static_dir").ToString(),DataBinder.Eval(Container.DataItem,"static_file").ToString(),DataBinder.Eval(Container.DataItem,"lanmu_id").ToString(),DataBinder.Eval(Container.DataItem,"subLanmu_id").ToString(),DataBinder.Eval(Container.DataItem,"id").ToString(),DataBinder.Eval(Container.DataItem,"zdy_url").ToString(),DataBinder.Eval(Container.DataItem,"permissions").ToString(),DataBinder.Eval(Container.DataItem,"checked").ToString(),DataBinder.Eval(Container.DataItem,"html").ToString())%> target="_blank"><%#SubStr(DataBinder.Eval(Container.DataItem,"title").ToString(),50,true)%></a><img src="images/image.gif" height="20px" align="absmiddle" title="带标题图片" style="display:<%#(DataBinder.Eval(Container.DataItem,"titlepic").ToString())==""?"none":""%>"><asp:Label ForeColor="#ff0000" text="[顶]"  visible='<%#Get_Bool(DataBinder.Eval(Container.DataItem,"istop").ToString())%>' runat="server" Title='<%#"置顶结束日期："+(DataBinder.Eval(Container.DataItem,"actdate")).ToString()%>' /><asp:Label ForeColor="#ff0000" text="[荐]"  visible='<%#Get_Bool(DataBinder.Eval(Container.DataItem,"isgood").ToString())%>' runat="server" title="推荐信息"/><asp:Label ForeColor="#ff0000" text="[新]"  visible='<%#Get_Bool(DataBinder.Eval(Container.DataItem,"isnew").ToString())%>' runat="server" title="设为最新的信息"/><asp:Label ForeColor="#ff0000" text="[热]"  visible='<%#Get_Bool(DataBinder.Eval(Container.DataItem,"ishot").ToString())%>' runat="server" title="热门信息"/><asp:Label id="lb_sign" runat="server" /></td>
                  <td  align=center nowrap title="<%#DataBinder.Eval(Container.DataItem,"thedate")%>"><%#DataBinder.Eval(Container.DataItem,"thedate","{0:yyyy-MM-dd}")%></td>
                  <td align=center nowrap><%#GetUserName(DataBinder.Eval(Container.DataItem,"username").ToString(),DataBinder.Eval(Container.DataItem,"istg").ToString())%></td>
                  <td align=center nowrap><%#Get_CheckState(DataBinder.Eval(Container.DataItem,"checked").ToString())%></td>
                  <td align=center nowrap title="√表示已经加入，×表示未加入"><img src='/e/images/public/<asp:Literal id="iconsrc" runat="server" />' border=0><asp:Label id="lbid" runat="server" text='<%#DataBinder.Eval(Container.DataItem,"id")%>' visible="false"/></td>
                </tr>
             </ItemTemplate>
          </asp:Repeater>
        <tr>
       </table>
<table border=0 width=100% class="tablestyle" align="center" style="margin-top:-1px">
<tr><td class="tdstyle" style="border-right:0px"> 
<input type="hidden" value="" name="ids" id="ids">
<input type="hidden" value="" name="act" id="act">
<input type="hidden" value="<%=AllData_Fields%>" name="fields" id="fields">
<input type="button" class="button" value="反选" onclick="CheckBox_Inverse('CK')"/>
[<a href="javascript:set('add')" title="把选中信息加入到全站搜索，如果存在则更新">选中信息加入全站搜索</a>]
[<a href="javascript:set('del')" title="把选中信息从全站搜索中删除">选中信息移除全站搜索</a>]
[<a href="javascript:set('load')" title="把列出的所有信息全部加入到全站搜索，如果数据量巨大请分批次选中加入">一键导入</a>]
[<a href="javascript:set('clear')" title="从全站搜索中删除所有来源于“<%=SiteName%> > <%=TableName%>”的信息">一键清空</a>]
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
<input type="button" class="button" value="关闭" onclick="parent.CloseDialog()">
</div>
</center>
<script type="text/javascript">
 MouseoverColor("tb_datalist");
 var obj_sort=document.getElementById("sortid");
 var obj_from=document.getElementById("s_from");
 var obj_type=document.getElementById("s_type");
 var obj_field=document.getElementById("s_field");
 var obj_order=document.getElementById("s_order");
 var obj_keyword=document.getElementById("s_keyword");
 var obj_pagesize=document.getElementById("Tb_pagesize");
 var obj_date1=document.getElementById("StartDate");
 var obj_date2=document.getElementById("EndDate");

 var Sortid="<%=Request.QueryString["sortid"]%>";
 var From="<%=Request.QueryString["from"]%>";
 var Type="<%=Request.QueryString["type"]%>";
 var Field="<%=Request.QueryString["field"]%>";
 var Order="<%=Request.QueryString["order"]%>";
 var Keyword="<%=Request.QueryString["keyword"]%>";

 var StartDate="<%=Request.QueryString["startdate"]%>";
 var EndDate="<%=Request.QueryString["enddate"]%>";

 if(obj_sort!=null){obj_sort.value=Sortid;}
 if(obj_from!=null){obj_from.value=From;}
 if(obj_type!=null){obj_type.value=Type;}
 if(obj_field!=null && Field!=""){obj_field.value=Field;}
 if(obj_order!=null && Order!=""){obj_order.value=Order;}
 if(obj_keyword!=null){obj_keyword.value=Keyword;}
 if(obj_date1!=null){obj_date1.value=StartDate;}
 if(obj_date2!=null){obj_date2.value=EndDate;}

function Go()
  { 
   location.href="?table=<%=TheTable%>&siteid=<%=Site_Id%>&from="+obj_from.value+"&type="+obj_type.value+"&sortid="+obj_sort.value+"&startdate="+escape(obj_date1.value)+"&enddate="+escape(obj_date2.value)+"&field="+obj_field.value+"&keyword="+escape(obj_keyword.value)+"&pagesize="+obj_pagesize.value;
  }

function add(did)
 {
   if(confirm("是否确定加入到全站搜索表中?"))
   {
     document.getElementById("ids").value=did;
     document.getElementById("act").value="add";
     document.forms[0].submit();
   }
 }


function set(act)
 {

   var fields=document.getElementById("fields").value;
   if(fields=="" || fields.split(",").length!=3)
     {
       alert("请先设置全站搜索导入字段!");
       location.href="table_add.aspx?act=edit&id=<%=TableId%>";
       return;
      }
   if(act=="clear")
    {
     if(!confirm("此操作将从全站搜索中删除所有来源于“<%=SiteName%> > <%=TableName%>”的信息，是否确定?"))
      {
        return;
      }
      document.getElementById("act").value=act;
      document.forms[0].submit();
      return;
    }
   else if(act=="load")
    {
     if(!confirm("此操作将把当前列出的所有信息加入到全站搜索，如果数据量巨大请分批次选中加入，是否继续?"))
      {
        return;
      }
      document.getElementById("act").value=act;
      document.forms[0].submit();
      return;
    }
   var Ids=Get_Checked("CK");
   var A_Ids=Ids.split(",");
   if(Ids=="")
    {
      alert("请选择要操作的信息!");
      return;
    }
   switch(act)
    {
     case "add":

     break;

    case "del":
     if(!confirm("是否确定移除?"))
      {
        return;
      }
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




<% @ Page language="c#"%> 
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<% @ Import NameSpace="PageAdmin"%>
<% @ Import NameSpace="System.Text.RegularExpressions"%>
<script language="c#" runat="server">
 int RecordCount,PageCount,CurrentPage,PageSize,StartIndex,Comment_TimeLimit,Comment_MaxLength;
 string Table,DetailId,c_footer,IsMember,LoginUserName,OrderStr,IP,Forbid_Keyword,Replace_Keyword;
 OleDbConnection conn;
 protected void Page_Load(Object src,EventArgs e)
  {
    string sql;
    OleDbCommand comm;
    Conn Myconn=new Conn();
    conn=Myconn.OleDbConn();//获取OleDbConnection
    if(Request.Form["post"]=="add")
     {
      IsMember=Request.Form["ismember"];
      if(IsMember=="0")
       {
         Md5 JM=new Md5();
         if(Session["YZM"]==null)
          {
            Response.Write("yzm error");
            Response.End();
          }
         else if(Request.Form["code"]!=Session["YZM"].ToString())
          {
           Response.Write("yzm error");
           Response.End();
         }
       }
       Table=Request.Form["table"];
       DetailId=Request.Form["id"];
       string UserName=Request.Form["username"];
       string Password=Request.Form["code"];
       string Quote=Request.Form["quote"];
       string Content=Request.Form["content"];
       string Checked=Request.Form["checked"];
       Checked=Checked=="0"?"1":"0";
       string SiteId=Request.Form["siteid"];
       LoginUserName="";
       IP=GetClientIP();
       if(Content=="" || !IsNum(Checked) || !IsNum(DetailId) || !IsNum(SiteId) || !IsNum(IsMember) || !IsStr(Table))
        {
          Response.Write("input error");
          Response.End();
        }
       else
        {
         Check_Post();
         conn.Open();

        //处理内容
        Get_Set(int.Parse(SiteId));
        Check_TimeLimit();   //检查时间间隔;
        if(Comment_MaxLength!=0 && Content.Length>Comment_MaxLength)//检查最大字符
         {
          conn.Close();
          Response.Write("maxleng_limit,"+Comment_MaxLength);
          Response.End();
         }
         Check_Forbid(Content);           //检查禁止关键字
         Content=Replace_String(Content);    //替换
         UserName=Replace_String(UserName);  //替换
         //处理内容
         if(IsMember=="1")
          {
            if(Request.Cookies["Member"]!=null)
             {
              Member_Valicate MCheck=new Member_Valicate();
              MCheck.Member_Check();
              UserName=MCheck._UserName;
             }
            else
             {
              Check_Member(UserName,Password); //检查用户名和密码
             }
          }
         sql="insert into pa_comments(site_id,thetable,[detail_id],[username],[content],[quote],[checked],[ip],thedate,[ismember]) values("+int.Parse(SiteId)+",'"+Sql_Format(Table)+"',"+int.Parse(DetailId)+",'"+Sql_Format(UserName)+"','"+Sql_Format(Content)+"','"+Sql_Format(Quote)+"',"+int.Parse(Checked)+",'"+IP+"','"+DateTime.Now+"',"+int.Parse(IsMember)+")";
         comm=new OleDbCommand(sql,conn);
         comm.ExecuteNonQuery();
         sql="update "+Table+" set comments=comments+1 where id="+DetailId;
         comm=new OleDbCommand(sql,conn);
         comm.ExecuteNonQuery();
         Response.Write(Checked);
         conn.Close();
         Response.End();
        }
     }
   else
     {
       if(Request.Cookies["Member"]!=null)
        {
         Member_Valicate MCheck=new Member_Valicate();
         MCheck.Member_Check();
         LoginUserName=MCheck._UserName;
        }
        Table=Request.QueryString["table"];
        DetailId=Request.QueryString["id"];
        string Page=Request.QueryString["page"];
        string PS=Request.QueryString["pagesize"];
        OrderStr=Request.QueryString["order"];
        string OrderStr_1=OrderStr;
        if(OrderStr!=null)
         {
          OrderStr_1=OrderStr.Replace(" ","").Replace("desc","").Replace("asc","");
         }
        if(OrderStr_1=="id" || OrderStr_1=="thedate")
         {
           OrderStr=" order by "+OrderStr;
         }
        else
         {
           OrderStr="";
         }
        if(IsStr(Table) && IsNum(Page) && IsNum(PS) && IsNum(DetailId))
        {
         conn.Open();
    	 CurrentPage=int.Parse(Page);
   	 PageSize=int.Parse(PS);
   	 sql="select count(id) as co from pa_comments where checked=1 and thetable='"+Table+"' and detail_id="+DetailId;
   	 comm=new OleDbCommand(sql,conn);
   	 OleDbDataReader dr=comm.ExecuteReader();
   	 if(dr.Read()) 
   	  {
   	    RecordCount=int.Parse(dr["co"].ToString());
   	  }
   	 else
   	  {
    	    RecordCount=0;
     	  }
         dr.Close();
   	 if(RecordCount>0)
     	 {
    	 if(RecordCount%PageSize==0)
      	 {
       	  PageCount=RecordCount/PageSize;
       	 }
       	else
        {
       	  PageCount=RecordCount/PageSize+1;
      	 }
    	if(CurrentPage<1)
     	 {
      	   CurrentPage=1;
     	 }
    	 if(CurrentPage>PageCount)
     	 {
      	   CurrentPage=PageCount;
     	 }
   	sql="select * from pa_comments where checked=1 and thetable='"+Table+"' and detail_id="+DetailId+OrderStr;
    	DataSet ds=new DataSet();
    	OleDbDataAdapter MyAdapter=new OleDbDataAdapter(sql,conn);
    	MyAdapter.Fill(ds,(CurrentPage-1)*PageSize,PageSize,"table");
    	List.DataSource=ds.Tables[0].DefaultView;
   	List.DataBind();
    	conn.Close();
        build_page();
        }
       }
      else
       {
          Response.End();
       }
    }
 }

private void Check_Member(string UserName,String Password)
 {
   if(!IsUserName(UserName) || !IsStr(Password) )
    {
      conn.Close();
      Response.Write("user_pass error");
      Response.End();
    }
   Md5 Jm=new Md5();
   Password=Jm.Get_Md5(Password);
   string sql="select id from pa_member where username='"+Sql_Format(UserName)+"' and userpassword='"+Password+"'";
   OleDbCommand Comm=new  OleDbCommand(sql,conn);
   OleDbDataReader dr=Comm.ExecuteReader();
   if(!dr.Read())
    {
      dr.Close();
      conn.Close();
      Response.Write("user_pass error");
      Response.End();
    }
   dr.Close();
 }

private void Check_Post()
 {
    string PostUrl=Request.ServerVariables["HTTP_REFERER"];
    string LocalUrl=Request.ServerVariables["SERVER_NAME"];
    if(PostUrl!=null)
      {
         if(PostUrl.Replace("http://","").Split('/')[0].Split(':')[0]!=LocalUrl)
          {
            Response.Write("invalid_submit");
            Response.End();
          }
      }
 }

 private void build_page()
   {
      c_footer="";
      StartIndex=((CurrentPage-1)*PageSize)+1;
      if(PageCount<=1)
       {
         return;
       }
      int c_m=7;
      int c_l=3;
      int LastPage;

     if(CurrentPage>1)
      {
       c_footer+=" <a href=\"javascript:Load_Comments('"+Table+"','"+DetailId+"',1)\">{pa:firstpage}</a>";
      }
     if(CurrentPage<c_m)
     {
      LastPage=c_m;
      if(c_m>PageCount)
       {
        LastPage=PageCount;
       }
      for(int i=1;i<=LastPage;i++)
       {
         if(CurrentPage==i)
          {
            c_footer+=" <span class='c'>"+i+"</span>";
          }
         else
          {
            c_footer+=" <a href=\"javascript:Load_Comments('"+Table+"','"+DetailId+"',"+i+")\">"+i+"</a>";
          }
       }
    }
  else
    {
      LastPage=CurrentPage+c_l;
      if(LastPage>PageCount)
       {
        LastPage=PageCount;
       }
      for(int i=(CurrentPage-c_l);i<=LastPage;i++)
       {
         if(CurrentPage==i)
          {
            c_footer+=" <span class='c'>"+i+"</span>";
          }
         else
          {
            c_footer+=" <a href=\"javascript:Load_Comments('"+Table+"','"+DetailId+"',"+i+")\">"+i+"</a>";
          }
       }
    }
    if(CurrentPage<PageCount)
      {
       if(LastPage<PageCount)
       {
       c_footer+=" <a href=\"javascript:Load_Comments('"+Table+"','"+DetailId+"',"+(LastPage+1)+")\">...</a>";
       }
       c_footer+=" <a href=\"javascript:Load_Comments('"+Table+"','"+DetailId+"',"+PageCount+")\">{pa:lastpage}</a>";
      }
   }

private string Get_UserName(string SiteId,string username,string Ismember)
 {
  if(username!="")
   {
     username=Server.HtmlEncode(username);
   }
  if(Ismember=="0")
   {
     return username;
   }
  else
   {
     return "<a href=\"/e/space/?username="+username+"\" target=\"space\">"+username+"</a>";
   }
 }

private void Check_TimeLimit()
 {
  bool cf=false;
  if(Comment_TimeLimit>0)
   {
     string sql;
     string Dbtype=ConfigurationManager.AppSettings["DbType"].ToString(); 
     if(Dbtype=="0")
     {
       sql="select top 1 id from pa_comments where ip='"+IP+"' and datediff('s',thedate,Now())<"+Comment_TimeLimit+" order by id desc";
     }
    else
     {
       sql="select top 1 id from pa_comments where ip='"+IP+"' and datediff(s,thedate,getdate())<"+Comment_TimeLimit+" order by id desc";
     }
    OleDbCommand Comm=new  OleDbCommand(sql,conn);
    OleDbDataReader dr=Comm.ExecuteReader();
    if(dr.Read())
     {
      cf=true;
     }
    dr.Close();
   }
  if(cf)
   {
    conn.Close();
    Response.Write("time_limit,"+Comment_TimeLimit);
    Response.End();
   }
 }

private void Get_Set(int SiteId)
 {
   string sql="select comment_timelimit,comment_maxlength,forbid_keyword,replace_keyword from pa_webset where site_id="+SiteId;
   OleDbCommand Comm=new  OleDbCommand(sql,conn);
   OleDbDataReader dr=Comm.ExecuteReader();
   if(dr.Read())
    {
      Comment_TimeLimit=int.Parse(dr["comment_timelimit"].ToString());
      Comment_MaxLength=int.Parse(dr["comment_maxlength"].ToString());
      Forbid_Keyword=dr["forbid_keyword"].ToString()+"|ajax_list.aspx|/e/zdymodel/";
      Replace_Keyword=dr["replace_keyword"].ToString();
    }
   else
    {
      Comment_TimeLimit=0;
      Comment_MaxLength=0;
      Forbid_Keyword="";
      Replace_Keyword="";
      Response.Write("invalid siteid");
      Response.End();
    }
  dr.Close();
  
 }

private string GetClientIP()
  {
   if (HttpContext.Current==null) return "127.0.0.1";
   string clientIp=Request.ServerVariables["HTTP_X_FORWARDED_FOR"];
   if (string.IsNullOrEmpty(clientIp))
   {
     clientIp=Request.ServerVariables["REMOTE_ADDR"];
   }
   if(string.IsNullOrEmpty(clientIp))
   {
     clientIp=Request.UserHostAddress;
   }
   if(clientIp.IndexOf(",")>0)
    {
      clientIp=clientIp.Split(',')[0];
    }
   if(!IsNum(clientIp.Replace(".","")))
    {
      clientIp="unknown";
    }
   return clientIp;
  }

private string Sql_Format(string str)
 {
   if(string.IsNullOrEmpty(str)){return "";}
   str=str.Replace("'","''");
   str=str.Replace("\"","\""); 
   return str;
 }

private string ubb(string str)
  {
    str=str.Replace("<","&lt;");
    str=str.Replace(">","&gt;");
    str=str.Replace("\n","<br>");
    str=str.Replace(" ","&nbsp;");
    return str;
  }

private bool IsUserName(string str)
 {
  if(string.IsNullOrEmpty(str)){return false;}
  Regex re = new Regex(@"[\u4e00-\u9fa5]+");
  str=re.Replace(str,"");
  if(str.Length==0){return true;}
  else{return IsStr(str);}
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
private string Replace_String(string str)
 {
   if(Replace_Keyword!="")
    {
      string[] Akws=Replace_Keyword.Split('|');
      for(int i=0;i<Akws.Length;i++)
       {
        if(Akws[i]!="")
         {
          str=Regex.Replace(str,@Akws[i],"***", RegexOptions.IgnoreCase);
         }
       }
    }
  return str;
 }

private void Check_Forbid(string str)
 {
   bool has=false;
   if(Forbid_Keyword!="")
    {
      string[] Akws=Forbid_Keyword.Split('|');
      for(int i=0;i<Akws.Length;i++)
       {
        if(Akws[i]!="")
         {
           Regex regex=new Regex(@Akws[i],RegexOptions.IgnoreCase); 
           if(regex.IsMatch(str)) 
            {
             has=true;
            }
         }
       }
    }
   if(has)
    {
      conn.Close();
      Response.Write("forbid_keyword");
      Response.End();
    }
 }
</script>
<asp:Repeater id="List" runat="server">
 <HeaderTemplate>
<span class="title">{pa:listsign}</span>
 </HeaderTemplate>
 <ItemTemplate>
   <ul class="item">
    <li class="header"><span class="left"><font class="floornum" id="c_floor_<%#DataBinder.Eval(Container.DataItem,"id")%>"><%=StartIndex++%></font>{pa:floor}<span id="c_username_<%#DataBinder.Eval(Container.DataItem,"id")%>"><%#Get_UserName(DataBinder.Eval(Container.DataItem,"site_id").ToString(),Server.HtmlEncode(DataBinder.Eval(Container.DataItem,"username").ToString()),DataBinder.Eval(Container.DataItem,"ismember").ToString())%></span></span><span class="right"><span id="c_date_<%#DataBinder.Eval(Container.DataItem,"id")%>"><%#DataBinder.Eval(Container.DataItem,"thedate","{0:yyyy-MM-dd HH:mm:ss}")%></span>&nbsp;&nbsp;<a href="#" onclick="return cquote('<%#DataBinder.Eval(Container.DataItem,"id")%>')">{pa:quote}</a></span><span class="clear"></span></li>
    <li class="content" id="c_content_<%#DataBinder.Eval(Container.DataItem,"id")%>"><%#DataBinder.Eval(Container.DataItem,"quote")%><%#ubb(DataBinder.Eval(Container.DataItem,"content").ToString())%></li>
    <asp:PlaceHolder Runat="server" Visible='<%#DataBinder.Eval(Container.DataItem,"reply").ToString()==""?false:true%>'><li class="reply">{pa:reply}<%#DataBinder.Eval(Container.DataItem,"reply")%></li></asp:PlaceHolder>
  </ul>
 </ItemTemplate>
 <FooterTemplate>
 <div id="c_page" style="display:none"><%=c_footer%>|<%=CurrentPage%>|<%=PageCount%>|<%=RecordCount%></div>
 </FooterTemplate>
</asp:Repeater><input type="hidden" id="c_loginusername" value="<%=LoginUserName%>">
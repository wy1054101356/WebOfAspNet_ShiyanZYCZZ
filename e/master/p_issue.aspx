<% @ Page language="c#"%>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<% @ Import NameSpace="System.IO"%>
<% @ Import NameSpace="PageAdmin"%>
<script language="c#" Runat="server">
  string Is_Static,DataHtml,DataTitle,author,current_username,current_workid,current_process_name,current_pass_name,current_rework_name,current_rework_node,current_work_state;
  int Work_Id,currnt_node,data_checked;
  OleDbConnection conn;
  string Act,TheTable,UserName,Result;
  int ID,Detail_Id,SiteId,IsChecked;
 protected void Page_Load(Object src,EventArgs e)
   {
    Result="";
    if(!IsStr(Request.QueryString["table"]) || !IsNum(Request.QueryString["detailid"]) || !IsNum(Request.QueryString["workid"]))
     {
       Response.Write("error");
       Response.End();
     }
     Master_Valicate YZ=new Master_Valicate();
     YZ.Master_Check();
     UserName=YZ._UserName;
     SiteId=int.Parse(Request.Cookies["SiteId"].Value);
     TheTable=Request.QueryString["table"];
     Detail_Id=int.Parse(Request.QueryString["detailid"]);
     Work_Id=int.Parse(Request.QueryString["workid"]);

     Conn Myconn=new Conn();
     conn=Myconn.OleDbConn();//获取OleDbConnection
     conn.Open();
      if(!string.IsNullOrEmpty(Request.QueryString["act"]))
       {
         Get_DataInfo();
       }
     conn.Close();
     Response.Write(Result);
     Response.End();
  }

private void Issue_Data()
 {
   if(UserName!=current_username && UserName!="admin")
    {
     return;
    }
   Act=Request.QueryString["act"];
   PageAdmin.Log log=new PageAdmin.Log();
   switch(Act)
    {
      case "pass":
       log.Save(SiteId,1,"issue",1,UserName,"签发信息：通过(标题："+DataTitle+")");
       Add_IssueList(Act);
       Update_Info(Act);
      break;

      case "rework":
       log.Save(SiteId,1,"issue",1,UserName,"签发信息：退回(标题："+DataTitle+")");
       Add_IssueList(Act);
       Update_Info(Act);
      break;

      case "delete":
       log.Save(SiteId,1,"issue",1,UserName,"签发信息：删除信息(标题："+DataTitle+")");
       Delete_Info();
      break;
    }
   if(Is_Static=="1" && DataHtml=="2"){Buile_Static();}//生成静态
   if(IsChecked==1)
    {
     Buile_Static();
     if(Act=="pass")
      {
        Send_Point(TheTable,Detail_Id,UserName);
      }
    }
   Result="success";
 }

private void  Add_IssueList(string Act)
 {
   string Reply="";
   switch(Act)
    {
      case "pass":
        Act=current_pass_name;
        if(Act==""){Act="通过";}
      break;

      case "rework":
        Act=current_rework_name;
        if(Act==""){Act="退回";}
        //Reply=Act;
      break;
    }
   string sql="insert into pa_issue([site_id],[thetable],[detail_id],[act],[work_node],[reply],[username]) values("+SiteId+",'"+TheTable+"',"+Detail_Id+",'"+Sql_Format(Act)+"',"+currnt_node+",'"+Reply+"','"+UserName+"')";
   OleDbCommand Comm=new OleDbCommand(sql,conn);
   Comm.ExecuteNonQuery();
 }


private void Update_Info(string Act)
 {
   int Checked=0,NextNode;
   string Work_State,work_username,Work_Notice;
   string sql;
   OleDbCommand comm;
   OleDbDataReader dr;
   switch(Act)
    {
      case "pass":
      sql="select top 1 id,work_username,process_name,send_notice from pa_work_node where work_id="+Work_Id+" and id>"+currnt_node+" order by id";
      comm=new OleDbCommand(sql,conn);
      dr=comm.ExecuteReader();
      if(dr.Read())
       {
         NextNode=int.Parse(dr["id"].ToString());
         work_username=dr["work_username"].ToString();
         Work_State=dr["process_name"].ToString();
         Work_Notice=dr["send_notice"].ToString();
       }
      else
       {
        Checked=1;
        NextNode=currnt_node;
        work_username=current_username;
        Work_State=current_pass_name;
        Work_Notice="0";
       }
      dr.Close();
     break;

     default:
      int reworknode=int.Parse(current_rework_node);
      sql="select id,work_username,send_notice from pa_work_node where work_id="+Work_Id+" and id="+reworknode;
      comm=new OleDbCommand(sql,conn);
      dr=comm.ExecuteReader();
      if(dr.Read())
       {
         NextNode=int.Parse(dr["id"].ToString());
         work_username=dr["work_username"].ToString();
         Work_State=current_rework_name;
         Work_Notice=dr["send_notice"].ToString();
       }
      else
       {
        NextNode=0;
        work_username="";
        Work_State=current_rework_name;
        Work_Notice="0";
       }
      dr.Close();
     break;
    }
   IsChecked=Checked;

   sql="update pa_issuedata set detail_checked="+Checked+",work_node="+NextNode+",work_state='"+Work_State+"',work_username='"+work_username+"',thedate='"+DateTime.Now+"' where thetable='"+TheTable+"' and  detail_id="+Detail_Id;
   comm=new OleDbCommand(sql,conn);
   comm.ExecuteNonQuery();

   sql="update "+TheTable+" set checked="+Checked+" where id="+Detail_Id;
   comm=new OleDbCommand(sql,conn);
   comm.ExecuteNonQuery();

   sql="update "+TheTable+" set checked="+Checked+" where source_id="+Detail_Id; //更新推送信息
   comm=new OleDbCommand(sql,conn);
   comm.ExecuteNonQuery();

   sql="update pa_alldata set checked="+Checked+" where thetable='"+TheTable+"' and detail_id="+Detail_Id; //更新全站数据表
   comm=new OleDbCommand(sql,conn);
   comm.ExecuteNonQuery();
 }

private void Delete_Info()
 {
   int Id=Detail_Id;
   string sql;
   Del_Html(Id);

   sql="delete from "+TheTable+" where id="+Id;
   OleDbCommand Comm=new OleDbCommand(sql,conn);
   Comm.ExecuteNonQuery();


  sql="delete from "+TheTable+" where source_id="+Id;
  Comm=new OleDbCommand(sql,conn);
  Comm.ExecuteNonQuery();

  sql="update pa_file set detail_id=-1 where detail_id="+Id+" and thetable='"+TheTable+"'"; //更新附件列表
  Comm=new OleDbCommand(sql,conn);
  Comm.ExecuteNonQuery();

  //删除其他相关表
   string Tables="pa_comments,pa_mood,pa_sign,pa_reply,pa_issue,pa_issuedata,pa_replydata,pa_signdata,pa_pushdata,pa_alldata,pa_favourites";
   string[] Athetable =Tables.Split(',');
   for(int i=0;i<Athetable.Length;i++)
    {
      if(Athetable[i]!="")
       {
        sql="delete from "+Athetable[i]+" where detail_id="+Id+" and thetable='"+TheTable+"'";
        Comm=new OleDbCommand(sql,conn);
        Comm.ExecuteNonQuery();
       }
    }
 }

private void Buile_Static()
 {
   string sql="select id,site_dir,static_dir,static_file,lanmu_id,sublanmu_id from "+TheTable+" where [html]=2 and id="+Detail_Id;
   OleDbCommand comm=new OleDbCommand(sql,conn);
   OleDbDataReader dr=comm.ExecuteReader();
   if(dr.Read()) 
    {
      Build_Html BH=new Build_Html();
      try
       {
         BH.Build_Detail(dr["site_dir"].ToString(),dr["static_dir"].ToString(),dr["static_file"].ToString(),dr["lanmu_id"].ToString(),dr["sublanmu_id"].ToString(),dr["id"].ToString());
       }
      catch
       {
         Result="buile_html_false";
       }
    }
  dr.Close();
 }

private void Send_Point(string TheTable,int Detail_Id,string Operator) //通过审核时赠送或扣除待处理的积分
 {
    int sendpoint=0;
    string author="",sql;
    OleDbCommand comm;
    OleDbDataReader dr;
    sql="select [amount],[act],[username] from pa_fnc_list where thetype=2 and [state]=0 and thetable='"+TheTable+"' and detail_id="+Detail_Id;
    comm=new OleDbCommand(sql,conn);
    dr=comm.ExecuteReader();
    if(dr.Read())
    {
      author=dr["username"].ToString();
      if(dr["act"].ToString()=="c")
       {
        sendpoint=int.Parse(dr["amount"].ToString());
       }
      else if(dr["act"].ToString()=="k")
       {
         sendpoint=-1*int.Parse(dr["amount"].ToString());
       }
    }
    dr.Close();
    if(sendpoint!=0)
     {
      sql="delete from pa_fnc_list where thetype=2 and [state]=0 and thetable='"+TheTable+"' and detail_id="+Detail_Id;
      comm=new OleDbCommand(sql,conn);
      comm.ExecuteNonQuery();
      if(sendpoint>0)
      {
        sql="update pa_member set point_ky=point_ky+"+sendpoint+",point_fk=point_fk+"+sendpoint+" where username='"+author+"'";
        comm=new OleDbCommand(sql,conn);
        comm.ExecuteNonQuery();

        sql="insert into pa_fnc_list(site_id,thetype,username,operator,act,amount,detail,beizhu,thetable,detail_id,[state]) values("+SiteId+",2,'"+author+"','"+Operator+"','c',"+sendpoint+",'投稿赠送积分','','"+TheTable+"',"+Detail_Id+",1)";
        comm=new OleDbCommand(sql,conn);
        comm.ExecuteNonQuery();
      }
      else
      {
        sendpoint=sendpoint*-1;
        sql="update pa_member set point_ky=point_ky-"+sendpoint+",point_xf=point_xf+"+sendpoint+" where username='"+author+"'";
        comm=new OleDbCommand(sql,conn);
        comm.ExecuteNonQuery();

        sql="insert into pa_fnc_list(site_id,thetype,username,operator,act,amount,detail,beizhu,thetable,detail_id,[state]) values("+SiteId+",2,'"+author+"','"+Operator+"','k',"+sendpoint+",'投稿扣除积分','','"+TheTable+"',"+Detail_Id+",1)";
        comm=new OleDbCommand(sql,conn);
        comm.ExecuteNonQuery();
       }
     }
 }

private void Get_DataInfo()
 {
   string Data_SiteId="0";
   Is_Static="0";
   current_workid="0";
   string sql="select [site_id],[title],[checked],[username],[html] from "+TheTable+" where id="+Detail_Id;
   OleDbCommand comm=new OleDbCommand(sql,conn);
   OleDbDataReader dr=comm.ExecuteReader();
   if(dr.Read())
    {
      Data_SiteId=dr["site_id"].ToString();
      DataTitle=dr["title"].ToString();
      data_checked=int.Parse(dr["checked"].ToString());
      author=dr["username"].ToString();
      DataHtml=dr["html"].ToString();
    }
   else
    {
      Result="error";
    }
   dr.Close();
  
   sql="select work_id,work_node,work_state from pa_issuedata where thetable='"+TheTable+"' and  detail_id="+Detail_Id;
   comm=new OleDbCommand(sql,conn);
   dr=comm.ExecuteReader();
   if(dr.Read())
    {
      current_workid=dr["work_id"].ToString();
      currnt_node=int.Parse(dr["work_node"].ToString());
      Get_NodeInfo(currnt_node);
      current_work_state=dr["work_state"].ToString();
    }
   else
    {
      Result="error";
    }
   dr.Close();


   string SiteDomain="";
   sql="select [html],[domain] from pa_site where id="+Data_SiteId;
   comm=new OleDbCommand(sql,conn);
   dr=comm.ExecuteReader();
   if(dr.Read())
    {
     Is_Static=dr["html"].ToString();
     SiteDomain=dr["domain"].ToString().Trim();
    }
   dr.Close();
  if(Is_Static=="1" && DataHtml=="2" && SiteDomain!="" && SiteDomain!=Request.ServerVariables["SERVER_NAME"])
   {
     Result="different_domain";
   }
  else
   {
    if(Data_SiteId!="0" && current_workid!="0")
    {
      Issue_Data();
    }
   }
 }

private void Get_NodeInfo(int nodeid)
 {
   string sql="select * from pa_work_node where id="+nodeid;
   OleDbCommand comm=new OleDbCommand(sql,conn);
   OleDbDataReader dr=comm.ExecuteReader();
   if(dr.Read())
    {
      current_username=dr["work_username"].ToString();
      current_process_name=dr["process_name"].ToString();
      current_pass_name=dr["pass_name"].ToString();
      current_rework_name=dr["rework_name"].ToString();
      current_rework_node=dr["rework_node"].ToString();
    }
  else
    {
      current_rework_node="0";
    }
   dr.Close();
 }

protected string GetNodeName(string Nodeid)
 {
   string Rv="";
   string sql="select [name] from pa_work_node where work_id="+Work_Id+" and id="+int.Parse(Nodeid);
   OleDbCommand comm=new OleDbCommand(sql,conn);
   OleDbDataReader dr=comm.ExecuteReader();
   if(dr.Read())
    {
      Rv=dr["name"].ToString();
    }
   dr.Close();
   return Rv;
 }

protected string GetUser(string str)
 {
   if(str!="")
    {
      return str;
    }
   else
    {
     return "匿名投稿";
    }
 }

private void Del_Html(int Id) //删除静态文件
 {
    string sql="select [id],[site_dir],[static_dir],[static_file] from "+TheTable+" where id="+Id;
    OleDbCommand myComm=new OleDbCommand(sql,conn);
    OleDbDataReader dr=myComm.ExecuteReader();
    if(dr.Read())
     {
       string Static_file=dr["static_file"].ToString();
       try
        {
         Del_StaticFile("/"+dr["site_dir"].ToString()+"/"+dr["static_dir"].ToString()+"/"+(Static_file==""?Id+".html":Static_file));
        }
       catch
        {
          Result="del_html_false";
        }
     }
   dr.Close();
 }

private void Del_StaticFile(string FilePath)
 {
    FilePath=Server.MapPath(FilePath);
    if(File.Exists(FilePath))
     {
       File.Delete(FilePath);
     }
 }

private string Sql_Format(string str)
 {
   if(str==null || str=="")
    {
     return "";
    }
   str=str.Replace("'","''");
   str=str.Replace("\"","\""); 
   return str;
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

private bool IsNum(string str)
 { 
   if(str==null || str=="")
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
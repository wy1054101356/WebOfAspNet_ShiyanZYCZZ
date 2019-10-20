<% @ Page Language="C#"%>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<% @ Import NameSpace="PageAdmin"%>
<script language="c#" Runat="server">
  OleDbConnection conn;
  OleDbCommand comm;
  OleDbDataReader dr;
  string Thetable,PushFields,Fields,Fields_Name,SiteList,CurrentSiteId,Sort_List,MemberTypeList,TheMaster,field_value,sql,sql_1,Sort_Ids,Admin_Sites,ToSite_Dir;
  int SiteId,UID,Lanmu_Id,Sublanmu_Id,Detail_Html;
  protected  void Page_Load(Object src,EventArgs e)
   {
    Conn Myconn=new Conn();
    conn=Myconn.OleDbConn();//获取OleDbConnection
    if(!Page.IsPostBack)
    {
       Master_Valicate YZ=new Master_Valicate();
       YZ.Master_Check();
       TheMaster=YZ._UserName;
       UID=YZ._UID;
       CurrentSiteId=Request.Cookies["SiteId"].Value;
       SiteId=int.Parse(CurrentSiteId);
       if(Request.Form["post"]=="update")
        {
          Data_Update();
        }
       else
        {
         Thetable=Request.QueryString["table"];
         if(!IsStr(Thetable))
         {
          Response.Write("<"+"script type='text/javascript'>alert('无效table!');parent.ymPrompt.close()</"+"script>");
          return;
         }
         conn.Open();
          Get_Fields();
          Get_Site();
          Get_Sort(0);
          MemberType_Bind();
         conn.Close();
        }
    }
  }


private void MemberType_Bind()
 {
   string sql="select id,name from pa_member_type where site_id in(0,"+SiteId+") order by xuhao";
   OleDbCommand comm=new OleDbCommand(sql,conn);
   OleDbDataReader dr=comm.ExecuteReader();
   while(dr.Read())
    {
     MemberTypeList+="<option value='"+dr["id"].ToString()+"'>"+dr["name"].ToString()+"</option>";
    }
   dr.Close();
 }

private void Get_Site()
 {
  if(IsNum(Request.QueryString["siteid"]))
   {
     CurrentSiteId=Request.QueryString["siteid"];
   }
  SiteList="";
  if(TheMaster=="admin")
    {
      sql="select sitename,id from pa_site order by xuhao";
    }
  else
    {
      Get_AdminSites();
      sql="select sitename,id from pa_site where id in ("+Admin_Sites+") order by xuhao";
    }
    comm=new OleDbCommand(sql,conn);
    dr=comm.ExecuteReader();
    while(dr.Read())
     {
      if(dr["id"].ToString()==CurrentSiteId)
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

  string CurrentSiteId=SiteId.ToString();
  if(IsNum(Request.QueryString["siteid"]))
   {
     CurrentSiteId=Request.QueryString["siteid"];
   }
   string sql="select id,sort_name from pa_sort where parent_id="+Parentid+" and thetable='"+Thetable+"' and site_id="+CurrentSiteId+" order by xuhao,id";
   OleDbCommand comm=new OleDbCommand(sql,conn);
   OleDbDataReader dr=comm.ExecuteReader();
   while(dr.Read())
    {
      Sort_List+="<option value='"+dr["id"].ToString()+"'>"+dr["sort_name"].ToString()+"</option>\r\n";
    }
   dr.Close();
 }

private void Get_AdminSites()
 {
   Admin_Sites="0";
   sql="select site_id from pa_adminpermission where uid="+UID;
   comm=new OleDbCommand(sql,conn);
   dr=comm.ExecuteReader();
   while(dr.Read())
    {
     Admin_Sites+=","+dr["site_id"].ToString();
    }
   dr.Close();
 }

private void Data_Update()
 {
   conn.Open();
   Thetable=Request.Form["table"];
   string Ids=Request.Form["ids"];
   string[] AIds=Ids.Split(',');
   string ztids=Request.Form["zt_ids"];
   string ZdyTitle="",zdy_keywords="",zdy_description="",permissions="",download_permissions="",downloadpermissionsset="",donwloadpointset="";
   permissions=Request.Form["permissions"];
   download_permissions=Request.Form["downloadpermissions"];

   int Change_SiteId=0,To_SortId=0,AddClicks=0,AddDownloads=0,AddReserves=0,Comment_Open=0,comment_check=0,comment_anonymous=0,download_point=0; 

   Change_SiteId=int.Parse(Request.Form["SiteId"]);
   To_SortId=int.Parse(Request.Form["sort"]);
   ZdyTitle=Request.Form["zdy_Title"];
   zdy_keywords=Request.Form["zdy_Keywords"];
   zdy_description=Request.Form["zdy_description"];
   if(IsNum(Request.Form["point"]))
     {
       download_point=int.Parse(Request.Form["point"]);
     }
   downloadpermissionsset=Request.Form["downloadpermissionsset"];
   donwloadpointset=Request.Form["donwloadpointset"];

   if(IsNum(Request.Form["clicks"])) {AddClicks=int.Parse(Request.Form["clicks"]);}
   if(IsNum(Request.Form["downloads"])){AddDownloads=int.Parse(Request.Form["downloads"]);}
   if(IsNum(Request.Form["reserves"])){AddReserves=int.Parse(Request.Form["reserves"]); }

   Comment_Open=int.Parse(Request.Form["comment_open"]);
   if(IsNum(Request.Form["comment_check"])){comment_check=1;}
   if(IsNum(Request.Form["comment_anonymous"])){comment_anonymous=1;}

   sql="update "+Thetable+" set ";

   if(Request.Form["siteidset"]=="1")
    {
      Get_Lanmu(Change_SiteId,To_SortId);
      sql+="site_id="+Change_SiteId+",site_dir='"+ToSite_Dir+"',[html]="+Detail_Html+",[lanmu_id]="+Lanmu_Id+",[sublanmu_id]="+Sublanmu_Id+",[sort_id]="+To_SortId+",";
    }
   if(Request.Form["seotitleset"]=="1")
    {
      sql+="zdy_title='"+Sql_Format(ZdyTitle)+"', ";
    }
   if(Request.Form["keywordsset"]=="1")
    {
      sql+="zdy_keywords='"+Sql_Format(zdy_keywords)+"', ";
    }
   if(Request.Form["descriptionset"]=="1")
    {
      sql+="zdy_description='"+Sql_Format(zdy_description)+"', ";
    }

   if(Request.Form["permissionsset"]=="1")
    {
      sql+="permissions='"+Sql_Format(permissions)+"', ";
    }

   if(Request.Form["clickset"]=="1")
    {
      sql+="clicks=clicks+"+AddClicks+",";
    }

   if(Request.Form["downloadsset"]=="1")
    {
      sql+="downloads=downloads+"+AddDownloads+",";
    }

   if(Request.Form["reservesset"]=="1")
    {
      sql+="reserves=reserves+"+AddReserves+",";
    }

   if(Request.Form["commentset"]=="1")
    {
      sql+="comment_open="+Comment_Open+",comment_check="+comment_check+",comment_anonymous="+comment_anonymous+",";
    }

   if(Request.Form["thedateset"]=="1")
    {
      string TheDate=Request.Form["thedate"];
      if(IsDate(TheDate))
       {
         sql+="thedate='"+TheDate+"',actdate='"+TheDate+"',";
       }
    }
    //其他属性
   if(Request.Form["ztset"]=="1")
    {
     if(Request.Form["zt_list"]!=null)
      {
       sql+="iszt=1,zt_ids=',"+Sql_Format(Request.Form["zt_list"])+",', ";
      }
     else
      {
       sql+="iszt=0,zt_ids='', ";
      }
    }

   sql+=" comments=comments ";
   
   int ReplaceAct=0;
   string ReplaceFields=Request.Form["replace_field"];
   string ReplaceField="";
   string Field_ValueType="nvarchar";
   string ReplaceStr=Request.Form["replace_str"];
   string ReplaceResult=Request.Form["replace_result"];
   if(ReplaceFields!="")
    {
     if(ReplaceStr!="" || ReplaceResult!="")
      {
         string[] AReplaceFields=ReplaceFields.Split('|');
         ReplaceField=AReplaceFields[0];
         Field_ValueType=AReplaceFields[1];
         ReplaceAct=1;
      }
    }

   string sqlcmd;
   int Id;

   if(Ids=="")
    {
      Response.Write("");
      Sort_Ids=SortIds(Request.Form["sortid"]);
     //所有信息设置
      sql_1="";
     if(sql.IndexOf("set  comments=comments")<0) //判断是否有选择
      {
       if(Sort_Ids=="")
       {
        sqlcmd=sql+" where site_id="+SiteId+" and iscg=0";
        sql_1="select id from "+Thetable+" where site_id="+SiteId+" and iscg=0";
       }
      else
       {
         if(IsNum(Sort_Ids))
         {
          sqlcmd=sql+" where site_id="+SiteId+" and iscg=0 and sort_id="+Sort_Ids;
          sql_1="select id from "+Thetable+" where site_id="+SiteId+" and iscg=0 and sort_id="+Sort_Ids;
         }
        else
         {
           sqlcmd=sql+" where site_id="+SiteId+" and iscg=0 and sort_id in("+Sort_Ids+")";
           sql_1="select id from "+Thetable+" where site_id="+SiteId+" and iscg=0 and sort_id in("+Sort_Ids+")";
         }
       }
       comm=new OleDbCommand(sqlcmd,conn);
       comm.ExecuteNonQuery();
      }

      if(ReplaceAct==1)//批量替换
        {
          Replace_Field(ReplaceField,Field_ValueType,ReplaceStr,ReplaceResult,0);
        }
      if(downloadpermissionsset=="1" || donwloadpointset=="1")//更新附件设置
        {
           comm=new OleDbCommand(sql_1,conn);
           dr=comm.ExecuteReader();
           while(dr.Read())
            {
             Update_File(downloadpermissionsset,donwloadpointset,download_permissions,download_point,int.Parse(dr["id"].ToString()));
            }
        }
    }
   else
    {
     //根据id设置
     PushFields=Request.Form["fields"];
     for(int i=0;i<AIds.Length;i++)
     {   
      if(IsNum(AIds[i]))
       {
        Id=int.Parse(AIds[i]);
        sqlcmd=sql+" where id="+Id;
        if(sqlcmd.IndexOf("set  comments=comments")<0) //判断是否有选择
        {
         comm=new OleDbCommand(sqlcmd,conn);
         comm.ExecuteNonQuery();
         if(Request.Form["siteidset"]=="null")
         {
          comm=new OleDbCommand(sqlcmd.Replace("where id=","where source_id="),conn); //更新推送信息
          comm.ExecuteNonQuery();
         }
         else
         {
          comm=new OleDbCommand("delete from "+Thetable+" where source_id="+Id+" and sort_id="+To_SortId,conn); //如果分类改变了，则删除同分类下的推送，避免重复
          comm.ExecuteNonQuery();
         }
        }
        if(ReplaceAct==1)//批量替换
         {
           Replace_Field(ReplaceField,Field_ValueType,ReplaceStr,ReplaceResult,Id);
         }
        if(downloadpermissionsset=="1" || donwloadpointset=="1")//更新附件设置
         {
           Update_File(downloadpermissionsset,donwloadpointset,download_permissions,download_point,Id);
         }
        if(Request.Form["pushset"]=="1")
         {
           Add_PushData(Id);
         }
       }
        
     }
     //根据id设置
   }

   conn.Close();
   PageAdmin.Log log=new PageAdmin.Log();
   log.Save(int.Parse(Request.Cookies["SiteId"].Value),1,"edit",1,TheMaster,"批量属性设置(所属表："+Request.QueryString["name"]+")");

   Response.Write("<scri"+"pt type='text/javascript'>parent.postover('提交成功!');</"+"script>"); 
   Response.End(); 
 }

private void Replace_Field(string field,string value_type,string replace_str,string replace_result,int Id)
 {
   sql_1="";
   if(Id==0)
    {
      if(Sort_Ids=="")
       {
        sql_1="select id,"+field+" from "+Thetable+" where iscg=0";
       }
      else
       {
         if(IsNum(Sort_Ids))
         {
          sql_1="select id,"+field+" from "+Thetable+" where iscg=0 and sort_id="+Sort_Ids;
         }
        else
         {
           sql_1="select id,"+field+" from "+Thetable+" where iscg=0 and sort_id in("+Sort_Ids+")";
         }
       }
     comm=new OleDbCommand(sql_1,conn);
     dr=comm.ExecuteReader();
     while(dr.Read())
      { 
       Id=int.Parse(dr["id"].ToString()); 
       Replace_Field_1(value_type,dr,field,replace_str,replace_result,Id);
      }
    }
   else
    {
     sql_1="select "+field+" from "+Thetable+" where id="+Id;
     comm=new OleDbCommand(sql_1,conn);
     dr=comm.ExecuteReader();
     if(dr.Read())
      {  
       Replace_Field_1(value_type,dr,field,replace_str,replace_result,Id);
      }
    }
   dr.Close();
 }

private void Replace_Field_1(string value_type,OleDbDataReader dr,string field,string replace_str,string replace_result,int Id)
 {
    if(value_type=="datetime")
       {
        field_value=((DateTime)dr[field]).ToString("yyyy-MM-dd HH:mm:ss").Replace(replace_str,replace_result);
       }
      else
       {
        if(dr[field].ToString()=="")
         {
          field_value=replace_result;
         }
        else
         {
          field_value=dr[field].ToString().Replace(replace_str,replace_result);
         }
       }

      switch(value_type)
       {
        case "int":
          if(IsNum(field_value))
           {
             sql_1="update "+Thetable+" set ["+field+"]="+int.Parse(field_value)+" where id="+Id;
             comm=new OleDbCommand(sql_1,conn);
             comm.ExecuteNonQuery();

             sql_1="update "+Thetable+" set ["+field+"]="+int.Parse(field_value)+" where source_id="+Id;
             comm=new OleDbCommand(sql_1,conn);
             comm.ExecuteNonQuery();
           }
        break;

        case "float":
          if(IsFloat(field_value))
           {
             sql_1="update "+Thetable+" set ["+field+"]="+double.Parse(field_value)+" where id="+Id;
             comm=new OleDbCommand(sql_1,conn);
             comm.ExecuteNonQuery();

             sql_1="update "+Thetable+" set ["+field+"]="+double.Parse(field_value)+" where source_id="+Id;
             comm=new OleDbCommand(sql_1,conn);
             comm.ExecuteNonQuery();
           }
        break;

        case "datetime":
          if(IsDate(field_value))
           {
             sql_1="update "+Thetable+" set ["+field+"]='"+field_value+"' where id="+Id;
             comm=new OleDbCommand(sql_1,conn);
             comm.ExecuteNonQuery();

             sql_1="update "+Thetable+" set ["+field+"]='"+field_value+"' where source_id="+Id;
             comm=new OleDbCommand(sql_1,conn);
             comm.ExecuteNonQuery();
           }
        break;

        case "nvarchar":
          if(field_value.Length>250)
           {
             field_value=field_value.Substring(0,250);
           }
          sql_1="update "+Thetable+" set ["+field+"]='"+Sql_Format(field_value)+"' where id="+Id;
          comm=new OleDbCommand(sql_1,conn);
          comm.ExecuteNonQuery();

          sql_1="update "+Thetable+" set ["+field+"]='"+Sql_Format(field_value)+"' where source_id="+Id;
          comm=new OleDbCommand(sql_1,conn);
          comm.ExecuteNonQuery();
  
          if(field=="title" || field=="username")
           {
             sql_1="update pa_alldata set ["+field+"]='"+Sql_Format(field_value)+"' where thetable='"+Thetable+"' and detail_id="+Id;
             comm=new OleDbCommand(sql_1,conn);
             comm.ExecuteNonQuery();
           }
        break;

        default:
          sql_1="update "+Thetable+" set ["+field+"]='"+Sql_Format(field_value)+"' where id="+Id;
          comm=new OleDbCommand(sql_1,conn);
          comm.ExecuteNonQuery();

          sql_1="update "+Thetable+" set ["+field+"]='"+Sql_Format(field_value)+"' where source_id="+Id;
          comm=new OleDbCommand(sql_1,conn);
          comm.ExecuteNonQuery();

          if(field=="content")
           {
             sql_1="update pa_alldata set ["+field+"]='"+Sql_Format(field_value)+"' where thetable='"+Thetable+"' and detail_id="+Id;
             comm=new OleDbCommand(sql_1,conn);
             comm.ExecuteNonQuery();
           }
        break;
      }
 }

private void Update_File(string permissionsset,string pointset,string Permissions,int Point,int DetailId)
 {
  sql_1="";
  string tj=" and detail_id="+DetailId;
  if(permissionsset=="1" && pointset=="1")
   {
    sql_1="update pa_file set [permissions]='"+Permissions+"',[point]="+Point+" where thetable='"+Thetable+"'"+tj;
   }
  else if(permissionsset=="1")
   {
    sql_1="update pa_file set [permissions]='"+Permissions+"' where thetable='"+Thetable+"'"+tj;
   }
  else
   {
    sql_1="update pa_file set [point]="+Point+" where thetable='"+Thetable+"'"+tj;
   }

   comm=new OleDbCommand(sql_1,conn);
   comm.ExecuteNonQuery();
 }



private void Add_PushData(int detailid)
 {
    OleDbDataReader dr;
    string sortids=Request.Form["push_list"];
    if(string.IsNullOrEmpty(sortids)){sortids="";}
    string[] Asortids=sortids.Split(',');
    string TheFields=PushFields+",[lanmu_id],[sublanmu_id],[html],[site_dir],[static_dir],[detail_model_id],[zdy_title],[zdy_keywords],[zdy_description],[zdy_url],[member_price],[reserves],[clicks],[downloads],[comments],[checked],[iscg],[istg],[istop],[isgood],[isnew],[ishot],[comment_open],[comment_check],[comment_anonymous],[permissions],[point],[sendpoint],[username],[reply_state],[ip],[actdate],[has_titlepic]";
    sql_1="delete from "+Thetable+" where source_id="+detailid;
    comm=new OleDbCommand(sql_1,conn);
    comm.ExecuteNonQuery();

   if(string.IsNullOrEmpty(sortids))
      {
         sql_1="delete from pa_pushdata where [thetable]='"+Thetable+"' and detail_id="+detailid;
         comm=new OleDbCommand(sql_1,conn);
         comm.ExecuteNonQuery();
      }
    else
       {
         sql_1="select id from pa_pushdata where [thetable]='"+Thetable+"' and detail_id="+detailid;
         comm=new OleDbCommand(sql_1,conn);
         dr=comm.ExecuteReader();
         if(dr.Read())
          {
           sql_1="update pa_pushdata set [site_id]="+SiteId+",[push_sortids]='"+sortids+"' where [thetable]='"+Thetable+"' and detail_id="+detailid;
          }
         else
          {
           sql_1="insert into pa_pushdata([site_id],[thetable],[detail_id],[push_sortids]) values("+SiteId+",'"+Thetable+"',"+detailid+",'"+sortids+"')";
          }
         dr.Close();
         comm=new OleDbCommand(sql_1,conn);
         comm.ExecuteNonQuery();
        for(int i=0;i<Asortids.Length;i++)
         {
          if(!IsNum(Asortids[i])){continue;}

          sql_1="select id from "+Thetable+" where id="+detailid+" and sort_id="+Asortids[i];
          comm=new OleDbCommand(sql_1,conn);
          dr=comm.ExecuteReader();
          if(dr.Read())
           {
            dr.Close();
            continue;
           }
          dr.Close();
          sql_1="select site_id from pa_sort where id="+Asortids[i];
          comm=new OleDbCommand(sql_1,conn);
          dr=comm.ExecuteReader();
          if(dr.Read())
           {
            sql_1="insert into "+Thetable+"([site_id],[sort_id],[source_id]"+TheFields+") select "+dr["site_id"].ToString()+","+Asortids[i]+","+detailid+TheFields+" from "+Thetable+" where id="+detailid;
            comm=new OleDbCommand(sql_1,conn);
            comm.ExecuteNonQuery();
           }
          dr.Close();
         }
     }
 }

private void Get_Lanmu(int SiteId,int Sort_Id)
 {
   string Parent_Sorts,sql;
   OleDbCommand Comm;
   OleDbDataReader dr;
   Lanmu_Id=0;
   Sublanmu_Id=0;
   Detail_Html=0;
   ToSite_Dir="";
  sql="select parent_ids from pa_sort where id="+Sort_Id+" and thetable='"+Thetable+"'";
  Comm=new OleDbCommand(sql,conn);
  dr=Comm.ExecuteReader();
   if(dr.Read())
     {
       Parent_Sorts=dr["parent_ids"].ToString();
     }
   else
     {
      Parent_Sorts="0";
     }
   dr.Close();

   sql="select [site_dir],id,lanmu_id,[detail_html] from pa_sublanmu where is_sortsublanmu=1 and site_id="+SiteId+" and sort_id=0 and thetable='"+Thetable+"'";
   Comm=new OleDbCommand(sql,conn);
   dr=Comm.ExecuteReader();
       if(dr.Read())
        {
         Lanmu_Id=int.Parse(dr["lanmu_id"].ToString());
         Sublanmu_Id=int.Parse(dr["id"].ToString());
         Detail_Html=int.Parse(dr["detail_html"].ToString());
         ToSite_Dir=dr["site_dir"].ToString();
        }
   dr.Close();

   if(Sort_Id>0)
    {
       Parent_Sorts=Parent_Sorts+","+Sort_Id.ToString();
       string[] AParent_Sorts=Parent_Sorts.Split(',');
       int SLength=AParent_Sorts.Length;
       string C_Sort;
       for(int i=0;i<SLength;i++)
        {
           C_Sort=AParent_Sorts[SLength-i-1];
           if(C_Sort!="")
            {
              sql="select [site_dir],id,lanmu_id,[detail_html] from pa_sublanmu where is_sortsublanmu=1 and site_id="+SiteId+" and sort_id="+int.Parse(C_Sort)+" and thetable='"+Thetable+"'";
              Comm=new OleDbCommand(sql,conn);
              dr=Comm.ExecuteReader();
              if(dr.Read())
              {
                Lanmu_Id=int.Parse(dr["lanmu_id"].ToString());
                Sublanmu_Id=int.Parse(dr["id"].ToString());
                Detail_Html=int.Parse(dr["detail_html"].ToString());
                ToSite_Dir=dr["site_dir"].ToString();
                dr.Close();
                break;
              }
            dr.Close();
           }
        }

     }
 }

private void Get_Fields()
  {
    PushFields="";
    sql="select field,field_name,field_type,value_type from pa_field where thetable='"+Thetable+"' and (tgitem=1 or additem=1 or edititem=1) and field_type<>'images' and field_type<>'files' order by xuhao";
    comm=new OleDbCommand(sql,conn);
    dr=comm.ExecuteReader();
    while(dr.Read())
     {
      Fields+=dr["field"].ToString()+"|"+dr["value_type"].ToString()+",";
      PushFields+=","+dr["field"].ToString();
      Fields_Name+=dr["field_name"].ToString()+",";
     }
    dr.Close();
  }

private string SortIds(string SortId)
 {
     string Ids=SortId;
     if(Ids==""){return "";}
     else
     {
       string sql="select id from pa_sort where site_id="+SiteId+" and parent_ids like '%,"+SortId+",%'";
       OleDbCommand comm=new OleDbCommand(sql,conn);
       OleDbDataReader dr=comm.ExecuteReader();
       while(dr.Read())
       {
         Ids+=","+dr["id"].ToString();
       }
     dr.Close();
    return Ids;
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

private  bool IsNum(string str)
 {
  if(string.IsNullOrEmpty(str)){return false;}
  if(str.IndexOf("-")==0)
   {
    str=str.Substring(1);
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

private bool IsFloat(string str)
 {
  if(string.IsNullOrEmpty(str)){return false;}
  string str1="0123456789.";
  if((str.Length-str.Replace(".",String.Empty).Length)>1)
   {
       return false;
   }
  for(int i=0;i<str.Length;i++)
   {
    if(str1.IndexOf(str[i])==-1)
     {
       return false;
     }
   }
  return true;
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
</script>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server" /> 
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table border=0 cellpadding=10 cellspacing=0 width=98%>
 <tr>
<td valign=top align="left">
<iframe name="post_iframe" id="post_iframe"  src="" frameborder=0 scroling=no height=1px width=1px marginwidth=0 marginheight=0 style="display:none"></iframe>
<div id="div1">
<div id="tabdiv">
<ul>
<li id="tab" name="tab"  onclick="showtab(0)" style="font-weight:bold">信息相关</li>
<li id="tab" name="tab"  onclick="showtab(1)">其他设置</li>
</ul>
</div>
<form method="post" target="post_iframe" action="data_pset.aspx?table=<%=Request.QueryString["table"]%>&name=<%=Server.UrlEncode(Request.QueryString["name"])%>">
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top align="left">
<div name="tabcontent" id="tabcontent" style="display:block">
<table border=0 cellpadding=2 cellspacing=0  align=center width=98%>
<tr><td align=left width="80px"><input type="checkbox" name='siteidset' id='siteidset' value="1">信息转移</td>
   <td>
<select name="SiteId" onchange="c_site(this.value)"><%=SiteList%></select>

<select name="s_sort" id="s_sort" onchange="c_sort(<%=CurrentSiteId%>,1,'<%=Request.QueryString["table"]%>')">
<option  value="0">---请选择所属类别---</option>
<%=Sort_List%>
</select>
<input type="hidden" name="sort" id="sort" value="0">
<script type="text/javascript">
var Current_SiteId="<%=Request.Cookies["SiteId"].Value%>"; //ajax加载数据用到
var Tg_Table="<%=Thetable%>"; //ajax加载数据用到
var Sort_Type="onlyone";
Write_Select(<%=CurrentSiteId%>,'<%=Request.QueryString["table"]%>');
</script>

</td>
</tr>

 <tr><td align=left width="80px"><input type="checkbox" name='seotitleset' value="1">SEO标题</td>
   <td><input  type="text" name="zdy_Title" Maxlength="100"  size=50></td>
</tr>

<tr><td><input type="checkbox" name='keywordsset' value="1">SEO关键字</td>
<td><input type="text" name="zdy_Keywords" Maxlength="100"  size=50></td>
</tr>

<tr>
<td><input type="checkbox" name='descriptionset' value="1">SEO描述</td>
<td><textarea name="zdy_description" Cols="50" rows="3" onkeyup="if(this.value.length>250){this.value=this.value.substring(0,250)}"></textarea></td>
</tr>

<tr>
<td align=left width='80px'><input type="checkbox" name='permissionsset' value="1">浏览权限</td>
<td>
  <select id="permissions" name="permissions" size="5" style="width:250px" multiple>
   <option value="">所有用户组</option>
   <%=MemberTypeList%>
  </select>
  <br><span style="color:#999">按住Ctrl键可实现多选或取消选择。</span>
      </td>
</tr>

<!--
<tr>
<td align=left><input type="checkbox" name='sxset' value="1">特殊属性</td>
<td><input type="checkbox" name='istop' id='istop' value="1">置顶
<input type="checkbox" name='isgood' id='isgood' value="1">推荐
<input type="checkbox" name='isnew' id='isnew' value="1">最新
<input type="checkbox" name='ishot' id='ishot' value="1">热门
</td>
</tr>
-->

<tr>
<td align=left><input type="checkbox" name='clickset' value="1">点击数+</td>
<td><input type=text name='clicks' id='clicks' Maxlength='10' size='5' value="0" onblur="if(isNaN(value))execCommand('undo')"></td>
</tr>

<tr>
<td align=left><input type="checkbox" name='downloadsset' value="1">下载数+</td>
<td><input type=text name='downloads' id='downloads' Maxlength='10'  size='5' value="0" onblur="if(isNaN(value))execCommand('undo')"></td>
</tr>

<tr>
<td align=left><input type="checkbox" name='reservesset' value="1">库存数+</td>
<td><input type=text name='reserves' id='reserves' Maxlength='10'  size='5' value="0" onblur="if(isNaN(value))execCommand('undo')"></td>
</tr>

<tr><td align=left><input type="checkbox" name='commentset' value="1">评论功能</td>
<td>
<input type="radio" name='comment_open' value="0" checked>关闭
<input type="radio" name='comment_open' id='comment_open_1' value="1">开启&nbsp;
<input type="checkbox" name='comment_check' id='comment_check' value="1" checked>评论需审核
<input type="checkbox" name='comment_anonymous' id='comment_anonymous' value="1" checked>允许匿名评论
</td>
</tr>

<tr><td align=left><input type="checkbox" name='thedateset' value="1">发布日期</td>
<td><input type=text name='thedate' id='thedate' Maxlength='20'  size='18' value="<%=System.DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss")%>"><a href="javascript:open_calendar('thedate',1)"><img src=/e/images/icon/date.gif border=0 height=20 hspace=2 align=absbottom></a></td>
</tr>

<tr><td colspan="2" height="5px"></td></tr>

<tr>
<td align=left>批量替换</td>
<td><select name="replace_field" id="replace_field"><option value="">请选择替换字段</option></select><input type="text" size="18" name="replace_str">替换为<input type="text" size="18" name="replace_result">
</td>
</tr>
</table>
</div>
<div name="tabcontent" id="tabcontent" style="display:none">
 <table border=0 cellpadding=5 cellspacing=0  align=center width=98%>
<tr>
<td align=left width="100px"><input type="checkbox" name='downloadpermissionsset' value="1">附件下载权限</td>
<td>
  <select id="downloadpermissions" name="downloadpermissions" size="5" style="width:250px" multiple>
   <option value="">所有用户组</option>
   <%=MemberTypeList%>
  </select>
  <br><span style="color:#999">按住Ctrl键可实现多选或取消选择。</span>
</td>
</tr>
<tr>
<td align=left><input type="checkbox" name='donwloadpointset' value="1">附件下载积分</td>
<td><input type="textbox" name="point" id="point"  size="10" Maxlength="10" value="0" onkeyup="if(isNaN(value))execCommand('undo')"></td>
</tr>

<tr>
 <td><input type="checkbox" name='ztset' value="1">所属专题<br><span style="color:#999999">双击删除</span></td>
          <td>
<table border=0 cellpadding=2 cellspacing=0>
<tr><td>
<select id="zt_list" name="zt_list" multiple style='width:300px;height:80px' ondblclick="clear_select('zt_list');"></select>
</td>
<td>
<input type="button" value="选择专题" class="bt" onclick="open_ztlist(1)">
</td></tr>
</table>

<tr>
 <td><input type="checkbox" name='pushset' id='pushset' value="1">信息推送<br><span style="color:#999999">双击删除</span></td>
 <td>
<table border=0 cellpadding=2 cellspacing=0>
<tr><td>
<select id="push_list" name="push_list" multiple style='width:300px;height:80px' ondblclick="clear_select('push_list');"></select>
</td>
<td>
<input type="button" value="选择分类" class="bt" onclick="Sort_Select('推送分类','all','<%=Request.Cookies["SiteId"].Value%>','<%=Thetable%>','<%=Thetable%>','push_list',1,1,true,'90%','90%')">
</td></tr>
</table>
</td>
 </tr>
</table>
</div>
<div align=center style="padding:10px">
<span id="post_area">
<input type="hidden" value="update" name="post">
<input type="hidden" value="0" id="ids" name="ids">
<input type="hidden" value="" id="sortid" name="sortid">
<input type="hidden" value="<%=PushFields%>" name="fields">
<input type="hidden" value="<%=Thetable%>" name="table">
<input type="submit" class=button value="提交" onclick="return ck()">
<input type="button" value="关闭" class="button" onclick="parent.CloseDialog()">
</span>
<span id="post_loading" style="display:none"><img src=images/loading.gif vspace="5" align=absmiddle>Loading...</span>
</div>
  </td>
  <tr>
 </table>
</form>
</td>
</tr>
</table>
</center>
<script type="text/javascript">
var Fields="<%=Fields%>username|nvarchar,"
var Fields_Name="<%=Fields_Name%>发布用户名,"
var AFields=Fields.split(',');
var AFields_Name=Fields_Name.split(',');
var obj=document.getElementById("replace_field");
for(var i=0;i<AFields.length-1;i++)
 {
  obj.options.add(new Option(AFields_Name[i]+"("+AFields[i].split('|')[0]+")",AFields[i]));
 }
document.getElementById("ids").value=parent.document.getElementById("ids").value;
if(document.getElementById("ids").value=="0" || document.getElementById("ids").value==""){document.getElementById("pushset").disabled="disabled";document.getElementById("siteidset").disabled="disabled";}
document.getElementById("sortid").value=parent.document.getElementById("sortid").value;

function ck()
 {
  Set_Selected('select-all','zt_list');
  Set_Selected('select-all','push_list');
  if(document.getElementById("pushset").checked && document.getElementById("siteidset").checked)
    {
      alert("对不起，信息转移和信息推送不能同时操作!")
      return false;
    }
  startpost();
 }

function clear_select(Id)
 {
  var obj=document.getElementById(Id);
  if(obj.options.length==0){return;}
  for(i=0;i<obj.options.length;i++)
   {
    if(obj.options[i].selected)
     {
       obj.remove(i);
       clear_select(Id);
     }
   }
 }

function c_site(siteid)
 {
   location.href="?table=<%=Request.QueryString["table"]%>&name=<%=Server.UrlEncode(Request.QueryString["name"])%>&siteid="+siteid;
 }
</script>
</body>
</html>  

<% @ Page language="c#"%> 
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<% @ Import NameSpace="PageAdmin"%>
<script language="c#" runat="server">
 string Ids,Table,TgTable,SiteId,Parameters,Rv,sql;
 DataTable DT;
 DataRow DR;
 OleDbConnection conn;
 protected void Page_Load(Object src,EventArgs e)
  {
    SiteId=Request.QueryString["siteid"];
    Table=Request.QueryString["table"];
    TgTable=Request.QueryString["tgtable"];
    Ids=Request.QueryString["ids"];
    Parameters=Request.QueryString["parameters"];
    Conn Myconn=new Conn();
    conn=Myconn.OleDbConn();//获取OleDbConnection
    if(string.IsNullOrEmpty(Ids))
     {
       return;
     }
    DT=new DataTable();
    DataRow DR=DT.NewRow();
    DT.Columns.Add("value", System.Type.GetType("System.String"));
    DT.Columns.Add("text", System.Type.GetType("System.String"));

    switch(Table)
      {
       case "pa_sort": //导入数据分类
        if(IsStr(Table) && IsStr(TgTable))
        {
         conn.Open();
          check_permission(Request.QueryString["from"]);
          load_sort();
         conn.Close();
        }
       break;

       case "pa_lanmu": //导入栏目
         conn.Open();
          check_permission("master");
           load_lanmu(0);
         conn.Close();
       break;

       case "zt": //导入专题
         conn.Open();
          check_permission("master");
           load_lanmu(1);
         conn.Close();
       break;

       case "pa_member": //导入用户
         conn.Open();
          check_permission("master");
          load_member();
         conn.Close();
       break;

       case "pa_membertype":  //导入会员组
         conn.Open();
          check_permission("master");
          load_membertype();
         conn.Close();
       break;

       case "pa_department":  //导入部门
         conn.Open();
          check_permission("master");
          load_department();
         conn.Close();
       break;

       default: //导入自定义表标题
        if(IsStr(Table) && IsStr(TgTable))
        {
         conn.Open();
         check_permission(Request.QueryString["from"]);
         load_datalist();
         conn.Close();
        }
       break;
      }
  Response.End();
 }

private void load_sort() //查找分类
 {
    OleDbCommand comm;
    OleDbDataReader dr;
    string[] AIds=Ids.Split(',');
    for(int i=0;i<AIds.Length;i++)
       {
          if(IsNum(AIds[i]))
           {
               sql="select id,site_id,parent_ids from pa_sort where id="+int.Parse(AIds[i]);
               comm=new OleDbCommand(sql,conn);
               dr=comm.ExecuteReader();
               while(dr.Read()) 
               {
                 DR=DT.NewRow();
                 DR["value"]=dr["id"].ToString();
                 DR["text"]=Get_SortName(dr["site_id"].ToString(),dr["parent_ids"].ToString()+","+dr["id"].ToString());
                 DT.Rows.Add(DR);
               }
               dr.Close();
           }
      }
    Rv=ToJson(DT);
    Response.Write(Rv);
 }

private void load_datalist() //载入自定义表单数据
 {
    OleDbCommand comm;
    OleDbDataReader dr;
    sql="select id from pa_table where thetable='"+Table+"'";//检查是否存在表
    comm=new OleDbCommand(sql,conn);
    dr=comm.ExecuteReader();
    if(!dr.Read()) 
      {
        Ids="";
      }
    dr.Close();
    string[] AIds=Ids.Split(',');
    for(int i=0;i<AIds.Length;i++)
       {
           if(IsNum(AIds[i]))
            {
               sql="select id,title,sort_id from "+Table+" where id="+int.Parse(AIds[i]);
               comm=new OleDbCommand(sql,conn);
               dr=comm.ExecuteReader();
               while(dr.Read()) 
               {
                 DR=DT.NewRow();
                 DR["value"]=dr["id"].ToString();
                 DR["text"]=Data_Sort(dr["sort_id"].ToString())+Server.HtmlEncode(dr["title"].ToString());
                 DT.Rows.Add(DR);
               }
               dr.Close();
            }
        }
     Rv=ToJson(DT);
     Response.Write(Rv);
 }

private void load_lanmu(int iszt) //查找栏目或者专题
 {
    OleDbCommand comm;
    OleDbDataReader dr;
    string[] AIds=Ids.Split(',');
    for(int i=0;i<AIds.Length;i++)
    {
      if(IsNum(AIds[i]))
         {
               sql="select id,name from pa_lanmu where iszt="+iszt+" and id="+int.Parse(AIds[i]);
               comm=new OleDbCommand(sql,conn);
               dr=comm.ExecuteReader();
               while(dr.Read()) 
               {
                 DR=DT.NewRow();
                 DR["value"]=dr["id"].ToString();
                 DR["text"]=Server.HtmlEncode(dr["name"].ToString());
                 DT.Rows.Add(DR);
               }
               dr.Close();
          }
     }
     Rv=ToJson(DT);
     Response.Write(Rv);
 }



private void load_member() //load用户列表
 {
    OleDbCommand comm;
    OleDbDataReader dr;
    string[] AIds=Ids.Split(',');

    for(int i=0;i<AIds.Length;i++)
       {
           if(IsNum(AIds[i]))
            {
               sql="select id,username,department_id,mtype_id from pa_member where id="+int.Parse(AIds[i]);
               comm=new OleDbCommand(sql,conn);
               dr=comm.ExecuteReader();
               while(dr.Read()) 
               {
                 DR=DT.NewRow();
                 DR["value"]=dr["id"].ToString();
                 if(Parameters=="department")
                  {
                   DR["text"]=Server.HtmlEncode(Get_Department(dr["department_id"].ToString())+dr["username"].ToString());
                  }
                 else if(Parameters=="membertype")
                  {
                    DR["text"]=Server.HtmlEncode(Get_MemberType(dr["mtype_id"].ToString())+dr["username"].ToString());
                  }
                 else
                  {
                    DR["text"]=Server.HtmlEncode(dr["username"].ToString());
                  }
                 DT.Rows.Add(DR);
               }
               dr.Close();
            }
      }
     Rv=ToJson(DT);
     Response.Write(Rv);
 }

private void load_department() //load用户分类列表
 {
    OleDbCommand comm;
    OleDbDataReader dr;
    string[] AIds=Ids.Split(',');
    for(int i=0;i<AIds.Length;i++)
      {
           if(IsNum(AIds[i]))
            {
               sql="select id,name from pa_department where id="+int.Parse(AIds[i]);
               comm=new OleDbCommand(sql,conn);
               dr=comm.ExecuteReader();
               while(dr.Read()) 
               {
                 DR=DT.NewRow();
                 DR["value"]=dr["id"].ToString();
                 DR["text"]=dr["name"].ToString();
                 DT.Rows.Add(DR);
               }
               dr.Close();
            }
     }
    Rv=ToJson(DT);
    Response.Write(Rv);
 }

private void load_membertype() //load用户分类列表
 {
    OleDbCommand comm;
    OleDbDataReader dr;
    string[] AIds=Ids.Split(',');
    for(int i=0;i<AIds.Length;i++)
      {
           if(IsNum(AIds[i]))
            {
               sql="select id,name from pa_member_type where id="+int.Parse(AIds[i]);
               comm=new OleDbCommand(sql,conn);
               dr=comm.ExecuteReader();
               while(dr.Read()) 
               {
                 DR=DT.NewRow();
                 DR["value"]=dr["id"].ToString();
                 DR["text"]=dr["name"].ToString();
                 DT.Rows.Add(DR);
               }
               dr.Close();
            }
     }
    Rv=ToJson(DT);
    Response.Write(Rv);
 }

private string Data_Sort(string sort_id)
 {
   string rv="";
   OleDbCommand comm;
   OleDbDataReader dr;
   sql="select id,site_id,parent_ids from pa_sort where id="+int.Parse(sort_id);
   comm=new OleDbCommand(sql,conn);
   dr=comm.ExecuteReader();
   if(dr.Read()) 
    {
       rv=Get_SortName(dr["site_id"].ToString(),dr["parent_ids"].ToString()+","+dr["id"].ToString())+">";
    }
   dr.Close();
   return rv;
 }

private string Get_SortName(string SiteId,string Parent_Ids)
 {
   string rv="";
   OleDbCommand comm;
   OleDbDataReader dr;
   string sql="select sitename from pa_site where id="+SiteId;
   comm=new OleDbCommand(sql,conn);
   dr=comm.ExecuteReader();
   if(dr.Read())
   {
     rv+="【"+dr["sitename"].ToString()+"】";
   }
  dr.Close();

  if(Parent_Ids!="0")
   {
     string[] A=Parent_Ids.Split(',');
     for(int i=0;i<A.Length;i++)
      {
        if(IsNum(A[i]))
         {
           sql="select sort_name,sort_level from pa_sort where id="+int.Parse(A[i]);
           comm=new OleDbCommand(sql,conn);
           dr=comm.ExecuteReader();
           if(dr.Read())
            {
              if(dr["sort_level"].ToString()!="1")
               {
                rv+=">";
               }
              rv+=dr["sort_name"].ToString();
            }
           dr.Close();
         }
      }
   }
  return rv;
 }

private string Get_Department(string departmentid)
 {
   string rv="";
   string sql="select name from pa_department where id="+int.Parse(departmentid);
   OleDbCommand comm=new OleDbCommand(sql,conn);
   OleDbDataReader dr=comm.ExecuteReader();
   if(dr.Read())
     {
       rv="【"+dr["name"].ToString()+"】";
     }
   dr.Close();
   return rv;
 }  

private string  Get_MemberType(string membertypeid)
 {
   string rv="";
   string sql="select name from pa_member_type where id="+int.Parse(membertypeid);
   OleDbCommand comm=new OleDbCommand(sql,conn);
   OleDbDataReader dr=comm.ExecuteReader();
   if(dr.Read())
     {
       rv="【"+dr["name"].ToString()+"】";
     }
   dr.Close();
   return rv;
 }  

 
private void check_permission(string from)
 {
   if(from=="master")
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
 }

private void Check_TG(string SiteId,int M_typeid,int DepartmentId)
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

private string ToJson(OleDbDataReader dataReader) //DataRead转json
        {
            StringBuilder jsonString = new StringBuilder();
            jsonString.Append("[");
            while (dataReader.Read())
            {
                jsonString.Append("{");
                for (int i = 0; i < dataReader.FieldCount; i++)
                {
                    Type type = dataReader.GetFieldType(i);
                    string strKey = dataReader.GetName(i);
                    string strValue = dataReader[i].ToString();
                    jsonString.Append("\"" + strKey + "\":");
                    strValue =JsonFormat(strValue, type);
                    if (i < dataReader.FieldCount - 1)
                    {
                        jsonString.Append(strValue + ",");
                    }
                    else
                    {
                        jsonString.Append(strValue);
                    }
                }
                jsonString.Append("},");
            }
            dataReader.Close();
            jsonString.Remove(jsonString.Length - 1, 1);
            jsonString.Append("]");
            string rv=jsonString.ToString();
            if(rv=="]"){rv="";}
            return jsonString.ToString();
        }

private string ToJson(DataTable dt)   //DataTable转json
        {
            DataRowCollection drc = dt.Rows;
            if(drc.Count==0){return "";}
            StringBuilder jsonString = new StringBuilder();
            jsonString.Append("[");
            for (int i = 0; i < drc.Count; i++)
            {
                jsonString.Append("{");
                for (int j = 0; j < dt.Columns.Count; j++)
                {
                    string strKey = dt.Columns[j].ColumnName;
                    string strValue = drc[i][j].ToString();
                    Type type = dt.Columns[j].DataType;
                    jsonString.Append("\"" + strKey + "\":");
                    strValue =JsonFormat(strValue, type);
                    if (j < dt.Columns.Count - 1)
                    {
                        jsonString.Append(strValue + ",");
                    }
                    else
                    {
                        jsonString.Append(strValue);
                    }
                }
                jsonString.Append("},");
            }
            jsonString.Remove(jsonString.Length-1, 1);
            jsonString.Append("]");
            return jsonString.ToString();
        }

private string JsonFormat(string str,Type type)
     {
            if (type == typeof(string))
            {
              StringBuilder sb = new StringBuilder();
              for (int i = 0; i <str.Length; i++)
              {
                char c = str.ToCharArray()[i];
                switch (c)
                {
                    case '\"':
                        sb.Append("\\\""); break;
                    case '\\':
                        sb.Append("\\\\"); break;
                    case '/':
                        sb.Append("\\/"); break;
                    case '\b':
                        sb.Append("\\b"); break;
                    case '\f':
                        sb.Append("\\f"); break;
                    case '\n':
                        sb.Append("\\n"); break;
                    case '\r':
                        sb.Append("\\r"); break;
                    case '\t':
                        sb.Append("\\t"); break;
                    default:
                        sb.Append(c); break;
                }
              }
               str=sb.ToString();
              str = "\"" + str + "\"";
            }
            else if (type == typeof(DateTime))
            {
                DateTime dt = DateTime.Parse(str);
                str = "\"" + dt.GetDateTimeFormats('s')[0].ToString() + "\"";
                // str = + str + ;
            }
            else if (type == typeof(bool))
            {
                str = str.ToLower();
            }
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
  string str1="0123456789";
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
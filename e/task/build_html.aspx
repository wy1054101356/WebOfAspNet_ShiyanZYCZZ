<% @ Page Language="C#"%>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<% @ Import NameSpace="PageAdmin"%>
<script language="c#" Runat="server">
 string Table,Ids,LanmuIds,SubLanmuIds,SlidIds,AdvIds,Url_Prefix,Language,SiteDir,ErrorUrl,LocalUrl,sql;
 int PageSize,PageCount,Page_Num;
 OleDbConnection conn;
 Build_Html BH;
 protected void Page_Load(Object src,EventArgs e)
  {
    LanmuIds=Request.QueryString["lanmuids"];
    SubLanmuIds=Request.QueryString["sublanmuids"];
    SlidIds=Request.QueryString["slideids"];
    AdvIds=Request.QueryString["advids"];
    Table=Request.QueryString["table"];
    Ids=Request.QueryString["ids"];
    Conn theconn=new Conn();
    conn=theconn.OleDbConn();//获取OleDbConnection
    conn.Open();
    check_code();//检测安全码，避免恶意刷新
    BH=new Build_Html();
    if(LanmuIds!=null)
    {
      Build_Lanmu(LanmuIds);
    }
    if(SubLanmuIds!=null)
    {
      Build_SubLanmu(SubLanmuIds);
    }
    if(SlidIds!=null)
    {
      Build_Slide(SlidIds);
    }
    if(AdvIds!=null)
    {
      Build_Adv(AdvIds);
    }
    if(Ids!=null && IsStr(Table))
    {
      Build_Detail(Ids);
    }

    conn.Close();
  }

private void check_code()
 {
   string id=Request.QueryString["id"];
   string s_code=Request.QueryString["security_code"];
   if(!IsNum(id) || !IsNum(s_code))
    {
     Response.Write("security_code参数错误！");
     Response.End();
     conn.Close();
    }
    string sql="select id from pa_task where id="+id+" and security_code='"+s_code+"'";
    OleDbCommand comm=new OleDbCommand(sql,conn);
    OleDbDataReader dr=comm.ExecuteReader();
    if(!dr.Read()) 
     {
      Response.Write("security_code参数不匹配！");
      Response.End();
      conn.Close();
     }
   dr.Close();
 }

private void Build_Detail(string Ids)
 {

    if(Ids!=null && IsNum(Ids.Replace(",","")))
     {
       if(IsNum(Ids))
        {
         sql="select id,site_dir,static_dir,static_file,lanmu_id,sublanmu_id from "+Table+" where html=2 and id="+Ids;
        }
       else
        {
         sql="select id,site_dir,static_dir,static_file,lanmu_id,sublanmu_id from "+Table+" where html=2 and id in("+Ids+")";
        }
       OleDbCommand comm=new OleDbCommand(sql,conn);
       OleDbDataReader dr=comm.ExecuteReader();
       while(dr.Read()) 
        {

          try
           {
            BH.Build_Detail(dr["site_dir"].ToString(),dr["static_dir"].ToString(),dr["static_file"].ToString(),dr["lanmu_id"].ToString(),dr["sublanmu_id"].ToString(),dr["id"].ToString());
           }
          catch(Exception e)
          {
            LocalUrl="http://"+Request.ServerVariables["SERVER_NAME"]+":"+Request.ServerVariables["SERVER_PORT"];
            SiteDir=dr["site_dir"].ToString();
            SiteDir=(SiteDir==""?"/":("/"+SiteDir+"/"));
            ErrorUrl=LocalUrl+SiteDir+"index.aspx?lanmuid="+dr["lanmu_id"].ToString()+"&sublanmuid="+dr["sublanmu_id"].ToString()+"&id="+dr["id"].ToString();
            Response.Write(ErrorUrl+"读取错误："+e.ToString());
            Response.End();
            break;
          }
        }
      dr.Close();
      Response.Write("生成"+Table+"表内容页成功!<br>");
     }
 }

private void Build_Lanmu(string Ids)
 {
    if(Ids!=null && IsNum(Ids.Replace(",","")))
     {
       if(IsNum(Ids))
        {
          sql="select site_id,id,site_dir,lanmu_dir,[html],thetype from pa_lanmu where id="+Ids;
        }
       else
        {
          sql="select site_id,id,site_dir,lanmu_dir,[html],thetype from pa_lanmu where id in("+Ids+")";
        }
      OleDbCommand comm=new OleDbCommand(sql,conn);
      OleDbDataReader dr=comm.ExecuteReader();
      while(dr.Read())
      {
        SiteDir=dr["site_dir"].ToString();
        try
         {
          BH.Build_Lanmu(int.Parse(dr["html"].ToString()),dr["site_id"].ToString(),SiteDir,dr["lanmu_dir"].ToString(),dr["thetype"].ToString(),dr["id"].ToString());
         }
        catch(Exception e)
         {
            LocalUrl="http://"+Request.ServerVariables["SERVER_NAME"]+":"+Request.ServerVariables["SERVER_PORT"];
            SiteDir=(SiteDir==""?"/":("/"+SiteDir+"/"));
            ErrorUrl=LocalUrl+SiteDir+"index.aspx?lanmuid="+dr["id"].ToString();
            Response.Write(ErrorUrl+"读取错误!");
            Response.End();
            break;
         }
      }
      dr.Close();
      Response.Write("生成栏目/专题栏目页成功!<br>");
     }
 }



private void Build_SubLanmu(string Ids)
 {
    if(Ids!=null && IsNum(Ids.Replace(",","")))
     {
       int BuildHomeHtml;
       if(IsNum(Ids))
        {
         sql="select site_id,id,site_dir,lanmu_dir,lanmu_id,parent_dir,sublanmu_dir,sublanmu_file,thetable,sort_id,list_html from pa_sublanmu where id="+Ids;
        }
       else
        {
        sql="select site_id,id,site_dir,lanmu_dir,lanmu_id,parent_dir,sublanmu_dir,sublanmu_file,thetable,sort_id,list_html from pa_sublanmu where id in("+Ids+")";
        }
      OleDbCommand comm=new OleDbCommand(sql,conn);
      OleDbDataReader dr=comm.ExecuteReader();
      while(dr.Read())
      {
        BuildHomeHtml=1;

        if(dr["thetable"].ToString()=="" || dr["thetable"].ToString()=="zdy")
         {
          if(dr["list_html"].ToString()=="0")
          {
            BuildHomeHtml=0;
          }
         }
        else if(dr["list_html"].ToString()!="2")
         {
           BuildHomeHtml=0;
         }
        try
         {
          BH.Build_SubLanmu(BuildHomeHtml,dr["site_id"].ToString(),dr["site_dir"].ToString(),dr["lanmu_id"].ToString(),dr["lanmu_dir"].ToString(),dr["id"].ToString(),dr["parent_dir"].ToString(),dr["sublanmu_dir"].ToString(),dr["sublanmu_file"].ToString(),dr["thetable"].ToString(),0);
         }
        catch(Exception e)
         {
            LocalUrl="http://"+Request.ServerVariables["SERVER_NAME"]+":"+Request.ServerVariables["SERVER_PORT"];
            SiteDir=dr["site_dir"].ToString();
            SiteDir=(SiteDir==""?"/":("/"+SiteDir+"/"));
            ErrorUrl=LocalUrl+SiteDir+"index.aspx?lanmuid="+dr["lanmu_id"].ToString()+"&sublanmuid="+dr["id"].ToString();
            Response.Write(ErrorUrl+"读取错误!");
            Response.End();
            break;
         }

        if(dr["thetable"].ToString()!="zdy" && dr["thetable"].ToString()!="" && dr["list_html"].ToString()=="2") //生成静态page页
         {
            Get_Sublanmu(int.Parse(dr["id"].ToString()));
            for(int i=1;i<=Page_Num;i++)
             {
               BH.Build_SubLanmu(1,dr["site_id"].ToString(),dr["site_dir"].ToString(),dr["lanmu_id"].ToString(),dr["lanmu_dir"].ToString(),dr["id"].ToString(),dr["parent_dir"].ToString(),dr["sublanmu_dir"].ToString(),i+".html",dr["thetable"].ToString(),i);
             }
         }

      }
      dr.Close();
      Response.Write("生成子栏目页成功!<br>");
     }
 }

private void Get_Sublanmu(int Sublanmu_Id)
 {
   sql="select site_id,sort_id,thetable,zdy_condition,show_num,list_html_page from pa_sublanmu where id="+Sublanmu_Id;
   OleDbCommand comm=new OleDbCommand(sql,conn);
   OleDbDataReader dr=comm.ExecuteReader();
   string count_sql="";
   if(dr.Read())
    {
       string Site_Id=dr["site_id"].ToString();
       int Sort_Id=int.Parse(dr["sort_id"].ToString());
       PageSize=int.Parse(dr["show_num"].ToString());
       Page_Num=int.Parse(dr["list_html_page"].ToString());
       string Thetable=dr["thetable"].ToString();
       string Sort_Ids=SortIds(Site_Id,Thetable,Sort_Id);
       string sql_condition=dr["zdy_condition"].ToString();
       if(sql_condition=="")
          {
           sql_condition=" ";
          }
         else
          {
           sql_condition=" and "+sql_condition+" ";
          }
         if(Sort_Id==0)
          {
            count_sql="select count(id) as co from "+Thetable+" where checked=1 and site_id="+Site_Id+sql_condition;
          }
         else
          {
           if(IsNum(Sort_Ids))
             {
              count_sql="select count(id) as co from "+Thetable+" where site_id="+Site_Id+" and checked=1 and sort_id="+Sort_Ids+sql_condition;
             }
           else
            {
             count_sql="select count(id) as co from "+Thetable+" where site_id="+Site_Id+" and checked=1 and sort_id in("+Sort_Ids+") "+sql_condition;
            }
          }
    }
   dr.Close();
   if(count_sql!="")
    {
     Tongji(count_sql);
    }
 }

private void Build_Slide(string Ids)
 {
    if(Ids!=null && IsNum(Ids.Replace(",","")))
     {
       if(IsNum(Ids))
        {
          sql="select id from pa_slide where id="+Ids;
        }
       else
        {
          sql="select id from pa_slide where id in("+Ids+")";
        }
      OleDbCommand comm=new OleDbCommand(sql,conn);
      OleDbDataReader dr=comm.ExecuteReader();
      while(dr.Read())
      {
        BH.Build_File("/e/aspx/slide.aspx?id="+dr["id"].ToString(),"/e/d/slide_"+dr["id"].ToString()+".js");
      }
      dr.Close();
      Response.Write("生成幻灯片成功!<br>");
    }
 }


private void Build_Adv(string Ids)
 {
    if(Ids!=null && IsNum(Ids.Replace(",","")))
     {
      
       if(IsNum(Ids))
        {
          sql="select id from pa_adv where id="+Ids;
        }
       else
        {
          sql="select id from pa_adv where id in("+Ids+")";
        }
      OleDbCommand comm=new OleDbCommand(sql,conn);
      OleDbDataReader dr=comm.ExecuteReader();
      while(dr.Read())
      {
        BH.Build_File("/e/aspx/adv.aspx?id="+dr["id"].ToString(),"/e/d/adv_"+dr["id"].ToString()+".js");
      }
      dr.Close();
      conn.Close();
      Response.Write("生成幻灯片成功!<br>");
    }
 }


private void Tongji(string sql)
  { 
     OleDbCommand comm=new OleDbCommand(sql,conn);
     OleDbDataReader dr= comm.ExecuteReader();
     int RecordCount;
     if(dr.Read())
     {
      RecordCount=int.Parse(dr["co"].ToString());
     }
     else
     {
       RecordCount=0;
     }
     dr.Close();
     if(RecordCount%PageSize==0)
      {
       PageCount=RecordCount/PageSize;
      }
     else
      {
       PageCount=RecordCount/PageSize+1;
      }
    if(Page_Num==0)
     {
       Page_Num=PageCount;
     }
    if(Page_Num>PageCount)
     {
      Page_Num=PageCount;
     }
  }

private string SortIds(string Site_Id,string Thetable,int SortId)
 {
     string Ids=SortId.ToString();
     string sql;
     if(SortId==0)
      {
       sql="select id from pa_sort where thetable='"+Thetable+"' and site_id="+Site_Id;
      }
     else
      {
       sql="select id from pa_sort where thetable='"+Thetable+"' and parent_ids like '%,"+SortId+",%'";
      }
     OleDbCommand comm=new OleDbCommand(sql,conn);
     OleDbDataReader dr=comm.ExecuteReader();
     while(dr.Read())
      {
        Ids+=","+dr["id"].ToString();
      }
    dr.Close();
    Ids=Ids.Replace(SortId.ToString()+",","");
    return Ids;
 }


private string Sql_Format(string str)
 {
  if(str=="" || str==null)
   {
    return "";
   }
   str=str.Replace("'","''");
   str=str.Replace("\"","\""); 
   return str;
 }

private bool IsStr(string str)
 {
  if(str=="" || str==null)
   {
    return false;
   }
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
  if(str=="" || str==null)
   {
    return false;
   }
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
<% @ Page language="c#"%> 
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<% @ Import NameSpace="System.IO"%>
<% @ Import NameSpace="PageAdmin"%>
<script language="c#" runat="server">
 string TheTable,TheMaster,List_Space,Sort_List,List_style,Site_Dir,Static_Dir,Parent_Sorts,Permissions,Comment_Open,Comment_Check,Comment_Anonymous,excle_path;
 int SiteId,List_Level,Lanmu_Id,Sublanmu_Id,Detail_Html;
 OleDbConnection conn;
 protected void Page_Load(Object src,EventArgs e)
  {
    SiteId=int.Parse(Request.Cookies["SiteId"].Value);
    TheTable=Request.QueryString["table"];
    Master_Valicate YZ=new Master_Valicate();
    YZ.Master_Check();
    TheMaster=YZ._UserName;
    if(!IsStr(TheTable))
     {
       ImportEnd("无效的table参数!");
       return;
     }
   Conn Myconn=new Conn();
   conn=Myconn.OleDbConn();//获取OleDbConnection
   if(!Page.IsPostBack)
    {
      conn.Open();
       if(TheTable=="pa_member")
        {
         MType_List();
        }
       else
        {
         CheckTable(TheTable);
         Get_Sort(0);
        }
      conn.Close();
   }
  else
   {
     lb_info.Text="";
     conn.Open();
      Load_Data();
     conn.Close();
   }
  }

private void CheckTable(string Table)
 {
   int finded=0;
   string sql="select id from pa_table where thetable='"+Table+"'";
   OleDbCommand comm=new OleDbCommand(sql,conn);
   OleDbDataReader dr=comm.ExecuteReader();
   if(dr.Read())
     {
       finded=1;
     }
   dr.Close();
   if(finded==0)
   {
    Response.End();
   }
 }

private void Get_Sort(int Parentid)
 {
   string sql="select id,sort_level,sort_name,final_sort from pa_sort where parent_id="+Parentid+" and thetable='"+TheTable+"' and site_id="+SiteId+" order by xuhao";
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
         Sort_List+="<option value='"+dr["id"].ToString()+"'>"+List_Space+"|-"+dr["sort_name"].ToString()+"</option>\r\n";
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
        Sort_List+="<option "+List_style+" value='"+dr["id"].ToString()+"' disabled>"+List_Space+"|-"+dr["sort_name"].ToString()+"</option>\r\n";
        Get_Sort(int.Parse(dr["id"].ToString()));
       }
    }
   dr.Close();
 }

private void MType_List()
 {
   string sql="select id,name,m_group from pa_member_type order by xuhao";
   OleDbCommand Comm=new OleDbCommand(sql,conn);
   OleDbDataReader dr=Comm.ExecuteReader();
   while(dr.Read())
    {
      Sort_List+="<option value=\""+dr["id"].ToString()+","+dr["m_group"].ToString()+"\">"+dr["name"].ToString()+"</option>\r\n";
    }
   dr.Close();
 }

private void Load_Data()
 {
   excle_path="";
   if(Request.Form["file_source"]=="0")
    {
     excle_path=Request.Form["excle_path"];
    }
   else
    {
     excle_path=Upload_File();
    }
   string excle_tablename=Request.Form["excle_tablename"];
   excle_path=Server.MapPath(excle_path);
   if(!File.Exists(excle_path))
    {
     ImportEnd("导入失败：Excle文件路径不存在。");
     return;
    }
   string File_ext=Path.GetExtension(excle_path).ToLower();
   if((".aspx,.asp,.php,.asa,.jsp,.shtml,.html,.htm").IndexOf(File_ext)>=0)
     {
      ImportEnd("禁止上传"+File_ext+"格式的文件。");
      return;
     }
   if((".xls,.xlsx").IndexOf(File_ext)<0)
     {
      ImportEnd("无效的Excle文件格式。");
      return;
     }
  string strConn;
  OleDbConnection excle_conn;
  OleDbDataAdapter myAdapter;
  DataSet ds=new DataSet();
  try
   {
    if(Request.Form["device_driver"]=="12.0")
     {
     strConn ="Provider=Microsoft.Ace.OleDb.12.0;" + "data source=" + excle_path + ";Extended Properties='Excel 12.0; HDR=Yes;IMEX=1'"; //此连接可以操作.xls与.xlsx文件 (支持Excel2003 和 Excel2007 的连接字符串)
     }
    else
     {
       strConn="Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" +excle_path+ ";Excel 8.0;HDR=YES";//此连接只能操作Excel2007之前(.xls)文件,且不能用于64位服务器。
     }
   excle_conn=new OleDbConnection(strConn);
   myAdapter=new OleDbDataAdapter ("select * from [" +excle_tablename+"$]", strConn);
   myAdapter.Fill(ds,"default");
  }
  catch(Exception e)
  {
    ImportEnd("导入失败："+e.Message);
    return;
  }
  int ColumnsLength=ds.Tables["default"].Columns.Count;
  string sql,FieldName;
  OleDbCommand comm;
  OleDbDataReader dr;
  string Columns="",ColumnsType="";
  int nocheck=0; //是否是自定义字段
  string ljdouhao=",";
  for(int i=0;i<ColumnsLength;i++)
   {
     FieldName=ds.Tables["default"].Columns[i].ColumnName;
     nocheck=0;
     if(Columns=="")
        {
          ljdouhao="";
        }
      else
        {
          ljdouhao=",";
        }

     if(TheTable=="pa_member")
       {
        if(FieldName=="username")
          {
            Columns+=ljdouhao+"[username]";
            ColumnsType+=ljdouhao+"username";
            nocheck=1;
          }
        if(FieldName=="userpassword")
          {
            Columns+=ljdouhao+"[userpassword]";
            ColumnsType+=ljdouhao+"userpassword";
            nocheck=1;
          }
        if(FieldName=="department_id")
          {
            Columns+=ljdouhao+"[department_id]";
            ColumnsType+=ljdouhao+"int";
            nocheck=1;
          }
       }
     else
       {
        if(FieldName=="comments")
          {
            Columns+=ljdouhao+"[comments]";
            ColumnsType+=ljdouhao+"int";
            nocheck=1;
          }
        if(FieldName=="clicks")
          {
            Columns+=ljdouhao+"[clicks]";
            ColumnsType+=ljdouhao+"int";
            nocheck=1;
          }
        if(FieldName=="downloads")
          {
            Columns+=ljdouhao+"[downloads]";
            ColumnsType+=ljdouhao+"int";
            nocheck=1;
          }
        if(FieldName=="reserves")
          {
            Columns+=ljdouhao+"[reserves]";
            ColumnsType+=ljdouhao+"int";
            nocheck=1;
          }
       }
     if(nocheck==0)
      {
        sql="select value_type from pa_field where thetable='"+TheTable+"' and [field]='"+Sql_Format(FieldName)+"'";
        comm=new OleDbCommand(sql,conn);
        dr=comm.ExecuteReader();
        if(dr.Read())
         {
            Columns+=ljdouhao+"["+FieldName+"]";
            ColumnsType+=ljdouhao+dr["value_type"].ToString();
         }
        dr.Close();
      }
   }
   if(TheTable=="pa_member")
     {
      if(Columns.IndexOf("username")<0)
      {
       ImportEnd("导入失败：导入的表中必须有username字段。");
       return;
      }

      if(Columns.IndexOf("userpassword")<0)
      {
       ImportEnd("导入失败：导入的表中必须有userpassword字段。");
       return;
      }
     }
  if(Columns=="")
   {
     ImportEnd("导入失败：没有匹配的字段，请确保Excle文件中的列名和表单的字段值同名。");
     return;
   }

   string ExcleColumns=Columns;
   Get_Site(SiteId);
   
   int SortId=0;
   string m_group="defaultusers";
   if(TheTable!="pa_member")
    {
     SortId=int.Parse(Request.Form["sort"]);
     Get_Lanmu(SortId);
     Get_SortSet(SortId);
    }
   else
    {
      if(Request.Form["sort"]!="0")
       {
         string[] Asort=Request.Form["sort"].Split(',');
         SortId=int.Parse(Asort[0]);
         m_group=Asort[1];
       }
    }
   if(string.IsNullOrEmpty(Static_Dir))
   {
     Static_Dir=TheTable+"/"+DateTime.Now.ToString("yyyyMMdd");
   }
  else
   {
     DateTime ndt=DateTime.Now;
     string YYYY=ndt.ToString("yyyy");
     string YY=ndt.ToString("yy");
     string MM=ndt.ToString("MM");
     string DD=ndt.ToString("dd");
     Static_Dir=Static_Dir.Replace("{table}",TheTable).Replace("{yyyy}",YYYY).Replace("{yy}",YY).Replace("{mm}",MM).Replace("{dd}",DD);
    }
   string ColumnsValue;
   string[] AColumns=Columns.Split(',');
   string[] AColumnsType=ColumnsType.Split(',');
   ColumnsLength=AColumns.Length;
   string DtNow=DateTime.Now.ToString("yyyy-MM-dd HH:ss:mm");
   string fieldvalue="";
   Md5 JM=new Md5();
   int Member_IsExists=0;
   for(int i=0;i<ds.Tables["default"].Rows.Count;i++)
    {
      ColumnsValue="";
      for(int k=0;k<ColumnsLength;k++)
       {
         fieldvalue=UBB(ds.Tables["default"].Rows[i][AColumns[k].Replace("[","").Replace("]","")].ToString());
         if(AColumnsType[k]=="username")
           {
             if(HasMember(fieldvalue))
              {
                Member_IsExists=1;
              }
             else
              {
                Member_IsExists=0;  
              }
           }
          if(AColumnsType[k]=="int")
           {
              if(!IsNum(fieldvalue)){fieldvalue="0";}
              ColumnsValue+=(ColumnsValue==""?"":",")+fieldvalue;
           }
          else if(AColumnsType[k]=="float")
            {
              if(!IsFloat(fieldvalue)){fieldvalue="0";}
              ColumnsValue+=(ColumnsValue==""?"":",")+"'"+Sql_Format(fieldvalue)+"'";
            }
          else if(AColumnsType[k]=="datetime")
            {
              if(!IsDate(fieldvalue)){fieldvalue=DtNow;}
              ColumnsValue+=(ColumnsValue==""?"":",")+"'"+Sql_Format(fieldvalue)+"'";
            }
          else if(AColumnsType[k]=="userpassword" && fieldvalue.Length<15)
            {
              ColumnsValue+=(ColumnsValue==""?"":",")+"'"+JM.Get_Md5(fieldvalue)+"'";
            }
          else
            {
              ColumnsValue+=(ColumnsValue==""?"":",")+"'"+Sql_Format(fieldvalue)+"'";
            }
       }
      if(Columns.IndexOf("thedate")<0 && i==0)
      {
         Columns+=",[thedate]";
      }
      if(ExcleColumns.IndexOf("thedate")<0)
       {
         ColumnsValue+=",'"+DtNow+"'";
       }
      if(TheTable=="pa_member")
       {
        if(Member_IsExists==1){continue;}
        sql="insert into pa_member("+Columns+",mtype_id,m_group,site_id,checked,changetype_day,changetype,fnc_ky,fnc_xf,fnc_fk,fnc_rk,point_ky,point_xf,point_fk,point_rk,space_clicks,logins,lastdate,login_key) values("+ColumnsValue+","+SortId+",'"+m_group+"',0,0,0,0,0,0,0,0,0,0,0,0,0,0,'"+DtNow+"','"+DtNow+"')";
       }
      else
       {
        sql="insert into "+TheTable+"("+Columns+",site_id,site_dir,static_dir,lanmu_id,sublanmu_id,[html],username,checked,sort_id,actdate,permissions,comment_open,comment_check,comment_anonymous,reply_state,istg,iscg,iszt,source_id) values("+ColumnsValue+","+SiteId+",'"+Site_Dir+"','"+Static_Dir+"',"+Lanmu_Id+","+Sublanmu_Id+","+Detail_Html+",'"+TheMaster+"',1,"+SortId+",'"+DtNow+"','"+Permissions+"',"+Comment_Open+","+Comment_Check+","+Comment_Anonymous+",0,0,0,0,0)";
       }
      comm=new OleDbCommand(sql,conn);
      comm.ExecuteNonQuery(); 

    }
   if(Request.Form["file_source"]=="1")
    {
      File.Delete(excle_path);
    }
   Response.Write("<script type='text/javascript'>parent.suc();</"+"script>");
 }

private void Get_SortSet(int Sort_Id)
 {
   string sql="select parent_ids,work_id,reply_username,permissions,comment_open,comment_check,comment_anonymous,static_dir from pa_sort where id="+Sort_Id+" and thetable='"+TheTable+"'";
   OleDbCommand Comm=new OleDbCommand(sql,conn);
   OleDbDataReader dr=Comm.ExecuteReader();
   if(dr.Read())
     {
       Parent_Sorts=dr["parent_ids"].ToString();
       Permissions=dr["permissions"].ToString();
       Comment_Open=dr["comment_open"].ToString();
       Comment_Check=dr["comment_check"].ToString();
       Comment_Anonymous=dr["comment_anonymous"].ToString();
       if(dr["static_dir"].ToString()!="")
        {
          Static_Dir=dr["static_dir"].ToString();
        }
     }
   else
     {
      Parent_Sorts="0";
      Permissions="";
      Comment_Open="0";
      Comment_Check="0";
      Comment_Anonymous="0";
      Static_Dir="";
     }
   dr.Close();
 }

private void Get_Lanmu(int Sort_Id)
 {
   string sql;
   OleDbCommand Comm;
   OleDbDataReader dr;
   Lanmu_Id=0;
   Sublanmu_Id=0;
   Detail_Html=0;
  
   sql="select id,lanmu_id,[detail_html] from pa_sublanmu where is_sortsublanmu=1 and site_id="+SiteId+" and sort_id=0 and model_id>0 and detail_model_id>0 and thetable='"+TheTable+"'";
   Comm=new OleDbCommand(sql,conn);
   dr=Comm.ExecuteReader();
   if(dr.Read())
    {
      Lanmu_Id=int.Parse(dr["lanmu_id"].ToString());
      Sublanmu_Id=int.Parse(dr["id"].ToString());
      Detail_Html=int.Parse(dr["detail_html"].ToString());
     }
   dr.Close();
   sql="select static_dir from pa_table where thetable='"+TheTable+"'";
   Comm=new OleDbCommand(sql,conn);
   dr=Comm.ExecuteReader();
   if(dr.Read())
     {
       Static_Dir=dr["static_dir"].ToString();
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
              sql="select id,lanmu_id,[detail_html] from pa_sublanmu where is_sortsublanmu=1 and site_id="+SiteId+" and sort_id="+int.Parse(C_Sort)+" and thetable='"+TheTable+"'";
              Comm=new OleDbCommand(sql,conn);
              dr=Comm.ExecuteReader();
              if(dr.Read())
              {
                Lanmu_Id=int.Parse(dr["lanmu_id"].ToString());
                Sublanmu_Id=int.Parse(dr["id"].ToString());
                Detail_Html=int.Parse(dr["detail_html"].ToString());
                dr.Close();
                break;
              }
            dr.Close();
           }
        }

     }
 }
private void Get_Site(int Id)
 {
    string sql="select [directory],[html] from pa_site where id="+Id;
    OleDbCommand comm=new OleDbCommand(sql,conn);
    OleDbDataReader dr=comm.ExecuteReader();
    if(dr.Read())
      {
       Site_Dir=dr["directory"].ToString();
      }
    else
      {
       ImportEnd("无效的siteid参数!");
       Response.End();
       Site_Dir="";
      }
    dr.Close();
 }

private bool HasMember(string username)
 {
    bool rv=false;
    if(string.IsNullOrEmpty(username)){return true;}
    string sql="select id from pa_member where username='"+Sql_Format(username)+"'";
    OleDbCommand comm=new OleDbCommand(sql,conn);
    OleDbDataReader dr=comm.ExecuteReader();
    if(dr.Read())
      {
       rv=true;
      }
    dr.Close();
   return rv;
 }

private string Upload_File()
 {
    HttpPostedFile hpf=Request.Files["local_file"];
    int hpfLength=hpf.ContentLength;
    if(hpfLength==0)
      {
       ImportEnd("文件内容为空，请选择包含有效内容的文件!");
       return "";
      }
   string Source_FileName=Path.GetFileNameWithoutExtension(hpf.FileName);
   string File_ext=Path.GetExtension(hpf.FileName).ToLower();

   if((".aspx,.asp,.php,.asa,.jsp,.shtml,.html,.htm").IndexOf(File_ext)>=0)
     {
      ImportEnd("禁止上传"+File_ext+"格式的文件。");
      return "";
     }
   if((".xls,.xlsx").IndexOf(File_ext)<0)
     {
      ImportEnd("无效的Excle文件格式。");
      return "";
     }

     string SavePath="/e/upload/s"+SiteId+"/excel/";
     if(!Directory.Exists(Server.MapPath(SavePath)))
        {
         Directory.CreateDirectory(Server.MapPath(SavePath));
        }
     string File_Name=DateTime.Now.ToString("yyyyMMddHHmmss")+File_ext;
     int num=0;
     string Start_File_Name=File_Name;
     while(true)
       {
         if(!File.Exists(Server.MapPath(SavePath+File_Name)))
          {
            break;
          }
         num++;
         File_Name=(Start_File_Name.Split('.'))[0]+"_"+num+File_ext;
       }
      string SaveFile=SavePath+File_Name;
      hpf.SaveAs(Server.MapPath(SaveFile));
      return SaveFile;
 }

private void ImportEnd(string str)
 {
   if(Request.Form["file_source"]=="1" && excle_path!="")
    {
      File.Delete(excle_path);
    }
   Response.Write("<script type='text/javascript'>parent.postover(\""+str+"\");</"+"script>");
   Response.End();
 }

protected string UBB(string str)
  {
   if(string.IsNullOrEmpty(str)){return string.Empty;}
   str=str.Replace("\r\n","<br>");
   str=str.Replace("\n","<br>");
   return str;
  }

private string Sql_Format(string str)
 {
    if(string.IsNullOrEmpty(str)){return string.Empty;}
    str=Server.UrlDecode(Server.UrlEncode(str).Replace("%00",""));
    str=str.Replace("'","''");
    return str;
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
</script><% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx"%>
<aspcn:uc_head runat="server"/> 
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table border=0 cellpadding=10 cellspacing=0 width=98% >
 <tr>
<td valign=top align="left">
<iframe name="post_iframe" id="post_iframe" src="" frameborder=0 scroling=no height=1px width=1px marginwidth=0 marginheight=0 style="display:none"></iframe>
<form runat="server" Enctype="multipart/form-data"  target="post_iframe" >
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center class=table_style2>
<tr>
  <td valign=top>
   <table border=0 cellpadding=2 cellspacing=0 width=98% align=center>
    <tr>
    <td height=20px><b>当前操作表：</b><%=Request.QueryString["table"]%></td>
   </tr>
  </table>
  <table border=0 cellpadding=2 cellspacing=0 width=98% align=center>
    <tr>
    <td height=25px width=100>文件来源：</td><td align=left><input type="radio" value="0" name="file_source" id="file_source_0" checked onclick="check_source(0)">服务器文件&nbsp;&nbsp;<input type="radio" value="1" name="file_source" id="file_source_1" onclick="check_source(1)">本地上传</td>
   </tr>

    <tr id="tr_path">
    <td height=25px width=100>Excle文件路径：</td><td align=left><input type="text" name="excle_path" id="excle_path" style="width:200px"> 如：/mydata.xls表示此文件在站点根目录下</td>
   </tr>

    <tr id="tr_file" style="display:none">
    <td height=25px width=100>上传Excle文件：</td><td align=left><input type="file" name="local_file" id="local_file" size="30"></td>
   </tr>
    <tr>
    <td height=25px>Excle中的表名：</td><td align=left><input type="text" name="excle_tablename" id="excle_tablename" style="width:200px" value="Sheet1"> Excle中表的名称</td>
   </tr>
    <tr>
    <td height=25px>驱动程序版本：</td><td align=left><select name="device_driver" id="device_driver"><option value="8.0">Excel 8.0</option><option value="12.0">Excel 12.0</option></select>
    注：64位服务器或xlsx后缀文件必须用Excel12.0驱动程序
   </td>
   </tr>
    <tr>
    <td height=25px>导入的分类：</td><td align=left><select name="sort" id="sort"><option value=0>请选择要导入的分类</option><%=Sort_List%></select></td>
    </tr>
    <tr>
    <td height=25px colspan="2">
<div align=center style="padding:10px">
<span id="post_area">
<input type="submit" class=button value="提交" onclick="return checkinput()">
<input type="button" value="关闭" class="button" onclick="parent.CloseDialog()">
</span>
<span id="post_loading" style="display:none"><img src=images/loading.gif vspace="5" align=absmiddle>Loading...</span>
</div>
</td>
   </tr>
  </table>
</td>
</tr>
</table>
<div style="padding:5px 0 5px 0"><asp:Label id="lb_info" runat="server"/></div>
</td>
</tr>
</table>
</form>
</center>
</body>
<script language="javascript">
var str_sort="<%=Request.QueryString["sortid"]%>";
var table="<%=Request.QueryString["table"]%>"
if(str_sort!="")
 {
  if(table=="pa_member")
   {
    document.getElementById("sort").value=str_sort+",<%=Request.QueryString["group"]%>";
   }
  else
   {
    document.getElementById("sort").value=str_sort;
   }
 }
function check_source(type)
 {
   var tr_path=document.getElementById("tr_path");
   var tr_file=document.getElementById("tr_file");
   if(type==0)
    {
     tr_path.style.display="";
     tr_file.style.display="none";
    }
   else
    { 
     tr_path.style.display="none";
     tr_file.style.display="";
    }
 }

function checkinput()
 {
  if(document.getElementById("file_source_1").checked==true)
   {
    var local_file=document.getElementById("local_file");
    if(local_file.value=="")
    {
     alert("请选择要上传的Excle文件!");
     local_file.focus();
     return false;
    }
   }
  else
   {
    var excle_path=document.getElementById("excle_path");
    if(excle_path.value=="")
    {
     alert("请填写Excle文件路径!");
     excle_path.focus();
     return false;
    }
  }
  var excle_tablename=document.getElementById("excle_tablename");
  if(excle_tablename.value=="")
   {
    alert("请填写Excle文件表名!");
    excle_tablename.focus();
    return false;
   }
  startpost();
 }

function suc()
 {
  alert("导入成功,刷新信息管理页后可看到新的数据!");
  parent.CloseDialog();
 }
</script>
</html>
<% @ Page Language="C#"%>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<% @ Import NameSpace="PageAdmin"%>
<script Language="c#" Runat="server">
  OleDbConnection conn;
  string TheTable,Detail_Id;
  protected void Page_Load(Object src,EventArgs e)
   {
    Conn Myconn=new Conn();
    conn=Myconn.OleDbConn();//获取OleDbConnection
    TheTable=Request.QueryString["table"];
    Detail_Id=Request.QueryString["id"];
    if(IsStr(TheTable)) && IsNum(Detail_Id))
     {
      Get_Url();
     }
  }

private void Data_Bind()
 {
   conn.Open();
    string sql="select id from pa_table where thetable='"+TheTable+"'"; //判断表是否存在
    OleDbCommand comm=new OleDbCommand(sql,conn);
    OleDbDataReader dr=comm.ExecuteReader();
    if(!dr.Read())
     {
       TheTable="";
     }
    dr.Close();

   if(IsStr(TheTable)))


   conn.Close();
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

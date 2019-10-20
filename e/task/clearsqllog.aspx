<% @ Page language="c#"%>
<% @ Import  NameSpace="PageAdmin"%>
<% @ Import  NameSpace="System.Data"%>
<% @ Import  NameSpace="System.Data.OleDb"%>
<script language="C#" Runat="server">
protected void Page_Load(Object Src,EventArgs e)
 {
  clearlog();
 }
void clearlog()
 {
  string Dbtype=ConfigurationManager.AppSettings["DbType"].ToString();
  if(Dbtype!="1")
   {
    lb_info.Text="<font color=#ff0000>提示：</font>您正使用的是access数据库，不需要清理日志。";
    return;
   }
  lb_info.Text="";
  string sql,DbName="";
  string sqlstr=ConfigurationManager.AppSettings["SqlConnection"].ToString();
  string DbReg="Initial Catalog=(?<content>[^;=]+);";
  Regex  Reg=new  Regex(DbReg,RegexOptions.IgnoreCase);
  Match M=Reg.Match(sqlstr);   
  if(M.Success)   
   {
     DbName=M.Groups["content"].Value;
   }
  if(DbName=="")
   {
    lb_info.Text="<font color=#ff0000>出错：</font>数据库名定位失败。";
    return;
   }
  Conn myconn=new Conn();
  OleDbConnection conn=Myconn.OleDbConn();//获取OleDbConnection
  OleDbCommand comm;
  try
   {
    conn.Open();
    sql="DUMP TRANSACTION "+DbName+" WITH NO_LOG";
    comm=new OleDbCommand(sql,conn);
    comm.ExecuteNonQuery();

    sql="BACKUP LOG "+DbName+" WITH NO_LOG";
    comm=new OleDbCommand(sql,conn);
    comm.ExecuteNonQuery();

    sql="DBCC SHRINKDATABASE("+DbName+")";
    comm=new OleDbCommand(sql,conn);
    comm.ExecuteNonQuery();
   conn.Close();
   lb_info.Text="日志清理成功。";
  }
 catch(Exception ee)
  {
   lb_info.Text="<font color=#ff0000>错误：</font>"+ee.Message;
  }
 }
</script>
<asp:Label id="lb_info" runat="server" />
<% @ Page Language="C#"%>
<% @ Import NameSpace="System.IO"%>
<% @ Import NameSpace="System.Net"%>
<% @ Import NameSpace="System.Text"%>
<script Language="c#" Runat="server">
  protected void Page_Load(Object src,EventArgs e)
   {
       Update_File();
   }

  protected void Update_File()
    {
       string Version=Request.QueryString["version"];
       string UpdateVersion=Request.QueryString["updateversion"];
       string FilePath="/update.aspx";
       if(!File.Exists(Server.MapPath(FilePath)))
         {
           Response.Write("升级程序不存在，检查文件是否下载完毕或没有复制完整 。");
           Response.End();
         }
      try
       {
        if(File.Exists(Server.MapPath("/bin/PageAdmin.Web.dll")))
        {
          Post_Url(FilePath);
          Update_Log(Version,UpdateVersion);
          Response.Write("success");
        }
        else
         {
           Response.Write("开发模式");
         }
       }
      catch(Exception e)
       {
        Response.Write(e.Message);
       }
      Response.End();
   }      

private void Update_Log(string Version,string UpdateVersion)
 {
      string File_Path=Server.MapPath("/update.log");
      Encoding encoding=Encoding.GetEncoding("UTF-8"); 
      FileStream fs=new FileStream(File_Path,FileMode.Append,FileAccess.Write);
      StreamWriter rw=new StreamWriter(fs,encoding);
      rw.Write("升级时间："+DateTime.Now.ToString()+"\r\n升级日志："+Version+"升级到"+UpdateVersion+"\r\n--------------------------------------------------\r\n");
      rw.Flush();
      fs.Close();
 }


private void Post_Url(string posturl) 
　　{ 
         string str_domain="http://"+Request.ServerVariables["SERVER_NAME"].ToLower()+":"+Request.ServerVariables["SERVER_PORT"];
         Encoding encoding=Encoding.GetEncoding("utf-8"); 
         StringBuilder sbTemp = new StringBuilder();
         sbTemp.Append("post=autoupdate"); 
         byte[] bTemp =encoding.GetBytes(sbTemp.ToString());
         string url=str_domain+posturl;
         HttpWebRequest hwRequest=(HttpWebRequest)WebRequest.Create(url);
         hwRequest.Timeout =6000*1000;
         hwRequest.Method = "POST";
         hwRequest.ContentType = "application/x-www-form-urlencoded;"; 

         hwRequest.ContentLength = bTemp.Length;
         System.IO.Stream smWrite = hwRequest.GetRequestStream();
         smWrite.Write(bTemp,0,bTemp.Length);
         smWrite.Close();

         HttpWebResponse hwResponse = (HttpWebResponse)hwRequest.GetResponse();//发出请求
         //StreamReader srReader = new StreamReader(hwResponse.GetResponseStream(),encoding);
         //string strResult = srReader.ReadToEnd();
         //srReader.Close();
         hwResponse.Close();
　　} 

</script>
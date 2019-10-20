<% @ Page Language="C#" %>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<% @ Import NameSpace="System.Net"%>
<% @ Import NameSpace="System.IO"%>
<% @ Import NameSpace="PageAdmin"%>
<script language="c#" runat="server">
 string Id,VoteCode;
 public void Page_Load(Object src,EventArgs e)
  {
     Master_Valicate YZ=new Master_Valicate();
     YZ.Master_Check();       //PageAdmin网站管理系统管理权限验证
     Get_Code();
  }

public void Get_Code()
 {
   string Type=Request.QueryString["type"];
   switch(Type)
    {
     case "link":
      Id=Request.QueryString["id"];
      Link_Holder.Visible=true;
    break;

    case "slide":
      Id=Request.QueryString["id"];
      slide_Holder.Visible=true;
    break;

    case "vote":
     Id=Request.QueryString["id"];
     vote_Holder.Visible=true;

     string LocalUrl="http://"+Request.ServerVariables["SERVER_NAME"]+":"+Request.ServerVariables["SERVER_PORT"];
     System.Text.Encoding encoding=System.Text.Encoding.GetEncoding("UTF-8");
     WebRequest  MyReq=WebRequest.Create(LocalUrl+"/e/vote/vote.aspx?id="+Id);
     WebResponse MyRes=MyReq.GetResponse();
     Stream ReStream=MyRes.GetResponseStream();
     ReStream.ReadTimeout=5000;
     StreamReader Reader=new StreamReader(ReStream,encoding);
     VoteCode=Reader.ReadToEnd();
     Reader.Close();
     ReStream.Close();

     break;

    case "adv":
     Id=Request.QueryString["id"];
     adv_Holder.Visible=true;
     break;

    case "loginbox":
     Id=Request.QueryString["id"];
     loginbox_Holder.Visible=true;
     break;


    }
 }
public bool IsNum(string str)
 {
  if(str=="" || str==null)
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
<aspcn:uc_head runat="server" />
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr><td height=10></td></tr>
 <tr><td class=table_style1><b>JS/Html调用代码</b></td></tr>
 <tr><td height=10></td></tr>
</table>
<table border=0 cellpadding=10 cellspacing=0 width=95% >
 <tr>
<td valign=top align="left">
 <form runat="server">
 <asp:PlaceHolder id="Link_Holder" runat="server" Visible="false" >
 <textArea cols="80" rows="5">
<script src="/e/d/link_<%=Id%>.js" type="text/javascript"></script>
</textArea>
  <br><br>说明：复制以上代码到您需要调用的地方;
 </asp:PlaceHolder>

<asp:PlaceHolder id="slide_Holder" runat="server" Visible="false" >
<textArea cols="80" rows="4">
<script src="/e/aspx/slide.aspx?id=<%=Id%>" type="text/javascript"></script>
或
<script src="/e/d/slide_<%=Id%>.js" type="text/javascript"></script>
</textArea>
  <br><br>说明：复制以上代码到您需要调用的地方<br>第一种为动态读取数据，实时行强，但速度慢<br>第二种静态调用，速度快，但需要每次更新才能生成最新数据;
 </asp:PlaceHolder>

<asp:PlaceHolder id="vote_Holder" runat="server" Visible="false" >
<textArea cols="85" rows="20">
<%=Server.HtmlEncode(VoteCode)%>
</textArea>
  <br><br>说明：复制以上代码到您需要调用的地方;
 </asp:PlaceHolder>


<asp:PlaceHolder id="adv_Holder" runat="server" Visible="false" >
<textArea cols="80" rows="5">
<script src="/e/aspx/adv.aspx?id=<%=Id%>" type="text/javascript"></script>
或
<script src="/e/d/adv_<%=Id%>.js" type="text/javascript"></script>
</textArea>
  <br><br>说明：复制以上代码到您需要调用的地方<br>第一种为动态读取数据，实时行强，但速度慢<br>第二种静态调用，速度快，但需要每次更新才能生成最新数据;
 </asp:PlaceHolder>

<asp:PlaceHolder id="loginbox_Holder" runat="server" Visible="false" >
<textArea cols="80" rows="4" id="L_js">
<script src="/e/aspx/loginbox.aspx?id=<%=Id%>" type="text/javascript"></script>
</textArea>
<br><br>说明：复制以上代码到您需要调用的地方,可以根据需要填写各参数重新生成JS;
 </asp:PlaceHolder>


</form>
</td>
</tr>
</table>
</center>
</body>
</html>  




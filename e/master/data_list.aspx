<% @ Page Language="C#"%><script language="c#" runat="server">
 string TheTable,TheField,TheId,objid;
 protected void Page_Load(Object src,EventArgs e)
  {
   string Table=Request.QueryString["table"];
   if(IsStr(Table))
    {
     UserControl Uc=(UserControl)Page.LoadControl("~/e/zdymodel/"+Table+"/master/data_list.ascx");
     holder.Controls.Add(Uc);
    }
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
</script>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server" Type="data_list"/> 
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr><td height=10></td></tr>
 <tr><td class=table_style1><a href="javascript:location.reload()" title="点击刷新"><b><%=Request.QueryString["name"]%></b></a></td></tr>
 <tr><td height=10 ></td></tr>
</table>
<asp:PlaceHolder id="holder" runat="server" />
</center>
</body>
</html>  

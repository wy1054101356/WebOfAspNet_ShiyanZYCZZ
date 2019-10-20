<% @ Control Language="C#" Inherits="PageAdmin.nav_zdymodel" %>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%><%if(Zdy_Tag==0 && CleanContainer<2){%>
<div id="nav_<%=Nav_Id%>" <%=Nav_box_style%>class="nav_box<%=Nav_ClassName%>">
<%if(CleanContainer==0){%><div <%=Nav_titlebox_style%>class="nav_title"><span <%=Nav_title_style%>class="nav_sign"><%=Nav_title%></span><span <%=Nav_more_style%>class="nav_more"><%=More_Url%></span></div>
<%}if(Nav_Header!=""){Response.Write(Nav_Header);}%><div id="nav_content_<%=Nav_Id%>" <%=Nav_content_style%>class="nav_content">
<%}%><%conn.Open();%><ul id="n_<%=Nav_Id%>" style="overflow:hidden;height:150px;"><% 
DataTable dt=Get_Data();
DataRow dr;
for(int i=0;i<dt.Rows.Count;i++)
{
dr=dt.Rows[i];
%><li style="line-height:20px;"><a href="<%=Detail_Url(dr)%>" target="<%=Target%>" title="<%=Server.HtmlEncode(dr["title"].ToString())%>"><%=SubStr(dr["title"].ToString(),Title_Num,true)%></a></li>
<%
}
%></ul>
<script type="text/javascript">
new Marquee("n_<%=Nav_Id%>","top",1,null,null,50,0,null,null);
</script><%conn.Close();%>
<%if(Zdy_Tag==0 && CleanContainer<2){%></div>
</div><%}%>
﻿<% @ Control Language="C#" Inherits="PageAdmin.sublanmu_zdymodel"%>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<%=Zdy_Location%>
<div class="sublanmu_box sublanmu_box_<%=Sublanmu_Id%>">
<div class="sublanmu_content sublanmu_content_<%=Query_Table%>"><%=TheContent%><asp:PlaceHolder id="P_Search" Runat="server"/>
<%if(IsSearch==0){conn.Open();%><ul class="sublanmu_dl download">
<% 
string Line;
DataTable dt=Get_Data();
DataRow dr;
for(int i=0;i<dt.Rows.Count;i++)
 {
dr=dt.Rows[i];
if(((i+1)%5)==0)
 {
  Line="<li class='line'></line>";
 }
else
 {
  Line="";
 }
%>
<li><span class="title"><a href="<%=Detail_Url(dr)%>" target="<%=Target%>" title="<%=Server.HtmlEncode(dr["title"].ToString())%>"><img src="/e/images/icon/<%=dr["pa_geshi"]%>.gif" border=0 width=16 height=16 hspace=2 align=bottom><%=SubStr(dr["title"].ToString(),Title_Num,true)%></a></span>
<span class="date"><%=((DateTime)dr["thedate"]).ToString("yyyy-MM-dd")%></span>
<span class="clear"></span>
</li>
<%
 }
%>
</ul>
<%conn.Close();}
if(PageCount>1)
{
string PageHtml="<div class=\"sublanmu_page\">";
if(CurrentPage==1)
{
if(APage_LinkText[0]!=""){PageHtml+="<span class=\"firstpage\">"+APage_LinkText[0]+"</span>";} //首页
}
else if(CurrentPage>1)
{
 if(APage_LinkText[0]!=""){PageHtml+="<a href=\""+GoPage(1)+"\" class=\"firstpage\">"+APage_LinkText[0]+"</a>";} //首页
 if(APage_LinkText[1]!=""){PageHtml+=" <a href=\""+GoPage(CurrentPage-1)+"\" class=\"prevpage\">"+APage_LinkText[1]+"</a>";} //上一页
}
 int p=8; //表示开始时显示的页码总数
 int M=4; //超过p页后左右两边显示页码数
 int LastPage=1;
 if(CurrentPage<p)
  {
    LastPage=p;
    if(LastPage>PageCount)
     {
       LastPage=PageCount;
     }
    for(int i=1;i<=LastPage;i++)
    {
     if(CurrentPage==i)
      {
        PageHtml+=" <span class=\"c\">"+i.ToString()+"</span>";
      }
    else
      {
       PageHtml+=" <a href=\""+GoPage(i)+"\">"+i.ToString()+"</a>";
      }
    }
  }
 else
  {
    //PageHtml+=" <a href=\""+GoPage(CurrentPage-1)+"\">1...</a>";
    LastPage=CurrentPage+M;
    if(LastPage>PageCount)
     {
       LastPage=PageCount;
     }
    for(int i=(CurrentPage-M);i<=LastPage;i++)
    {
     if(CurrentPage==i)
      {
        PageHtml+=" <span class=\"c\">"+i.ToString()+"</span>";
      }
    else
      {
       PageHtml+=" <a href=\""+GoPage(i)+"\">"+i.ToString()+"</a>";
      }
    }

  }

if(CurrentPage<PageCount)
{
  if(LastPage<PageCount)
   {
     PageHtml+=" <a href=\""+GoPage(LastPage+1)+"\">...</a>";
   }
  if(APage_LinkText[2]!=""){PageHtml+=" <a href=\""+GoPage(CurrentPage+1)+"\" class=\"nextpage\">"+APage_LinkText[2]+"</a>";}  //下一页
  if(APage_LinkText[3]!=""){PageHtml+=" <a href=\""+GoPage(PageCount)+"\" class=\"lastpage\">"+APage_LinkText[3]+"</a>";}     //尾页
}
else if(CurrentPage==PageCount)
{
if(APage_LinkText[3]!=""){PageHtml+=" <span class=\"lastpage\">"+APage_LinkText[3]+"</span>";}     //尾页
}
if(Page_LinkInfo!=""){PageHtml+=" <span class=\"pageinfo\">"+String.Format(Page_LinkInfo,CurrentPage,PageCount,RecordCount)+"</span>";} //记录页次
PageHtml+="</div>";
Response.Write(PageHtml);
}%>
</div>
</div>
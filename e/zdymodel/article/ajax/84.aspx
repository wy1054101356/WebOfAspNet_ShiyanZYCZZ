<% @ Page language="c#" Inherits="PageAdmin.ajax_zdymodel"%>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<%conn.Open();%><div class="article">
<ul>
<% 
DataTable dt;
DataRow dr;
dt=Get_Data();
for(int i=0;i<dt.Rows.Count;i++)
 {
dr=dt.Rows[i];
%>
<li><span class="title">
<a href="<%=Detail_Url(dr)%>" target="_blank" title="<%=Server.HtmlEncode(dr["title"].ToString())%>" style="<%=dr["pa_style"]%>"><%=SubStr(dr["title"].ToString(),100,true)%></a></span>
<span class="date"><%=((DateTime)dr["thedate"]).ToString("yyyy-MM-dd")%></span>
<span class="clear"></span>
</li>
<%
 }
%>
</ul></div>
<%conn.Close();
if(PageCount>1)
{
string PageHtml="<div class=\"sublanmu_page ajax_zdymodel_page\">";
if(CurrentPage>1)
{
 if(APage_LinkText[0]!=""){PageHtml+="<a href=\"javascript:rajax_"+ Model_Id+Ajax_Num+"(1,"+Ajax_Syn+")\" class=\"firstpage\">"+APage_LinkText[0]+"</a>";} //首页
 if(APage_LinkText[1]!=""){PageHtml+=" <a href=\"javascript:rajax_"+ Model_Id+Ajax_Num+"("+(CurrentPage-1)+","+Ajax_Syn+")\" class=\"prevpage\">"+APage_LinkText[1]+"</a>";} //上一页
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
       PageHtml+=" <a href=\"javascript:rajax_"+ Model_Id+Ajax_Num+"("+i+","+Ajax_Syn+")\">"+i.ToString()+"</a>";
      }
    }
  }
 else
  {
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
       PageHtml+=" <a href=\"javascript:rajax_"+ Model_Id+Ajax_Num+"("+i+","+Ajax_Syn+")\">"+i.ToString()+"</a>";
      }
    }

  }

if(CurrentPage<PageCount)
{
  if(LastPage<PageCount)
   {
     PageHtml+=" <a href=\"javascript:rajax_"+ Model_Id+Ajax_Num+"("+(LastPage+1)+")\">...</a>";
   }
  if(APage_LinkText[2]!=""){PageHtml+=" <a href=\"javascript:rajax_"+ Model_Id+Ajax_Num+"("+(CurrentPage+1)+","+Ajax_Syn+")\" class=\"nextpage\">"+APage_LinkText[2]+"</a>";}  //下一页
  if(APage_LinkText[3]!=""){PageHtml+=" <a href=\"javascript:rajax_"+ Model_Id+Ajax_Num+"("+PageCount+","+Ajax_Syn+")\" class=\"lastpage\">"+APage_LinkText[3]+"</a>";} //尾页
}
if(Page_LinkInfo!=""){PageHtml+=" <span class=\"pageinfo\">"+String.Format(Page_LinkInfo,CurrentPage,PageCount,RecordCount)+"</span>";} //记录页次
PageHtml+="</div>";
Response.Write(PageHtml);
}%>
<% @ Control  Language="C#" Inherits="PageAdmin.patag"%>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<%Start();%>
<style type="text/css">
.search_list{clear:both;overflow:hidden}
.search_list li{clear:both;padding:0px 5px 5px 5px;margin-bottom:10px;border-bottom:1px dotted #cccccc;overflow:hidden}
.search_list li .title{float:left;height:25px;line-height:25px;}
.search_list li .title a{font-size:13px;}
.search_list li .date{float:right}
</style>
<script language="c#" runat="server">
string Sql_Format(string str,bool isFuzzyQuery)
 {
    if(string.IsNullOrEmpty(str)){return string.Empty;}
    str=Server.UrlDecode(Server.UrlEncode(str).Replace("%00",""));
    str=str.Replace("'","''");
    str=str.Replace("\"","\"");
    if(isFuzzyQuery)
     {
      str=str.Replace("[]","[[]]");
      str=str.Replace("[","[[]");
      str=str.Replace("]","[]]");
      str=str.Replace("_","[_]");
      str=str.Replace("%","[%]");
      str=str.Replace("^","[^]");
     }
    return str;
 }

protected string SubStr(string Title,int Title_Num,bool HtmlEncode)
{
   if(Title_Num==0)
    {
      return ""; }
   else
    {
       System.Text.RegularExpressions.Regex regex = new System.Text.RegularExpressions.Regex("[\u4e00-\u9fa5]+", System.Text.RegularExpressions.RegexOptions.Compiled);
       char[] stringChar = Title.ToCharArray();
       StringBuilder sb = new StringBuilder();
       int nLength = 0;
      for(int i = 0; i < stringChar.Length; i++)
       {
          if (regex.IsMatch((stringChar[i]).ToString()))
           {
            nLength += 2;
           }
         else
           {
             nLength = nLength + 1;
           }
         if(nLength <= Title_Num)
          {
           sb.Append(stringChar[i]);
          }
        else
         {
          break;
         }
      }
     if(sb.ToString() != Title)
      {
         sb.Append("...");
      }
    if(HtmlEncode)
      {
        return Server.HtmlEncode(sb.ToString());
      }
    else
      {
        return sb.ToString();
      }  }
}
</script>
<ul class="search_list">
<%
string sql_condition="";
string kw=Request.QueryString["kw"];
if(string.IsNullOrEmpty(kw))
 {
   Response.Write("<li class='noitem'>对不起，没有您要找的记录。</li>");
 }
else
 {
    string url=""; 
    kw=Sql_Format(kw.Trim(),true);
    kw=SubStr(kw,30,true).Replace("...","");
    sql_condition+=" and title like '%"+kw+"%'";
    string sql="select * from article where checked=1 and source_id=0 "+sql_condition;
    string countsql="select count(id) as co from article where checked=1 and source_id=0"+sql_condition;
    DataTable dt=Get_Data(sql,countsql,10);
    DataRow dr;
if(dt.Rows.Count>0)
  { for(int i=0;i<dt.Rows.Count;i++)
 {
  dr=dt.Rows[i]; //说明：给dr赋值 
  url=Detail_Url(dr,"article");
 %>
<li><span class="title"><a href="<%=url%>" target="_blank"><%=dr["title"]%></a></span>
<span class="date"><%=((DateTime)dr["thedate"]).ToString("yyyy-MM-dd")%></span>
</li>
<%
 }
}
else
 {
   Response.Write("<li class='noitem'>对不起，没有查询到匹配的记录，您可以更换关键词重新搜索。</li>");
 }
}
%>
</ul>
<script type="text/javascript">
var kw="<%=Server.HtmlEncode(Request.QueryString["kw"])%>";
if(kw!="" && Id("searchkw")!=null)
 {
   Id("searchkw").value=kw;
  }
</script>
<%End();
if(PageCount>1)
{
string PageHtml="<div id=\"sublanmu_page\" class=\"sublanmu_page\">";
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
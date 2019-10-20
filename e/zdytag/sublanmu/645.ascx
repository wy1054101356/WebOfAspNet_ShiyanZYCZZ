<% @ Control  Language="C#" Inherits="PageAdmin.patag"%>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<%Start();%>
<script language="c#" runat="server">
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
      return "";
    }
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
<ul class="allsearch">
<%
string sql_condition="";
string table=Request.QueryString["table"];
if(IsStr(table))
 {
   sql_condition+=" and thetable='"+table+"'";
 }
string kw=Request.QueryString["kw"];
if(string.IsNullOrEmpty(kw))
 {
   Response.Write("<li class='noitem'>对不起，没有您要找的记录。</li>");
 }
else
 {
   kw=Sql_Format(kw.Trim(),true);
   kw=SubStr(kw,30,true).Replace("...","");
   sql_condition+=" and title like '%"+kw+"%'";
string sql="select title,thetable,thedate,detail_id,introduction from pa_alldata where checked=1"+sql_condition+" order by thedate desc";
string countsql="select count(id) as co from pa_alldata where checked=1"+sql_condition;
string title,titpic,con,rkw,url;
DataTable dt,dt1;
dt=Get_Data(sql,countsql,10); 
DataRow dr,dr1;
if(dt.Rows.Count>0)
{
for(int i=0;i<dt.Rows.Count;i++)
 {
  dr=dt.Rows[i]; //说明：给dr赋值
  dt1=Get_Data("select * from "+dr["thetable"].ToString()+" where id="+dr["detail_id"].ToString());
  if(dt1.Rows.Count==1)
  {
    dr1=dt1.Rows[0];
    rkw="<span class='keyword'>"+kw+"</span>";
    title=dr1["title"].ToString().Replace(kw,rkw);
    url=Detail_Url(dr1,dr["thetable"].ToString());
    if(dr["thetable"].ToString()=="product")
     {
      titpic="<a href='"+url+"' target='_blank'><img src='"+dr1["titlepic"].ToString()+"'></a>";
     }
    else
     {
       titpic="";
      }
    con=SubStr(dr["introduction"].ToString(),150,true).Replace(kw,rkw);
%>
<li><span class="title"><a href="<%=url%>" target="_blank"><%=title%></a></span>
<span class="con"><%=titpic%><%=con%></span>
<span class="info">来源：<%=Get_Data("table_name","select table_name from pa_table where thetable='"+dr["thetable"].ToString()+"'")%> &nbsp; 发布时间:<%=((DateTime)dr["thedate"]).ToString("yyyy-MM-dd")%></span>
</li>
<%
 }
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
if(kw!="" && Id("s_kw")!=null)
 {
   Id("s_kw").value=kw;
  }
</script>
<%End();
if(PageCount>1)
{
string PageHtml="<div id=\"sublanmu_page\" class=\"sublanmu_page\">";
if(CurrentPage>1)
{
 if(APage_LinkText[0]!=""){PageHtml+="<a href=\""+GoPage(1)+"\">"+APage_LinkText[0]+"</a>";} //首页
 if(APage_LinkText[1]!=""){PageHtml+=" <a href=\""+GoPage(CurrentPage-1)+"\">"+APage_LinkText[1]+"</a>";} //上一页
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
  if(APage_LinkText[2]!=""){PageHtml+=" <a href=\""+GoPage(CurrentPage+1)+"\">"+APage_LinkText[2]+"</a>";}  //下一页
  if(APage_LinkText[3]!=""){PageHtml+=" <a href=\""+GoPage(PageCount)+"\">"+APage_LinkText[3]+"</a>";}     //尾页
}
if(Page_LinkInfo!=""){PageHtml+=" <span>"+String.Format(Page_LinkInfo,CurrentPage,PageCount,RecordCount)+"</span>";} //记录页次
PageHtml+="</div>";
Response.Write(PageHtml);
}%>
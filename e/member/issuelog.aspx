<% @ Page language="c#"%>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<% @ Import NameSpace="PageAdmin"%>
<% @ Import NameSpace="System.Text"%>
<% @ Import NameSpace="System.Text.RegularExpressions"%>
<% @ Import NameSpace="System.Configuration"%>
<script language="c#" runat="server">
 OleDbConnection conn;
 int PageSize,SiteId;
 string UserName,Url_Prefix,IsStatic,sql,SiteXml,Count_Sql,Query_Sql;
 protected void Page_Load(Object src,EventArgs e)
   {
    PageSize=15;
    Conn Myconn=new Conn();
    conn=Myconn.OleDbConn();//获取OleDbConnection
    if(!IsStr(Request.QueryString["from"])){return;}
    if(Request.QueryString["from"]=="master")
      {
        Master_Valicate Master=new Master_Valicate();
        Master.Master_Check();
        UserName=Master._UserName;
      }
    else
      {
        Member_Valicate Member=new Member_Valicate();
        Member.Member_Check();
        UserName=Member._UserName;
      }
   string Sql_Str="";
   if(IsDate(Request.QueryString["startdate"]) && IsDate(Request.QueryString["enddate"]))
    {
     if(ConfigurationManager.AppSettings["DbType"]=="1")
        {
         Sql_Str+=" and (thedate between '"+Request.QueryString["startdate"]+"' and '"+Request.QueryString["enddate"]+" 23:59:59')";
        }
     else
        {
         Sql_Str+=" and (thedate between #"+Request.QueryString["startdate"]+"# and #"+Request.QueryString["enddate"]+" 23:59:59#)";
        }
    }
    Query_Sql="select * from pa_issue where work_node>0 and username='"+UserName+"'"+Sql_Str+" order by id desc";
    Count_Sql="select count(id) as co from pa_issue where work_node>0 and username='"+UserName+"'"+Sql_Str;
    if(!Page.IsPostBack)
    {
      ViewState["CurrentPage"]=0;
      conn.Open();
        Tongji();
        Data_Bind();
     conn.Close();
   }
  }

private void Data_Bind()
 {
  int CurrentPage=(int)ViewState["CurrentPage"];
  int PageCount=(int)ViewState["PageCount"];
  if(CurrentPage>(PageCount-1))
   {
     CurrentPage=PageCount-1;
   }
  if(CurrentPage<0)
   {
     CurrentPage=0;
   }
  Lblcurrentpage.Text=(CurrentPage+1).ToString();

 //填充拉单
  Dp_page.Items.Clear();
  int StartPage,EndPage;
  int JS=100,MB=50;
  if(CurrentPage<JS)
   {
     StartPage=0;
     EndPage=JS;
   }
  else
   {
     StartPage=CurrentPage-MB;
     EndPage=CurrentPage+MB;
     Dp_page.Items.Add(new ListItem("1","0"));
     Dp_page.Items.Add(new ListItem("...",(StartPage-1).ToString()));
   }
  if(EndPage>=PageCount)
   {
     EndPage=PageCount;
   }

  for(int i=StartPage;i<EndPage;i++)
    {
     Dp_page.Items.Add(new ListItem((i+1).ToString(),i.ToString()));
    }
  if(PageCount>JS && EndPage<PageCount-1)
   {
     Dp_page.Items.Add(new ListItem("...",EndPage.ToString()));
   }
  if(EndPage<PageCount)
   {
     Dp_page.Items.Add(new ListItem(PageCount.ToString(),(PageCount-1).ToString()));
   }
  Dp_page.SelectedIndex=Dp_page.Items.IndexOf(Dp_page.Items.FindByValue(CurrentPage.ToString()));
 //填充下拉单
  
   First.Enabled=true;
   Prev.Enabled=true;
   Next.Enabled=true;
   Last.Enabled=true;
   if(CurrentPage>=PageCount-1)
    {
      Next.Enabled=false;
      Last.Enabled=false;
    }
   if(CurrentPage<=0)
     {
       First.Enabled=false;
       Prev.Enabled=false;
     }
  int StartIndex=CurrentPage*PageSize;
  DataSet ds=new DataSet();
  OleDbDataAdapter myAdapter=new OleDbDataAdapter(Query_Sql,conn);//在数据库和DataSet之间建立桥接。
  myAdapter.Fill(ds,StartIndex,PageSize,"default");
  P1.DataSource=ds.Tables["default"].DefaultView;
  P1.DataBind();
 }

private void Tongji()
{
//计算总记录
 OleDbCommand myComm=new OleDbCommand(Count_Sql,conn);
 OleDbDataReader dr=myComm.ExecuteReader();
 int Rcount;
  if(dr.Read())
   {
    Rcount=(int)dr["co"];
   }
  else
   {
   Rcount=0;
   }
 Lblrecordcount.Text=Rcount.ToString();

//计算总页数
 int PageCount;
 if(Rcount%PageSize==0)
  {
   PageCount=Rcount/PageSize;
  }
 else
 {
  PageCount=Rcount/PageSize+1;
 }

 ViewState["PageCount"]=PageCount;
 if(PageCount==0)
  {
    PageCount=1;
  }
 LblpageCount.Text=PageCount.ToString();
}


protected void Page_change(Object src,CommandEventArgs e)
   {
     int CurrentPage=(int)ViewState["CurrentPage"];
     int PageCount=(int)ViewState["PageCount"];
     string TheCommand= e.CommandName;
     switch(TheCommand)
      {
      case "First":
       CurrentPage=0;
       break;
      case "Prev":
        CurrentPage=CurrentPage-1;
       break;
      case "Next":
        CurrentPage=CurrentPage+1;
       break;
      case "Last":
        CurrentPage=PageCount-1;
       break;
     }

    ViewState["CurrentPage"]=CurrentPage;

    conn.Open();
     Data_Bind(); 
    conn.Close();
   }

protected void Page_select(Object src,EventArgs e)
   {
     int CurrentPage=int.Parse(Dp_page.SelectedItem.Value);
     ViewState["CurrentPage"]=CurrentPage;

     conn.Open();
      Data_Bind(); 
     conn.Close();
   }


protected string DetailUrl(string SiteId,string Lanmu_Id,string SubLanmu_Id,string Id)
 {
  Get_Site(int.Parse(SiteId));
  string Rv=Url_Prefix+"index.aspx?lanmuid="+Lanmu_Id+"&sublanmuid="+SubLanmu_Id+"&id="+Id;
  return Rv;
 }

protected string GetSortName(string sortid)
 {
   string Rv="";
   string sql="select sort_name from pa_sort where id="+int.Parse(sortid);
   OleDbCommand  myComm=new OleDbCommand(sql,conn);
   OleDbDataReader dr=myComm.ExecuteReader();
   if(dr.Read())
    {
      Rv="["+dr["sort_name"].ToString()+"]";
    }
   dr.Close();
   return Rv;
 }


private void Get_Site(int sid)
 {
   Url_Prefix="/";
   sql="select [directory],[domain],[html] from pa_site where id="+sid;
   OleDbCommand comm=new OleDbCommand(sql,conn);
   OleDbDataReader dr=comm.ExecuteReader();
   if(dr.Read())
    {
     string SiteDir=dr["directory"].ToString();
     string TheDomain=dr["domain"].ToString();
     IsStatic=dr["html"].ToString();
     if(TheDomain!="")
      {
        Url_Prefix="http://"+TheDomain.Replace("http://","")+"/";
      }
     if(SiteDir!="")
        {
          if(TheDomain=="")
           {
             Url_Prefix="/"+SiteDir+"/";
           }
          else
           {
             Url_Prefix+=SiteDir+"/";
           }
        }

    }
   else
    {
     IsStatic="0";
     dr.Close();
     conn.Close();
     Response.Write("<scrip"+"t type='text/javascript'>alert('无效的siteid!');location.href=location.href</s"+"cript>");
     Response.End();
    }
   dr.Close();
 }


protected void Data_Bound(Object sender,RepeaterItemEventArgs e)
 { 
   if (e.Item.ItemType   ==   ListItemType.Item   ||   e.Item.ItemType   ==   ListItemType.AlternatingItem) 
    { 
     Label Lb_id=(Label)e.Item.FindControl("Lb_DetailId");
     int Detail_ID=int.Parse(Lb_id.Text);
     Label Lb_Table=(Label)e.Item.FindControl("Lb_Table");
     string TheTable=Lb_Table.Text;
     Label Lb_Title=(Label)e.Item.FindControl("Lb_Title");

     string sql="select title,thedate,sort_id,site_id,lanmu_id,subLanmu_id from "+TheTable+" where id="+Detail_ID;
     OleDbCommand comm=new OleDbCommand(sql,conn);
     OleDbDataReader dr=comm.ExecuteReader();
     if(dr.Read())
     {
      if(dr["subLanmu_id"].ToString()=="0")
       {
         Lb_Title.Text=SubStr(dr["title"].ToString(),50,true);
       }
      else
       {
        Lb_Title.Text="<a href=\""+DetailUrl(dr["site_id"].ToString(),dr["lanmu_id"].ToString(),dr["subLanmu_id"].ToString(),Detail_ID.ToString())+"\" target=\"dataview\" title=\""+Server.HtmlEncode(dr["title"].ToString())+"\">"+SubStr(dr["title"].ToString(),50,true)+"<a>";
       }
     }
     dr.Close();

     Label Lb_worknode=(Label)e.Item.FindControl("Lb_WorkNode");
     sql="select name,work_id from pa_work_node where id="+int.Parse(Lb_worknode.Text);
     comm=new OleDbCommand(sql,conn);
     dr=comm.ExecuteReader();
     if(dr.Read())
     {
       Lb_worknode.Text=dr["name"].ToString();
     }
    else
     {
       Lb_worknode.Text="<span style='color:#999'>此步骤已被删除</span>";
     }
     dr.Close();

    }
 }



protected string SubStr(string Title,int Title_Num,bool HtmlEncode) 
{ 
   if(Title_Num==0)
    {
      return "";
    }
   else
    {
       Regex regex = new Regex("[\u4e00-\u9fa5]+", RegexOptions.Compiled); 
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


private string Sql_Format(string str)
 {
   if(string.IsNullOrEmpty(str)){return "";}
   str=str.Replace("'","''");
   str=str.Replace("\"","\""); 
   return str;
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

private bool IsDate(string str)
 {
  //日期
  if(System.Text.RegularExpressions.Regex.IsMatch((str==null?"":str), @"^((((1[6-9]|[2-9]\d)\d{2})-(0?[13578]|1[02])-(0?[1-9]|[12]\d|3[01]))|(((1[6-9]|[2-9]\d)\d{2})-(0?[13456789]|1[012])-(0?[1-9]|[12]\d|30))|(((1[6-9]|[2-9]\d)\d{2})-0?2-(0?[1-9]|1\d|2[0-9]))|(((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))-0?2-29-))$"))
   {
     return true;
   }
  else
   {
    //日期+时间
    return System.Text.RegularExpressions.Regex.IsMatch((str==null?"":str), @"^(((((1[6-9]|[2-9]\d)\d{2})-(0?[13578]|1[02])-(0?[1-9]|[12]\d|3[01]))|(((1[6-9]|[2-9]\d)\d{2})-(0?[13456789]|1[012])-(0?[1-9]|[12]\d|30))|(((1[6-9]|[2-9]\d)\d{2})-0?2-(0?[1-9]|1\d|2[0-8]))|(((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))-0?2-29-)) (20|21|22|23|[0-1]?\d):[0-5]?\d:[0-5]?\d)$");
   }
 }

</script>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>我的签发记录</title>
<meta name="Author" content="PageAdmin CMS" />
<meta http-equiv="X-UA-Compatible" content="IE=7" />
<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/ >
<script src="/e/js/comm.js" type="text/javascript"></script>
<script src="/e/js/calendar.js" type="text/javascript"></script>
<style type=text/css>
body,div,ul,li,table,p,form,legend,fieldset,input button,select,textarea,button{margin:0px;padding:0px;font-family:inherit;font-size:inherit;}
input,select,textarea,button{font-size:100%;}
ul,li{list-style:none;}
table{border-collapse:collapse;border-spacing:0;}
a{color:#333333;text-decoration:none;}
a:hover{color:#CC0000;text-decoration:none;}
body{word-wrap:break-word;text-align:center;font:12px/20px Verdana,Helvetica,Arial,sans-serif;color:#333333;padding-top:10px}
.page_style{width:95%;margin:0px auto 0px auto;text-align:center;background-color:#ffffff;overflow:hidden;}

#Ftable{border:1px solid #4388A9;text-align:center;}
#Ftable td{border:1px solid #4388A9;padding:5px 2px}
.tdhead{background-color:#4388A9;color:#ffffff;text-align:center;font-weight:bold;border-color:#ffffff;}
.bt{width:55px;font-size:9pt;height:19px;cursor:pointer;background-image:url(/e/images/public/button.gif);background-position: center center;border-top: 0px outset #eeeeee;border-right: 0px outset #888888;border-bottom: 0px outset #888888;border-left: 0px outset #eeeeee;padding-top: 2px;background-repeat: repeat-x;}
.current{background-color:#efefef}

.overcolor td,.tb_datalist tr.overcolor td{background-color:#E0F0FE}

.sublanmu_page{clear:both;text-align:center;margin:15px 0 10px 0;font-size:12px;font-family:宋体;}
.sublanmu_page a{vertical-align:middle;zoom:1;height:15px;line-height:15px;padding:2px 8px 3px 8px;border:1px solid #cccccc;}
.sublanmu_page span.c{padding:2px 2px 3px 2px;font-weight:bold;border:0px solid #cccccc;}
.sublanmu_page span{vertical-align:middle;zoom:1;height:15px;line-height:15px;padding:2px 8px 3px 8px;}
.sublanmu_page span.c{padding:2px 2px 3px 2px;border:0px solid #cccccc;}
</style>
</head>
<body>
<div class="page_style">
<center>
<table border=0 cellpadding="2px" cellspacing="0" width=100% align=center>
   <tr>
      <td height=20 align="left">签发记录(用户：<%=UserName%>)</td>
     <td height=20 align="right">按日期
<input name="StartDate" id="StartDate" Maxlength="10" size="10" ><a href="javascript:open_calendar('StartDate')"><img src="/e/images/icon/date.gif" border=0 height=20 hspace=2 align=absbottom></a> 
到 
<input name="EndDate" id="EndDate" Maxlength="10" size="10"><a href="javascript:open_calendar('EndDate')"><img src="/e/images/icon/date.gif" border=0 height=20 hspace=2 align=absbottom></a> 
<input type="button" value="确定" class="button" onclick="Go()">
</td>
   </tr>
</table>
 <form runat="server" name="datalist">
  <table border=0 cellpadding=0 cellspacing=0 width=100% id="Ftable">
         <tr>
           <td width=50% align=center class=tdhead>信息</td>
           <td width=13% align=center class=tdhead>工作流步骤</td>
           <td width=15% align=center class=tdhead>操作</td>
           <td width=15% align=center class=tdhead>时间</td>
           <td width=7% align=center class=tdhead>记录</td>
         </tr>
      <asp:Repeater id="P1" runat="server" OnItemDataBound="Data_Bound">         
             <ItemTemplate>
                 <tr class="listitem">
                  <td align=left class="memlist_item"><asp:Label id="Lb_Title" runat="server" /></td>
                  <td align=left class="memlist_item"><asp:Label id="Lb_WorkNode" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"work_node")%>'/></td>
                  <td align=left class="memlist_item"><%#DataBinder.Eval(Container.DataItem,"act")%><div><%#DataBinder.Eval(Container.DataItem,"reply")%></div></td>
                  <td align=center class="memlist_item_last"><%#DataBinder.Eval(Container.DataItem,"thedate","{0:yyyy-MM-dd HH:mm}")%></td>
                  <td align=center class="memlist_item_last"><a href="javascript:state('<%#DataBinder.Eval(Container.DataItem,"id")%>','<%#DataBinder.Eval(Container.DataItem,"thetable")%>','<%#DataBinder.Eval(Container.DataItem,"detail_id")%>','<%#DataBinder.Eval(Container.DataItem,"work_node")%>')">查看</a></td>
                </tr>
               <asp:Label id="Lb_DetailId" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"detail_id")%>' visible="false"/>
               <asp:Label id="Lb_Table" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"thetable")%>' visible="false"/>
             </ItemTemplate>
          </asp:Repeater>
  </table>
<div class="sublanmu_page">
<span>共<asp:Literal id="Lblrecordcount"  Text=0 runat="server" />条记录</span> 
<span>页次：<asp:Literal id="Lblcurrentpage"  runat="server" />/<asp:Literal id="LblpageCount"  runat="server" /></span>
<asp:LinkButton id="First" CssClass="link" CommandName="First"  OnCommand="Page_change"  runat="server" Text="首页"/>
<asp:LinkButton id="Prev"  CssClass="link"  CommandName="Prev"  OnCommand="Page_change"  runat="server" Text="上一页"/>
<asp:LinkButton id="Next"  CssClass="link"  CommandName="Next"  OnCommand="Page_change"  runat="server" Text="下一页"/>
<asp:LinkButton id="Last"  CssClass="link"  CommandName="Last"  OnCommand="Page_change"  runat="server" Text="尾页"/>
转到：<asp:DropDownList id="Dp_page" runat="server" AutoPostBack="true" OnSelectedIndexChanged="Page_select">
</asp:DropDownList>页
</div>
</form>
<br>
</center>
<script type="text/javascript">
MouseoverColor("Ftable");

var From="<%=Request.QueryString["from"]%>";
var Sid="0";
function state(Id,Table,DetailId,Wid)
  {
   if(Wid=="0"){return false;}
   IDialog("操作记录","/e/member/state.aspx?s="+Sid+"&id="+Id+"&table="+Table+"&detailid="+DetailId+"&workid="+Wid+"&viewstate=1&from=<%=Request.QueryString["from"]%>",800,300);
  } 

function MouseoverColor(id)
{
 var trs=document.getElementById(id).getElementsByTagName("tr");
 for(var i=0 ;i<trs.length;i++)
  {
   if(trs[i].className.indexOf("listitem")>=0)
   {
   trs[i].onmouseover=function(){this.className+=" overcolor";}
   trs[i].onmouseout=function(){this.className=this.className.replace(" overcolor","")}
   }
  }
}

function open_calendar(Id,showtime)
 {
  var ObjId=document.getElementById(Id);
  if(showtime==1)
   {
    SelectDate(ObjId,'yyyy-MM-dd hh:mm:ss');
   }
  else
   {
    SelectDate(ObjId,'yyyy-MM-dd');
   }
 }

var obj_date1=document.getElementById("StartDate");
var obj_date2=document.getElementById("EndDate");
var StartDate="<%=Request.QueryString["startdate"]%>";
var EndDate="<%=Request.QueryString["enddate"]%>";
if(obj_date1!=null){obj_date1.value=StartDate;}
if(obj_date2!=null){obj_date2.value=EndDate;}
 function Go()
  { 
   location.href="?from="+From+"&startdate="+escape(obj_date1.value)+"&enddate="+escape(obj_date2.value);
  }
</script>
</body>
</html> 
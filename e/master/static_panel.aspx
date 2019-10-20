<% @ Page Language="C#"%>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<% @ Import NameSpace="PageAdmin"%>
<script language="c#" Runat="server">
 string SiteId,Table,Ids,LanmuIds,SubLanmuIds,sql,countsql,sort_ids,IsDetail,D1,D2,Date_Cs;
 int PageSize,PageCount,CurrentPage,RecordCounts;
 OleDbConnection conn;
 protected void Page_Load(Object src,EventArgs e)
  {
    Master_Valicate YZ=new Master_Valicate();
    YZ.Master_Check();
    SiteId=Request.QueryString["siteid"];
    D1=Request.QueryString["d1"];
    D2=Request.QueryString["d2"];
    if(SiteId==null || !IsNum(SiteId.Replace(",","")))
     {
      if(IsNum(Request.QueryString["siteid"]))
      {
       SiteId=Request.QueryString["siteid"];
      }
     else 
      {
       SiteId=Request.Cookies["SiteId"].Value;
      }
     }
    Ids=Request.QueryString["ids"];
    Table=Request.QueryString["table"];
    PageSize=500; //每组生成PageSize后刷新读取下一组
    if(!IsStr(Table))
     {
      Response.Write("无效的table!");
      Response.End();
     }
   IsDetail="0";
   if(Ids==null || !IsNum(Ids.Replace(",","")) || Table=="pa_sublanmu" || Table=="pa_lanmu")
    {
      Conn Myconn=new Conn();
      conn=Myconn.OleDbConn();//获取OleDbConnection
      conn.Open();
      string TJ="",DateTj="",SiteTj;
      if(IsNum(SiteId) && SiteId!="0")
        {
          SiteTj=" site_id="+SiteId+" ";
        }
      else
        {
          SiteTj=" site_id in("+SiteId+")";
        }
      if(IsDate(D1) && IsDate(D2))
       {
        Date_Cs="&d1="+D1+"&d2="+D2;
        if(ConfigurationManager.AppSettings["DbType"]=="1")
        {
         DateTj=" and (thedate between '"+D1+"' and '"+D2+" 23:59:59') ";
        }
        else
        {
         DateTj=" and (thedate between #"+D1+"# and #"+D2+" 23:59:59#) ";
        }
       }
       switch(Table)
         {
           case "pa_zt":
             LanmuIds=Request.QueryString["lanmuids"];
             if(LanmuIds=="0"){LanmuIds="";}
             if(LanmuIds==null || !IsNum(LanmuIds.Replace(",","")))
              {
               sql="select id from pa_lanmu where iszt=1 and "+SiteTj+DateTj;
               countsql="select count(id) as co from pa_lanmu where iszt=1 and "+SiteTj+DateTj;
              }
             else
              {
               sql="select id from pa_lanmu where iszt=1 and "+SiteTj+" and id in ("+LanmuIds+")";
               countsql="select count(id) as co from pa_lanmu where iszt=1 and "+SiteTj+" and id in ("+LanmuIds+")";
              }
             Ids="";
           break;

           case "pa_zt_sublanmu":
             LanmuIds=Request.QueryString["lanmuids"];
             if(LanmuIds=="0"){LanmuIds="";}
             SubLanmuIds=Request.QueryString["sublanmuids"];
             if(SubLanmuIds=="0"){SubLanmuIds="";}

             if(SubLanmuIds!=null && IsNum(SubLanmuIds.Replace(",","")) )
              {
               sql="select id from pa_sublanmu where iszt=1 and "+SiteTj+" and id in ("+SubLanmuIds+")";
               countsql="select count(id) as co from pa_sublanmu where iszt=1 and "+SiteTj+" and id in ("+SubLanmuIds+")";
              }
             else if(LanmuIds!=null && IsNum(LanmuIds.Replace(",","")) )
              {
               sql="select id from pa_sublanmu where iszt=1 and "+SiteTj+" and lanmu_id in ("+LanmuIds+")";
               countsql="select count(id) as co from pa_sublanmu where iszt=1 and "+SiteTj+" and lanmu_id in ("+LanmuIds+")";
              }
            else
              {
               sql="select id from pa_sublanmu where iszt=1 and "+SiteTj+DateTj;
               countsql="select count(id) as co from pa_sublanmu where iszt=1 and "+SiteTj+DateTj;
              }
             Ids="";

           break;

           case "pa_lanmu":
             LanmuIds=Request.QueryString["lanmuids"];
             if(LanmuIds=="0"){LanmuIds="";}
             if(LanmuIds==null || !IsNum(LanmuIds.Replace(",","")))
              {
               sql="select id from pa_lanmu where iszt=0 and "+SiteTj+" and thetype<>'external'";
               countsql="select count(id) as co from pa_lanmu where iszt=0 and "+SiteTj+" and thetype<>'external'";
              }
             else
              {
               sql="select id from pa_lanmu where "+SiteTj+" and thetype<>'external' and id in ("+LanmuIds+")";
               countsql="select count(id) as co from pa_lanmu where "+SiteTj+" and thetype<>'external' and id in ("+LanmuIds+")";
              }
             Ids="";
           break;

           case "pa_sublanmu":
             LanmuIds=Request.QueryString["lanmuids"];
             if(LanmuIds=="0"){LanmuIds="";}
             SubLanmuIds=Request.QueryString["sublanmuids"];
             if(SubLanmuIds=="0"){SubLanmuIds="";}

             if(SubLanmuIds!=null && IsNum(SubLanmuIds.Replace(",","")) )
              {
               sql="select id from pa_sublanmu where "+SiteTj+" and id in ("+SubLanmuIds+")";
               countsql="select count(id) as co from pa_sublanmu where "+SiteTj+" and id in ("+SubLanmuIds+")";
              }
             else if(LanmuIds!=null && IsNum(LanmuIds.Replace(",","")) )
              {
               sql="select id from pa_sublanmu where "+SiteTj+" and lanmu_id in ("+LanmuIds+")";
               countsql="select count(id) as co from pa_sublanmu where "+SiteTj+" and lanmu_id in ("+LanmuIds+")";
              }
            else
              {
               sql="select id from pa_sublanmu where iszt=0 and "+SiteTj;
               countsql="select count(id) as co from pa_sublanmu where iszt=0 and "+SiteTj;
              }
             Ids="";
           break;

           default:
            sort_ids=SortIds(Request.QueryString["sortid"]);
            if(sort_ids==null || sort_ids=="")
            {
              TJ="";
            }
           else
            {
              if(IsNum(sort_ids))
              {
                TJ=" and sort_id="+sort_ids;
              }
             else
              {
               TJ=" and sort_id in("+sort_ids+")";
              }
            }
            IsDetail="1";
            sql="select id from "+Table+" where "+SiteTj+" and checked=1 and source_id=0 and html=2 "+TJ+DateTj;
            countsql="select count(id) as co from "+Table+" where "+SiteTj+" and checked=1 and source_id=0 and html=2 "+TJ+DateTj;
            Ids="";
           break;
         }
     Tj(countsql);
     P_Read_List();
     conn.Close();
     if(Ids=="")
     {
      Response.Write("无生成记录!");
      Response.End();
     }
   }

  }

private void Tj(string sql) //分组生成
 {
 OleDbCommand myComm=new OleDbCommand(sql,conn);
 OleDbDataReader dr=myComm.ExecuteReader();
 RecordCounts=0;
  if(dr.Read())
   {
    RecordCounts=(int)dr["co"];
   }
  else
  {
   RecordCounts=0;
  }
 dr.Close();

 if(RecordCounts%PageSize==0)
  {
   PageCount=RecordCounts/PageSize;
  }
 else
  {
   PageCount=RecordCounts/PageSize+1;
  }

 }

private void P_Read_List() //分组生成
 {
   CurrentPage=0;
   if(IsNum(Request.QueryString["page"]))
    {
     CurrentPage=int.Parse(Request.QueryString["page"]);
    }
  int StartIndex=CurrentPage*PageSize;
  DataSet ds=new DataSet();
  OleDbDataAdapter myAdapter=new OleDbDataAdapter(sql,conn);//在数据库和DataSet之间建立桥接。
  myAdapter.Fill(ds,StartIndex,PageSize,"default");
  DataRow dr;
  int counts=ds.Tables["default"].Rows.Count;
  for(int i=0;i<counts;i++)
   {
    dr=ds.Tables["default"].Rows[i];
   if(Ids=="")
    {  
      Ids=dr["id"].ToString();
    }
   else
    {
      Ids+=","+dr["id"].ToString();
    }
  }

 }

private string SortIds(string SortId)
 {
     if(SortId==null){SortId="";}
     if(SortId==""){return "";}
     string Ids=SortId; 
     string sql="select id from pa_sort where parent_ids like '%,"+SortId+",%' order by sort_level,xuhao";
     OleDbCommand comm=new OleDbCommand(sql,conn);
     OleDbDataReader dr=comm.ExecuteReader();
     while(dr.Read())
      {
        Ids+=","+dr["id"].ToString();
      }
    dr.Close();
    Ids=Ids.Replace(SortId+",","");
    return Ids;
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


private bool IsStr(string str)
 {
  if(str=="" || str==null)
   {
    return false;
   }
  string str1="abcdefghijklmnopqrstuvwxyz0123456789_";
  string str2=str.ToLower();;
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
  if(str=="" || str==null)
   {
    return false;
   }
  string str1="0123456789";
  string str2=str.ToLower();;
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
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>静态生成界面</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="Author"  content="www.pageadmin.net" />
<script src="master.js" type="text/javascript"></script>
<link  href="master.css" type="text/css" rel="stylesheet" />
</head>
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table border=0 cellpadding=10 cellspacing=0 width=100% >
 <tr>
<td valign=top align="left">
<table border=0 cellpadding=0 cellspacing=0 width=95% align=center  class=table_style2>
<tr>
  <td valign=top>
   <table border=0 cellpadding=0 cellspacing=5 width=100% align=center>
    <tr>
    <td height=20px>静态生成进度：</td>
   </tr>

   <tr>
    <td height=20px>总记录数：<span id="RecordsCount" style="font-family:Arial Black;font-size:13px;font-style:italic;"></span></td>
   </tr>
   <tr>
    <td height=20px>已经生成：<span id="Builed"  style="font-family:Arial Black;font-size:13px;font-style:italic;"></span></td>
   </tr>
   <tr>
    <td height=20px>生成进度：<span id="Percent" style="font-family:Arial Black;font-size:13px;font-style:italic;">0%</span></td>
   </tr>
  </table>
<div id="error"></div>
 </td>
  </tr>
</table>
<br>
<div align="center"><input type="button" id="bt_stop" value="暂停" class="button" onclick="stop_build()"> &nbsp; <input type="button" value="关闭" class="button" onclick="parent.CloseDialog()"></div>
<script type="text/javascript">
 var Ids="<%=Ids%>";
 var Table="<%=Table%>";
 var AIds=Ids.split(',');
 var RecordsCount=<%=RecordCounts%>;
 var AllPageCount=<%=PageCount%>;
 var CurrentPage=<%=CurrentPage%>;
 var BuildedNum=<%=PageSize*CurrentPage%>;
 var Js_RecordsCount=0;
 if(Ids!="")
  {
   Js_RecordsCount=AIds.length;
   if(RecordsCount==0)
    {
     RecordsCount=AIds.length;
    }
  }
 var Js_PageSize=1,Js_PageCount=0,StartIndex=0,EndIndex=0;
 if((Js_RecordsCount % Js_PageSize)==0)
  {
   Js_PageCount=Js_RecordsCount/Js_PageSize;
  }
 else
  {
   Js_PageCount=parseInt(Js_RecordsCount/Js_PageSize)+1;
  }

function get_ids(Js_page)
  {
   var rv="";
   StartIndex=Js_page*Js_PageSize;
   EndIndex=(Js_page+1)*Js_PageSize;
   if(EndIndex>Js_RecordsCount)
    {
      EndIndex=Js_RecordsCount;
    }
   for(i=StartIndex;i<EndIndex;i++)
    {
      if(rv=="")
       {
         rv=String(AIds[i]);
       }
      else
       {
         rv+=","+String(AIds[i]);
       }
    }
   return rv;
  }

var Js_BuildedNum=0;
var Js_Page=0;
var ObjRecordsCount=document.getElementById("RecordsCount");
var ObjBuiled=document.getElementById("Builed");
var Percent=document.getElementById("Percent");
ObjRecordsCount.innerHTML=RecordsCount;
ObjBuiled.innerHTML=BuildedNum;
Percent.innerHTML=(Math.round(BuildedNum/RecordsCount*100))+"%";

var x=new PAAjax();
var date=new Date();

var StartTime="<%=Request.QueryString["starttime"]%>";
if(StartTime==null || StartTime=="")
{
 StartTime=date.getFullYear()+"-"+date.getMonth()+"-"+date.getDate()+" "+date.getHours()+":"+date.getMinutes()+":"+date.getSeconds();
}
var EndTime;
var R;
var stop=0;
var sto;   
function start_html(Ids)
 {
   R=Math.random();
   x.setarg("get",true);
   x.send("build_static.aspx","table="+Table+"&ids="+Ids+"&r="+R,function(v){build_state(v)});
   //document.write("build_static.aspx?table="+Table+"&ids="+Ids");
}

function build_state(v)
 {
   Js_Page++;
   date=new Date();
   if(Js_Page>Js_PageCount)
    {
      if(CurrentPage>=AllPageCount-1)
       {
        EndTime=date.getFullYear()+"-"+date.getMonth()+"-"+date.getDate()+" "+date.getHours()+":"+date.getMinutes()+":"+date.getSeconds();
        Percent.innerHTML="100% &nbsp;&nbsp;生成完毕!&nbsp;&nbsp;总耗时为："+TimeDiff(StartTime,EndTime);
        document.getElementById("bt_stop").style.display="none";
       }
     else 
       {
         location.href="static_panel.aspx?siteid=<%=SiteId%>&table=<%=Table%>&sortid=<%=Request.QueryString["sortid"]%>&lanmuids=<%=Request.QueryString["lanmuids"]%>&sublanmuids=<%=Request.QueryString["sublanmuids"]%><%=Date_Cs%>&starttime="+StartTime+"&page="+(CurrentPage+1);
       }
    }
  else
   {
    if(v=="success")
     {
     Js_BuildedNum=Js_Page*Js_PageSize;
     if(Js_BuildedNum>Js_RecordsCount)
      {
        Js_BuildedNum=Js_RecordsCount;
      }
     ObjBuiled.innerHTML=(BuildedNum+Js_BuildedNum);
     EndTime=date.getFullYear()+"-"+date.getMonth()+"-"+date.getDate()+" "+date.getHours()+":"+date.getMinutes()+":"+date.getSeconds();
     Percent.innerHTML=(Math.round((Js_BuildedNum+BuildedNum)/RecordsCount*100))+"% &nbsp;&nbsp;已耗时："+TimeDiff(StartTime,EndTime);
     if(stop==0)
      {
       sto=setTimeout("start_html(get_ids(Js_Page))",100);
      }
     }
    else
    {
     if(v=="Invalid Ids")
      {
        alert("无效的id组!");
        return;
      }
     else
      {
       document.getElementById("error").innerHTML=v;
       return;
      }
    }
  }
 }
 
 if(Ids!="")
  {
   window.onload=function(){start_html(get_ids(0))}; 
  }

function stop_build()
 {
  if(stop==0)
   {
    document.getElementById("bt_stop").value="继续";
    stop=1;
    clearTimeout(sto);
   }
  else
   {
    document.getElementById("bt_stop").value="暂停";
    stop=0;
    sto=setTimeout("start_html(get_ids(Js_Page))",500);
   }
 }

</script>
</body>
</html>

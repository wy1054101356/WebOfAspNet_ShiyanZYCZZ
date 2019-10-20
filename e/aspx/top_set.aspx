<% @ Page language="c#"%><% @ Import NameSpace="System.Data"%><% @ Import NameSpace="System.Data.OleDb"%><% @ Import NameSpace="System.IO"%><% @ Import NameSpace="PageAdmin"%><!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<script language="c#" runat="server">
 int KyPoint,ActPoint,MemberTypeId,DepartmentId;
 string SiteId,Thetable,UserName,DetailId,sql;
 OleDbConnection conn;
 protected void Page_Load(Object src,EventArgs e)
  {
     Conn Myconn=new Conn();
     conn=Myconn.OleDbConn();//获取OleDbConnection
     if(!Page.IsPostBack)
     {
        Member_Valicate MCheck=new Member_Valicate();
        MCheck.Member_Check();
        UserName=MCheck._UserName;
        MemberTypeId=MCheck._MemberTypeId;
        DepartmentId=MCheck._DepartmentId;
        Thetable=Request.QueryString["table"];
        DetailId=Request.QueryString["id"];
        if(IsNum(DetailId) && IsStr(Thetable))
         {
           conn.Open();
             Get_Data();
             Get_KyPoint();
           conn.Close();
         lb_siteid.Text=SiteId;
         lb_table.Text=Thetable;
         lb_id.Text=DetailId;
         lb_username.Text=UserName;
         lb_kypoint.Text=KyPoint.ToString();
         lb_actpoint.Text=ActPoint.ToString();

         }
     }
    else
     {
      SetTop();
     }
  }



private void Get_Data() //获取资料
 {
   sql="select site_id from "+Thetable+" where id="+DetailId;
   OleDbCommand comm=new OleDbCommand(sql,conn);
   OleDbDataReader dr=comm.ExecuteReader();
   if(dr.Read())
    {
      SiteId=dr["site_id"].ToString();
      Get_ActPoint();
    }
   else
    {
      Response.Write("invalid id");
      Response.End();
    }
   dr.Close();
 }


protected void Get_ActPoint() //获取单位扣除积分
 {
   ActPoint=0;
    if(DepartmentId>0)
     {
      sql="select settop_needpoint from pa_member_tgset where site_id="+SiteId+" and thetable='"+Thetable+"' and department_id="+DepartmentId;
     }
    else
     {
      sql="select settop_needpoint from pa_member_tgset where site_id="+SiteId+" and thetable='"+Thetable+"' and mtype_id="+MemberTypeId;
     }
   OleDbCommand myComm=new OleDbCommand(sql,conn);
   OleDbDataReader dr=myComm.ExecuteReader();
   if(dr.Read())
    {
      ActPoint=int.Parse(dr["settop_needpoint"].ToString());
    }
   else
    {
      Response.End();
    }
   dr.Close();
 }

private void Get_KyPoint() //获取可用积分
 {
   KyPoint=0;
   sql="select point_ky from pa_member where username='"+UserName+"'";
   OleDbCommand comm=new OleDbCommand(sql,conn);
   OleDbDataReader dr=comm.ExecuteReader();
   if(dr.Read())
    {
      KyPoint=int.Parse(dr["point_ky"].ToString());
    }
   else
    {
      Response.End();
    }
   dr.Close();
 }

private void SetTop()
  {
   conn.Open();
   OleDbCommand comm;
   SiteId=lb_siteid.Text;
   Thetable=lb_table.Text;
   DetailId=lb_id.Text;
   UserName=lb_username.Text;
   KyPoint=int.Parse(lb_kypoint.Text);
   ActPoint=(int.Parse(lb_actpoint.Text))*int.Parse(Request.Form["days"]); //获取需要的总积分


   if(ActPoint>0 && ActPoint>KyPoint)
    {
     Response.Write("<s"+"cript type='text/javascript'>alert('积分余额不足!');location.href=location.href</"+"script>");
     Response.End();
     return;
    }
   else
    {
      if(Request.Form["refresh"]=="1")
       {
        sql="update "+Thetable+" set istop=1,actdate='"+DateTime.Now.AddDays(int.Parse(Request.Form["days"]))+"',thedate='"+DateTime.Now+"' where id="+DetailId;
       }
      else
       {
        sql="update "+Thetable+" set istop=1,actdate='"+DateTime.Now.AddDays(int.Parse(Request.Form["days"]))+"' where id="+DetailId;
       }
      comm=new OleDbCommand(sql,conn);
      comm.ExecuteNonQuery();
      comm=new OleDbCommand(sql.Replace("id=","source_id="),conn);
      comm.ExecuteNonQuery();
      if(ActPoint>0)
      {
        sql="update pa_member set point_ky=point_ky-"+ActPoint+",point_xf=point_xf+"+ActPoint+" where username='"+UserName+"'";
        comm=new OleDbCommand(sql,conn);
        comm.ExecuteNonQuery();
       
        string InfoTitle="";
        sql="select [title] from "+Thetable+" where id="+DetailId;
        comm=new OleDbCommand(sql,conn);
        OleDbDataReader dr=comm.ExecuteReader();
        if(dr.Read())
         {
          InfoTitle=SubStr(dr["title"].ToString(),50,true);
         }
        dr.Close();
        sql="insert into pa_fnc_list(site_id,thetype,username,act,amount,detail,beizhu,thedate) values("+SiteId+",2,'"+UserName+"','k',"+ActPoint+",'信息置顶"+Request.Form["days"]+"天','标题："+Sql_Format(InfoTitle)+"','"+DateTime.Now+"')";
        comm=new OleDbCommand(sql,conn);
        comm.ExecuteNonQuery();
      }
   }
   Build_Html(SiteId,DetailId);//生成静态
   conn.Close();
   Response.Write("<s"+"cript type='text/javascript'>alert('置顶成功!');parent.CloseDialog('refresh')</"+"script>");
   Response.End();
  }

private void Build_Html(string siteid,string Ids)
 {
   OleDbCommand comm;
   OleDbDataReader dr;  
   string IsHtml="0";
   sql="select [html] from pa_site where id="+siteid;
   comm=new OleDbCommand(sql,conn);
   dr=comm.ExecuteReader();
   if(dr.Read()) 
     {
      IsHtml=dr["html"].ToString();
     }
   dr.Close();
   if(IsHtml=="1" && Ids!=null && IsNum(Ids.Replace(",","")))
     {
       Build_Html BH=new Build_Html();
       if(IsNum(Ids))
        {
         sql="select id,site_dir,static_dir,static_file,lanmu_id,sublanmu_id from "+Thetable+" where html=2 and id="+Ids;
        }
       else
        {
         sql="select id,site_dir,static_dir,static_file,lanmu_id,sublanmu_id from "+Thetable+" where html=2 and id in("+Ids+")";
        }
       comm=new OleDbCommand(sql,conn);
       dr=comm.ExecuteReader();
       while(dr.Read()) 
        {
          try
           {
            BH.Build_Detail(dr["site_dir"].ToString(),dr["static_dir"].ToString(),dr["static_file"].ToString(),dr["lanmu_id"].ToString(),dr["sublanmu_id"].ToString(),dr["id"].ToString());
           }
          catch(Exception e)
           {
            continue;
           }
        }
      dr.Close();
     }
 }

private string SubStr(string Title,int Title_Num,bool HtmlEncode) 
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
      }  
  }
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
</script>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta name="Author" content="PageAdmin CMS" />
<meta http-equiv="X-UA-Compatible" content="IE=7" />
<meta http-equiv="Content-Type" content="text/html;charset=utf-8"/ >
<style type=text/css>
body div td{margin:0px;padding:0px;word-wrap:break-word;text-align:center;font:12px/20px Verdana,Helvetica,Arial,\5b8b\4f53;color:#333333;}
button,input,select,textarea{font-size:13px}
form,ul,li{list-style-type:none;margin:0 0 0 0;padding:0 0 0 0;}
.main{background-color:#D1EAFE;line-height:200%;font-size:12px;margin:0px auto 0px auto;padding:6px 5px 6px 10px;border:1px solid #999999;}
.main .head{font-size:14px;font-weight:bold;display:block;height:30px;}
.main .tip{display:block;padding:5px 0 5px 0;}

a:link{color:#333333;text-decoration:underline;font-size:12px}
a:visited{color:#333333;text-decoration:underline;font-size:12px}
a:hover{color:#333333;text-decoration:none;font-size:12px}
.button{
	width:55px;
	font-size:9pt;
	height:19px;
	cursor: hand;
	background-image: url(/e/images/public/button.gif);
	background-position: center center;
	border-top: 0px outset #eeeeee;
	border-right: 0px outset #888888;
	border-bottom: 0px outset #888888;
	border-left: 0px outset #eeeeee;
	padding-top: 2px;
	background-repeat: repeat-x;
	}
</style>
</head>
<body onload="Get_PayPoint()">
<div class="main"><form method="post" runat="server" >
<span class="head">置顶信息将优先显示在信息列表最前面。</span>
信息置顶天数：<input type="text" name="days" id="days" size="3" maxlength="5" value="1" onkeyup="Get_PayPoint()">天(<input type="checkbox" value="1" name="refresh" checked title='刷新信息发布时间为当前最新时间'>同时刷新发布时间)
<span class="tip">
所需积分：<span id="need_point" name="need_point" style="color:#ff0000"><%=ActPoint%></span>点&nbsp;&nbsp;
您的可用积分：<asp:Label id="lb_kypoint" runat="server" forecolor=#ff0000/>点 &nbsp;<span id="ts" style="color:#ff0000"></span>
</span>
<div align="center">
<asp:Label id="lb_siteid" runat="server" visible="false" />
<asp:Label id="lb_table" runat="server" visible="false"/>
<asp:Label id="lb_id" runat="server" visible="false"/>
<asp:Label id="lb_username" runat="server" visible="false"/>
<asp:Label id="lb_actpoint" runat="server" visible="false"/>
<input type="button" value=" 确定 " class="button" id="sbt" onclick="return Ck_Post()">
</div></form>
</div>
</body>
<script type="text/javascript">
var act_point=<%=ActPoint%>;
var ky_point=<%=KyPoint%>;
var need_point=document.getElementById("need_point");
var days=document.getElementById("days");
var ts=document.getElementById("ts");
var sbt=document.getElementById("sbt");
function Get_PayPoint()
 {
   ts.innerHTML="";
   sbt.disabled=false;
   if(isNaN(days.value))
    {
     days.value="1";
     return;
    }
   var CountPay=parseInt(days.value)*parseInt(act_point);
   need_point.innerHTML=CountPay;
   if(CountPay>ky_point)
    {
     ts.innerHTML="余额不足";
     sbt.disabled=true;
    }
 }


function Ck_Post()
 {
   if(!IsNum(days.value))
    {
      alert("请输入有效的数字");
      days.focus();
      return false;
    }
   if(days.value=="0")
    {
      alert("请输入大于0的数字");
      days.focus();
      return false;
    }
   if(confirm('是否确定?'))
    {
      document.forms[0].submit();
    }
 }

function IsNum(str)  //是否是数字
 {
   if(str==""){return false;}
   var str1="0123456789";
   var Astr=str.split('');
   for(i=0;i<Astr.length;i++)
    {
      if(str1.indexOf(Astr[i])<0)
       {
        return false;
       }
    }
  return true;
 }
</script>
</html>

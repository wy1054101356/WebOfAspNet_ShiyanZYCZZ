<% @ Page language="c#"%>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<% @ Import NameSpace="System.IO"%>
<% @ Import NameSpace="PageAdmin"%>
<script Language="C#" Runat="server">
 string Id,Adv_Type,Adv_range,Adv_canshu,Adv_content,Left_content,Right_content,EndDate;
 int Ad1,Ad2,Ad3,Ad4;
 OleDbConnection conn;
 protected void Page_Load(Object sender,EventArgs e)
   {
     Conn Myconn=new Conn();
     conn=Myconn.OleDbConn();//获取OleDbConnection
     conn.Open();
      Get_Value();
     conn.Close();
   }
private void Get_Value()
 {
  if(!IsNum(Request.QueryString["id"]))
   {
     return;
   }
  Id=Request.QueryString["id"];
  string sql="select * from pa_adv where id="+Id;
  OleDbCommand Comm=new  OleDbCommand(sql,conn);
  OleDbDataReader dr=Comm.ExecuteReader();
  if(dr.Read())
   {
     Adv_Type=dr["adv_type"].ToString();
     Adv_range=dr["adv_range"].ToString();
     Adv_content=dr["content"].ToString().Replace("\"","\\\"").Replace("\r\n","<br>");
     switch(Adv_Type)
      {
        case "1":
         if(Adv_range!="0")
          {
           Ad1=1;
          }
        break;
        case "2":
         if(Adv_range!="0")
          {
           Ad2=1;
          }
        break;
        case "3":
         if(Adv_range!="0")
          {
           Ad3=1;
          }
        break;

        case "4":
         if(Adv_range!="0")
          {
           Ad4=1;
           UserControl UC=(UserControl)Page.LoadControl("~/e/d/adv_"+Id+".ascx");
           ((PageAdmin.patag)UC).SiteId=int.Parse(dr["site_id"].ToString());
           P4.Controls.Add(UC);
          }
        break;
      }
     Adv_canshu=dr["window_canshu"].ToString();
     Left_content=dr["left_content"].ToString().Replace("\"","\\\"").Replace("\r\n","<br>");
     Right_content=dr["right_content"].ToString().Replace("\"","\\\"").Replace("\r\n","<br>");
     EndDate=((DateTime)dr["enddate"]).ToString("yyyy\\/MM\\/dd");
   }
  dr.Close();
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
var Adv_range_<%=Id%>="<%=Adv_range%>";
var EndDate_<%=Id%>="<%=EndDate%>";
var Dt_<%=Id%>=new Date();
var NowDate_<%=Id%>=Dt_<%=Id%>.getFullYear()+"/"+(Dt_<%=Id%>.getMonth()+1)+"/"+Dt_<%=Id%>.getDate();
if(Date.parse(EndDate_<%=Id%>)-Date.parse(NowDate_<%=Id%>)<0) 
{
 Adv_range_<%=Id%>="0";
} 
else if(Adv_range_<%=Id%>=="1" && IsPageHome!="1")
{
 Adv_range_<%=Id%>="0";
}
else if(location.href.indexOf("/e/")>0) 
 {
 Adv_range_<%=Id%>="0";
 }
<%if(Ad1==1){%>
function newwindow_<%=Id%>()
 {
  window.open("/e/aspx/adv_new.aspx?id=<%=Id%>","newwindow<%=Id%>","<%=Adv_canshu%>");
 }
 if(Adv_range_<%=Id%>!="0"){newwindow_<%=Id%>();}
<%}%>
<%if(Ad2==1){%>
document.write("<div id='adv_<%=Id%>' style='display:none;position:absolute;left:0px;top:0px;z-index:100'><%=Adv_content%></div>");
var adv_<%=Id%>=document.getElementById("adv_<%=Id%>");
var floatdelay<%=Id%>=25; //控制每次执行间隔的时间，做越大移动得越慢；
var floatspeed =1; //控制每次执行移动的距离，值越大移动得越快；
var floatflagX<%=Id%> =0;
var floatflagY<%=Id%> =0;
function toPixel<%=Id%>(str1) 
{
 var oldLen = str1.length;
 var newLen = oldLen - 2;
 str2 = str1.slice(0, newLen);
 str3 = parseInt(str2);
 return str3;
}
function flowAdv<%=Id%>(){
var bWidth = document.body.clientWidth;
var bHeight = document.body.clientHeight;
var bLeft = document.body.scrollLeft;
var bTop = document.body.scrollTop;
var iWidth = adv_<%=Id%>.offsetWidth;
var iHeight = adv_<%=Id%>.offsetHeight;
var iLeft = toPixel<%=Id%>(adv_<%=Id%>.style.left);
var iTop = toPixel<%=Id%>(adv_<%=Id%>.style.top);
if(iLeft < (bWidth - iWidth) && floatflagX<%=Id%> == 0) {
adv_<%=Id%>.style.left = (iLeft + floatspeed) + "px";
}
else if(iLeft >= (bWidth - iWidth) && floatflagX<%=Id%> ==0) {
floatflagX<%=Id%> = 1;
}
else if(iLeft > 0 && floatflagX<%=Id%> == 1) {
adv_<%=Id%>.style.left = (iLeft - floatspeed) + "px";
}
else if(0 >= iLeft && floatflagX<%=Id%> == 1) {
floatflagX<%=Id%> = 0;
}
if(iTop < (bHeight - iHeight) && floatflagY<%=Id%> == 0) {
adv_<%=Id%>.style.top = (iTop + floatspeed) + "px";
}
else if(iTop >= (bHeight - iHeight) && floatflagY<%=Id%> ==0) {
floatflagY<%=Id%> = 1;
}
else if(iTop > 0 && floatflagY<%=Id%> == 1) {
adv_<%=Id%>.style.top = (iTop - floatspeed) + "px";
}
else if(0 >= iTop && floatflagY<%=Id%> == 1) {
floatflagY<%=Id%> = 0;
}
}
function startflowAdv<%=Id%>()
{
adv_<%=Id%>.style.left =Math.floor(Math.random()*1000)+"px";
adv_<%=Id%>.style.display="block";
var floatinterval<%=Id%> = setInterval("flowAdv<%=Id%>()", floatdelay<%=Id%>);
adv_<%=Id%>.onmouseover = function() {clearInterval(floatinterval<%=Id%>);}
adv_<%=Id%>.onmouseout = function() {floatinterval<%=Id%> = setInterval("flowAdv<%=Id%>()", floatdelay<%=Id%>);}
}
if(Adv_range_<%=Id%>!="0"){setTimeout('startflowAdv<%=Id%>()',Math.floor(Math.random()*1000));}
<%}%>
<%if(Ad3==1){%>
lastScrollY=0;
function DlAdv_<%=Id%>(){ 
var diffY;
if (document.documentElement && document.documentElement.scrollTop)
    diffY = document.documentElement.scrollTop;
else if (document.body)
    diffY = document.body.scrollTop
else
    {/*Netscape stuff*/}
percent=.1*(diffY-lastScrollY); 
if(percent>0)percent=Math.ceil(percent); 
else percent=Math.floor(percent); 
document.getElementById("adv_<%=Id%>_left").style.top=parseInt(document.getElementById("adv_<%=Id%>_left").style.top)+percent+"px";
document.getElementById("adv_<%=Id%>_right").style.top=parseInt(document.getElementById("adv_<%=Id%>_left").style.top)+percent+"px";
lastScrollY=lastScrollY+percent; 
}
var LeftAdv="<div id=\"adv_<%=Id%>_left\" style='left:5px;position:absolute;top:100px;z-index:100'><%=Left_content%></div>"
var RightAdv="<div id=\"adv_<%=Id%>_right\" style='right:5px;position:absolute;top:100px;z-index:100'><%=Right_content%></div>"
if(Adv_range_<%=Id%>!="0")
   {
      document.write(LeftAdv); 
      document.write(RightAdv); 
      window.setInterval("DlAdv_<%=Id%>()",10);
  }
<%}%>
<%
if(Ad4==1)
{
%>
if(Adv_range_<%=Id%>!="0"){
document.write("<div id=\"adv_<%=Id%>\">");
<asp:PlaceHolder id="P4" runat="server"></asp:PlaceHolder>
document.write("</div>");
}
<%}%>
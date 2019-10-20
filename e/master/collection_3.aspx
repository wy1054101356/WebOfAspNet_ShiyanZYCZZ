<% @ Page Language="C#" Inherits="PageAdmin.collection_3"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server" Type="bs_collection" />
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr><td height=10></td></tr>
 <tr><td class=table_style1 align="left"><b>采集参数获取</b></td></tr>
 <tr><td height=10 ></td></tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr>
<td valign=top  align="left">
<div id="tabdiv">
<ul>
<li id="tab" name="tab"  onclick="location.href='collection_2.aspx?id=<%=Request.QueryString["id"]%>&table=<%=Request.QueryString["table"]%>&name=<%=Server.UrlEncode(Request.QueryString["name"])%>&tab=0'">列表规则</li>
<li id="tab" name="tab"  onclick="location.href='collection_2.aspx?id=<%=Request.QueryString["id"]%>&table=<%=Request.QueryString["table"]%>&name=<%=Server.UrlEncode(Request.QueryString["name"])%>&tab=1'" >内容规则</li>
<li id="tab" name="tab"  onclick="location.href='#'" style="font-weight:bold">开始采集</li>
</ul>
</div>
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top  align="left">
 <table border=0 cellpadding=5 width=95% align=center>
    <tr>
     <td  align="left"><b>当前采集：</b><%=Request.QueryString["name"]%></td>
    </tr>
    <tr>
     <td  align="left" height="5"></td>
    </tr>
  </table>
<form>
 <table border=0 cellpadding=5 width=95% align=center>
    <tr>
     <td align="left" width=100px>待采集网址</td>
       <td  align="left"><TextArea name="List_Url" id="List_Url" cols="70" rows="8" ><%=Collection_List_Url%></TextArea>
       </td>
     </tr>
    <tr>
     <tr>
         <td height=25 >导入类别</td>
         <td><select  name="Sort" id="Sort" onchange=""><option  value="0">-----选择导入类别------</option><%=Sort_List%></select></td>
     </tr>
    <tr>
     <tr>
         <td height=25 >默认审核</td>
         <td><select id="DefaultChecked" name="DefaultChecked">
<option value="1">审核</option>
<option value="0">待审核</option>
</select><td>
     </tr>
  <tr>
         <td height=25 >采集时间间隔</td>
         <td><input type="textbox" id="C_time"  maxlength=2  size="5" onkeyup="if(isNaN(value))execCommand('undo')" value="4"> 秒 注：根据目标网站速度设置，太小会导致采集失败。<td>
    </tr>
    </table>

<div   style="display:none" id="D_CollectionInfo">
   <table border=0 cellpadding=5  width=95% align=center>
     <tr>
     <td  align="left" width=100px>采集状态</td>
       <td  align="left"><TextArea name="Collection_Info" id="Collection_Info" cols="70" rows="6"></TextArea></td>
     </tr>
    </table>
</div>
<br>
   <table border=0 cellpadding=5  width=95% align=center>
     <tr>
     <td  align="left" >
     <span id="C_Count"></span>&nbsp;&nbsp;<span id="C_Bar"></span>
     </td>
     </tr>
    </table>
<br>
<div align=center>
<input type="hidden" id="lanmuparpams" value="">
<input  type="button"  id="stop" value="停止"  Class="button" onclick="StopOrStart()" style="display:none">
<input  type="button"  id="tijiao" value="采集"  Class="button" onclick="return CheckForm()" >
&nbsp;&nbsp;<input type="button" value="返回"  Class="button" OnClick="location.href='collection_1.aspx'">
</div>
</form>
<br>
</td>
</tr>
</table>
</td>
</tr>
</table><br>
</center>
<script language="javascript">
var objsort=document.getElementById("Sort");
var obj_urls=document.getElementById("List_Url");
var objinfo=document.getElementById("Collection_Info");
var D_Info=document.getElementById("D_CollectionInfo");
var C_Bar=document.getElementById("C_Bar");
var C_Count=document.getElementById("C_Count");
var objstop=document.getElementById("stop");
var c_lanmuparpams=document.getElementById("lanmuparpams");

if(obj_urls.value.indexOf("http://")<0)
 {
   document.getElementById("tijiao").disabled=true;
 }

var C_order;
var C_urls;
var A_C_urls;
var Count;
var sendurl;
var C_Time;
var curret_url;
var c_setInterval;
var i=0,c_ok=0,errornum=0;
var XmlHttp=CreateXmlHttp();
var Url;
var stop=0;
var IsEnd=0;
function CheckForm()
 {
  if(objsort.length>1)
    {
     if(objsort.value=="0")
     {
      alert("请选择要导入的类别");
      objsort.focus();
      return false;
     }
   }
    get_lanmu();
    if(c_lanmuparpams.value=="")
     {
      alert("未能加载栏目参数！");
      return false;
     }
    C_order="<%=C_order%>";
    C_Time=document.getElementById("C_time").value;
    if(obj_urls.value.indexOf("http://")>=0)
     {
       objsort.disabled=true;
       obj_urls.disabled=true;
       document.getElementById("tijiao").style.display="none";
       objstop.style.display="";
       document.getElementById("C_time").disabled=true;
       document.getElementById("DefaultChecked").disabled=true;
       D_Info.style.display="";
       C_urls=obj_urls.value;
       if(C_urls.indexOf("\r\n")>=0)
        {
          C_urls=obj_urls.value.replace(/\r\n/ig,",");
          C_urls=C_urls.replace(/\n/ig,",");
        }
       else
        {
         C_urls=C_urls.replace(/\n/ig,",");
        }
       A_C_urls=C_urls.split(',');
       Count=A_C_urls.length;
       C_Count.innerHTML="待采集数："+Count;
       sendurl="collection_5.aspx?sortid="+objsort.value+"&checked="+document.getElementById("DefaultChecked").value+"&saveimage=<%=C_detail_saveimage%>&table=<%=Table%>&cid=<%=Cid%>&c_list_domain=<%=C_list_domain%>&c_encode=<%=C_encode%>&collection=yes&siteid=<%=SiteId%>&lanmuparpams="+c_lanmuparpams.value;
       sendurl+="&savetitlepic=<%=C_titlepic%>&titlepiccontains=<%=C_titlepiccontains%>&titlepicnotcontains=<%=C_titlepicnotcontains%>&timeout="+C_Time;
       objinfotr=true;
       objinfo.value="开始采集...\r\n";
       c_setInterval=setInterval(StartHttp,parseInt(C_Time)*1000);
     }
   else
    {
      alert("无待采集网址");
    }
 }


function StartHttp()
 {
  if(C_order=="0")
   {
     Url=sendurl+"&c_url="+escape(A_C_urls[i]);
   }
  else
   {
     Url=sendurl+"&c_url="+escape(A_C_urls[Count-i-1]);
   }
   //window.open(Url+"&debug=1"); //调试模式
   XmlHttp.onreadystatechange=SendHTTP;  // 这onreadystatechange很关键,在IE里没有它可以,到了其他浏览器行不通
   XmlHttp.open("get",Url,true);// 还有这里的true是关键,在火狐下false运行不了,所以只能用true了
   XmlHttp.send(null);//火狐下必须加null,IE有没有都没问题 
 }

function SendHTTP()
 {
   if(XmlHttp.readyState==4)  // 判断传送完全
    {
      curret_url=A_C_urls[i];
      i++;
      //objinfo.value+=curret_url+"采集中...\r\n";
      if(XmlHttp.status==200)
      {
        if(XmlHttp.responseText=="ok")
          {
            c_ok++;
            //objinfo.value+="采集成功\r\n";
          }
        else
          {
           errornum++;
           objinfo.value+=curret_url+"采集失败，错误："+XmlHttp.responseText+"\r\n";
          }
        if(i>=Count)
         {
           objinfo.value+="采集结束!";
           IsEnd=1;
           clearInterval(c_setInterval);
         }
       C_Bar.innerHTML="成功："+c_ok+"&nbsp;&nbsp;失败："+errornum+"&nbsp;&nbsp;采集进度："+((i+0)/Count*100).toFixed(0)+"%";
      }
    else
     {
       errornum++;
       C_Bar.innerHTML="成功："+c_ok+"&nbsp;&nbsp;失败："+errornum+"&nbsp;&nbsp;采集进度："+((i+0)/Count*100).toFixed(0)+"%";
       objinfo.value+=curret_url+"采集失败，出现http"+XmlHttp.status+"错误\r\n";
        if(i>=Count)
         {
           objinfo.value+="采集结束!";
           clearInterval(c_setInterval);
         }
     }
  

   }
}

function StopOrStart()
 {
   if(IsEnd==1)
    {
     alert("采集已经结束！");
     return;
    }
   if(stop==0)
    {
      clearInterval(c_setInterval);
      stop=1;
      objstop.value="继续"
    }
   else
    {
      c_setInterval=setInterval(StartHttp,parseInt(C_Time)*1000);
      stop=0;
      objstop.value="停止"
    }

 }

function CreateXmlHttp()
{
   var xmlHttp;
   var activeKey = new Array("MSXML2.XMLHTTP.6.0","MSXML2.XMLHTTP.5.0","MSXML2.XMLHTTP.4.0","MSXML2.XMLHTTP.3.0","MSXML2.XMLHTTP","Microsoft.XMLHTTP");
   if(window.ActiveXObject)
      {
       for(var i=0;i<activeKey.length;i++)
        {
          try
          {
              xmlHttp = new ActiveXObject(activeKey[i]);
              if(xmlHttp!=null)
               return xmlHttp;
          }
          catch(error)
          {
            throw new Error("您的浏览器不支持ajax!");
          }
       }
    }
  else if(window.XMLHttpRequest)
    {
      xmlHttp = new XMLHttpRequest();
    }
  else
    {
       throw new Error("您的浏览器不支持ajax!");
    }  
   return xmlHttp;
} 

function get_lanmu()
 {
   var R=Math.random();
   var x=new PAAjax();
   x.setarg("get",false);
   x.send("collection_getparpams.aspx","table=<%=Table%>&sortid="+objsort.value+"&r="+R,function(v){Id("lanmuparpams").value=v;});
 }
</script>
</body>
</html>


<% @ Page language="c#"%>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<% @ Import NameSpace="PageAdmin"%>
<script language="c#" runat="server">
 int Model_id,Page;
 string AjaxId,TheTable,AjaxNum,sql;
 protected void Page_Load(Object src,EventArgs e)
  {
    TheTable="";
    if(IsNum(Request.QueryString["modelid"]))
     {
       Model_id=int.Parse(Request.QueryString["modelid"]);
     }
    else
     {
      Model_id=0;
      Response.Write("alert('无效的ajax模型id')");
      Response.End();
     }
   Conn Myconn=new Conn();
   OleDbConnection conn=Myconn.OleDbConn();//获取OleDbConnection
   conn.Open();
   sql="select thetable from pa_model where thetype='ajax' and hasfile=1 and id="+Model_id;
   OleDbCommand comm=new OleDbCommand(sql,conn);
   OleDbDataReader dr=comm.ExecuteReader();
   if(dr.Read()) 
    {
     TheTable=dr["thetable"].ToString();
    }
   dr.Close();
   conn.Close();
   AjaxId=Model_id.ToString();
   if(IsNum(Request.QueryString["num"]))
    {
      AjaxNum=Request.QueryString["num"];
      AjaxId=AjaxId+"_"+AjaxNum;
    }
   if(TheTable=="")
   {
     Response.Write("alert('modelid无效或者模型文件不存在!')");
     Response.End();
   }
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
document.write('<div id="ajax_<%=AjaxId%>_box" style="background-image:url(/e/images/public/loading.gif);background-repeat:no-repeat;background-position:center center"></div>');
var ajax_<%=AjaxId%>_box=document.getElementById("ajax_<%=AjaxId%>_box");
var ajax_<%=AjaxId%>_back;
function rajax_<%=AjaxId%>(Page,Ajax_Syn,fun) //读取ajax列表
 {
   if(typeof(Ajax_Syn)=="undefined")
    {
      Ajax_Syn=true;//true表示异步加载
    }
   ajax_<%=AjaxId%>_box.style.backgroundImage="url('/e/images/public/loading.gif')";
   var x=new PAAjax();
   x.setarg("get",Ajax_Syn);
   if(typeof(fun)=="function")
   {
     ajax_<%=AjaxId%>_back=fun;
   }
  else
   {
     if(typeof(ajax_<%=AjaxId%>_fun)=="function")
      {
        ajax_<%=AjaxId%>_back=ajax_<%=AjaxId%>_fun;
      }
   }
   x.send("/e/zdymodel/<%=TheTable%>/ajax/<%=Model_id%>.aspx","modelid=<%=Model_id%>&table=<%=TheTable%>&page="+Page+"&"+ajaxparameter_<%=AjaxId%>+"&ajax_syn="+Ajax_Syn+"&ajax_num=<%=AjaxNum%>",function(v){wajax_<%=AjaxId%>(v,ajax_<%=AjaxId%>_back)});
 }
function wajax_<%=AjaxId%>(V,fun) //写入ajax内容
 {
   ajax_<%=AjaxId%>_box.style.backgroundImage="none";
   if(typeof(fun)=="function")
    {
      fun(V);
    }
   else
    {
      ajax_<%=AjaxId%>_box.innerHTML=V;
    }
 }
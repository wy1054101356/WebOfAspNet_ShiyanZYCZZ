<% @ Page Language="C#"%>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<% @ Import NameSpace="System.IO"%>
<% @ Import NameSpace="PageAdmin"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<script language="c#" runat="server">
 OleDbConnection conn;
 string UserName,TheTable;
 int SiteId;
 protected void Page_Load(Object src,EventArgs e)
   {
     Master_Valicate YZ=new Master_Valicate();
     YZ.Master_Check();
     UserName=YZ._UserName;
     TheTable=Request.QueryString["table"];
     Conn Myconn=new Conn();
     conn=Myconn.OleDbConn();//获取OleDbConnection
  }

protected void Data_Update(Object src,EventArgs e)
 {
    string sql_str="";
    if(Request.Form["ck_style"]=="1")
     {
       sql_str+=",style='"+Sql_Format(Request.Form["f_style"])+"'";
     }
    if(Request.Form["ck_onlyitem"]=="1")
     {
       sql_str+=",onlyitem="+Sql_Format(Request.Form["f_onlyitem"]);
     }
    if(Request.Form["ck_mustitem"]=="1")
     {
       sql_str+=",mustitem="+Sql_Format(Request.Form["f_mustitem"]);
     }
    if(Request.Form["ck_additem"]=="1")
     {
       sql_str+=",additem="+Sql_Format(Request.Form["f_additem"]);
     }
    if(Request.Form["ck_edititem"]=="1")
     {
       sql_str+=",edititem="+Sql_Format(Request.Form["f_edititem"]);
     }
    if(Request.Form["ck_tgitem"]=="1")
     {
       sql_str+=",tgitem="+Sql_Format(Request.Form["f_tgitem"]);
     }
    if(Request.Form["ck_searchitem"]=="1")
     {
       sql_str+=",searchitem="+Sql_Format(Request.Form["f_searchitem"]);
     }
    if(Request.Form["ck_searchmustitem"]=="1")
     {
       sql_str+=",searchmustitem="+Sql_Format(Request.Form["f_searchmustitem"]);
     }
    if(Request.Form["ck_collectionitem"]=="1")
     {
       sql_str+=",collectionitem="+Sql_Format(Request.Form["f_collectionitem"]);
     }
    if(Request.Form["ck_sortitem"]=="1")
     {
       sql_str+=",sortitem="+Sql_Format(Request.Form["f_sortitem"]);
     }
    if(Request.Form["ck_addpageitem"]=="1")
     {
       if(Request.Form["f_masteritem"]=="1")
        {
          sql_str+=",masteritem=1";
        }
       else
        {
          sql_str+=",masteritem=0";
        }
       if(Request.Form["f_memberitem"]=="1")
        {
          sql_str+=",memberitem=1";
        }
       else
        {
          sql_str+=",memberitem=0";
        }
     }
    if(Request.Form["ck_listitem"]=="1")
     {
       if(Request.Form["f_masterlistitem"]=="1")
        {
          sql_str+=",masterlistitem=1";
        }
       else
        {
          sql_str+=",masterlistitem=0";
        }
       if(Request.Form["f_memberlistitem"]=="1")
        {
          sql_str+=",memberlistitem=1";
        }
       else
        {
          sql_str+=",memberlistitem=0";
        }
       if(IsNum(Request.Form["f_listitem_words"]))
        {
          sql_str+=",listitem_words="+int.Parse(Request.Form["f_listitem_words"]);
        }
     }
    if(Request.Form["ck_attribute"]=="1")
     {
       sql_str+=",field_attribute='"+Sql_Format(Request.Form["f_attribute"])+"'";
     }
    if(Request.Form["ck_submit_js"]=="1")
     {
       sql_str+=",submit_js='"+Sql_Format(Request.Form["f_submit_js"])+"'";
     }

    if(Request.Form["ck_tip"]=="1")
     {
       sql_str+=",field_tip='"+Sql_Format(Request.Form["f_tip"])+"'";
     }
    if(IsNum(Request.Form["ck_xuhao"]))
     {
       sql_str+=",xuhao="+Sql_Format(Request.Form["f_xuhao"]);
     }



   string Ids=Request.Form["ids"];
   string[] AIds=Ids.Split(',');
   string sql;
   conn.Open();
   OleDbCommand comm;
   OleDbDataReader dr;
   for(int i=0;i<AIds.Length;i++)
    {
     if(AIds[i]==""){continue;}
     sql="update pa_field set show=show"+sql_str+" where id="+AIds[i];
     comm=new OleDbCommand(sql,conn);
     comm.ExecuteNonQuery();
    }

   conn.Close();
   PageAdmin.Log log=new PageAdmin.Log();
   log.Save(int.Parse(Request.Cookies["SiteId"].Value),1,"edit",1,UserName,"字段批量属性设置");
   Response.Write("<scri"+"pt type='text/javascript'>parent.postover('提交成功!');</"+"script>"); 
   Response.End(); 
 }

private string Sql_Format(string str)
 {
   string Res=str.Replace("'","''");
   Res=Res.Replace("\"","\""); 
   return Res;
 }

private bool IsNum(string str)
 {
  if(str=="" || str==null)
   {
    return false;
   }
  string str1="0123456789";
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
</script>
<aspcn:uc_head runat="server" /> 
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table border=0 cellpadding=10 cellspacing=0 width=98%>
 <tr>
<td valign=top  align="left">
<iframe name="post_iframe" id="post_iframe" src="" frameborder=0 scroling=no height=1px width=1px marginwidth=0 marginheight=0 style="display:none"></iframe>
<form runat="server" target="post_iframe">
<table border=0 cellpadding=0 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top>
<br>
<table border=0 cellpadding=2 cellspacing=0 width=100% align=center>
<tr>
  <td height=25 align="left" width="150"><input type="checkbox" name="ck_style" value="1">文本框样式：</td>
  <td align="left"><input name="f_style" id="f_style" type="text" size="25" maxlength="100"></td>
</tr>

<tr>
  <td height=25 align="left"><input type="checkbox" name="ck_onlyitem" value="1">值唯一：</td>
  <td align="left"  title="表示此字段不允许出现重复值"><input type="radio"  name="f_onlyitem" value="1" checked>是 <input type="radio" name="f_onlyitem"  value="0">否</td>
</tr>

<tr>
  <td height=25 align="left"><input type="checkbox" name="ck_mustitem" value="1">必填项：</td>
  <td align="left"><input type="radio"  name="f_mustitem" value="1" checked>是 <input type="radio" name="f_mustitem"  value="0">否</td>
 </tr>

<tr>
  <td height=25 align="left"><input type="checkbox" name="ck_additem" value="1">可增加：</td>
  <td align="left"><input type="radio"  name="f_additem" value="1" checked>是 <input type="radio" name="f_additem"  value="0" >否  <span style="color:#666666">注：只应用于会员中心</span></td>
</tr>

<tr>
  <td height=25 align="left"><input type="checkbox" name="ck_edititem" value="1">可修改：</td>
  <td align="left"><input type="radio"  name="f_edititem" value="1" checked>是 <input type="radio" name="f_edititem"  value="0" >否  <span style="color:#666666">注：只应用于会员中心</span></td>
</tr>

<tr id="T_tg" style="display:<%=TheTable=="pa_member"?"none":""%>">
  <td height=25 align="left"><input type="checkbox" name="ck_tgitem" value="1">匿名投稿项：</td>
  <td align="left" title="如果不选择，获取表单界面的不生成此字段的代码" ><input type="radio"  name="f_tgitem" value="1" checked>是 <input type="radio" name="f_tgitem"  value="0" >否  <span style="color:#666"> 注：选择否时，获取表单>发布表单代码中不生成此字段的代码。</span></td>
</tr>

<tr id="T_search" style="display:<%=TheTable=="pa_member"?"none":""%>">
  <td   height=25 align="left"><input type="checkbox" name="ck_searchitem" value="1">搜索字段：</td>
  <td align="left"><input type="radio" name="f_searchitem" value="2">精确匹配 <input type="radio"  name="f_searchitem" value="1" checked>模糊匹配 <input type="radio" name="f_searchitem"  value="0" >否  <span style="color:#666"> 注：模糊匹配只对文本类型有效</span></td>
</tr>

<tr id="T_search" style="display:<%=TheTable=="pa_member"?"none":""%>">
  <td   height=25 align="left"><input type="checkbox" name="ck_searchmustitem" value="1">精确匹配必搜项：</td>
  <td align="left"><input type="radio" name="f_searchmustitem" value="1">是 <input type="radio" name="f_searchmustitem" value="0" checked>否  <span style="color:#666">注：选择否时字段值为空则不进行匹配。</span></td>
</tr>

<tr id="T_collection" style="display:<%=TheTable=="pa_member"?"none":""%>">
  <td   height=25 align="left"><input type="checkbox" name="ck_collectionitem" value="1">采集项：</td>
  <td align="left"><input type="radio"  name="f_collectionitem" value="1">是 <input type="radio" name="f_collectionitem"  value="0" checked>否</td>
</tr>

<tr id="T_sort">
  <td   height=25 align="left"><input type="checkbox" name="ck_sortitem" value="1">排序项：
  <td align="left"><input type="radio"  name="f_sortitem" value="1">是 <input type="radio" name="f_sortitem"  value="0" checked>否</td>
</tr>

<tr  title="应用于信息发布界面的字段，不选择则不在发布界面显示">
  <td  height=25 align="left"><input type="checkbox" name="ck_addpageitem" value="1">信息发布应用：</td>
  <td align="left">
  <input type="checkbox"  name="f_masteritem" value="1">后台信息发布界面显示
  <input type="checkbox"  name="f_memberitem" value="1">会员信息发布界面显示
</tr>

<tr title="是否在后台和会员信息列表界面显示" style="display:<%=TheTable=="pa_member"?"none":""%>">
  <td  height=25 align="left"><input type="checkbox" name="ck_listitem" value="1">信息管理应用：</td>
  <td align="left">
<input type="checkbox"  name="f_masterlistitem" value="1">后台信息管理界面显示 
<input type="checkbox"  name="f_memberlistitem" value="1">会员信息管理界面显示
显示字数：<input name="f_listitem_words" id="f_listitem_words" type="text" size="4" maxlength="3"> <span style="color:#666">数值型和日期型字段不受限制</span>
</td>
</tr>

<tr>
  <td  height=25 align="left"><input type="checkbox" name="ck_attribute" value="1">表单属性：</td>
  <td align="left"><Textarea name="f_attribute" id="f_attribute" style="width:80%;height:80px" title="每行一个属性"></Textarea></td>
 </tr>

 <tr>
  <td  height=25 align="left"><input type="checkbox" name="ck_submit_js" value="1">提交验证js：</td>
  <td align="left"><Textarea name="f_submit_js" id="f_submit_js" style="width:80%;height:80px" rows="5" title="在点击提交按钮前进行验证"></Textarea></td>
 </tr>

<tr>
  <td height=25 align="left"><input type="checkbox" name="ck_tip" value="1">字段提示：</td>
  <td align="left"><input name="f_tip" id="f_tip" type="text" size="45" maxlength="50" ></td>
 </tr>

<tr>
  <td height=25 align="left"><input type="checkbox" name="ck_xuhao" value="1">排列序号：</td>
  <td align="left"><input type="text" name="f_xuhao" id="f_xuhao" size="5" maxlength="3"></td>
</tr>
</table>

<div align=center style="padding:10px">
<span id="post_area">
<input type="hidden" value="" name="ids" id="ids">
<asp:Button Cssclass=button text="提交" id="Submit" runat="server" onclick="Data_Update" onclientclick="startpost()"/>
<input type="button" value="关闭" class="button" onclick="parent.CloseDialog()">
</span>
<span id="post_loading" style="display:none"><img src=images/loading.gif vspace="5" align=absmiddle>Loading...</span>
</div>
<br>
</td>
</tr>
</table>
</form>
</td>
</tr>
</table>
<br>
</center>
</body>
<script type="text/javascript">
document.getElementById("ids").value=parent.document.getElementById("ids").value;
</script>
</html>
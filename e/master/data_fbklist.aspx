<% @ Page Language="C#"  Inherits="PageAdmin.data_list"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server" Type="data_list"/> 
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr><td height=10></td></tr>
 <tr><td class=table_style1><b><%=Request.QueryString["name"]%></b></td></tr>
 <tr><td height=10 ></td></tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr>
<td valign=top align="left">
<form runat="server">
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top align="left">

<table border=0 cellpadding=0 cellspacing=0 width=95%  style="table-layout:fixed;" align=center>
<tr>
<td align="left" width="110px">
每页<asp:TextBox id="Tb_pagesize" style="width:30px" maxlength="10"  Runat="server"/>条记录
</td>
<td align="right">
<select  name="sortid" id="sortid" onchange="Go()"><option  value="">所有类别</option><%=Sort_List%><option value="0" style="color:#ff0000">未分类信息</option></select>
<select id="s_from" onchange="Go()">
<option value="">所有来源</option>
<option value="master">后台发布</option>
<option value="member">会员投稿</option>
<option value="guest">匿名投稿</option>
</select>

<select id="s_type" onchange="Go()">
<option value="">所有属性</option>
<option value="noreply">未回复</option>
<option value="unchecked">未审核</option>
<option value="istop">置顶</option>
<option value="isgood">推荐</option>
<option value="isnew">最新</option>
<option value="ishot">热门</option>
<option value="iscg">草稿</option>
</select>
<select id="s_order" onchange="Go()">
<option value="">默认排序</option>
<%=Sort_Str%>
<option value="id desc">按ID↓</option>
<option value="id asc">按ID↑</option>
<option value="clicks desc">按点击次数↓</option>
<option value="comments desc">按评论次数↓</option>
<option value="downloads desc">按下载次数↓</option>
</select>
搜索：<select id="s_field">
<option value="">选择搜索字段</option>
<%=Fields_Str%>
<option value="username">发布人</option>
<option value="zdy_keywords">关键字</option>
<option value="tags">Tags</option>
<option value="code">按信息编号</option>
<option value="ip">按ip</option>
</select><input text="text" id="s_keyword" style="width:100px">
<input type="button" value="确定" class="button" onclick="Go()">
 </td>
 </tr>
</table>

<table border=0 cellpadding=2 cellspacing=0 width=95% align=center>
      <tr>
        <td    align="left">
           <table border=0 cellpadding=0 cellspacing=0 width=100% class=tablestyle style="table-layout:fixed;" id="tb_datalist">
                <tr>
                  <td align=center width=35% class=white><%=TitleName%></td>
                  <td align=center width=10% class=white height=20>发布人</td>
                  <td align=center width=10% class=white height=20>提交时间</td>
                  <td align=center width=5% class=white>点击</td>
                  <td align=center width=5% class=white>评论</td>
                  <td align=center width=10% class=white height=20>审核</td>
                  <td align=center width=10% class=white height=20>回复</td>
                  <td align=center width=15% class=white>管理</td>
                </tr>
          <asp:Repeater id="P1" runat="server" OnItemDataBound="Data_Bound">         
             <ItemTemplate>
                 <tr class="listitem">
                  <td align=left class="tdstyle"  title="<%#Server.HtmlEncode(DataBinder.Eval(Container.DataItem,"title").ToString())%>"><input type="checkbox" id="CK" Name="CK" Value="<%#DataBinder.Eval(Container.DataItem,"id")%>"><%#GetSortName(DataBinder.Eval(Container.DataItem,"sort_id").ToString())%><a href='<%#DetailUrl(DataBinder.Eval(Container.DataItem,"static_dir").ToString(),DataBinder.Eval(Container.DataItem,"static_file").ToString(),DataBinder.Eval(Container.DataItem,"lanmu_id").ToString(),DataBinder.Eval(Container.DataItem,"subLanmu_id").ToString(),DataBinder.Eval(Container.DataItem,"id").ToString(),DataBinder.Eval(Container.DataItem,"zdy_url").ToString(),DataBinder.Eval(Container.DataItem,"permissions").ToString(),DataBinder.Eval(Container.DataItem,"checked").ToString(),DataBinder.Eval(Container.DataItem,"html").ToString())%>' target="dataview"><%#SubStr(DataBinder.Eval(Container.DataItem,"title").ToString(),100,true)%></a><img src=images/image.gif height=20px align=absmiddle title="带标题图片" style="display:<%#(DataBinder.Eval(Container.DataItem,"titlepic").ToString())==""?"none":""%>"><asp:Label ForeColor="#ff0000" text="[顶]"  visible='<%#Get_Bool(DataBinder.Eval(Container.DataItem,"istop").ToString())%>' Title='<%#"置顶结束日期："+(DataBinder.Eval(Container.DataItem,"actdate")).ToString()%>' runat="server"/><asp:Label ForeColor="#ff0000" text="[荐]"  visible='<%#Get_Bool(DataBinder.Eval(Container.DataItem,"isgood").ToString())%>' runat="server"/><asp:Label ForeColor="#ff0000" text="[新]"  visible='<%#Get_Bool(DataBinder.Eval(Container.DataItem,"isnew").ToString())%>' runat="server"/><asp:Label ForeColor="#ff0000" text="[热]"  visible='<%#Get_Bool(DataBinder.Eval(Container.DataItem,"ishot").ToString())%>' runat="server"/><asp:Label id="lb_sign" runat="server" /><a>
                  </td>
                  <td class=tdstyle><%#GetUserName(DataBinder.Eval(Container.DataItem,"username").ToString(),DataBinder.Eval(Container.DataItem,"istg").ToString())%></td>
                  <td class="tdstyle" title="<%#DataBinder.Eval(Container.DataItem,"thedate")%>"><%#DataBinder.Eval(Container.DataItem,"thedate","{0:yyyy-MM-dd}")%></td>
                  <td align=center class="tdstyle"><%#DataBinder.Eval(Container.DataItem,"clicks")%></td>
                  <td align=center class="tdstyle"><a href='comments_list.aspx?detailid=<%#DataBinder.Eval(Container.DataItem,"id")%>&table=<%#Request.QueryString["table"]%>&name=<%#Server.UrlEncode(Request.QueryString["name"])%>'><%#DataBinder.Eval(Container.DataItem,"comments")%></a></td>
                  <td align=center class=tdstyle><asp:Label id="lb_checked" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"checked")%>'/></td>
                  <td align=center class="tdstyle"><%#Get_ReplyState(DataBinder.Eval(Container.DataItem,"reply_state").ToString())%></td>
                  <td align=center class="tdstyle">
                   <asp:Label id="lb_id" runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"id")%>' visible="false"/>
                   <a href='data_reply.aspx?detailid=<%#DataBinder.Eval(Container.DataItem,"id")%>&table=<%#Request.QueryString["table"]%>&name=<%#Server.UrlEncode(Request.QueryString["name"])%>'>回复</a>
                   <a href="javascript:General_Set('信息编辑','data_add.aspx?id=<%#DataBinder.Eval(Container.DataItem,"id")%>&table=<%#Request.QueryString["table"]%>&name=<%#Request.QueryString["name"]%>')">编辑</a>
                   <asp:LinkButton Id="Delete" runat="server" Text="删除" CommandName='<%#DataBinder.Eval(Container.DataItem,"id")%>' OnCommand="BT_Delete" />
                  </td>
                </tr>
               <asp:Label id="Lb_iscg" Runat="server" Text='<%#DataBinder.Eval(Container.DataItem,"iscg")%>' Visible="false"/>
             </ItemTemplate>
          </asp:Repeater>
<tr>
<td colspan="8" class=tdstyle>

<table border=0 width=100%>
 <tr><td>
<input type="button" class="button" value="反选" onclick="CheckBox_Inverse('CK')"/>
[<a href="javascript:set('pset')">批设属性</a>]

[<a href="javascript:set('fbkover')"  title="结贴后不能再回复留言">结贴</a>]

[<a href="javascript:set('checked')">审核</a>/<a href="javascript:set('unchecked')" title="前台隐藏">取消</a>]

[<a href="javascript:set('istop')">置顶</a><input type="text" value=1 maxlength="5" name="topdays" id="topdays" onkeyup="if(isNaN(value))execCommand('undo')" style="border:1px solid #cccccc;height:15px;width:25px">天/<a href="javascript:set('nottop')" title="取消置顶">取消</a>]

[<a href="javascript:set('isgood')">推荐</a>/<a href="javascript:set('notgood')" title="取消推荐">取消</a>]

[<a href="javascript:set('isnew')">最新</a>/<a href="javascript:set('notnew')" title="取消最新">取消</a>]

[<a href="javascript:set('ishot')">热门</a>/<a href="javascript:set('nothot')" title="取消热门">取消</a>]

<!--[<a href="javascript:set('import_excle')">导入</a>/<a href="javascript:set('export_excle')">导出</a>]-->

[<a href="javascript:set('delete')">删除</a>]

</td>
<td align=right>
<input type="hidden" name="act" id="act" value="">
<input type="hidden" name="ids" id="ids" value="">
<select name="tosortid" id="tosortid"><option value="0">目标类别</option><%=Sort_List_1%></select>
<input type="button" class="button" value="转移" onclick="set('transfer')"/>
<input type="button" class="button" value="复制" onclick="set('copy')"/>
</td></tr></table>
</td></tr></table> 
<div align=left style="padding:10px 0 5px 0">
<%if(Is_Static=="1")
 {
%>
<select name="htmltype" id="htmltype"><option value="0">仅选中信息生成静态</option><option value="1">所有信息生成静态</option></select>
<input type="button" class="button" value="生成" onclick="html()">
<%}%>
共<asp:Label id="Lblrecordcount"  Text=0 runat="server" />条记录 
&nbsp;当前页次: <asp:Label id="Lblcurrentpage"  runat="server" />/<asp:Label id="LblpageCount"  runat="server" />&nbsp;
<asp:Button  text="上一页"  id="LblPrev"  cssclass="button"  runat="server"  CommandName="Prev"   OnCommand="Bt_Click" />&nbsp;
<asp:Button  text="下一页"  id="LblNext"  cssclass="button"  runat="server"  CommandName="Next"   OnCommand="Bt_Click" />&nbsp;
转到:&nbsp;<asp:DropDownList id="DLpage" runat="server" AutoPostBack="true" OnSelectedIndexChanged="Page_Changed"  /> 页&nbsp;
</div>
       </td>
    </tr>
   </table>
  </td>
  <tr>
 </table>
</form>
</td>
</tr>
</table><br>
</center>
<script type="text/javascript">
 MouseoverColor("tb_datalist");
 var obj_sort=document.getElementById("sortid");
 var obj_from=document.getElementById("s_from");
 var obj_type=document.getElementById("s_type");
 var obj_field=document.getElementById("s_field");
 var obj_order=document.getElementById("s_order");
 var obj_keyword=document.getElementById("s_keyword");
 var obj_pagesize=document.getElementById("Tb_pagesize");

 var Table="<%=Request.QueryString["table"]%>";
 var Tname="<%=Request.QueryString["name"]%>";

 var Sortid="<%=Request.QueryString["sortid"]%>";
 var From="<%=Request.QueryString["from"]%>";
 var Type="<%=Request.QueryString["type"]%>";
 var Field="<%=Request.QueryString["field"]%>";
 var Order="<%=Request.QueryString["order"]%>";
 var Keyword="<%=Request.QueryString["keyword"]%>";

 if(obj_sort!=null){obj_sort.value=Sortid;}
 if(obj_from!=null){obj_from.value=From;}
 if(obj_type!=null){obj_type.value=Type;}
 if(obj_field!=null && Field!=""){obj_field.value=Field;}
 if(obj_order!=null && Order!=""){obj_order.value=Order;}
 if(obj_keyword!=null){obj_keyword.value=Keyword;}


 function Go()
  { 
   if(obj_keyword.value!="")
    {
     if(obj_field.value=="")
      {
        alert("请选择搜索字段!");
        obj_field.focus();
        return;
      }
    }
   location.href="?table="+Table+"&name="+escape(Tname)+"&sortid="+obj_sort.value+"&from="+obj_from.value+"&type="+obj_type.value+"&field="+obj_field.value+"&order="+obj_order.value+"&keyword="+escape(obj_keyword.value)+"&pagesize="+obj_pagesize.value;
  }

function Get_CheckBox(Name)
 {
   var Obj=document.getElementsByName(Name);
   var ID="0";
   for(i=0;i<Obj.length;i++)
     {
      if(Obj[i].checked)
       {
         ID+=","+Obj[i].value;
       }
     }
   return ID.replace("0,","");
 }



function set(act)
 {
   if(act=="import_excle")
    {
      IDialog("导入Excel数据","import_excle.aspx?table="+Table,660,230);
      return ;
    }
   var Ids=Get_CheckBox("CK");
   if(Ids=="0" && act!="pset")
    {
      alert("请选择要操作的信息!");
      return;
    }
   if(act=="delete")
    {
      if(!confirm("确定删除吗?"))
       {
         return;
       }
    }

   if(act=="nottop")
    {
      if(!confirm("此操作将重置信息的置顶结束日期，是否确定?"))
       {
         return;
       }
    }
   if(act=="istop")
    {
      var Days=document.getElementById("topdays").value;
      if(!IsNum(Days) || Days=="0")
       {
         alert("请输入有效的数字!");
         return;
       }
    }


   if(act=="copy" || act=="transfer")
    {
      if(document.getElementById("tosortid").value=="0")
      {
        alert("请选择要操作的目标类别!");
        document.getElementById("tosortid").focus();
        return ;
      }
      if(!confirm("是否确定?"))
       {
         return;
       }
    }
  document.getElementById("act").value=act;
  document.getElementById("ids").value=Ids;
  if(act=="pset")
    {
      if(Ids=="0")
       {
         if(!confirm("不选择信息则对所有信息进行设置，是否继续!"))
          {
           return;
          }
       }
      IDialog("批量参数设置","data_pset.aspx?table="+Table+"&name="+encodeURI("<%=Request.QueryString["name"]%>"),760,500);
      return;
    }
  document.forms[0].submit();
 }


function html()
 {
  var obj=document.getElementById("htmltype")
  if(obj.value=="0")
   {
     var Ids=Get_CheckBox("CK");
     if(Ids=="0")
     {
      alert("请选择要生成的记录!");
      return;
     }
     htm_panel(Table,name,Ids);
   }
  else
   {
     htm_panel(Table,name,"");
   }
 }

function htm_panel(Table,Name,Ids)
 {
  var Width=400;
  var Height=180;
  IDialog("内容页静态生成","static_panel.aspx?table="+Table+"&ids="+Ids+"&sortid=<%=Request.QueryString["sortid"]%>",Width,Height,'no');
 }
SetCookie("currentnode","");
SetCookie("currentnodes","");
</script>
</body>
</html>  

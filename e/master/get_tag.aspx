<% @ Page Language="C#"%>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<% @ Import NameSpace="PageAdmin"%>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<script language="c#" runat="server">
  OleDbConnection conn;
  string P_Language,TheTable,Sort_List,Sort_Id,Zdy_Module_Open;
  int SiteId;
  protected void Page_Load(Object src,EventArgs e)
   {
    Master_Valicate YZ=new Master_Valicate();
    YZ.Master_Check();
    SiteId=int.Parse(Request.Cookies["SiteId"].Value);
    Conn Myconn=new Conn();
    conn=Myconn.OleDbConn();//获取OleDbConnection
    if(!Page.IsPostBack)
    {
       conn.Open();
         Table_Bind();
         Site_Bind();
         Get_Zt();
       conn.Close();
    }
   else
    {
       conn.Open();
         P_Language=Get_Language(SiteId);
         TheTable=D_Table.SelectedItem.Value;
         SiteId=int.Parse(D_Site.SelectedItem.Value);
         Model_Bind(P_Language,TheTable);
         Get_Sort(0);
         Get_SortField(TheTable);
       conn.Close();
    }

  }



private void Get_Zt()
  {
    string lanmuid=Request.QueryString["lanmuid"];
    string iszt=Request.QueryString["iszt"];
    if(IsNum(lanmuid) && iszt=="1")
     {
       string sql="select name from pa_lanmu where iszt=1 and id="+lanmuid;
       OleDbCommand comm=new OleDbCommand(sql,conn);
       OleDbDataReader dr=comm.ExecuteReader();
       if(dr.Read()) 
        {
          zt_list.Items.Add(new ListItem(dr["name"].ToString(),lanmuid));
          zt_list.SelectedIndex=1;
        }
       dr.Close();
     }
  }


private void Table_Bind()
 {
   string sql="select thetable,table_name from pa_table where inlanmu=1 and site_ids like '%,"+SiteId.ToString()+",%' order by xuhao";
   DataSet ds=new DataSet();
   OleDbDataAdapter myAdapter=new OleDbDataAdapter(sql,conn);
   myAdapter.Fill(ds,"table1");
   D_Table.DataSource=ds.Tables["table1"].DefaultView;
   D_Table.DataBind();
   D_Table.Items.Insert(0,new ListItem("---选择数据表---","0"));
 }

private void Site_Bind()
 {
   string sql="select sitename,id from pa_site where id<>"+SiteId+" order by xuhao";
   DataSet ds=new DataSet();
   OleDbDataAdapter myAdapter=new OleDbDataAdapter(sql,conn);
   myAdapter.Fill(ds,"tb");
   D_Site.DataSource=ds.Tables["tb"].DefaultView;
   D_Site.DataBind();
   D_Site.Items.Insert(0,new ListItem("当前站点",SiteId.ToString()));
 }

private string Get_Language(int sid)
 {
   string RV="";
   string sql="select [language] from pa_site where id="+sid;
   OleDbCommand  comm=new OleDbCommand(sql,conn);
   OleDbDataReader dr=comm.ExecuteReader();
   if(dr.Read())
    {
     RV=dr["language"].ToString();
    }
   else
    {
     Response.Write("无效站点id");
     Response.End();
    }
   dr.Close();
  return RV;
 }

private void Get_Sort(int Parentid)
 {
   string sql="select id,sort_level,sort_name,final_sort from pa_sort where parent_id="+Parentid+" and thetable='"+TheTable+"' and site_id="+SiteId+" order by xuhao,id";
   OleDbCommand comm=new OleDbCommand(sql,conn);
   OleDbDataReader dr=comm.ExecuteReader();
   while(dr.Read())
    {
      Sort_List+="<option value='"+dr["id"].ToString()+"'>"+dr["sort_name"].ToString()+"</option>\r\n";
    }
   dr.Close();
 }


private void Model_Bind(string P_Language,string TheTable)
 {
   string TagType,model_name,sql;
   TagType=Request.QueryString["type"];
   switch(TagType)
    {
      case "sublanmu":
        model_name="---请选择子栏目模型---";
        sql="select * from pa_model where show=1 and [language] in('"+P_Language+"','all') and thetable='"+TheTable+"' and thetype='sublanmu' and hasfile=1 order by xuhao";
      break;

      case "nav":
       model_name="---请选择导航模型---";
       sql="select * from pa_model where show=1 and [language] in('"+P_Language+"','all') and thetable='"+TheTable+"' and thetype='nav' and hasfile=1 order by xuhao";
      break;

      case "module":
        model_name="---请选择模块模型---";
        sql="select * from pa_model where show=1 and [language] in('"+P_Language+"','all') and thetable='"+TheTable+"' and thetype='module' and hasfile=1 order by xuhao";
      break;
   
      default:
        model_name="---请选择模块模型---";
        sql="select * from pa_model where show=1 and [language] in('"+P_Language+"','all') and thetable='"+TheTable+"' and thetype='module' and hasfile=1 order by xuhao";
      break;

    }

   DataSet ds=new DataSet();
   OleDbDataAdapter myAdapter=new OleDbDataAdapter(sql,conn);
   myAdapter.Fill(ds,"table1");
   D_Model.DataSource=ds.Tables["table1"].DefaultView;
   D_Model.DataBind();
   D_Model.Items.Insert(0,new ListItem(model_name,"0"));
 }

private void  Get_SortField(string thetable)
 {
   D_SortStr.Items.Clear();
   D_SortStr.Items.Add(new ListItem("默认排序",""));
   string sql="select [field],[field_name] from pa_field where thetable='"+TheTable+"' and sortitem=1 order by xuhao";
   OleDbCommand comm=new OleDbCommand(sql,conn);
   OleDbDataReader dr=comm.ExecuteReader();
   while(dr.Read())
    {
      D_SortStr.Items.Add(new ListItem("按"+dr["field_name"].ToString()+"↓",dr["field"].ToString()+" desc"));
      D_SortStr.Items.Add(new ListItem("按"+dr["field_name"].ToString()+"↑",dr["field"].ToString()+" asc"));
    }
   D_SortStr.Items.Add(new ListItem("按ID↓","id desc"));
   D_SortStr.Items.Add(new ListItem("按ID↑","id asc"));
   D_SortStr.Items.Add(new ListItem("按点击量↓","clicks desc"));
   D_SortStr.Items.Add(new ListItem("按下载量↓","downloads desc"));
   D_SortStr.Items.Add(new ListItem("按评论量↓","comments desc"));
   dr.Close();
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

private string SubStr(string Str)
 {
  int MaxLength=250;
  if(Str.Length>MaxLength)
   {
    return Str.Substring(0,MaxLength);
   }
  else
   {
    return Str;
   }
 }

</script>
<aspcn:uc_head runat="server" />  
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table border=0 cellpadding=5 cellspacing=0 width=98% >
 <tr>
<td valign=top  align="left">

<form runat="server" >
<table border=0 cellpadding=5 cellspacing=0 width=100% align=center  class=table_style2>
<tr>
  <td valign=top>
<table border=0 cellpadding=0 cellspacing=2 width=95% align=center>
<tr>
  <td width=100px height=30>数据来源</td>
  <td>
     <asp:DropDownList id="D_Site" DataTextField="sitename" DataValueField="id"  Runat="server" AutoPostBack="True"/>
     <asp:DropDownList id="D_Table" DataTextField="table_name" DataValueField="thetable"  Runat="server" AutoPostBack="True"/>  <span style="color:#999999">当前站点ID值：<%=SiteId%></span>
  </td>
 </tr>

<tr>
  <td width=100px height=30>选择模型</td>
  <td>
     
     <asp:DropDownList id="D_Model" DataTextField="name" DataValueField="id"  Runat="server" onchange="show_modelid(this.value)"/> <span style="color:#999999" id="s_modelid">当前模型ID值：0</span>
  </td>
 </tr>

<tr>
  <td height=30>调用类别</td>
  <td>
<select name="s_sort" id="s_sort" onchange="c_sort(<%=SiteId%>,1,'<%=TheTable%>','admin')">
<option  value="0">---所有类别---</option>
<%=Sort_List%>
</select>
<script type="text/javascript">
var Sort_Type="all";
Write_Select(<%=SiteId%>,'<%=TheTable%>')
</script>
<span style="color:#999999">当前分类ID值：<input type="text" name="sort" id="sort" value="0" size="10" style="background-color:#D1EAFE;border-width:0px;color:#999999"></span>
  </td>
 </tr>

 <tr>
  <td  height=30>属性筛选</td>
  <td><select name="D_ShowType" id="D_ShowType" onchange="change_showtype()">
	<option selected="selected" value="">选择类型</option>
	<option value="istop=1">&quot;置顶&quot;的信息</option>
	<option value="isgood=1">&quot;推荐&quot;的信息</option>
	<option value="isnew=1">&quot;最新&quot;的信息</option>
	<option value="ishot=1">&quot;热门&quot;的信息</option>

</select><select name="D_NotShowType" id="D_NotShowType" onchange="change_notshowtype()">
	<option selected="selected" value="">选择排除类型</option>
	<option value="istop=0">排除&quot;置顶&quot;信息</option>
	<option value="isgood=0">排除&quot;推荐&quot;信息</option>
	<option value="isnew=0">排除&quot;最新&quot;信息</option>
	<option value="ishot=0">排除&quot;热门&quot;信息</option>
	<option value="source_id=0">排除&quot;推送&quot;信息</option>
	<option value="reply_state>=1">排除&quot;未回复&quot;信息</option>
	<option value="has_titlepic=1">排除不带&quot;标题图片&quot;的信息</option>
</select>条件：<input name="zdy_condition" type="text" id="zdy_condition" size="30" />

</td>
 </tr>

 <tr>
  <td  height=30>专题筛选</td>
  <td>
<asp:DropDownList id="zt_list" Runat="server">
<asp:ListItem value="0">选择所属专题</asp:ListItem>
</asp:DropDownList>
<input type="button" value="选择专题" class="f_bt" onclick="open_ztlist(0)"> 注：表示只调用属于对应专题的信息，不选择则不限制
</td>
</tr>

  <tr>
  <td  height=30>信息排序</td>
  <td>
<asp:DropDownList id="D_SortStr" Runat="server">
</asp:DropDownList>
</td>
 </tr>

<tr>
  <td height=30>目标窗口</td>
  <td><asp:DropDownList id="D_Target" Runat="server"><asp:ListItem value="_self">本窗口</asp:ListItem><asp:ListItem value="_blank">新窗口</asp:ListItem></asp:DropDownList></td>
 </tr>

 <tr>
  <td height=30><span id="show_num_txt">显示信息数</span></td>
  <td><asp:TextBox id="Show_Num" runat="server" Value="5" Maxlength="3" size=5/> 条记录</td>
 </tr>

  <tr>
  <td  height=30>标题显示数</td>
  <td><asp:TextBox id="Title_Num" runat="server" Value="50" Maxlength="3" size=5/> 个字符</td>
 </tr>

  <tr>
  <td  height=30>标题图片</td>
  <td>宽：<asp:TextBox id="TitlePic_Width" runat="server"  Maxlength="5" Text="150" size=5/>px 高：<asp:TextBox id="TitlePic_Height" runat="server" Text="150" Maxlength="5" size=5/>px 注：其中一个设置0表示自动缩放</td>
 </tr>

 <tr id="tr_page" style="display:none">
  <td height=30>是否分页</td>
  <td><asp:RadioButton id="page_1" GroupName="gopage" runat="server" Checked onclick="changge_page(0)"/>否 <asp:RadioButton id="page_2" GroupName="gopage" runat="server" onclick="changge_page(1)"/>是</td>
 </tr>

 <tr>
  <td height=30><input type="button" class="f_bt" value="获取标签"  onclick="get_tag()"></td>
  <td><input type="textbox" id="tag" size="85" Maxlength="100"></td>
 </tr>
</table>

</td>
</tr>
</table>
</form>
</td>
</tr>
</table>
</center>
<script language="javascript">
var type="<%=Server.HtmlEncode(Request.QueryString["type"])%>";
var obj1=document.getElementById("D_ShowType");
var obj2=document.getElementById("D_NotShowType");
var obj3=document.getElementById("zdy_condition");
var show_num_txt=document.getElementById("show_num_txt");
if(type=="zt"){document.getElementById("tr_page").style.display="";}
function changge_page(num)
 {
  if(num==0)
   {
    show_num_txt.innerHTML="显示信息数";
   }
  else
   {
    show_num_txt.innerHTML="每页信息数";
   }  
 }

function change_showtype()
 {
   var v1=obj1.value;
   var v2=obj2.value;
   if(v2!="")
    {
      if(v1=="")
       {
        obj3.value="and "+v2;
       }
      else
       {
        obj3.value="and "+v1+" and "+v2;
       }
    }
  else
    {
      obj3.value="and "+v1;
    }
  if(v2=="" && v1=="")
   {
    obj3.value="";
   }
 }

function show_modelid(Id)
 {
  document.getElementById("s_modelid").innerHTML="当前模型ID值："+Id;
 }

function change_notshowtype()
 {
  change_showtype();
 }

function get_tag()
 {
   var Table=document.getElementById("D_Table");
   if(Table.value=="0")
    {
      alert("请选择信息所在的数据表!");
      Table.focus();
      return;
    }
   var Model=document.getElementById("D_Model");
   if(Model.value=="0")
    {
      alert("请选择模型!");
      Model.focus();
      return;
    }
   var Tag=document.getElementById("tag");
   var Sql_Lj="";
   var TagStr=document.getElementById("D_Site").value+","+Model.value+","+document.getElementById("sort").value;
   TagStr+=","+obj3.value+","+document.getElementById("zt_list").value;
   TagStr+=","+document.getElementById("D_SortStr").value+","+document.getElementById("D_Target").value+","+document.getElementById("Show_Num").value+","+document.getElementById("Title_Num").value;
   TagStr+=","+document.getElementById("TitlePic_Width").value+","+document.getElementById("TitlePic_Height").value;
   if(type=="zt")
   {
    if(document.getElementById("page_1").checked)
     {
      TagStr+=",0";
     }
    else
     {
       TagStr+=",1";
     }
   }
   Tag.value="{pa:model}"+ubb(TagStr)+"{/pa:model}";
 }
function ubb(content)
 {
   content=ReplaceAll(content,"\\","/fxg/");
   content=ReplaceAll(content,"*","/xh/");
   content=ReplaceAll(content,"+","/jh/");
   content=ReplaceAll(content,"?","/wh/");
   content=ReplaceAll(content,"$","/my/");
   content=ReplaceAll(content,"(","/lykh/");
   content=ReplaceAll(content,")","/rykh/");
   content=ReplaceAll(content,"[","/lfkh/");
   content=ReplaceAll(content,"]","/rfkh/");
   content=ReplaceAll(content,"{","/ldkh/");
   content=ReplaceAll(content,"}","/rdkh/");
   return content;
 }
function AddSelect(txt,value,id) //填充专题
 {
   var obj=document.getElementById(id);
   obj.options.add(new Option(txt,value));
   obj[obj.options.length-1].selected=true;
 }
</script>
</body>
</html>  
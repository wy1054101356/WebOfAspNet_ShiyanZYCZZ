<% @ Page Language="C#"%>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<% @ Import NameSpace="PageAdmin"%>
<script language="c#" runat="server">
  string Sort_List,Search_Sort_List;
  string Form_Table,Field_title,Field_name,Field_type,Field_Length,Value_type,Defaultvalue,Fitems,Submit_Js,Style,Fck_Style,Mustfill,MustFillName,MustFillField,MustFillType,Input_Attribute,DateInput;
  OleDbConnection conn;
  int SiteId,List_Level;
  string SortStr,List_Space,Show_TgYzm,LC,Domain;
 protected void Page_Load(Object src,EventArgs e)
    {
    Master_Valicate YZ=new Master_Valicate();
    YZ.Master_Check();
    LC=YZ._LC;
    Domain=YZ._Domain;
    SiteId=int.Parse(Request.Cookies["SiteId"].Value);
    Form_Table=Request.QueryString["table"];
    if(!Page.IsPostBack)
     {
       Conn Myconn=new Conn();
       conn=Myconn.OleDbConn();//获取OleDbConnection
       conn.Open();
        Get_Table(Form_Table);
        Get_Sort(0);
        Get_SearchSort(0);
        Get_SortField();
        Get_FormHtml(); 
        Get_SearchHtml();
       conn.Close();
     }
   }

private void Get_FormHtml()
   {
    string SubmitValue=" 提交 ",ResetValue=" 重设 ";
    string sql="select * from pa_field where thetable='"+Form_Table+"' and tgitem=1 order by  xuhao"; 
    OleDbCommand mycomm=new OleDbCommand(sql,conn);
    OleDbDataReader dr=mycomm.ExecuteReader();
    string FormHtml="<s"+"cript type=\"text/javascript\" src=\"/e/js/zdyform.js\"></script"+">\r\n<style type='text/css'>\r\n."+Form_Table+"_table{border:1px solid #eeeeee}\r\n."+Form_Table+"_table td{border:1px solid #eeeeee;padding:5px}\r\n</style>\r\n<form name=\""+Form_Table+"\" method=\"post\" Enctype=\"multipart/form-data\" action=\"/e/aspx/post.aspx\">\r\n<table border=0 cellpadding=0 cellspacing=0  align=center width=95% class=\""+Form_Table+"_table\">";
    MustFillName="";
    Submit_Js="";
    int HasDate=0,HasEditor=0;
    if(Sort_List!="" && Sort_List!=null)
     {
       FormHtml+="<tr><td align=right>分类&nbsp;&nbsp;</td><td><select name=\"sort\" id=\"sort\"><option value=\"0\">选择分类</option>"+Sort_List+"</select></td></tr>";
     }
    while(dr.Read())
     {
       Field_type=dr["field_type"].ToString();
       Field_Length=dr["field_length"].ToString();
       Field_title=dr["field_name"].ToString();
       Field_name=dr["field"].ToString();
       Value_type=dr["value_type"].ToString();
       DateInput="";
       Input_Attribute=dr["field_attribute"].ToString().Replace("\"","\"").Replace("\r\n","  ");
       if(dr["submit_js"].ToString().Trim()!="")
        {
         Submit_Js+=dr["submit_js"].ToString()+"\r\n";
        }

       Defaultvalue=dr["defaultvalue"].ToString();
       Fitems=dr["items"].ToString().Replace("\r\n","|");
       string[] AItems=Fitems.Split('|');
       string[] A_AItems=new string[2];
       Style=dr["style"].ToString();
       if(Style.Trim()!="")
        {
         Style=" style=\""+Style+"\" ";
        }
       Fck_Style=dr["fck_style"].ToString();
       Mustfill=dr["mustitem"].ToString();
       if(Mustfill=="1")
        {
           Mustfill=" <span style=\"color:#ff0000\">*</span>";
           MustFillName+=Field_title+",";
           MustFillField+=Field_name+",";
           if(Field_type=="editor" && Fck_Style=="textarea")
            {
             MustFillType+="textarea"+",";
            }
           else
            {
             MustFillType+=Field_type+",";
            }
        }
       else
        {
          Mustfill="&nbsp;&nbsp;";
        }
       switch(Field_type)
        {
          case "text":
            if(Value_type=="nvarchar")
             {
               Input_Attribute+=" maxlength=\""+Field_Length+"\"";
             }
          if(Value_type=="datetime")
             {
              HasDate=1;
              DateInput="<a href=javascript:open_calendar(\""+Field_name+"\")><img src=/e/images/public/date.gif border=0 height=20 hspace=2 align=absbottom></a>";
             }

          if(Input_Attribute.ToLower().IndexOf("maxlength=")<0)
            {
              Input_Attribute+=" maxlength=\""+Field_Length+"\"";
            }

          FormHtml+="\r\n<tr><td align=right>"+Field_title+Mustfill+"</td><td><input type=text name=\""+Field_name+"\" id=\""+Field_name+"\""+Style+Input_Attribute+">"+DateInput+"</td></tr>";
          break;

          case "textarea":
          FormHtml+="\r\n<tr><td align=right>"+Field_title+Mustfill+"</td><td><textarea name=\""+Field_name+"\" id=\""+Field_name+"\""+Style+Input_Attribute+" >"+Defaultvalue+"</textarea></td></tr>";
          break;

          case "editor":
           if(Style==""){Style=" style=\"width:100%;height:300px\" ";}
           FormHtml+="\r\n<tr><td align=right>"+Field_title+Mustfill+"</td><td><textarea name=\""+Field_name+"\" id=\""+Field_name+"\"" +Style+Input_Attribute+" >"+Defaultvalue+"</textarea></td></tr>";
            
              if(HasEditor==0)
               {
	         FormHtml+="<s"+"cript charset=\"utf-8\" src=\"/e/incs/kindeditor/kindeditor.js\" type=\"text/javascript\"></script"+">";
                 HasEditor=1;
               }
              FormHtml+="\r\n<s"+"cript type=\"text/javascript\">\r\nvar KE_"+Field_name+";";
              FormHtml+="\r\nKindEditor.ready(function(K) {";
              FormHtml+="\r\nKE_"+Field_name+"= K.create(\"#"+Field_name+"\",";
              FormHtml+="\r\n{";
              FormHtml+="\r\nuploadJson :kindeditor_uploadJson,";
              FormHtml+="\r\nfileManagerJson :kindeditor_fileManagerJson,";
              FormHtml+="\r\nallowImageUpload:false,";
              FormHtml+="\r\nallowFlashUpload:false,";
              FormHtml+="\r\nallowMediaUpload:false,";
              FormHtml+="\r\nallowFileUpload:false,";
              FormHtml+="\r\nallowFileManager :false,";
              FormHtml+="\r\nitems :kindeditor_"+Fck_Style+"Items,";
              FormHtml+="\r\nnewlineTag:\"p\",";
              FormHtml+="\r\nfilterMode :true,";
              FormHtml+="\r\nextraFileUploadParams:{siteid:\""+SiteId+"\"}";
              FormHtml+="\r\n}";
              FormHtml+="\r\n);";
             FormHtml+="\r\n});";
             FormHtml+="\r\n</script"+">";
          Submit_Js+="KE_"+Field_name+".sync();"+"\r\n";
          break;

          case "image":
          FormHtml+="\r\n<tr><td align=right>"+Field_title+Mustfill+"</td><td><input type=file name=\""+Field_name+"\"  id=\""+Field_name+"\" value=\""+Defaultvalue+"\""+Style+Input_Attribute+" ></td></tr>";
          break;

          case "file":
          FormHtml+="\r\n<tr><td align=right>"+Field_title+Mustfill+"</td><td><input type=file name=\""+Field_name+"\"  id=\""+Field_name+"\" value=\""+Defaultvalue+"\""+Style+Input_Attribute+" ></td></tr>";
          break;

        case "select":
          FormHtml+="\r\n<tr><td align=right>"+Field_title+Mustfill+"</td><td><select id=\""+Field_name+"\" name=\""+Field_name+"\" "+Input_Attribute+" >";
          for(int i=0;i<AItems.Length;i++)
           {
              if(AItems[i].Split(',').Length==2)
               {
                A_AItems=AItems[i].Split(',');
               }
              else
               {
                A_AItems[0]=AItems[i];
                A_AItems[1]=AItems[i];
               }
             if(A_AItems[0]==Defaultvalue)
              {
               FormHtml+="<option value=\""+A_AItems[0]+"\" selected>"+A_AItems[1]+"</option>";
              }
             else
              {
               FormHtml+="<option value=\""+A_AItems[0]+"\">"+A_AItems[1]+"</option>";
              }
           }
          FormHtml+="</select></td></tr>";
          break;

       case "checkbox":
          FormHtml+="\r\n<tr><td align=right>"+Field_title+Mustfill+"</td><td>";
           for(int i=0;i<AItems.Length;i++)
           {
              if(AItems[i].Split(',').Length==2)
               {
                A_AItems=AItems[i].Split(',');
               }
              else
               {
                A_AItems[0]=AItems[i];
                A_AItems[1]=AItems[i];
               }
             if(A_AItems[0]==Defaultvalue)
              {
               FormHtml+=" <input type=checkbox  value=\""+A_AItems[0]+"\" checked  name=\""+Field_name+"\">"+A_AItems[1];
              }
             else
              {
               FormHtml+=" <input type=checkbox  value=\""+A_AItems[0]+"\" name=\""+Field_name+"\">"+A_AItems[1];
              }
           }
          FormHtml+="</td></tr>";
          break;

       case "radio":
          FormHtml+="\r\n<tr><td align=right>"+Field_title+Mustfill+"</td><td>";
           for(int i=0;i<AItems.Length;i++)
           {
              if(AItems[i].Split(',').Length==2)
               {
                A_AItems=AItems[i].Split(',');
               }
              else
               {
                A_AItems[0]=AItems[i];
                A_AItems[1]=AItems[i];
               }
             if(A_AItems[0]==Defaultvalue)
              {
               FormHtml+=" <input type=radio value=\""+A_AItems[0]+"\" checked name=\""+Field_name+"\">"+A_AItems[1];
              }
             else
              {
               FormHtml+=" <input type=radio value=\""+A_AItems[0]+"\"  name=\""+Field_name+"\">"+A_AItems[1];
              }
           }
          FormHtml+="</td></tr>";
          break;

        }
     }
    dr.Close();
    if(Show_TgYzm=="1")
    {
     FormHtml+="\r\n<tr><td align=right>验证码<span style=\"color:#ff0000\">*</span></td><td><input type=text name=\"vcode\" id=\"vcode\" maxlength=4 size=4> <img src=\"/e/aspx/yzm.aspx\" onclick=Code_Change(\"vcode_img\") align=absmiddle border=0 id=\"vcode_img\" style=\"cursor:pointer\" alt=\"点击更换\"></td></tr>";
    }
    FormHtml+="\r\n<tr><td colspan=2 align=center><input type=\"hidden\" name=\"checked\" value=\"0\"><input type=\"hidden\" name=\"showcode\" value=\"0\"><input type=\"hidden\" name=\"to\" value=\"\"><input type=\"hidden\" name=\"mailto\" value=\"\"><input type=\"hidden\" name=\"mailreply\" value=\"\"><input type=\"hidden\" name=\"mailsubject\" value=\"\"><input type=\"hidden\" name=\"mailbody\" value=\"\"><input type=\"hidden\" name=\"insertdatabase\" value=\"1\"><input type=\"hidden\" name=\"siteid\" value=\""+SiteId+"\"><input type=\"hidden\" name=\"formtable\" value=\""+Form_Table+"\"><input type=\"hidden\" name=\"mustname\" value=\""+MustFillName+"\"><input type=\"hidden\" name=\"mustfield\" value=\""+MustFillField+"\"><input type=\"hidden\" name=\"musttype\" value=\""+MustFillType+"\"><input type=\"button\" class=\"bt\" value=\""+SubmitValue+"\" onclick=\"return set_"+Form_Table+"()\"> <input type=\"reset\" value=\""+ResetValue+"\" class=\"bt\"></td></tr></table>\r\n</form>";
    FormHtml+="\r\n<s"+"cript type=\"text/javascript\">\r\nfunction set_"+Form_Table+"()\r\n{\r\ndocument.forms[\""+Form_Table+"\"].mailto.value=\"\";\r\ndocument.forms[\""+Form_Table+"\"].mailreply.value=\"\";\r\ndocument.forms[\""+Form_Table+"\"].mailsubject.value=\"\";\r\ndocument.forms[\""+Form_Table+"\"].mailbody.value=\"\";\r\nreturn Check_ZdyForm(\""+Form_Table+"\");\r\n}\r\n";
    FormHtml+="\r\nfunction "+Form_Table+"_zdycheck(){\r\n"+Submit_Js+"return true;\r\n}\r\n</script"+">";
    if(HasDate==1)
    {
     FormHtml="<s"+"cript type=\"text/javascript\" src=\"/e/js/calendar.js\"></script"+">"+FormHtml;
    }
    Content.Text=FormHtml;
   }

 void Get_SearchHtml()
    {
    string SubmitValue=" 搜索 ";
    string sql="select * from pa_field where thetable='"+Form_Table+"' and searchitem>0  order by xuhao"; 
    OleDbCommand mycomm=new OleDbCommand(sql,conn);
    OleDbDataReader dr=mycomm.ExecuteReader();
    string FormHtml="<form name=\"S_"+Form_Table+"\" method=\"get\" target=\"zdy_search\" action=\"/e/search/\">\r\n";
    MustFillName="";
    int HasDate=0;
    if(Search_Sort_List!="" && Search_Sort_List!=null)
     {
       FormHtml+="分类：<select name=\"sortid\" id=\"sortid\"><option value=\"0\">所有类别</option>"+Search_Sort_List+"</select><br>";
     }

    while(dr.Read())
     {
       DateInput="";
       Field_type=dr["field_type"].ToString();
       Field_title=dr["field_name"].ToString();
       Field_name=dr["field"].ToString();
       Value_type=dr["value_type"].ToString();
       Input_Attribute=dr["field_attribute"].ToString().Replace("\"","\"").Replace("\r\n","  ");
    
       Defaultvalue=dr["defaultvalue"].ToString();
       Fitems=dr["items"].ToString().Replace("\r\n","|");
       string[] AItems=Fitems.Split('|');
       string[] A_AItems=new string[2];
       Style=dr["style"].ToString();

       switch(Field_type)
        {
          case "text":
             if(Input_Attribute.ToLower().IndexOf("maxlength=")<0)
              {
               Input_Attribute+=" maxlength=\"50\" ";
              }
           if(Value_type=="datetime")
             {
              HasDate=1;
              DateInput="<a href=javascript:open_calendar(\""+Field_name+"_min\")><img src=/e/images/public/date.gif border=0 height=20 hspace=2 align=absbottom></a>";
              FormHtml+=Field_title+"：<input type=text name=\""+Field_name+"_min\" id=\""+Field_name+"_min\" maxlength=\"10\">"+DateInput;
              DateInput="<a href=javascript:open_calendar(\""+Field_name+"_max\")><img src=/e/images/public/date.gif border=0 height=20 hspace=2 align=absbottom></a>";
              FormHtml+=" 至 <input type=text name=\""+Field_name+"_max\" id=\""+Field_name+"_max\" maxlength=\"10\">"+DateInput+"<br>";
             }
           else
             {
              FormHtml+=Field_title+"：<input type=text name=\""+Field_name+"\" id=\""+Field_name+"\" value=\""+Defaultvalue+"\" "+Input_Attribute+"><br>";
             }
          break;

         case "select":
          FormHtml+=Field_title+"： <select name=\""+Field_name+"\" id=\""+Field_name+"\" "+Input_Attribute+" >";
          for(int i=0;i<AItems.Length;i++)
           {
              if(AItems[i].Split(',').Length==2)
               {
                A_AItems=AItems[i].Split(',');
               }
              else
               {
                A_AItems[0]=AItems[i];
                A_AItems[1]=AItems[i];
               }
             if(A_AItems[0]==Defaultvalue)
              {
               FormHtml+="<option value=\""+A_AItems[0]+"\" selected>"+A_AItems[1]+"</option>";
              }
             else
              {
               FormHtml+="<option value=\""+A_AItems[0]+"\">"+A_AItems[1]+"</option>";
              }
           }
          FormHtml+="</select><br>";
          break;

        case "checkbox":
          FormHtml+=Field_title+"：";
           for(int i=0;i<AItems.Length;i++)
           {
              if(AItems[i].Split(',').Length==2)
               {
                A_AItems=AItems[i].Split(',');
               }
              else
               {
                A_AItems[0]=AItems[i];
                A_AItems[1]=AItems[i];
               }
             if(A_AItems[0]==Defaultvalue)
              {
               FormHtml+=" <input type=checkbox value=\""+A_AItems[0]+"\" checked name=\""+Field_name+"\">"+A_AItems[1];
              }
             else
              {
               FormHtml+=" <input type=checkbox value=\""+A_AItems[0]+"\" name=\""+Field_name+"\">"+A_AItems[1];
              }
           }
           FormHtml+="<br>";
          break;

       case "radio":
          FormHtml+=Field_title+"：";
           for(int i=0;i<AItems.Length;i++)
           {
              if(AItems[i].Split(',').Length==2)
               {
                A_AItems=AItems[i].Split(',');
               }
              else
               {
                A_AItems[0]=AItems[i];
                A_AItems[1]=AItems[i];
               }
             if(A_AItems[0]==Defaultvalue)
              {
               FormHtml+=" <input type=radio value=\""+A_AItems[0]+"\" checked name=\""+Field_name+"\">"+A_AItems[1];
              }
             else
              {
               FormHtml+=" <input type=radio value=\""+A_AItems[0]+"\"  name=\""+Field_name+"\">"+A_AItems[1];
              }
           }
           FormHtml+="<br>";
          break;
        default:
          FormHtml+=Field_title+"：<input type=text name=\""+Field_name+"\" id=\""+Field_name+"\" value=\""+Defaultvalue+"\" "+Input_Attribute+"><br>";
        break;
        }
     }
    dr.Close();
    string ModelId="0";
    sql="select id from pa_model where thetable='"+Form_Table+"' and thetype='search'  order by xuhao"; 
    mycomm=new OleDbCommand(sql,conn);
    dr=mycomm.ExecuteReader();
    if(dr.Read())
     {
      ModelId=dr["id"].ToString();
     }
    dr.Close();
    FormHtml+="排序："+SortStr+"<br>";
    FormHtml+="每页显示数：<input type=\"text\" name=\"pagesize\" value=\"20\" size=\"5\" maxlength=\"9\"><br>";
    FormHtml+="<!--以上html代码可根据需要删除和修改-->";
    FormHtml+="<input type=\"hidden\" name=\"modelid\" value=\""+ModelId+"\"><input type=\"hidden\" name=\"siteid\" value=\""+SiteId+"\"><input type=\"submit\" class=\"bt\" value=\""+SubmitValue+"\">\r\n</form>";
    if(HasDate==1)
    {
     FormHtml="<s"+"cript type=\"text/javascript\" src=\"/e/js/calendar.js\"></script"+">"+FormHtml;
    }
    Search.Text=FormHtml;
   }

private void Get_Table(string thetable)
 {
   Show_TgYzm="0";
   if(IsStr(thetable))
   {
   string sql="select show_tgyzm from pa_table where thetable='"+thetable+"'";
   OleDbCommand comm=new OleDbCommand(sql,conn);
   OleDbDataReader dr=comm.ExecuteReader();
   if(dr.Read())
    {
     Show_TgYzm=dr["show_tgyzm"].ToString();
    }
   dr.Close();
   }
 }

private void  Get_Sort(int Parentid)
 {
   string sql="select id,sort_level,sort_name,final_sort from pa_sort where parent_id="+Parentid+" and thetable='"+Form_Table+"' and site_id="+SiteId+" order by xuhao";
   OleDbCommand comm=new OleDbCommand(sql,conn);
   OleDbDataReader dr=comm.ExecuteReader();
   string List_style="";
   while(dr.Read())
    {
      List_Space="";
      List_Level=int.Parse(dr["sort_level"].ToString());
      for(int i=0;i<List_Level-1;i++)
       {
        List_Space+="&nbsp;&nbsp;&nbsp;";
       }
      if(List_Level>1)
       {
        List_Space+="|-";
       }
      if(dr["final_sort"].ToString()=="1") 
       {
         Sort_List+="<option value=\""+dr["id"].ToString()+"\">"+List_Space+dr["sort_name"].ToString()+"</option>\r\n";
       }
      else
       {
        if(List_Level==1)
         {
           List_style=" class=\"rootnode\" ";
         }
        else
         {
           List_style=" class=\"childnode\" ";
         }
         Sort_List+="<option value=\"\" "+List_style+" disabled=\"disabled\">"+List_Space+dr["sort_name"].ToString()+"</option>\r\n";
         Get_Sort(int.Parse(dr["id"].ToString()));
       }

    }
   dr.Close();
  }

private void  Get_SearchSort(int Parentid)
 {
   string sql="select id,sort_level,sort_name,final_sort from pa_sort where parent_id="+Parentid+" and thetable='"+Form_Table+"' and site_id="+SiteId+" order by xuhao";
   OleDbCommand comm=new OleDbCommand(sql,conn);
   OleDbDataReader dr=comm.ExecuteReader();
   string List_style="";
   while(dr.Read())
    {
      List_Space="";
      List_Level=int.Parse(dr["sort_level"].ToString());
      for(int i=0;i<List_Level-1;i++)
       {
        List_Space+="&nbsp;&nbsp;&nbsp;";
       }
      if(List_Level>1)
       {
        List_Space+="|-";
       }
      if(dr["final_sort"].ToString()=="1") 
       {
         Search_Sort_List+="<option value=\""+dr["id"].ToString()+"\">"+List_Space+dr["sort_name"].ToString()+"</option>\r\n";
       }
      else
       {
        if(List_Level==1)
         {
           List_style=" class=\"rootnode\" ";
         }
        else
         {
           List_style=" class=\"childnode\" ";
         }
         Search_Sort_List+="<option value=\""+dr["id"].ToString()+"\" "+List_style+">"+List_Space+dr["sort_name"].ToString()+"</option>\r\n";
         Get_SearchSort(int.Parse(dr["id"].ToString()));
       }
    }
   dr.Close();
  }

private void Get_SortField()
 {
   SortStr="<select name=\"order\" id=\"order\">\r\n";
   string sql="select [field],[field_name] from pa_field where thetable='"+Form_Table+"' and sortitem=1 order by xuhao";
   OleDbCommand comm=new OleDbCommand(sql,conn);
   OleDbDataReader dr=comm.ExecuteReader();
   while(dr.Read())
    {
      SortStr+="<option value=\""+dr["field"].ToString()+" desc\">按"+dr["field_name"].ToString()+"↓</option>\r\n";
      SortStr+="<option value=\""+dr["field"].ToString()+"\">按"+dr["field_name"].ToString()+"↑</option>\r\n";
    }
   dr.Close();

  SortStr+="<option value=\"id desc\">按Id↓</option>\r\n";
  SortStr+="<option value=\"clicks desc\">按点击↓</option>\r\n";
  SortStr+="<option value=\"downloads desc\">按下载↓</option>\r\n";
  SortStr+="<option value=\"comments desc\">按评论↓</option>\r\n";
  SortStr+="</select>\r\n";

 }

private bool IsStr(string str)
 { 
   if(str==null || str=="")
    {
     return false;
    }
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
</script>
<% @ Register TagPrefix="aspcn" TagName="uc_head" src="head.ascx" %>
<aspcn:uc_head runat="server" Type="zdytable_list"/> 
<body topmargin=0 bottommargin=0 leftmargin=0  rightmargin=0>
<center>
<table  border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr><td height=10></td></tr>
 <tr><td class=table_style1><a href="javascript:location.reload()" title="点击刷新"><b>获取表单</b></a></td></tr>
 <tr><td height=10></td></tr>
</table>
<table border=0 cellpadding=0 cellspacing=0 width=95% >
 <tr>
<td valign=top align="left">
<form runat="server" >
<div id="tabdiv">
<ul>
<li id="tab" name="tab" onclick="showtab(0)" style="font-weight:bold">发布表单</li>
<li id="tab" name="tab" onclick="showtab(1)">搜索表单</li>
</ul>
</div>
<div name="tabcontent" id="tabcontent">
<table border=0 cellpadding=10 cellspacing=0 width=100% align=center class=table_style2>
<tr>
  <td><asp:TextBox id="Content" TextMode="MultiLine"  runat="server" style="width:90%;height:400px"/>
  </td>
 </tr>
 <tr><td>注：以上为系统自动生成的html提交表单，使用时可自行对html代码进行修改或重新排版。</td></tr>
</table>
</div>
<div name="tabcontent" id="tabcontent" style="display:none">
<table border=0 cellpadding=10 cellspacing=0 width=100% align=center class=table_style2>
 <tr>
  <td ><asp:TextBox id="Search" TextMode="MultiLine"  runat="server" style="width:90%;height:400px"/>
  </td>
   </tr>
 <tr><td>注：以上为根据搜索字段自动生成的html搜索表单，使用时可自行对html代码进行修改或重新排版<br>如果需要设置搜索模型，找到name="modelid"的input表单，value值改为你要使用的搜索模型的ID值即可。</td></tr>
</table>
</div>
<div align=center style="padding:10px"><input type="button" class=button value="关闭"  onclick="parent.CloseDialog()"></div>
</td>
</tr>
</table>
<br>
</td>
</tr>
</table>
</form>
</center>
</body>
</html>


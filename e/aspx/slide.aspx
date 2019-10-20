<% @ Page  language="c#"%>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<% @ Import NameSpace="System.Text"%>
<% @ Import NameSpace="System.Text.RegularExpressions"%>
<% @ Import NameSpace="System.IO"%>
<% @ Import NameSpace="PageAdmin"%>
<script Language="C#" Runat="server">
  string Pics,Links,Titles,Contents,Alts,Width,Height,Show_Text,CurrentId,Target,Border_Width,Border_Color,Tf_Effect,Tf_Time,Show_Slide_Num;
  string TheTable,Sort_Ids,Show_Num,Show_Style,Show_Type,List_Order,Url_Prefix,Url_Prefix_1,Sql_ZtCondition,sql;
  int Data_SiteId,Is_Static,Is_Static_1,Title_Num,Sort_Id,Zt_Id,Site_Id;
  OleDbConnection conn;
  protected void Page_Load(Object sender,EventArgs e)
   {
     Conn Myconn=new Conn();
     conn=Myconn.OleDbConn();//获取OleDbConnection
     conn.Open();
      Load_Data();
     conn.Close();
   }

private void Load_Data()
   {
     int Id=0;
     if(IsNum(Request.QueryString["id"]))
      {
        Id=int.Parse(Request.QueryString["id"]);
      }
     else
      {
        return;
      }
     OleDbCommand Comm;
     sql="select * from pa_slide where id="+Id;
     Comm=new OleDbCommand(sql,conn);
     OleDbDataReader dr=Comm.ExecuteReader();
     if(dr.Read())
      {
       Data_SiteId=int.Parse(dr["data_siteid"].ToString());
       Show_Style=dr["style"].ToString();
       if(Show_Style=="0")
         {
          UserControl UC=(UserControl)Page.LoadControl("~/e/d/slide_"+Id+".ascx");
          ((PageAdmin.patag)UC).SiteId=int.Parse(dr["site_id"].ToString());
          P4.Controls.Add(UC);
          P4.Visible=true;
         }
        else if(Show_Style=="5")
         {
          P2.Visible=true;
          Border_Color=dr["border_color"].ToString().Replace("#","0x");
         }  
        else if(Show_Style=="4")
         {
          P1.Visible=true;
          Border_Color=dr["border_color"].ToString().Replace("#","0x");
         }  
        else
         {
          P3.Visible=true;
         }
        Tf_Effect=dr["tf_effect"].ToString();
        Tf_Time=dr["tf_time"].ToString();
        Border_Width=dr["border_width"].ToString();
        CurrentId=dr["id"].ToString();
        Sort_Id=int.Parse(dr["sort_id"].ToString());
        Site_Id=int.Parse(dr["site_id"].ToString());
        if(Data_SiteId==0){Data_SiteId=Site_Id;}
        Zt_Id=int.Parse(dr["zt_id"].ToString());
        if(Zt_Id>0)
         {
          Sql_ZtCondition=" and iszt=1 and zt_ids like '%,"+Zt_Id+",%'";
         }
        Get_Site();
        Title_Num=int.Parse(dr["title_num"].ToString());
        if(Title_Num==0)
         {
          Show_Text="0";
         }
        else
         {
          Show_Text="1";
         }
        Show_Num=dr["show_num"].ToString();
        Show_Type=dr["show_type"].ToString();
        List_Order=dr["zdy_sort"].ToString();
        TheTable=dr["thetable"].ToString();
        if(TheTable==""){TheTable="zdy";}
        if(List_Order=="")
         {
          List_Order="order by "+Get_DefaultSort(TheTable);
         }
        switch(TheTable)
         {
          case "zdy":
             Pics=dr["zdy_image"].ToString();
             Links=dr["zdy_link"].ToString();
             Titles=Server.HtmlEncode(dr["zdy_title"].ToString());
             Contents=dr["zdy_content"].ToString();
             Alts="";
             if(Titles=="")
              {
                Show_Text="0";
              }
             else
              {
                Show_Text="1";
              }
          break;

          default:
            if(Sort_Id==0)
             {
               sql="select top "+Show_Num+" id from "+TheTable+" where site_id="+Data_SiteId+" and has_titlepic=1 and checked=1 "+Show_Type+Sql_ZtCondition+" "+List_Order;
             }
            else
             {
               Sort_Ids=SortIds(Sort_Id);
               if(IsNum(Sort_Ids))
               {
                 sql="select top "+Show_Num+" id from "+TheTable+" where site_id="+Data_SiteId+" and has_titlepic=1 and checked=1 and sort_id="+Sort_Ids+" "+Show_Type+Sql_ZtCondition+" "+List_Order;
               }
               else
               {
                 sql="select top "+Show_Num+" id from "+TheTable+" where site_id="+Data_SiteId+" and has_titlepic=1 and checked=1 and sort_id in("+Sort_Ids+") "+Show_Type+Sql_ZtCondition+" "+List_Order;
               }
             }
            Read_Data(sql);
          break;
         }
       Width=dr["width"].ToString();
       Height=dr["height"].ToString();
       Target=dr["target"].ToString();
      }
    else
      {
       Response.End();
      }
   dr.Close();
  }

private void Read_Data(string sql)
   {
      string SP="";
      DataSet ds=new  DataSet(); 
      OleDbDataAdapter myAdapter=new OleDbDataAdapter(sql,conn);//在数据库和DataSet之间建立桥接。
      myAdapter.Fill(ds,0,int.Parse(Show_Num),"default");
      ds=Optimize_DataSet(ds,TheTable);
      ds.Tables["default"].DefaultView.Sort=List_Order.Replace("order by ","");
      DataTable DT=ds.Tables["default"].DefaultView.ToTable();
      DataRow dr;
      for(int i=0;i<DT.Rows.Count;i++)
        { 
          dr=DT.Rows[i];
          if(i<DT.Rows.Count-1)
           {
             SP="|";
           }
          else
           {
             SP="";
           }
           Pics+=dr["titlepic"].ToString()+SP;
           Links+=Detail_Url(dr)+SP;
           Titles+=Get_title_num(dr["title"].ToString(),true)+SP;
           Alts+=dr["title"].ToString()+SP;
         }

   }

private DataSet Optimize_DataSet(DataSet SourceDs,string Table)
 {
   int RCount=SourceDs.Tables["default"].Rows.Count;
   string Ids="0";
   if(RCount>0)
    {
      DataRow dr;
      for(int i=0;i<RCount;i++)
       {
         dr=SourceDs.Tables["default"].Rows[i];
         Ids+=","+dr["id"].ToString();
       }
    }
   SourceDs.Clear();
   string sql="select * from "+Table+" where id in("+Ids+")";
   OleDbDataAdapter myAdapter=new OleDbDataAdapter(sql,conn);
   myAdapter.Fill(SourceDs,"default");
   return SourceDs;
 }

private string Get_DefaultSort(string Table)
 {
   string rv="";
   string sql="select default_sort from pa_table where thetable='"+Table+"'";
   OleDbCommand comm=new OleDbCommand(sql,conn);
   OleDbDataReader dr=comm.ExecuteReader();
   if(dr.Read())
      {
        rv=dr["default_sort"].ToString();
      }
   dr.Close();
   if(rv==""){rv="actdate desc";}
   return rv;
 }

private string SortIds(int SortId)
 {
     string Ids=SortId.ToString(); 
     sql="select id from pa_sort where site_id="+Site_Id+" and thetable='"+TheTable+"' and final_sort=1 and parent_ids like '%,"+SortId+",%'";
     OleDbCommand comm=new OleDbCommand(sql,conn);
     OleDbDataReader dr=comm.ExecuteReader();
     while(dr.Read())
      {
        Ids+=","+dr["id"].ToString();
      }
    dr.Close();
    return Ids;
 }

private DataTable Get_Data(string Sql)
   {
     DataSet ds=new  DataSet(); 
     OleDbDataAdapter myAdapter=new OleDbDataAdapter(Sql,conn);
     myAdapter.Fill(ds,"zdy");
     return ds.Tables["zdy"];
   }

private string Sublanmu_Url(int SiteId,int Lanmu_Id,int SubLanmu_Id,string Parent_Dir,string Lanmu_dir,string Sublanmu_Dir,string zdyurl)
 {
   string Rv="";
   if(zdyurl!="")
    {
     Rv=zdyurl;
    }
   else
   {
    if(Site_Id==SiteId)
     {
       Url_Prefix_1=Url_Prefix;
       Is_Static_1=Is_Static;
     }
    else
     {
      Get_Site(SiteId);
     }
   if(Is_Static_1==1)
      {
        Rv=Url_Prefix_1+(Lanmu_dir==""?"":Lanmu_dir+"/")+(Parent_Dir==""?"":"/"+Parent_Dir)+Sublanmu_Dir;
        Rv=Rv.Replace("//","/");
      }
   else
      {
       Rv=Url_Prefix_1+"index.aspx?lanmuid="+Lanmu_Id+"&sublanmuid="+SubLanmu_Id;
      }
   }
  return Rv;
 }


private string Sort_Url(int DataSiteId,string TheTable,int Sort_Id)
 {
   string ParentIds="0",Rv="";
   string sql="select parent_dir,lanmu_id,lanmu_dir,sublanmu_dir,zdy_url,id from pa_sublanmu where site_id="+Site_Id+" and data_siteid="+DataSiteId+" and is_sortsublanmu=1 and sort_id="+Sort_Id+" and thetable='"+TheTable+"'";
   OleDbCommand Comm=new OleDbCommand(sql,conn);
   OleDbDataReader dr=Comm.ExecuteReader();
   if(dr.Read())
    {
      Rv=Sublanmu_Url(Site_Id,int.Parse(dr["lanmu_id"].ToString()),int.Parse(dr["id"].ToString()),dr["parent_dir"].ToString(),dr["lanmu_dir"].ToString(),dr["sublanmu_dir"].ToString(),dr["zdy_url"].ToString());
    }
   dr.Close();
   if(Rv=="")
    {
      sql="select parent_ids from pa_sort where id="+Sort_Id;
      Comm=new OleDbCommand(sql,conn);
      dr=Comm.ExecuteReader();
      if(dr.Read())
      {
       ParentIds=dr["parent_ids"].ToString();
      }
      dr.Close();
      string[] AParent_Sorts=ParentIds.Split(',');
      int SLength=AParent_Sorts.Length;
      string C_Sort;
       for(int i=0;i<SLength;i++)
        {
           C_Sort=AParent_Sorts[SLength-i-1];
           if(C_Sort!="" && C_Sort!="0")
            {
              sql="select parent_dir,lanmu_id,lanmu_dir,sublanmu_dir,zdy_url,id from pa_sublanmu where site_id="+Site_Id+" and data_siteid="+DataSiteId+" and is_sortsublanmu=1 and sort_id="+int.Parse(C_Sort)+" and thetable='"+TheTable+"'";
              Comm=new OleDbCommand(sql,conn);
              dr=Comm.ExecuteReader();
              if(dr.Read())
              {
                Rv=Sublanmu_Url(Site_Id,int.Parse(dr["lanmu_id"].ToString()),int.Parse(dr["id"].ToString()),dr["parent_dir"].ToString(),dr["lanmu_dir"].ToString(),dr["sublanmu_dir"].ToString(),dr["zdy_url"].ToString());
                dr.Close();
                break;
              }
             dr.Close();
           }
        }

    }
   if(Rv=="")
    {
      sql="select parent_dir,lanmu_id,lanmu_dir,sublanmu_dir,zdy_url,id from pa_sublanmu where site_id="+Site_Id+" and data_siteid="+DataSiteId+" and is_sortsublanmu=1  and sort_id=0 and thetable='"+TheTable+"'";
      Comm=new OleDbCommand(sql,conn);
      dr=Comm.ExecuteReader();
      if(dr.Read())
      {
       Rv=Sublanmu_Url(Site_Id,int.Parse(dr["lanmu_id"].ToString()),int.Parse(dr["id"].ToString()),dr["parent_dir"].ToString(),dr["lanmu_dir"].ToString(),dr["sublanmu_dir"].ToString(),dr["zdy_url"].ToString());
      }
     dr.Close();
    }
   
  return Rv;
 }

private string Detail_Url(DataRow dr)
 {  
   string Rv="";
   if(dr["source_id"].ToString()!="0")
    {
     dr=Get_Data("select * from "+TheTable+" where id="+dr["source_id"].ToString()).Rows[0]; 
    }
   if(dr["site_id"].ToString()!=Site_Id.ToString())
    {
     Rv=Sort_Url(int.Parse(dr["site_id"].ToString()),TheTable,int.Parse(dr["sort_id"].ToString()));
     if(Rv!="")
      {
       if(Rv.IndexOf("&")>0)
       {
        Rv+="&id="+dr["id"].ToString();
       }
      else
       {
        Rv+="/index.aspx?id="+dr["id"].ToString();
       }
     }
   }
   if(Rv=="")
    {
     Rv=DetailUrl(int.Parse(dr["site_id"].ToString()),TheTable,dr["static_dir"].ToString(),dr["static_file"].ToString(),dr["lanmu_id"].ToString(),dr["sublanmu_id"].ToString(),dr["id"].ToString(),dr["zdy_url"].ToString(),dr["permissions"].ToString(),dr["html"].ToString());
    }
   if(Rv=="")
    {
     Rv="javascript:void(0)";
    }
   return Rv;
 }

private string DetailUrl(int SiteId,string TheTable,string Static_dir,string Static_file,string Lanmu_Id,string SubLanmu_Id,string Id,string ZdyUrl,string Permissions,string Html)
 {
  string Rv;
  if(ZdyUrl!="")
   {
     Rv=ZdyUrl;
   }
  else
   {
    if(Site_Id==SiteId)
    {
     Url_Prefix_1=Url_Prefix;
     Is_Static_1=Is_Static;
    }
   else
    {
     Get_Site(SiteId);
    }
    if(Is_Static_1==1)
     {
      if(Html=="2" && Permissions=="")
       {
         Rv=Url_Prefix_1+(Static_dir==""?"":Static_dir+"/")+(Static_file==""?Id+".html":Static_file);
       }
      else if(Html=="1")
       {
         Rv=Url_Prefix_1+TheTable+"/detail_"+Id+".html";
       }
      else
       {
        DataTable dt=Get_Data("select * from pa_sublanmu where id="+SubLanmu_Id);
        if(dt.Rows.Count>0)
         {
          DataRow dr=dt.Rows[0];
          Rv=Sublanmu_Url(int.Parse(dr["site_id"].ToString()),int.Parse(dr["lanmu_id"].ToString()),int.Parse(dr["id"].ToString()),dr["parent_dir"].ToString(),dr["lanmu_dir"].ToString(),dr["sublanmu_dir"].ToString(),"")+"/index.aspx?id="+Id;
         }
        else
         {
          Rv=Url_Prefix_1+"index.aspx?lanmuid="+Lanmu_Id+"&sublanmuid="+SubLanmu_Id+"&id="+Id;
         } 
       }
     }
    else
     {
       Rv=Url_Prefix_1+"index.aspx?lanmuid="+Lanmu_Id+"&sublanmuid="+SubLanmu_Id+"&id="+Id;
     }
   }
  return Rv;
 }


private void Get_Site(int sid)
 {
   Url_Prefix_1="/";
   Is_Static_1=0;
   string sql="select [html],[directory],[domain],[html] from pa_site where id="+sid;
   OleDbCommand comm=new OleDbCommand(sql,conn);
   OleDbDataReader dr=comm.ExecuteReader();
   if(dr.Read())
    {
     Is_Static_1=int.Parse(dr["html"].ToString());
     string SiteDir=dr["directory"].ToString();
     string TheDomain=dr["domain"].ToString();
     if(TheDomain!="")
      {
        Url_Prefix_1="http://"+TheDomain.Replace("http://","")+"/";
      }
     if(SiteDir!="")
        {
          if(TheDomain=="")
           {
             Url_Prefix_1="/"+SiteDir+"/";
           }
          else
           {
             Url_Prefix_1+=SiteDir+"/";
           }
        }
    }
   dr.Close();
 }

private void Get_Site()
 {
   Url_Prefix="/";
   sql="select [directory],[domain],[html] from pa_site where id="+Site_Id;
   OleDbCommand comm=new OleDbCommand(sql,conn);
   OleDbDataReader dr=comm.ExecuteReader();
   if(dr.Read())
    {
     Is_Static=int.Parse(dr["html"].ToString());
     string SiteDir=dr["directory"].ToString();
     string TheDomain=dr["domain"].ToString();
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
     Url_Prefix="/";
     Response.End();
    }
   dr.Close();
 }

private string Get_title_num(string Title,bool HtmlEncode) 
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

</script><%if(Show_Style!="0"){%>var Show_Style=<%=Show_Style%>;
var Image_<%=CurrentId%>=new Array();
var Pics="<%=Pics%>";
var Links="<%=Links%>";
var Titles="<%=Server.HtmlEncode(Titles)%>";
var Alts="<%=Server.HtmlEncode(Alts)%>";
var Apic<%=CurrentId%>=Pics.split('|');
var ALink<%=CurrentId%>=Links.split('|');
var ATitle<%=CurrentId%>=Titles.split('|');
var AAlts<%=CurrentId%>=Alts.split('|');
var Show_Text=<%=Show_Text%>;
for(i=0;i<Apic<%=CurrentId%>.length;i++)
  {
   Image_<%=CurrentId%>.src = Apic<%=CurrentId%>[i]; 
  }
<%}%><asp:PlaceHolder id="P1" runat="server" Visible="false">
function LoadSlideBox_<%=CurrentId%>()
{
var text_mtop = 0;
var text_lm = 0;
var textmargin = text_mtop+"|"+text_lm;
var textcolor = "0x000000|0xff0000";
var text_align= 'center'; 
var text_size = 12;
var Border_Alpha;
if(<%=Border_Width%>=="0")
 {
  Border_Alpha=0;
 }
else
 {
  Border_Alpha=100;
 }
var borderStyle="1|0x000033|10";

var Interval_Time=<%=Tf_Time%>;
var focus_width=<%=Width%>;
var focus_height=<%=Height%>;
var text_height=20;
if(Show_Text==0)
 {
   text_height=0;
 }
var swf_height = focus_height+text_height+text_mtop; 
var text_align="center";
Links=escape(Links);
document.write('<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0" width="'+ focus_width +'" height="'+ swf_height +'">');
document.write('<param name="allowScriptAccess" value="sameDomain"><param name="movie" value="/e/images/swf/focus.swf"> <param name="quality" value="high"><param name="bgcolor" value="#ffffff">');
document.write('<param name="menu" value="false"><param name=wmode value="transparent">');
document.write('<param name="FlashVars" value="pics='+Pics+'&links='+Links+'&texts='+Titles+'&borderwidth='+focus_width+'&borderheight='+focus_height+'&textheight='+text_height+'&textmargin='+textmargin+'&textcolor='+textcolor+'&borderstyle='+borderStyle+'&text_align='+text_align+'&interval_time='+Interval_Time+'">');
document.write('<embed src="/e/images/swf/focus.swf"  wmode="transparent"  FlashVars="pics='+Pics+'&links='+Links+'&texts='+Titles+'&borderwidth='+focus_width+'&borderheight='+focus_height+'&textheight='+text_height+'&textmargin='+textmargin+'&textcolor='+textcolor+'&borderstyle='+borderStyle+'&text_align='+text_align+'&interval_time='+Interval_Time+'" menu="false" bgcolor="#ffffff" quality="high" width="'+ focus_width +'" height="'+ swf_height +'" allowScriptAccess="sameDomain" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" />');
document.write('</object>');
}
LoadSlideBox_<%=CurrentId%>();
</asp:PlaceHolder>

<asp:PlaceHolder id="P2" runat="server" Visible="false">
function LoadSlideBox_<%=CurrentId%>()
{
var bcastr_config="&bcastr_config=0xffffff|2|0x000000|60|0xffffff|0xff6600|0x000033|<%=Tf_Time%>|1|1|<%=Target%>";
//文字颜色|文字位置|文字背景颜色|文字背景透明度|按键文字颜色|按键默认颜色|按键当前颜色|自动播放时间(秒)|图片过渡效果|是否显示按钮|打开目标窗口
var swf_width=<%=Width%>;
var swf_height=<%=Height%>;
Links=escape(Links);
document.write('<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://fpdownload.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0" width="'+ swf_width +'" height="'+ swf_height +'">');
document.write('<param name="movie" value="/e/images/swf/bcastr3.swf"><param name="quality" value="high">');
document.write('<param name="menu" value="false"><param name=wmode value="transparent">');
document.write('<param name="FlashVars" value="bcastr_file='+Pics+'&bcastr_link='+Links+'&bcastr_title='+Titles+'&bcastr_config='+bcastr_config+'">');
document.write('<embed src="/e/images/swf/bcastr3.swf" wmode="transparent" FlashVars="bcastr_file='+Pics+'&bcastr_link='+Links+'&bcastr_title='+Titles+'&bcastr_config='+bcastr_config+'& menu="false" quality="high" width="'+ swf_width +'" height="'+ swf_height +'" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" />'); 
document.write('</object>'); 
}
LoadSlideBox_<%=CurrentId%>();
</asp:PlaceHolder><asp:PlaceHolder id="P3" runat="server" Visible="false">
  var FHTML='<div id="js_slide_focus_<%=CurrentId%>" class="slide_focus focus_style<%=Show_Style%>" <%=Height=="0"?"":"style=\"height:"+Height+"px\""%>><a class="prev"></a><a class="next"></a>';
  <%if(!string.IsNullOrEmpty(Contents))
  {%>
  FHTML+="<div class=\"slide_focus_zdycontent\"><%=Contents.Replace("\"","\\\"").Replace("\r\n","")%></div>";
  <%}%>
  FHTML+='<ul class="inner">';
  for(var i=0;i<Apic<%=CurrentId%>.length;i++)
   {
     if(ALink<%=CurrentId%>.length<(i+1) || ALink<%=CurrentId%>[i]=="")
      {
       ALink<%=CurrentId%>[i]="javascript:void(0)";
      }
     if(AAlts<%=CurrentId%>.length<(i+1))
      {
       AAlts<%=CurrentId%>[i]="";
      }
     if(ATitle<%=CurrentId%>.length<(i+1))
      {
       ATitle<%=CurrentId%>[i]="";
      }
    FHTML+='<li><a href="'+ALink<%=CurrentId%>[i]+'" target="<%=Target%>" title="'+AAlts<%=CurrentId%>[i]+'"><img src="'+Apic<%=CurrentId%>[i]+'">';
    FHTML+='<em>'+ATitle<%=CurrentId%>[i]+'</em>';
    FHTML+='</a></li>';
   }
 FHTML+='</ul>';
 FHTML+='</div>';
 document.write(FHTML);
<%if(Width=="0"){%>$(window).load(function(){Slide_Focus("js_slide_focus_<%=CurrentId%>",<%=Tf_Effect%>,<%=Tf_Time%>,<%=Width%>,<%=Height%>,<%=Show_Style=="3"?"true":"false"%>);});
<%}else{%>$(function(){Slide_Focus("js_slide_focus_<%=CurrentId%>",<%=Tf_Effect%>,<%=Tf_Time%>,<%=Width%>,<%=Height%>,<%=Show_Style=="3"?"true":"false"%>);});<%}%>
</asp:PlaceHolder><asp:PlaceHolder id="P4" runat="server" Visible="false"></asp:PlaceHolder>
<% @ Control  Language="C#" Inherits="PageAdmin.patag"%>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<%Start();%>
<div class="flash">
<script src="/e/aspx/slide.aspx?id=17" type="text/javascript"></script>
</div>
<div class="news">
<% @ Register TagPrefix="ascx" TagName="M_0" src="/e/zdymodel/article/module/132.ascx"%><ascx:M_0 runat="server" TagSiteId=1 SiteId=1 ZdyTag=1 ModuleId="217_0" TagTable="article" TagSortId=638 SqlOrder="order by " SqlCondition="" ShowNum=7 TagZtId=0 TitleNum=50 TitlePicWidth=150 TitlePicHeight=150 TheTarget="_self"/>
</div>
<div class="clear"></div>
<%End();%>
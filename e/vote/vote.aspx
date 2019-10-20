<% @ Page language="c#" Inherits="PageAdmin.vote" src="~/e/vote/vote.aspx.cs"%>
<form name="v<%=Id%>" method="post" action="/e/vote/vote.aspx?id=<%=Id%>" target="v">
<div class="vote"><ul>
<li class="votetitle"><%=VoteTitle%></li>
<li class="voteinfo">调查日期：<%=StartDate%> —— 截至日期：<%=EndDate%></li>
<li class="description"></li>
<asp:Repeater id="P" runat="server" OnItemDataBound="Data_Bound">
<ItemTemplate>
<asp:Label id="Lb_thetype" Text='<%#DataBinder.Eval(Container.DataItem,"thetype")%>' Runat="server" Visible="false"/>
<asp:Label id="Lb_id" Text='<%#DataBinder.Eval(Container.DataItem,"id")%>' Runat="server"  Visible="false"/>
 <li class="quesion"><b><%=I++%>.<%#DataBinder.Eval(Container.DataItem,"quesion")%></b><a name="<%#DataBinder.Eval(Container.DataItem,"id")%>" ></a></li>
     <asp:Repeater id="P1" runat="server"><ItemTemplate>
       <li class="choice"><input type="<%#Thetype%>" name="q<%#QuesionId%>" id="q<%#QuesionId%>" value="<%#DataBinder.Eval(Container.DataItem,"id")%>"><%#DataBinder.Eval(Container.DataItem,"choice")%></li>
     </ItemTemplate></asp:Repeater>
 <li class="clear"></li>
</ItemTemplate>
</asp:Repeater>
</ul></div>
<br>
<div align=center><input type="hidden" value="1" name="vote"> <input type="button" Value=" 投票 "  onclick="vote_<%=Id%>('vote')" class="bt">&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" Value=" 查看 " onclick="vote_<%=Id%>('view')" class="bt"></div>
</form> 
<script type="text/javascript">
 function vote_<%=Id%>(thetype)
  {
   var voteurl="/e/vote/voteview.aspx?id=<%=Id%>";
   if(thetype=="vote")
    {
    var obj;
    var Q="<%=QuesionIds%>";
    var AQ=Q.split(',');
    for(i=0;i<AQ.length;i++)
     {
       if(AQ[i]!="")
        {
           obj=document.getElementsByName("q"+AQ[i]);
           if(!IsChecked(obj))
           {
            alert("请填写好所有的问卷调查项目!");
            location.href="#"+AQ[i];
            return;
           }
        }
     }
     voteurl="";
    }
   var Width=850;
   var Height=500;
   var Left=(window.screen.availWidth-10-Width)/2;
   var Top=(window.screen.availHeight-30-Height)/2;
   var v=window.open(voteurl,"v","width="+Width+",height="+Height+",top="+Top+",left="+Left+",toolbar=no,menubar=no,scrollbars=yes,resizable=yes,location=no,status=no");
   if(thetype=="vote")
    {
    document.forms["v<%=Id%>"].target="v";
    document.forms["v<%=Id%>"].submit();
    }
  }

</script>
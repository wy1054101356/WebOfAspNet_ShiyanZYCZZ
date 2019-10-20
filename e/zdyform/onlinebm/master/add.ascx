<% @ Control  Language="C#" Inherits="PageAdmin.paform"%>
<% @ Import NameSpace="System.Data"%>
<% @ Import NameSpace="System.Data.OleDb"%>
<%Start();%>
<tr id='tr_onlinebm_title'><td class='tdhead'>姓名<span style='color:#ff0000'>*</span></td><td><input type=text name='title' id='title' value="<%if(post=="add"){Response.Write("");}else{Response.Write(r("title"));}%>"  maxlength="200"><span id="title_tip"></span></td></tr>
<tr id='tr_onlinebm_pa_xb'><td class='tdhead'>性别</td><td> <input type=radio value="男"  name='pa_xb' id='pa_xb' <%if(post=="add"){Response.Write(""=="男"?"checked":"");}else{Response.Write(r("pa_xb")=="男"?"checked":"");}%>>男 <input type=radio value="女"  name='pa_xb' id='pa_xb' <%if(post=="add"){Response.Write(""=="女"?"checked":"");}else{Response.Write(r("pa_xb")=="女"?"checked":"");}%>>女<span id="pa_xb_tip"></span></td></tr><tr id='tr_onlinebm_titlepic'><td class='tdhead'>相片</td><td><input ondblclick="if(this.value!='')window.open(this.value)" type=text name='titlepic' id='titlepic'  value="<%if(post=="add"){Response.Write("");}else{Response.Write(r("titlepic"));}%>"  ><a href="javascript:delete_file('onlinebm','titlepic',<%=InforId%>)" id="delete_titlepic" style="padding-left:2px;display:<%=r("titlepic")==""?"none":""%>" title='删除图片'><img src=/e/images/public/del.gif border=0></a><a id='upload_titlepic' href="javascript:open_upload('<%=SiteId%>','','image','onlinebm','titlepic','titlepic')" style="display:<%=r("titlepic")==""?"":"none"%>"><img src='/e/images/public/attachimg.gif' border=0  hspace=2 alt='上传图片' align=absbottom></a><span id="titlepic_tip"></span></td></tr><tr id='tr_onlinebm_pa_jg'><td class='tdhead'>籍贯</td><td><input type=text name='pa_jg' id='pa_jg' value="<%if(post=="add"){Response.Write("");}else{Response.Write(r("pa_jg"));}%>"  maxlength="200"><span id="pa_jg_tip"></span></td></tr>
<tr id='tr_onlinebm_thedate'><td class='tdhead'>发布日期<span style='color:#ff0000'>*</span></td><td><input type=text name='thedate' id='thedate' value="<%if(post=="add"){Response.Write(""==""?DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss"):"");}else{Response.Write(DateTime.Parse(r("thedate")).ToString("yyyy-MM-dd HH:mm:ss"));}%>"  maxlength="200"><a href="javascript:open_calendar('thedate',1)"><img src=/e/images/icon/date.gif border=0 height=20 hspace=2 align=absbottom></a><span id="thedate_tip"></span></td></tr>
<tr id='tr_onlinebm_pa_zy'><td class='tdhead'>专业选择</td><td><select name='pa_zy' id='pa_zy'   ><option value="工商管理学院">工商管理学院</option><option value="建筑工程学院">建筑工程学院</option><option value="国际人文学院">国际人文学院</option></select><span id="pa_zy_tip"></span><%if(post=="add"){%><script type="text/javascript">Set_Selected("","pa_zy")</script><%}else{%><script type="text/javascript">Set_Selected("<%=r("pa_zy")%>","pa_zy")</script><%}%></td></tr><tr id='tr_onlinebm_pa_tel'><td class='tdhead'>联系电话</td><td><input type=text name='pa_tel' id='pa_tel' value="<%if(post=="add"){Response.Write("");}else{Response.Write(r("pa_tel"));}%>"  maxlength="200"><span id="pa_tel_tip"></span></td></tr>
<tr id='tr_onlinebm_pa_adress'><td class='tdhead'>住址</td><td><input type=text name='pa_adress' id='pa_adress' value="<%if(post=="add"){Response.Write("");}else{Response.Write(r("pa_adress"));}%>"  maxlength="200"><span id="pa_adress_tip"></span></td></tr>

<input type='hidden' name='mustname' value='姓名,发布日期,'><input type='hidden' name='mustfield' value='title,thedate,'><input type='hidden' name='musttype' value='text,text,'>
<script  type='text/javascript'>
function onlinebm_zdycheck(){
return true;
}
</script>
<%End();%>







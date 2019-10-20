var Show_Style=1;
var Image_16=new Array();
var Pics="/e/upload/s1/article/image/2015/03/t_28230100.jpg|/e/upload/s1/article/image/2015/03/t_28230114.jpg";
var Links="/index.aspx?lanmuid=97&sublanmuid=817&id=529|/index.aspx?lanmuid=97&sublanmuid=817&id=528";
var Titles="知识产权法院共建协议签字仪...|学院召开2014年全院工作总结...";
var Alts="知识产权法院共建协议签字仪式成功举办|学院召开2014年全院工作总结大会";
var Apic16=Pics.split('|');
var ALink16=Links.split('|');
var ATitle16=Titles.split('|');
var AAlts16=Alts.split('|');
var Show_Text=1;
for(i=0;i<Apic16.length;i++)
  {
   Image_16.src = Apic16[i]; 
  }



  var FHTML='<div id="js_slide_focus_16" class="slide_focus focus_style1" style="height:140px"><a class="prev"></a><a class="next"></a>';
  FHTML+='<ul class="inner">';
  for(var i=0;i<Apic16.length;i++)
   {
     if(ALink16.length<(i+1) || ALink16[i]=="")
      {
       ALink16[i]="javascript:void(0)";
      }
     if(AAlts16.length<(i+1))
      {
       AAlts16[i]="";
      }
     if(ATitle16.length<(i+1))
      {
       ATitle16[i]="";
      }
    FHTML+='<li><a href="'+ALink16[i]+'" target="_self" title="'+AAlts16[i]+'"><img src="'+Apic16[i]+'">';
    FHTML+='<em>'+ATitle16[i]+'</em>';
    FHTML+='</a></li>';
   }
 FHTML+='</ul>';
 FHTML+='</div>';
 document.write(FHTML);
$(function(){Slide_Focus("js_slide_focus_16",0,5,204,140,false);});
var Show_Style=1;
var Image_17=new Array();
var Pics="/e/upload/s1/article/image/2015/03/t_28230100.jpg|/e/upload/s1/article/image/2015/03/t_28230114.jpg";
var Links="/index.aspx?lanmuid=97&sublanmuid=817&id=529|/index.aspx?lanmuid=97&sublanmuid=817&id=528";
var Titles="知识产权法院共建协议签字仪...|学院召开2014年全院工作总结...";
var Alts="知识产权法院共建协议签字仪式成功举办|学院召开2014年全院工作总结大会";
var Apic17=Pics.split('|');
var ALink17=Links.split('|');
var ATitle17=Titles.split('|');
var AAlts17=Alts.split('|');
var Show_Text=1;
for(i=0;i<Apic17.length;i++)
  {
   Image_17.src = Apic17[i]; 
  }



  var FHTML='<div id="js_slide_focus_17" class="slide_focus focus_style1" style="height:200px"><a class="prev"></a><a class="next"></a>';
  FHTML+='<ul class="inner">';
  for(var i=0;i<Apic17.length;i++)
   {
     if(ALink17.length<(i+1) || ALink17[i]=="")
      {
       ALink17[i]="javascript:void(0)";
      }
     if(AAlts17.length<(i+1))
      {
       AAlts17[i]="";
      }
     if(ATitle17.length<(i+1))
      {
       ATitle17[i]="";
      }
    FHTML+='<li><a href="'+ALink17[i]+'" target="_self" title="'+AAlts17[i]+'"><img src="'+Apic17[i]+'">';
    FHTML+='<em>'+ATitle17[i]+'</em>';
    FHTML+='</a></li>';
   }
 FHTML+='</ul>';
 FHTML+='</div>';
 document.write(FHTML);
$(function(){Slide_Focus("js_slide_focus_17",0,5,265,200,false);});
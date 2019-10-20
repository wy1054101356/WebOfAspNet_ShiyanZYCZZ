var Show_Style=2;
var Image_15=new Array();
var Pics="/e/images/banner/5_1.jpg|/e/images/banner/5_2.jpeg|/e/images/banner/5_3.png|/e/images/banner/5_4.jpg|/e/images/banner/5_5.jpg";
var Links="";
var Titles="武当药谷|张湾区西沟乡中药材示范基地|郧阳区鲍峡镇芍药基地|房县万亩中药材GAP示范基地|房县万亩中药材GAP示范基地";
var Alts="";
var Apic15=Pics.split('|');
var ALink15=Links.split('|');
var ATitle15=Titles.split('|');
var AAlts15=Alts.split('|');
var Show_Text=1;
for(i=0;i<Apic15.length;i++)
  {
   Image_15.src = Apic15[i]; 
  }



  var FHTML='<div id="js_slide_focus_15" class="slide_focus focus_style2" style="height:314px"><a class="prev"></a><a class="next"></a>';
  FHTML+='<ul class="inner">';
  for(var i=0;i<Apic15.length;i++)
   {
     if(ALink15.length<(i+1) || ALink15[i]=="")
      {
       ALink15[i]="javascript:void(0)";
      }
     if(AAlts15.length<(i+1))
      {
       AAlts15[i]="";
      }
     if(ATitle15.length<(i+1))
      {
       ATitle15[i]="";
      }
    FHTML+='<li><a href="'+ALink15[i]+'" target="_self" title="'+AAlts15[i]+'"><img src="'+Apic15[i]+'">';
    FHTML+='<em>'+ATitle15[i]+'</em>';
    FHTML+='</a></li>';
   }
 FHTML+='</ul>';
 FHTML+='</div>';
 document.write(FHTML);
$(function(){Slide_Focus("js_slide_focus_15",0,5,640,314,false);});
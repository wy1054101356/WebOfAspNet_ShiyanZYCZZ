var Show_Style=1;
var Image_18=new Array();
var Pics="/e/images/banner/sb1.jpg|/e/images/banner/sb2.jpg|/e/images/banner/sb3.jpg|/e/images/banner/sb4.jpg|/e/images/banner/sb5.jpg|/e/images/banner/sb6.jpg";
var Links="";
var Titles="";
var Alts="";
var Apic18=Pics.split('|');
var ALink18=Links.split('|');
var ATitle18=Titles.split('|');
var AAlts18=Alts.split('|');
var Show_Text=0;
for(i=0;i<Apic18.length;i++)
  {
   Image_18.src = Apic18[i]; 
  }



  var FHTML='<div id="js_slide_focus_18" class="slide_focus focus_style1" style="height:200px"><a class="prev"></a><a class="next"></a>';
  FHTML+='<ul class="inner">';
  for(var i=0;i<Apic18.length;i++)
   {
     if(ALink18.length<(i+1) || ALink18[i]=="")
      {
       ALink18[i]="javascript:void(0)";
      }
     if(AAlts18.length<(i+1))
      {
       AAlts18[i]="";
      }
     if(ATitle18.length<(i+1))
      {
       ATitle18[i]="";
      }
    FHTML+='<li><a href="'+ALink18[i]+'" target="_self" title="'+AAlts18[i]+'"><img src="'+Apic18[i]+'">';
    FHTML+='<em>'+ATitle18[i]+'</em>';
    FHTML+='</a></li>';
   }
 FHTML+='</ul>';
 FHTML+='</div>';
 document.write(FHTML);
$(function(){Slide_Focus("js_slide_focus_18",0,5,800,200,false);});
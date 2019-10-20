<% @ Page language="c#"%>
<% @ Import NameSpace="System.IO"%>
<% @ Import NameSpace="System.Drawing" %>
<% @ Import NameSpace="System.Drawing.Imaging"%>
<% @ Import NameSpace="System.Drawing.Text"%>
<script Language="c#" runat="server">
int Noise_Line,Noise_Point,Num,width;
string Texts;
public void Page_Load()
 {
   Texts="0123456789";  //字符串库
   Num=4;              //显示字符数
   Noise_Line=2;       //噪音线数
   Noise_Point=52;     //噪音点数
   width=52;          //生成宽度
   buildcode(12,width,20);
 }
 string  GetCode()
  {
    string codestr="";
    Random rd=new Random();
    char[] vcharArry=Texts.ToCharArray();
    int VLength=vcharArry.Length;
    for(int i=0;i<Num;i++)
    {
      codestr+=vcharArry[rd.Next(VLength)].ToString();
      if(i==0 || i==(Num-1)){codestr+="";}
    }
    Session["YZM"]=codestr.Replace(" ","");
    return codestr;         
  }

void buildcode(int intFontSize,int intWidth,int intHeight)
  {
    Random random = new Random(); 
    string strFontName="Tahoma";
    Color bgcolor=Color.Yellow;  //背景色
    SolidBrush bgbrush=new  SolidBrush(bgcolor); //建立一个背景笔刷；
    Color forecolor=Color.Black;   //前景色
    SolidBrush forebrush=new SolidBrush(forecolor); //建立一个前景笔刷；
    Font foreFont=new Font(strFontName,intFontSize,FontStyle.Bold); //定义字体
    Bitmap newBitmap=new Bitmap(intWidth,intHeight,PixelFormat.Format32bppArgb);//建立一个画布
    Graphics g=Graphics.FromImage(newBitmap);//封装Bitmap类
    Rectangle newRect=new Rectangle(0,0,intWidth,intHeight);//建立一个矩形区域
    //g.FillRectangle(bgbrush,newRect); //涂上背景颜色
    g.Clear(Color.White); //清空背景颜色,和FillRectangle一样效果
        
    Pen bgpen=new Pen(Color.Black,1);
    for (int i = 0; i <Noise_Line; i++) 
    {
        int x1 = random.Next(intWidth); 
        int x2 = random.Next(intWidth); 
        int y1 = random.Next(intHeight); 
        int y2 = random.Next(intHeight); 
        g.DrawLine(bgpen,x1,y1,x2,y2);   //画边框噪音线
    } 
    for (int i = 0; i <Noise_Point; i++) 
    { 
        int x = random.Next(intWidth); 
        int y = random.Next(intHeight); 
        newBitmap.SetPixel(x, y, Color.Black);  //画图片的前景噪音点 
           
    } 

    g.DrawString(GetCode(),foreFont,forebrush,1,1); //把字体写上去,最后两个是横纵坐标
    //Pen forpen=new Pen(Color.Black,1);//建一个钢笔对象
    //g.DrawRectangle(forpen,0,0,newBitmap.Width-1,newBitmap.Height-1);//绘制边框
    MemoryStream mstream=new MemoryStream();   
    newBitmap.Save(mstream,ImageFormat.Gif);//存入内存中
    g.Dispose();//释放System.Drawing.Graphics
    newBitmap.Dispose();//释放System.Drawing.Bitmap;

    //发送
    System.Web.HttpContext.Current.Response.ClearContent(); 
    System.Web.HttpContext.Current.Response.ContentType="image/GIF";
    System.Web.HttpContext.Current.Response.BinaryWrite(mstream.ToArray());
    System.Web.HttpContext.Current.Response.End();
  }
</script>

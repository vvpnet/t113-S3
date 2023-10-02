//NOTE:VCC=3.3V,在进入RGB模式前必须要用SPI对屏进行初始化
NOTE:VCI=3.3V,IOVCC=1.8-3.3V,
Display resolution:480*640
params->dsi.vertical_sync_active=2
params->dsi.vertical_backporch=12
params->dsi.vertical_frontporch=8
params->dsi.horizontal_sync_active=2
params->dsi.horizontal_backporch=12
params->dsi.horizontal_frontporch=8
params->RGB_CLOCK=(20)M
Frame Rate=60HZ
//*****************************************************************
void write_command (unsigned char y) // (uchar y,uchar x)
{
  unsigned char i;
csb=0;
sclb=0;
sdi=0;
sclb=1;
for(i=0;i<8;i++)
    {
     sclb=0;      
      if (y&0x80)
       {
          sdi=1;
        }
          else
         {
          sdi=0;
         }
       sclb=1;
      y=y<<1;
    }
csb=1;
}
//***************************************************************
void write_data(unsigned char w) // (uchar w, uchar v)
{
  unsigned char i;
csb=0;
sclb=0;
sdi=1;
sclb=1;
for(i=0;i<8;i++)
 {
  sclb=0;
     if (w&0x80)
     {
        sdi=1;
       }
          else
        {
         sdi=0;
        }
   sclb=1;
   w=w<<1;
    }
csb=1;
}
//***********************************************************************
void initi(void)
{
   res=1;
   delay(1);
   res=0;
   delay(10);
   res=1;
   delay(120);
//***************************************************************//LCD SETING
write_command(0xFF);   //PAGE3
write_data(0x77);
write_data(0x01);
write_data(0x00);
write_data(0x00);
write_data(0x13);

write_command(0xEF);
write_data(0x08);

write_command(0xFF);//PAGE01
write_data(0x77);
write_data(0x01);
write_data(0x00);
write_data(0x00);
write_data(0x10);

write_command(0xC0); //Display Line Setting   
write_data(0x4F);
write_data(0x00);

write_command(0xC1); //Porch Control  
write_data(0x10);
write_data(0x02);

write_command(0xC2);// Inversion set  
write_data(0x31); //31 2-DOT 37-Column
write_data(0x02);

write_command(0xCC);
write_data(0x10);

write_command(0xB0);//Positive Voltage Gamma Control 
write_data(0x00);
write_data(0x10);
write_data(0x17);
write_data(0x0D);
write_data(0x11);
write_data(0x06);
write_data(0x05);
write_data(0x08);
write_data(0x07);
write_data(0x1F);
write_data(0x04);
write_data(0x11);
write_data(0x0E);
write_data(0x29);
write_data(0x30);
write_data(0x1F);

write_command(0xB1); //Negative Voltage Gamma Control   
write_data(0x00);
write_data(0x0D);
write_data(0x14);
write_data(0x0E);
write_data(0x11);
write_data(0x06);
write_data(0x04);
write_data(0x08);
write_data(0x08);
write_data(0x20);
write_data(0x05);
write_data(0x13);
write_data(0x13);
write_data(0x26);
write_data(0x30);
write_data(0x1F);
 //*******power set********//
//PAGE1
write_command(0xFF);
write_data(0x77);
write_data(0x01);
write_data(0x00);
write_data(0x00);
write_data(0x11);

write_command(0xB0);//Vop Amplitude setting  
write_data(0x65); //Vop

write_command(0xB1);//VCOM amplitude setting  
write_data(0x7C);

write_command(0xB2); //VGH Voltage setting  
write_data(0x87);//VGH=+15V

write_command(0xB3);//TEST Command Setting   
write_data(0x80);

write_command(0xB5); //VGL Voltage setting   
write_data(0x49); //VGL-10V

write_command(0xB7);//Power Control 1  
write_data(0x85);

write_command(0xB8); //Power Control 2    
write_data(0x20);  //AVDD=6.6 & AVCL=-4.6 

write_command(0xC1);//Source pre_drive timing set1
write_data(0x78);

write_command(0xC2);//Source EQ2 Setting  
write_data(0x78);

write_command(0xD0); //Source EQ2 Setting 
write_data(0x88);

write_command(0xEE);
write_data(0x42);
  //*********GIP SET*************//
write_command(0xE0);
write_data(0x00);
write_data(0x00);
write_data(0x02);

write_command(0xE1);
write_data(0x04);
write_data(0xA0);
write_data(0x06);
write_data(0xA0);
write_data(0x05);
write_data(0xA0);
write_data(0x07);
write_data(0xA0);
write_data(0x00);
write_data(0x44);
write_data(0x44);

write_command(0xE2);
write_data(0x00);
write_data(0x00);
write_data(0x00);
write_data(0x00);
write_data(0x00);
write_data(0x00);
write_data(0x00);
write_data(0x00);
write_data(0x00);
write_data(0x00);
write_data(0x00);
write_data(0x00);

write_command(0xE3);
write_data(0x00);
write_data(0x00);
write_data(0x22);
write_data(0x22);

write_command(0xE4);
write_data(0x44);
write_data(0x44);

write_command(0xE5);
write_data(0x0C);
write_data(0x90);
write_data(0xA0);
write_data(0xA0);
write_data(0x0E);
write_data(0x92);
write_data(0xA0);
write_data(0xA0);
write_data(0x08);
write_data(0x8C);
write_data(0xA0);
write_data(0xA0);
write_data(0x0A);
write_data(0x8E);
write_data(0xA0);
write_data(0xA0);

write_command(0xE6);
write_data(0x00);
write_data(0x00);
write_data(0x22);
write_data(0x22);

write_command(0xE7);
write_data(0x44);
write_data(0x44);

write_command(0xE8);
write_data(0x0D);
write_data(0x91);
write_data(0xA0);
write_data(0xA0);
write_data(0x0F);
write_data(0x93);
write_data(0xA0);
write_data(0xA0);
write_data(0x09);
write_data(0x8D);
write_data(0xA0);
write_data(0xA0);
write_data(0x0B);
write_data(0x8F);
write_data(0xA0);
write_data(0xA0);

write_command(0xEB);
write_data(0x00);
write_data(0x00);
write_data(0xE4);
write_data(0xE4);
write_data(0x44);
write_data(0x00);
write_data(0x00);

write_command(0xED);
write_data(0xFF);
write_data(0xF5);
write_data(0x47);
write_data(0x6F);//
write_data(0x0B);
write_data(0xA1);
write_data(0xAB);
write_data(0xFF);
write_data(0xFF);
write_data(0xBA);
write_data(0x1A);
write_data(0xB0);
write_data(0xF6);//
write_data(0x74);
write_data(0x5F);
write_data(0xFF);

write_command(0xEF);
write_data(0x08);
write_data(0x08);
write_data(0x08);
write_data(0x40);
write_data(0x3F);
write_data(0x64);

write_command(0xFF);
write_data(0x77);
write_data(0x01);
write_data(0x00);
write_data(0x00);
write_data(0x00);

write_command(0xFF);
write_data(0x77);
write_data(0x01);
write_data(0x00);
write_data(0x00);
write_data(0x13);

write_command(0xE6);
write_data(0x7C);

write_command(0xE8);
write_data(0x00);
write_data(0x0E);

write_command(0xFF);
write_data(0x77);
write_data(0x01);
write_data(0x00);
write_data(0x00);
write_data(0x00);

write_command(0x11);
 delay(120);

write_command(0xFF);
write_data(0x77);
write_data(0x01);
write_data(0x00);
write_data(0x00);
write_data(0x13);

write_command(0xE8);
write_data(0x00);
write_data(0x0C);
 delay(10);
write_command(0xE8);
write_data(0x00);
write_data(0x00);

write_command(0xFF); //PAGE 0
write_data(0x77);
write_data(0x01);
write_data(0x00);
write_data(0x00);
write_data(0x00);
   																	
write_command(0x11);     
delay(120); 

write_command(0xE8);     
write_data(0x00);   
write_data(0x00);   

write_command(0xFF);     
write_data(0x77);   
write_data(0x01);   
write_data(0x00);   
write_data(0x00);   
write_data(0x00);   

write_command(0x3A); 
write_data(0x70); //24 bit

write_command(0x29);     
 delay(25);  
  
  }

//*********************************************************
void ExitSleep (void)

 {
    write_command(0x11);
    delay(120);
    write_command(0x29);

   }
   *********************************************************
void ExitSleep (void)

 {
    write_command(0x11);
    delay(120);
    write_command(0x29);

   }
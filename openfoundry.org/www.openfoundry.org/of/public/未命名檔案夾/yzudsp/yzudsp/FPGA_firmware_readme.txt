因為版權問題，我們以此檔案說明如何修改 FPGA firewarm。

需修改部份為 ISR.C, hello_led.c

此版本主要使用軟體 dct 來計算，請在 ISR.C 中加入 dct(), DCT(), 並取代 Isr_Ep01Done()

unsigned int data_counter;
int matrix[8][8];
unsigned char result[8][8][4];
void dct( int input[8][8],double output[8][8])
{
    int i, j, x, y;
    double pi = atan( 1.0 ) * 4.0, ci[ 8 ], cj[ 8 ], temp1=0, temp2=0, ti, tj;
    for ( i = 0;i < 8;i++ ) 
    {
        if ( i == 0 )
        {
            ci[ i ] = 1 / sqrt( 2 );
            cj[ i ] = ci[ i ];
        }
        else
        {
            ci[ i ] = 1;
            cj[ i ] = ci[ i ];
        }
    }
    for ( i = 0;i < 8;i++ ) 
    {
        for ( j = 0;j < 8;j++ ) 
        {
            for ( x = 0;x < 8;x++ ) 
            {
                for ( y = 0;y < 8;y++ ) {
                    ti = cos( ( ( 2 * x + 1 ) * i * pi ) / ( 2 * 8 ) );
                    tj = cos( ( ( 2 * y + 1 ) * j * pi ) / ( 2 * 8 ) );
                    temp1 += ( input[ x ][ y ]/*-128*/) * ti * tj;
                }
                temp2 += temp1;
                temp1 = 0.0;
                ti = 0.0;
                tj = 0.0;
            }
            output[ i ][ j ] =( 1.0 / sqrt(  2 * 8 ) )  * ci[ i ] * cj[ j ] * temp2;
            temp2 = 0.0;
        }
    }
    return;
}



void DCT()
{
    int i,j;
    double tmp[8][8];
    
    for (i=0;i<8;i++)
    {
        for(j=0;j<8;j++)
        {
            printf("%d\t",matrix[i][j]);                
        }
        printf("\n\n");
    }
    dct(matrix,tmp);
    for (i=0;i<8;i++)
    {
        for(j=0;j<8;j++)
        {
            printf("%3.3f\t",tmp[i][j]);                
        }
        printf("\n\n");
    }
    
    int transform[8][8];
    
    for(i=0;i<8;i++)
    {
        for(j=0;j<8;j++)
        {
            //捨去小數點
            transform[i][j]=(int)tmp[i][j];
            printf("%08x ",transform[i][j]);            
        }
        printf("\n\n");
    }
    
    for(i=0;i<8;i++)
    {
        for(j=0;j<8;j++)
        {
            result[i][j][0]=transform[i][j]&0xff;
            result[i][j][1]=(transform[i][j]&0xff00)>>8;
            result[i][j][2]=(transform[i][j]&0xff0000)>>16;
            result[i][j][3]=(transform[i][j]&0xff000000)>>24;                        
            //printf("%02x%02x%02x%02x ",(unsigned char)result[i][j][3],(unsigned char)result[i][j][2],(unsigned char)result[i][j][1],(unsigned char)result[i][j][0]);
        }
        //printf("\n\n");
    }    
    
    
    
    DCT_done=1;
    DCT_enable=0;
    
    
}



void Isr_Ep01Done(void)
{
	unsigned char bbuf[8];
    int i,j;
    UCHAR      ep_last; 
    
    
    ep_last = (UCHAR)Hal4D13_GetEndpointStatusWInteruptClear(EPINDEX4EP01); // Clear interrupt flag
   
     
    Hal4D13_ReadBulkEndpoint(EPINDEX4EP01,&bbuf, 8);
    //printf("Received From Endpoint 1\n");

    if(DCT_enable==0 && DCT_done==0)
    {
    
        for (i=0;i<8;i++)
        {
            matrix[data_counter][i]=bbuf[i];
            //printf("%d\t",matrix[data_counter][i]);
        }
        //printf("\n\n");
        
        //printf("data_counter = %d\n",data_counter);
        
        data_counter=(data_counter+1)%8;
        
        if(data_counter==0)
        {
            printf("Starting DCT\n");
            DCT_enable=1;
        }
        
    }
    else if(DCT_enable==0 && DCT_done==1)
    {
        int i;
        printf("send result to PC\n");
             

        unsigned char send_buff[4];
        //printf("send %dth pkg\n",i+1);
        
        int p,q,r;
        for(p=0;p<8;p++)
        {
            for(q=0;q<8;q++)
            {
                for(r=0;r<4;r++)
                {
                    send_buff[r]=result[p][q][r];
                }
                //printf("%02x%02x%02x%02x\n",(unsigned char)send_buff[3],(unsigned char)send_buff[2],(unsigned char)send_buff[1],(unsigned char)send_buff[0]);
                usleep(10000);   //必須要有一個夠大的 delay 才能符合 USB timing (除非使用更高階的 USB 傳輸模式)       
                Hal4D13_WriteEndpoint(EPINDEX4EP02,send_buff,4);
            }
        }
            

        DCT_done=0;
    }
    else //DCT_enable==1
    {
        printf("DCT is stilling running\n");
    }
    
    Hal4D13_GetEndpointStatusWInteruptClear(EPINDEX4EP01);    
}


此外請在 hello_led.c 檔案最後的 while(1) 中加入

      if(DCT_enable==1)
      {
        DCT();
      }
	  

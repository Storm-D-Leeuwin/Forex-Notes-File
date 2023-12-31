//+------------------------------------------------------------------+
//|                                              No Nonsense ATR.mq4 |
//|                   rpsreal Copyright 2019, rpsreal Software Corp. |
//|                                                                  |
//+------------------------------------------------------------------+
#property strict
#property copyright "rpsreal"
#property description "No Nonsense ATR"

//---- input parameters
input int        ATR_TP_PERIOD        = 14;         // TP ATR PERIOD       
input double     ATR_TP_MULTIPLIER    = 1;          // TP MULTIPLIER            
input int        ATR_SL_PERIOD        = 14;         // SL ATR PERIOD  
input double     ATR_SL_MULTIPLIER    = 1.5;        // SL MULTIPLIER 
input char       ATR_SHIFT            = 0;          // ATR SHIFT
input int        ATR_digits           = 0;          // Nº OF DIGITS TO THE RIGHT OF a DECIMAL POINT
input char       text_corner          = 0;          // TEXT CORNER 0-UL 1-UR 2-LL 3-LR
input int        text_size            = 12;         // FONT SIZE
input color      text_color           = Gold;       // TEXT COLOR

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
int OnInit(){
   ObjectCreate("ATR_text", OBJ_LABEL, 0, 0, 0);
   ObjectSetText("ATR_text"," No Nonsense ATR",text_size, "Verdana", text_color);
   ObjectSet("ATR_text", OBJPROP_CORNER, text_corner);
   ObjectSet("ATR_text", OBJPROP_XDISTANCE, 0);
   ObjectSet("ATR_text", OBJPROP_YDISTANCE, 20);
   return(INIT_SUCCEEDED);
}
 
//+------------------------------------------------------------------+
//| Custor indicator deinitialization function                       |
//+------------------------------------------------------------------+
int deinit(){
   ObjectDelete("ATR_text"); // apagar objeto
   return(0);
}
  
  
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
  {
//---
    double SL, TP;
    string text;
    
    
    TP=((iATR(NULL,0,ATR_TP_PERIOD,ATR_SHIFT)/Point)/10)*ATR_TP_MULTIPLIER;
    SL=((iATR(NULL,0,ATR_SL_PERIOD,ATR_SHIFT)/Point)/10)*ATR_SL_MULTIPLIER;
    
    text=StringConcatenate("\n SL = ", NormalizeDouble(SL,ATR_digits), " pips     TP = ",  NormalizeDouble(TP,ATR_digits), " pips");  
    ObjectSetText("ATR_text",text,text_size, "Verdana", text_color);
   
//--- return value of prev_calculated for next call
   return(rates_total);
  }
//+------------------------------------------------------------------+

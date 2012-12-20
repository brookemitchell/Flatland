void xBeeEvent(XBeeReader xbee) {
  XBeeDataFrame data = xbee.getXBeeReading();

  if (data.getApiID() == xbee.SERIES1_RX16PACKET) {
    int addr = data.getAddress16();
    int[] bytes = data.getBytes();
    
  //  print(millis() + "\t[" + addr + "]:");
    
    /*
 //   for (int n = 0; n < bytes.length; n++) {
   //   print(" " + bytes[n]);
   if (addr == 1){
     
    x = bytes[0];
    y = bytes[1];
    z = bytes[2];
 //    println(x);
    
   }
   */
        
      if (addr == 2){
     ir1 = bytes[0];
     ir2 = bytes[1];
     }
       
     /*
      if (addr == 3){
     flex1 = int(map((bytes[0]), 217, 93, 0, 255));
     flex2 = int(map((bytes[1]), 177, 32, 0, 255));
     }
      println(ir2);
   // }
    */
   // println();
    
    // echo data back to the xbee.
//    xbee.sendDataString16(addr, bytes);
  } 
}

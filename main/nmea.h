#ifndef _NMEA_TASK_H
#define _NMEA_TASK_H

#define SENT_BUF_SZ 30
#define UDP_PORT    9000
#define MULTICAST_TTL 10

void vTaskNMEASend( void * xQueue  );

#endif


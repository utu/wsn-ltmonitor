
#include <stdio.h>
#include "contiki.h"
#include "dev/i2cmaster.h"
#include "dev/tmp102.h"
#include "dev/light-ziglet.h"


#if 1
#define PRINTF(...) printf(__VA_ARGS__)
#else
#define PRINTF(...)
#endif


#if 0
#define PRINTFDEBUG(...) printf(__VA_ARGS__)
#else
#define PRINTFDEBUG(...)
#endif


#define TMP102_READ_INTERVAL (CLOCK_SECOND/2)
#define SENSOR_READ_INTERVAL (CLOCK_SECOND)

PROCESS(tempLight_process, "Test Temperature and Light process");
AUTOSTART_PROCESSES(&tempLight_process);
/*---------------------------------------------------------------------------*/
static struct etimer et;
static struct etimer et2;

PROCESS_THREAD(tempLight_process, ev, data)
{
  PROCESS_BEGIN();

  int16_t tempint;
  uint16_t tempfrac;
  int16_t raw;
  uint16_t absraw;
  int16_t sign;
  char minus = ' ';
  uint16_t light;

  tmp102_init();
  light_ziglet_init();

  while(1) {
    etimer_set(&et, TMP102_READ_INTERVAL);
    PROCESS_WAIT_EVENT_UNTIL(etimer_expired(&et));
    etimer_set(&et2, SENSOR_READ_INTERVAL);
    PROCESS_WAIT_EVENT_UNTIL(etimer_expired(&et2));

    sign = 1;

    PRINTFDEBUG("Reading Temp...\n");
    raw = tmp102_read_temp_raw();
    absraw = raw;
    if(raw < 0) {// Perform 2C's if sensor returned negative data
      absraw = (raw ^ 0xFFFF) + 1;
      sign = -1;
    }
    tempint = (absraw >> 8) * sign;
    tempfrac = ((absraw >> 4) % 16) * 625;// Info in 1/10000 of degree
    minus = ((tempint == 0) & (sign == -1)) ? '-' : ' ';
    PRINTF("Temp = %c%d.%04d\n", minus, tempint, tempfrac);

    light = light_ziglet_read();
    PRINTF("Light = %u\n", light);
  }
  PROCESS_END();
}

= Software
== BLE
*!* Das Auto ist als @ble Client konfiguriert.

== Motorregelung 
Die Drehzahl wird über den Drehzahlsensor eingelesen. Der Sensor geht einmal in der Umdrehung auf low. Auf den Input-pin ist ein Interrupt gesetzt, die Zeit zwischen den Interrupts wird gemessen. 

```c
__attribute__((interrupt("WCH-Interrupt-fast")))
void GPIOA_IRQHandler(void) {
    if (GPIOA_ReadITFlagBit(GPIO_Pin_4)) {
        uint64_t current_tick = SysTick->CNT;
        period_ticks = current_tick - last_tick;
        last_tick = current_tick;
        flag = 1;
        GPIOA_ClearITFlagBit(GPIO_Pin_4);
    }
}
```
Für den PI-Regler ist ein periodischer Ablauf nötig. Die Motorleistung wird alle 10 Millisekunden berechnet. 
```c
uint32_t interval = GetSysClock() / 100; // 10ms Ticks
uint32_t time_old = 0;

while(1)
{    uint32_t now = (uint32_t)SysTick->CNT;
        if (flag) 
        {
            flag = 0;
            //get millisecond values
            raw_ms = (uint32_t)(period_ticks / (GetSysClock() / 1000)); 
            update_filter = 1;
        } 
        //determine standstill
        else if ((t_now - last_tick) > (GetSysClock() / 4)) 
        {
            raw_ms = 1024;
            update_filter = 1;
        }

        int x = soll - per_norm;
        i_sum += (float)x * 0.1f; p
        if(i_sum > 1500) i_sum = 1500;
        if(i_sum < 0)    i_sum = 0;

        int p = (int)((0.5f * (float)x) + (0.12f * i_sum));
        if(p < 0) p = 0; if(p > 255) p = 255;
    }
}
```

== NFC



== Pairing mode

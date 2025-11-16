
# Lab 9: Ultrasonic range controlled stepper motor.

![VideoToGif_GIF (2)](https://github.com/user-attachments/assets/8c5b8f18-8274-4f24-ac27-20f794650d1f)


## Original Block Diagram

I thought this project would need slightly less modules than it actually needed.  Below is what I thought it would look like:

![IMG_0344](https://github.com/user-attachments/assets/26e0e200-b331-40e3-b42e-a1375bf1ee63)

Original functional block diagram

![IMG_0343](https://github.com/user-attachments/assets/bcd65f0e-47a1-4232-9296-5f9b347f8dab)

High level setep: (This is not difficult to predict).  I needed a voltage divider to drop the return echo of the Ultrasonic rage sensor 
from 5V to ~3V, using a 1K ohm / 1.5k ohm setp.

Original functional diagram.

<img width="1080" height="587" alt="block_diag_final" src="https://github.com/user-attachments/assets/1b3e3ab9-fcf8-43b9-af4b-47d276afabbf" />

Final block diagram

## Pulser

<img width="656" height="298" alt="image" src="https://github.com/user-attachments/assets/04bf75b6-8b34-4eb7-82a5-f6b0e9c07ec7" />

The HC-SR04 Ultrasonic sensing module uses 40 KHz ultrasound pulses to gather range data. The sensor requires a 10 us pulse to initiate its own range pulse. It then
begins a return echo pulse, where the pulse width is proportional to the time of flight of the echo.  A simple math calculation (using cm as range) is 34,300 cm/s in 
~ room temperature conditions.  

THis pulse module emits a 10us pulse every 100 ms. 

In hindsight, I noticed the HC-SR04 newer versions are 3.3V compliant, unlike older generations. If that were the case, I would have not needed the voltage divider.

## Ranging Finite State Machine
This module uses a finite state machine to characterize the return pulse. It determines whether or not there is a pulse, or the line is idle, and detects rising and falling edges. Lastly,
it times out if there hasn't been a pulse.

![VideoToGif_GIF](https://github.com/user-attachments/assets/16bce38c-f17a-4d30-8f42-31b426a0575f)




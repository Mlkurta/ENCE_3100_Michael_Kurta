
# Lab 9: Ultrasonic range controlled stepper motor.

![VideoToGif_GIF (2)](https://github.com/user-attachments/assets/8c5b8f18-8274-4f24-ac27-20f794650d1f)

This device uses an ultrasonic sensor for real-time short-range distance measurement. The measurement calculates the range by the time of flight for the sound pressure
waves to return. When the distance is calculated, the required direction and velocity of the turn is calculated. If the range is between 10-54 cm, the motor spins clockwise
at a speed proportional to the distance from 55.  At a range of 55 cm, the motor stops completely. Lastly, the motor spins counter-clockwise proportional to the distance
between 55 and 100. But there is no more increase in speed at ranges beyond 100 cm.


## Original Block Diagram

I thought this project would need slightly less modules than it actually needed.  Below is what I thought it would look like:

<img width="500" height="600" alt="img_0344" src="https://github.com/user-attachments/assets/17a3a9d0-9886-45f4-a716-54b348c93f17" />

Original functional block diagram

<img width="500" height="600" alt="img_0343" src="https://github.com/user-attachments/assets/7ed2f0b2-7093-4ea3-adda-be7bb14705a9" />

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

![VideoToGif_GIF (3)](https://github.com/user-attachments/assets/e1df7f29-4197-40c5-9995-1016c869d3e1)

Debugging the module

This module does a range conversion and passes an 11 bit value in centimeters. Most of this 11 bits will not be used, as most returns are within the maximum pulse width 18 ms (36 ms if no return
pulse is detected)

## Moving average filter

Ultrasound detection abilities decay repidly with distance, and especially so against non-planar targets. The HC-SR04 has internal amplification and filtering, and yet the pulse data, updating at 10 Hz 
is still jumpy. This is where the moving average filter helps.

<img width="540" height="95" alt="image" src="https://github.com/user-attachments/assets/08830d1a-3ba2-4b67-814b-605dec88202b" />

The one implemenmted here is a 5 point moving average filter. I didn't experiment with longer versions, though longer filters may provide better performance. What I noticed is the "jitteryness" was 
improved, especially noticable when the distance doesn't vary much in a short period.

This module outputs a range_valid signal and the 11 bit range value, just a smoothed out one.

## Speed Converter

The speed converter takes the 11 bit range value (and data_valid) and converts it to an signed 8-bit value. This module could have potentially been combined with the next module, as both are relatively simple, 
but it is simpler to think about.

## Speed to Steps

What can a module do alone with a 8-bit signed value for motor control?  You can control a motor, but there must be some element that creates a varying time value. This module does that by converting the
signed value into a time-based pulse, and also a '1' or '0' value which determines direction.

## Full-Step 28-BYJ-48

This module is like a driver module for a specific stepper motor. It's a common stepper motor found in many Arduino kits. I looked online for a good step sequence, and I opted for a full-step sequence. I had identified a problem when first testing out the motor: that the speed and direction seemed to be random. 

After some frustration with debugging I'd began to wonder if the motor timing sequence was correct. I dug a little bit deeper and found a different suggestion for the sequence and tried it. It turns out that this was the fix.


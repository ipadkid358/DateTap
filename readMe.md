## DateTap

Double tap on status bar time to toggle between date and time views. Currently supports iOS 10 - 11, but not iPhone X. If you'd like to attempt to compile for the iPhone X, see the Shared header. 

To provide iOS 7 support, and higher, you just need to get that time view, to add the gesture recognizer to. For iPhone X support, you have to figure out why taps are not being delivered to the target view, and a new method for updating the status bar time

I have a `sim.sh` script provided to help test in the simulator. This was my first time using the simulator for a tweak, as I do not have a jailbroken iPhone X availible

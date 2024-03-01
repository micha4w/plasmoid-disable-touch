# ch.micha4w.disable-touch

Small Plasmoid that lets you disable the Touschreen, but keeps leaves the Stylus InputDevice untouched.
So you write without having to worry about touch events happening due to your Hand moving on the Display.

## Installing
```sh
git pull https://github.com/micha4w/plasmoid-disable-touch ~/.local/share/plasma/plasmoids/ch.micha4w.disable-touch
```

You need to figure out the InputEvent id of your TouchScreen by running
```sh
cat /proc/bus/input/devices
```
and then taking the event{id} of your touchscreen and pasting it into `~/.local/share/plasma/plasmoids/ch.micha4w.disable-touch/contents/ui/main.qml:34:76`

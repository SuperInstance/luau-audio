# luau-audio

> Musical math for Roblox games. MIDI, scales, intervals, frequency math — everything you need to make games that teach music theory.

## Quick Start

```lua
local AudioMath = require(path.to["luau-audio"])

-- Generate a C major scale
local scale = AudioMath.majorScale(60) -- {60, 62, 64, 67, 69, 71}
for _, note in ipairs(scale) do
    print(AudioMath.midiToName(note), string.format("%.1f Hz", AudioMath.midiToFreq(note)))
end

-- Transpose a melody
local melody = {60, 64, 67, 72}
local upAFifth = AudioMath.transpose(melody, 7)

-- Velocity to dB for volume control
local dB = AudioMath.velocityToDb(96)
```

## API

| Function | Description |
|----------|-------------|
| `midiToFreq(midi)` | MIDI note → Hz |
| `freqToMidi(freq)` | Hz → MIDI note |
| `midiToName(midi)` | MIDI → "A4" |
| `semitonesBetween(a, b)` | Distance in semitones |
| `intervalName(semitones)` | "perfect 5th" etc |
| `majorScale(root)` | 7-note major scale |
| `minorScale(root)` | Natural minor |
| `pentatonicScale(root)` | 5-note pentatonic |
| `transpose(notes, semi)` | Transpose by semitones |
| `invert(notes, pivot)` | Invert around pivot |
| `velocityToDb(vel)` | Velocity (0-127) → dB |
| `dbToVelocity(db)` | dB → velocity (0-127) |

## License

MIT

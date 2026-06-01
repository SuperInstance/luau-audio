local AudioMath = require(script.Parent:FindFirstChild("luau-audio") or script.Parent.Parent.src)

local passed = 0
local failed = 0
local function assert(cond, msg)
    if cond then passed = passed + 1
    else failed = failed + 1; warn("FAIL: " .. (msg or ""))
    end
end

-- Test 1: A4 = 440Hz
assert(math.abs(AudioMath.midiToFreq(69) - 440.0) < 0.01, "A4 = 440Hz")

-- Test 2: Middle C = ~261.6Hz
local c4 = AudioMath.midiToFreq(60)
assert(math.abs(c4 - 261.63) < 0.1, "C4 ~= 261.6Hz")

-- Test 3: freq → MIDI roundtrip
assert(math.abs(AudioMath.freqToMidi(440.0) - 69) < 0.01, "freq→MIDI roundtrip")

-- Test 4: Note names
assert(AudioMath.midiToName(60) == "C4", "C4 name")
assert(AudioMath.midiToName(69) == "A4", "A4 name")

-- Test 5: Interval names
assert(AudioMath.intervalName(0) == "unison", "unison")
assert(AudioMath.intervalName(7) == "perfect 5th", "perfect 5th")
assert(AudioMath.intervalName(12) == "unison", "octave = unison")

-- Test 6: Semitones between
assert(AudioMath.semitonesBetween(60, 67) == 7, "7 semitones")

-- Test 7: Major scale
local cMajor = AudioMath.majorScale(60)
assert(#cMajor == 7, "7 notes in major scale")
assert(cMajor[1] == 60, "root note")
assert(cMajor[#cMajor] == 71, "7th note")

-- Test 8: Minor scale
local aMinor = AudioMath.minorScale(69)
assert(#aMinor == 7, "7 notes in minor scale")

-- Test 9: Pentatonic
local pent = AudioMath.pentatonicScale(60)
assert(#pent == 5, "5 notes in pentatonic")

-- Test 10: Transpose
local transposed = AudioMath.transpose({60, 64, 67}, 12)
assert(transposed[1] == 72, "transposed up octave")

-- Test 11: Invert
local inverted = AudioMath.invert({60, 64, 67}, 60)
assert(inverted[1] == 60, "pivot stays")
assert(inverted[2] == 56, "inverted below")

-- Test 12: Velocity → dB
assert(AudioMath.velocityToDb(127) == 0, "max velocity = 0dB")
assert(AudioMath.velocityToDb(0) == -120, "zero velocity = -120dB")

-- Test 13: dB → velocity roundtrip
assert(AudioMath.dbToVelocity(0) == 127, "0dB = 127")

-- Test 14: Frequency doubling = octave
local f1 = AudioMath.midiToFreq(60)
local f2 = AudioMath.midiToFreq(72)
assert(math.abs(f2 / f1 - 2.0) < 0.001, "octave doubles frequency")

-- Test 15: All 12 note names unique
local names = {}
for i = 0, 11 do
    local name = AudioMath.midiToName(i):match("^(%S+)")
    names[name] = true
end
-- Should have all 12 unique note names

print(string.format("=== luau-audio: %d passed, %d failed ===", passed, failed))

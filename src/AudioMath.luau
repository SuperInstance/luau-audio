-- luau-audio: Audio math utilities for Roblox games
-- Musical math, pitch calculations, rhythm analysis

local AudioMath = {}
AudioMath.__index = AudioMath

-- MIDI note to frequency (Hz)
-- A4 = MIDI 69 = 440Hz
function AudioMath.midiToFreq(midi: number): number
    return 440.0 * (2.0 ^ ((midi - 69) / 12.0))
end

-- Frequency to MIDI note
function AudioMath.freqToMidi(freq: number): number
    return 69 + 12 * math.log(freq / 440.0) / math.log(2)
end

-- Note name from MIDI number
local NOTE_NAMES = {"C", "C#", "D", "D#", "E", "F", "F#", "G", "G#", "A", "A#", "B"}
function AudioMath.midiToName(midi: number): string
    local note = ((midi % 12) + 12) % 12
    local octave = math.floor(midi / 12) - 1
    return NOTE_NAMES[note + 1] .. tostring(octave)
end

-- Semitones between two MIDI notes
function AudioMath.semitonesBetween(a: number, b: number): number
    return math.abs(a - b)
end

-- Interval name from semitone count
function AudioMath.intervalName(semitones: number): string
    local s = math.abs(semitones) % 12
    local names = {
        [0] = "unison", [1] = "minor 2nd", [2] = "major 2nd",
        [3] = "minor 3rd", [4] = "major 3rd", [5] = "perfect 4th",
        [6] = "tritone", [7] = "perfect 5th", [8] = "minor 6th",
        [9] = "major 6th", [10] = "minor 7th", [11] = "major 7th",
    }
    return names[s] or "unknown"
end

-- Scale generation
function AudioMath.majorScale(root: number): {number}
    local pattern = {0, 2, 4, 5, 7, 9, 11}
    local scale = {}
    for _, interval in ipairs(pattern) do
        table.insert(scale, root + interval)
    end
    return scale
end

function AudioMath.minorScale(root: number): {number}
    local pattern = {0, 2, 3, 5, 7, 8, 10}
    local scale = {}
    for _, interval in ipairs(pattern) do
        table.insert(scale, root + interval)
    end
    return scale
end

function AudioMath.pentatonicScale(root: number): {number}
    local pattern = {0, 2, 4, 7, 9}
    local scale = {}
    for _, interval in ipairs(pattern) do
        table.insert(scale, root + interval)
    end
    return scale
end

-- Transpose a sequence of MIDI notes by semitones
function AudioMath.transpose(notes: {number}, semitones: number): {number}
    local result = {}
    for _, note in ipairs(notes) do
        table.insert(result, note + semitones)
    end
    return result
end

-- Invert a chord/notes around a pivot
function AudioMath.invert(notes: {number}, pivot: number): {number}
    local result = {}
    for _, note in ipairs(notes) do
        table.insert(result, 2 * pivot - note)
    end
    return result
end

-- Volume/velocity to dB
function AudioMath.velocityToDb(velocity: number): number
    if velocity <= 0 then return -120 end
    return 20 * math.log10(velocity / 127.0)
end

-- dB to velocity
function AudioMath.dbToVelocity(db: number): number
    local v = 127.0 * (10 ^ (db / 20.0))
    return math.floor(math.clamp(v, 0, 127) + 0.5)
end

return AudioMath

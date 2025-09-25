Log ← ÷∩°ₑ

Semitone ← ⁿⁿ¯1 12 2
Tone     ← ⁿ2 Semitone

# Pad ← ⬚0↯△ Track # Pad with blank space until end of track
# Rep ← ↯△ Track   # Repeat until end of track

# Waveforms, periodic funs [0,1) -> [-1,1]
Sin   ← ∿×τ
Cos   ← ∿×τ+÷4 τ
Saw   ← -1×2
Squ   ← -1×2⁅
Squaw ← +⊃(Squ|Saw)
Tri   ← ×⊃(ⁿ⊙¯1◿2⌊|-1◿2×2)×2

Env ← ⊂₃⊓(÷⟜⇡|⬚1↯:[]¤|-:1÷⟜⇡) ∩₃(⁅×&asr)
EnvPP ← ⊂₅ ⊓(
  ⬚0↯:[]¤
| ÷⟜⇡
| ⬚1↯:[]¤
| -:1÷⟜⇡
| ⬚0↯:[]¤
) ∩₅(⁅×&asr) # Pre, Attack, Sustain, Decay, Post
DefEnv     ← EnvPP 0.05 0.2 0.5 0.2 0.05
DefPercEnv ← EnvPP 0 0.05 0.05 0.1 0.85
DefLongEnv ← EnvPP 0.2 0.2 1.2 0.2 0.2
# Envelope; audio -> enveloped audio
ApplyEnv ← ×↯◡⋅△

AM ← ApplyEnv

# Seq  ← |2 ⊞⊙◌:÷⟜⇡(⁅×&asr) # Time per note and a list of notes
Seq ← ◿1×÷&asr⇡⧻.▽×&asr

# Ex. [[0 1] [0 NaN]] [0]
# Rule, initial position; NaN as placeholder
LSys ← ▽(≠NaN).♭⊡≡¤:

# An mth division of an nth interval
ED  ← ⁿⁿ¯1 :
EDO ← ED 2
# Times to repeat, interval to repeat, interval to quotient by
# Ex: Scale 6 ⁿ7Semitone 2 is Lydian
Scale ← ⧈÷ ⍆⊂⊸ⁿ:⊙(◿1)⟜Log :ⁿ⇡ +1
# p; q -> Christoffel word q/p
Christoffel ← /◇⊂⧈(□⊂ 0⍥1/-)2⌊×⇡+1⟜÷:
# L-systems > Sturmer words where possible (easier computing len)
# n; theta -> Sturmer word of theta with n-1 x's or something
# Broken idk why
Sturmer   ← /◇⊂⧈(□⊂ 0⍥1/-)2⌊×⇡
Chromatic ← ⨬(∘|0◌)+⊃(=∞|=NaN). ×ⁿ⊙Semitone :

# Diatonic tetrachord intervals
DTInt ← [Tone Tone Semitone]
# Major intervals
MajorInt ← ⊂₃ DTInt Tone DTInt
# 0-indexed which note to start on
Mode ← ↻: MajorInt

# List of intervals in a scale to a function
# I forgor how this works :skull:
# ScaleDegree ← ⨬(∘|0◌)=∞. ⨬(/×↯¤:|/×↯:ⁿ¯1⇌)<0⊃(⋅∘|⊙∘)

# Scale, degree
Degree ← /×ⁿ⊙↯⊃(±|¤):

# List of intervals; base note -> list of notes
InitScale ← \×⊂:

# Intervals and chords

MinThird      ← ÷: 6 5
MajThird      ← ÷: 5 4
PerFourth     ← ÷: 4 3
PerFifth      ← ÷: 3 2
Octave        ← ÷: 2 1
MinSeventh    ← ÷: 16 9
MajTriadInt   ← [MajThird MinThird]
MinTriadInt   ← [MinThird MajThird]
DiatonicTriad ← [0 2 4]

# Complexity is from edge cases priveleging melody over beat
ToBeat ← ⬚0⊡≡¤×\+. ⊙(⊂ [0]) (↯¤×◡(⌈÷⊃(/+|⧻)⊙⧻))
# Priveleges beat
ToMelody ← ⊡≡¤×\+. ⊙(⊂ [0]) ⟜(↯△) :

# Mix a polyphonic sound array
Mix ← ÷⊃(⧻|/+)

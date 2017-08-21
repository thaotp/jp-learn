ffmpeg -i public/audio/Nameraka_Nihongo_Kaiwa_CD/04_Track_4.mp3 -ss 17 -to 21 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/17_21.mp3
ffmpeg -i public/audio/silence.mp3 -ss 17 -to 25 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/17_21.mp3 
ffmpeg -i public/audio/Nameraka_Nihongo_Kaiwa_CD/04_Track_4.mp3 -ss 21 -to 23.2 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/21_23.2.mp3
ffmpeg -i public/audio/silence.mp3 -ss 21 -to 25.4 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/21_23.2.mp3 
ffmpeg -i public/audio/Nameraka_Nihongo_Kaiwa_CD/04_Track_4.mp3 -ss 23.3 -to 28 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/23.3_28.mp3
ffmpeg -i public/audio/silence.mp3 -ss 23.3 -to 32.7 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/23.3_28.mp3 
ffmpeg -i public/audio/Nameraka_Nihongo_Kaiwa_CD/04_Track_4.mp3 -ss 28 -to 31.8 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/28_31.8.mp3
ffmpeg -i public/audio/silence.mp3 -ss 28 -to 35.6 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/28_31.8.mp3 
ffmpeg -i public/audio/Nameraka_Nihongo_Kaiwa_CD/04_Track_4.mp3 -ss 31.8 -to 33.8 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/31.8_33.8.mp3
ffmpeg -i public/audio/silence.mp3 -ss 31.8 -to 35.8 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/31.8_33.8.mp3 
ffmpeg -i public/audio/Nameraka_Nihongo_Kaiwa_CD/04_Track_4.mp3 -ss 33.8 -to 36.5 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/33.8_36.5.mp3
ffmpeg -i public/audio/silence.mp3 -ss 33.8 -to 39.2 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/33.8_36.5.mp3 
ffmpeg -i public/audio/Nameraka_Nihongo_Kaiwa_CD/04_Track_4.mp3 -ss 36.5 -to 40 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/36.5_40.mp3
ffmpeg -i public/audio/silence.mp3 -ss 36.5 -to 43.5 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/36.5_40.mp3 
ffmpeg -i public/audio/Nameraka_Nihongo_Kaiwa_CD/04_Track_4.mp3 -ss 40 -to 48 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/40_48.mp3
ffmpeg -i public/audio/silence.mp3 -ss 40 -to 56 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/40_48.mp3 
ffmpeg -i public/click.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/17_21.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/21_23.2.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/23.3_28.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/28_31.8.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/31.8_33.8.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/33.8_36.5.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/36.5_40.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/40_48.mp3  -filter_complex '[0:0][1:0][2:0][3:0][4:0][5:0][6:0][7:0][8:0]concat=n=9:v=0:a=1[out]' -map '[out]' public/audio/Nameraka_Nihongo_Kaiwa_CD/final/A_04_Track_4.mp3
ffmpeg -i public/click.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/17_21.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/21_23.2.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/23.3_28.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/28_31.8.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/31.8_33.8.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/33.8_36.5.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/36.5_40.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/40_48.mp3  -filter_complex '[0:0][1:0][2:0][3:0][4:0][5:0][6:0][7:0][8:0]concat=n=9:v=0:a=1[out]' -map '[out]' public/audio/Nameraka_Nihongo_Kaiwa_CD/final/B_04_Track_4.mp3

ffmpeg -i public/audio/Nameraka_Nihongo_Kaiwa_CD/05_Track_5.mp3 -ss 13 -to 17.2 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/13_17.2.mp3
ffmpeg -i public/audio/silence.mp3 -ss 13 -to 21.4 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/13_17.2.mp3 
ffmpeg -i public/audio/Nameraka_Nihongo_Kaiwa_CD/05_Track_5.mp3 -ss 17.2 -to 18.5 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/17.2_18.5.mp3
ffmpeg -i public/audio/silence.mp3 -ss 17.2 -to 19.8 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/17.2_18.5.mp3 
ffmpeg -i public/audio/Nameraka_Nihongo_Kaiwa_CD/05_Track_5.mp3 -ss 18.5 -to 21 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/18.5_21.mp3
ffmpeg -i public/audio/silence.mp3 -ss 18.5 -to 23.5 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/18.5_21.mp3 
ffmpeg -i public/audio/Nameraka_Nihongo_Kaiwa_CD/05_Track_5.mp3 -ss 21 -to 21.8 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/21_21.8.mp3
ffmpeg -i public/audio/silence.mp3 -ss 21 -to 22.6 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/21_21.8.mp3 
ffmpeg -i public/audio/Nameraka_Nihongo_Kaiwa_CD/05_Track_5.mp3 -ss 21.8 -to 25.3 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/21.8_25.3.mp3
ffmpeg -i public/audio/silence.mp3 -ss 21.8 -to 28.8 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/21.8_25.3.mp3 
ffmpeg -i public/audio/Nameraka_Nihongo_Kaiwa_CD/05_Track_5.mp3 -ss 25.3 -to 27 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/25.3_27.mp3
ffmpeg -i public/audio/silence.mp3 -ss 25.3 -to 28.7 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/25.3_27.mp3 
ffmpeg -i public/audio/Nameraka_Nihongo_Kaiwa_CD/05_Track_5.mp3 -ss 27 -to 29.6 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/27_29.6.mp3
ffmpeg -i public/audio/silence.mp3 -ss 27 -to 32.2 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/27_29.6.mp3 
ffmpeg -i public/audio/Nameraka_Nihongo_Kaiwa_CD/05_Track_5.mp3 -ss 29.6 -to 31.8 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/29.6_31.8.mp3
ffmpeg -i public/audio/silence.mp3 -ss 29.6 -to 34.0 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/29.6_31.8.mp3 
ffmpeg -i public/audio/Nameraka_Nihongo_Kaiwa_CD/05_Track_5.mp3 -ss 31.8 -to 33 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/31.8_33.mp3
ffmpeg -i public/audio/silence.mp3 -ss 31.8 -to 34.2 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/31.8_33.mp3 
ffmpeg -i public/audio/Nameraka_Nihongo_Kaiwa_CD/05_Track_5.mp3 -ss 33 -to 42 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/33_42.mp3
ffmpeg -i public/audio/silence.mp3 -ss 33 -to 51 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/33_42.mp3 
ffmpeg -i public/click.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/13_17.2.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/17.2_18.5.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/18.5_21.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/21_21.8.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/21.8_25.3.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/25.3_27.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/27_29.6.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/29.6_31.8.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/31.8_33.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/33_42.mp3  -filter_complex '[0:0][1:0][2:0][3:0][4:0][5:0][6:0][7:0][8:0][9:0][10:0]concat=n=11:v=0:a=1[out]' -map '[out]' public/audio/Nameraka_Nihongo_Kaiwa_CD/final/A_05_Track_5.mp3
ffmpeg -i public/click.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/13_17.2.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/17.2_18.5.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/18.5_21.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/21_21.8.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/21.8_25.3.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/25.3_27.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/27_29.6.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/29.6_31.8.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/31.8_33.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/33_42.mp3  -filter_complex '[0:0][1:0][2:0][3:0][4:0][5:0][6:0][7:0][8:0][9:0][10:0]concat=n=11:v=0:a=1[out]' -map '[out]' public/audio/Nameraka_Nihongo_Kaiwa_CD/final/B_05_Track_5.mp3

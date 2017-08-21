ffmpeg -i public/audio/Nameraka_Nihongo_Kaiwa_CD/08_Track_8.mp3 -ss 11 -to 14.5 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/11_14.5.mp3
ffmpeg -i public/audio/silence.mp3 -ss 11 -to 18.0 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/11_14.5.mp3 
ffmpeg -i public/audio/Nameraka_Nihongo_Kaiwa_CD/08_Track_8.mp3 -ss 14.5 -to 19 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/14.5_19.mp3
ffmpeg -i public/audio/silence.mp3 -ss 14.5 -to 23.5 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/14.5_19.mp3 
ffmpeg -i public/audio/Nameraka_Nihongo_Kaiwa_CD/08_Track_8.mp3 -ss 19 -to 20.8 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/19_20.8.mp3
ffmpeg -i public/audio/silence.mp3 -ss 19 -to 22.6 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/19_20.8.mp3 
ffmpeg -i public/audio/Nameraka_Nihongo_Kaiwa_CD/08_Track_8.mp3 -ss 20.8 -to 23.5 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/20.8_23.5.mp3
ffmpeg -i public/audio/silence.mp3 -ss 20.8 -to 26.2 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/20.8_23.5.mp3 
ffmpeg -i public/audio/Nameraka_Nihongo_Kaiwa_CD/08_Track_8.mp3 -ss 23.5 -to 25.5 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/23.5_25.5.mp3
ffmpeg -i public/audio/silence.mp3 -ss 23.5 -to 27.5 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/23.5_25.5.mp3 
ffmpeg -i public/audio/Nameraka_Nihongo_Kaiwa_CD/08_Track_8.mp3 -ss 25.5 -to 28 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/25.5_28.mp3
ffmpeg -i public/audio/silence.mp3 -ss 25.5 -to 30.5 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/25.5_28.mp3 
ffmpeg -i public/audio/Nameraka_Nihongo_Kaiwa_CD/08_Track_8.mp3 -ss 28 -to 30.1 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/28_30.1.mp3
ffmpeg -i public/audio/silence.mp3 -ss 28 -to 32.2 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/28_30.1.mp3 
ffmpeg -i public/audio/Nameraka_Nihongo_Kaiwa_CD/08_Track_8.mp3 -ss 30.1 -to 33 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/30.1_33.mp3
ffmpeg -i public/audio/silence.mp3 -ss 30.1 -to 35.9 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/30.1_33.mp3 
ffmpeg -i public/audio/Nameraka_Nihongo_Kaiwa_CD/08_Track_8.mp3 -ss 33 -to 35.5 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/33_35.5.mp3
ffmpeg -i public/audio/silence.mp3 -ss 33 -to 38.0 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/33_35.5.mp3 
ffmpeg -i public/audio/Nameraka_Nihongo_Kaiwa_CD/08_Track_8.mp3 -ss 35.5 -to 37.4 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/35.5_37.4.mp3
ffmpeg -i public/audio/silence.mp3 -ss 35.5 -to 39.3 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/35.5_37.4.mp3 
ffmpeg -i public/audio/Nameraka_Nihongo_Kaiwa_CD/08_Track_8.mp3 -ss 37.4 -to 42 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/37.4_42.mp3
ffmpeg -i public/audio/silence.mp3 -ss 37.4 -to 46.6 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/37.4_42.mp3 
ffmpeg -i public/click.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/11_14.5.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/14.5_19.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/19_20.8.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/20.8_23.5.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/23.5_25.5.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/25.5_28.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/28_30.1.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/30.1_33.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/33_35.5.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/35.5_37.4.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/37.4_42.mp3  -filter_complex '[0:0][1:0][2:0][3:0][4:0][5:0][6:0][7:0][8:0][9:0][10:0][11:0]concat=n=12:v=0:a=1[out]' -map '[out]' public/audio/Nameraka_Nihongo_Kaiwa_CD/final/A_08_Track_8.mp3
ffmpeg -i public/click.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/11_14.5.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/14.5_19.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/19_20.8.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/20.8_23.5.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/23.5_25.5.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/25.5_28.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/28_30.1.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/30.1_33.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/33_35.5.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/35.5_37.4.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/37.4_42.mp3  -filter_complex '[0:0][1:0][2:0][3:0][4:0][5:0][6:0][7:0][8:0][9:0][10:0][11:0]concat=n=12:v=0:a=1[out]' -map '[out]' public/audio/Nameraka_Nihongo_Kaiwa_CD/final/B_08_Track_8.mp3

ffmpeg -i public/audio/Nameraka_Nihongo_Kaiwa_CD/06_Track_6.mp3 -ss 17 -to 21 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/17_21.mp3
ffmpeg -i public/audio/silence.mp3 -ss 17 -to 25 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/17_21.mp3 
ffmpeg -i public/audio/Nameraka_Nihongo_Kaiwa_CD/06_Track_6.mp3 -ss 21 -to 23.1 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/21_23.1.mp3
ffmpeg -i public/audio/silence.mp3 -ss 21 -to 25.200000000000003 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/21_23.1.mp3 
ffmpeg -i public/audio/Nameraka_Nihongo_Kaiwa_CD/06_Track_6.mp3 -ss 23.1 -to 26 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/23.1_26.mp3
ffmpeg -i public/audio/silence.mp3 -ss 23.1 -to 28.9 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/23.1_26.mp3 
ffmpeg -i public/audio/Nameraka_Nihongo_Kaiwa_CD/06_Track_6.mp3 -ss 26 -to 29 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/26_29.mp3
ffmpeg -i public/audio/silence.mp3 -ss 26 -to 32 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/26_29.mp3 
ffmpeg -i public/audio/Nameraka_Nihongo_Kaiwa_CD/06_Track_6.mp3 -ss 29 -to 32.3 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/29_32.3.mp3
ffmpeg -i public/audio/silence.mp3 -ss 29 -to 35.599999999999994 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/29_32.3.mp3 
ffmpeg -i public/audio/Nameraka_Nihongo_Kaiwa_CD/06_Track_6.mp3 -ss 32.3 -to 34.2 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/32.3_34.2.mp3
ffmpeg -i public/audio/silence.mp3 -ss 32.3 -to 36.10000000000001 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/32.3_34.2.mp3 
ffmpeg -i public/audio/Nameraka_Nihongo_Kaiwa_CD/06_Track_6.mp3 -ss 34.2 -to 37 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/34.2_37.mp3
ffmpeg -i public/audio/silence.mp3 -ss 34.2 -to 39.8 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/34.2_37.mp3 
ffmpeg -i public/audio/Nameraka_Nihongo_Kaiwa_CD/06_Track_6.mp3 -ss 37 -to 41.7 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/37_41.7.mp3
ffmpeg -i public/audio/silence.mp3 -ss 37 -to 46.400000000000006 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/37_41.7.mp3 
ffmpeg -i public/audio/Nameraka_Nihongo_Kaiwa_CD/06_Track_6.mp3 -ss 41.7 -to 43.6 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/41.7_43.6.mp3
ffmpeg -i public/audio/silence.mp3 -ss 41.7 -to 45.5 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/41.7_43.6.mp3 
ffmpeg -i public/audio/Nameraka_Nihongo_Kaiwa_CD/06_Track_6.mp3 -ss 43.6 -to 46 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/43.6_46.mp3
ffmpeg -i public/audio/silence.mp3 -ss 43.6 -to 48.4 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/43.6_46.mp3 
ffmpeg -i public/click.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/17_21.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/21_23.1.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/23.1_26.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/26_29.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/29_32.3.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/32.3_34.2.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/34.2_37.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/37_41.7.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/41.7_43.6.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/43.6_46.mp3  -filter_complex '[0:0][1:0][2:0][3:0][4:0][5:0][6:0][7:0][8:0][9:0][10:0]concat=n=11:v=0:a=1[out]' -map '[out]' public/audio/Nameraka_Nihongo_Kaiwa_CD/final/A_06_Track_6.mp3
ffmpeg -i public/click.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/17_21.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/21_23.1.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/23.1_26.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/26_29.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/29_32.3.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/32.3_34.2.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/34.2_37.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/37_41.7.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/41.7_43.6.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/43.6_46.mp3  -filter_complex '[0:0][1:0][2:0][3:0][4:0][5:0][6:0][7:0][8:0][9:0][10:0]concat=n=11:v=0:a=1[out]' -map '[out]' public/audio/Nameraka_Nihongo_Kaiwa_CD/final/B_06_Track_6.mp3

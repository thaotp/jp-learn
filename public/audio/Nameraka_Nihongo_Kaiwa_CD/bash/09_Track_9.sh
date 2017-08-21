ffmpeg -i public/audio/Nameraka_Nihongo_Kaiwa_CD/09_Track_9.mp3 -ss 12 -to 17.1 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/12_17.1.mp3
ffmpeg -i public/audio/silence.mp3 -ss 12 -to 22.200000000000003 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/12_17.1.mp3 
ffmpeg -i public/audio/Nameraka_Nihongo_Kaiwa_CD/09_Track_9.mp3 -ss 17.1 -to 19 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/17.1_19.mp3
ffmpeg -i public/audio/silence.mp3 -ss 17.1 -to 20.9 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/17.1_19.mp3 
ffmpeg -i public/audio/Nameraka_Nihongo_Kaiwa_CD/09_Track_9.mp3 -ss 19 -to 26.9 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/19_26.9.mp3
ffmpeg -i public/audio/silence.mp3 -ss 19 -to 34.8 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/19_26.9.mp3 
ffmpeg -i public/audio/Nameraka_Nihongo_Kaiwa_CD/09_Track_9.mp3 -ss 26.9 -to 30 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/26.9_30.mp3
ffmpeg -i public/audio/silence.mp3 -ss 26.9 -to 33.1 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/26.9_30.mp3 
ffmpeg -i public/audio/Nameraka_Nihongo_Kaiwa_CD/09_Track_9.mp3 -ss 30 -to 34.1 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/30_34.1.mp3
ffmpeg -i public/audio/silence.mp3 -ss 30 -to 38.2 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/30_34.1.mp3 
ffmpeg -i public/audio/Nameraka_Nihongo_Kaiwa_CD/09_Track_9.mp3 -ss 34.1 -to 40.2 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/34.1_40.2.mp3
ffmpeg -i public/audio/silence.mp3 -ss 34.1 -to 46.300000000000004 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/34.1_40.2.mp3 
ffmpeg -i public/audio/Nameraka_Nihongo_Kaiwa_CD/09_Track_9.mp3 -ss 40.2 -to 43 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/40.2_43.mp3
ffmpeg -i public/audio/silence.mp3 -ss 40.2 -to 45.8 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/40.2_43.mp3 
ffmpeg -i public/click.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/12_17.1.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/17.1_19.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/19_26.9.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/26.9_30.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/30_34.1.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/34.1_40.2.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/40.2_43.mp3  -filter_complex '[0:0][1:0][2:0][3:0][4:0][5:0][6:0][7:0]concat=n=8:v=0:a=1[out]' -map '[out]' public/audio/Nameraka_Nihongo_Kaiwa_CD/final/A_09_Track_9.mp3
ffmpeg -i public/click.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/12_17.1.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/17.1_19.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/19_26.9.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/26.9_30.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/30_34.1.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/34.1_40.2.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/40.2_43.mp3  -filter_complex '[0:0][1:0][2:0][3:0][4:0][5:0][6:0][7:0]concat=n=8:v=0:a=1[out]' -map '[out]' public/audio/Nameraka_Nihongo_Kaiwa_CD/final/B_09_Track_9.mp3

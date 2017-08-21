ffmpeg -i public/audio/Nameraka_Nihongo_Kaiwa_CD/02_Track_2.mp3 -ss 11 -to 14.6 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/11_14.6.mp3
ffmpeg -i public/audio/silence.mp3 -ss 11 -to 18.2 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/11_14.6.mp3 
ffmpeg -i public/audio/Nameraka_Nihongo_Kaiwa_CD/02_Track_2.mp3 -ss 14.6 -to 16.4 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/14.6_16.4.mp3
ffmpeg -i public/audio/silence.mp3 -ss 14.6 -to 18.199999999999996 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/14.6_16.4.mp3 
ffmpeg -i public/audio/Nameraka_Nihongo_Kaiwa_CD/02_Track_2.mp3 -ss 16.4 -to 18.6 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/16.4_18.6.mp3
ffmpeg -i public/audio/silence.mp3 -ss 16.4 -to 20.800000000000004 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/16.4_18.6.mp3 
ffmpeg -i public/audio/Nameraka_Nihongo_Kaiwa_CD/02_Track_2.mp3 -ss 18.6 -to 20 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/18.6_20.mp3
ffmpeg -i public/audio/silence.mp3 -ss 18.6 -to 21.4 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/18.6_20.mp3 
ffmpeg -i public/audio/Nameraka_Nihongo_Kaiwa_CD/02_Track_2.mp3 -ss 20 -to 22.8 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/20_22.8.mp3
ffmpeg -i public/audio/silence.mp3 -ss 20 -to 25.6 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/20_22.8.mp3 
ffmpeg -i public/audio/Nameraka_Nihongo_Kaiwa_CD/02_Track_2.mp3 -ss 22.8 -to 24 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/22.8_24.mp3
ffmpeg -i public/audio/silence.mp3 -ss 22.8 -to 25.2 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/22.8_24.mp3 
ffmpeg -i public/audio/Nameraka_Nihongo_Kaiwa_CD/02_Track_2.mp3 -ss 24 -to 25.8 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/24_25.8.mp3
ffmpeg -i public/audio/silence.mp3 -ss 24 -to 27.6 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/24_25.8.mp3 
ffmpeg -i public/audio/Nameraka_Nihongo_Kaiwa_CD/02_Track_2.mp3 -ss 25.8 -to 31 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/25.8_31.mp3
ffmpeg -i public/audio/silence.mp3 -ss 25.8 -to 36.2 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/25.8_31.mp3 
ffmpeg -i public/click.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/11_14.6.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/14.6_16.4.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/16.4_18.6.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/18.6_20.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/20_22.8.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/22.8_24.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/24_25.8.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/25.8_31.mp3  -filter_complex '[0:0][1:0][2:0][3:0][4:0][5:0][6:0][7:0][8:0]concat=n=9:v=0:a=1[out]' -map '[out]' public/audio/Nameraka_Nihongo_Kaiwa_CD/final/A_02_Track_2.mp3
ffmpeg -i public/click.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/11_14.6.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/14.6_16.4.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/16.4_18.6.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/18.6_20.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/20_22.8.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/22.8_24.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/24_25.8.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/25.8_31.mp3  -filter_complex '[0:0][1:0][2:0][3:0][4:0][5:0][6:0][7:0][8:0]concat=n=9:v=0:a=1[out]' -map '[out]' public/audio/Nameraka_Nihongo_Kaiwa_CD/final/B_02_Track_2.mp3

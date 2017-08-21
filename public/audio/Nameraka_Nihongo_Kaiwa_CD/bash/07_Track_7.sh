ffmpeg -i public/audio/Nameraka_Nihongo_Kaiwa_CD/07_Track_7.mp3 -ss 11 -to 16.3 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/11_16.3.mp3
ffmpeg -i public/audio/silence.mp3 -ss 11 -to 21.6 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/11_16.3.mp3 
ffmpeg -i public/audio/Nameraka_Nihongo_Kaiwa_CD/07_Track_7.mp3 -ss 16.3 -to 21 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/16.3_21.mp3
ffmpeg -i public/audio/silence.mp3 -ss 16.3 -to 25.7 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/16.3_21.mp3 
ffmpeg -i public/audio/Nameraka_Nihongo_Kaiwa_CD/07_Track_7.mp3 -ss 21 -to 24.85 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/21_24.85.mp3
ffmpeg -i public/audio/silence.mp3 -ss 21 -to 28.700000000000003 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/21_24.85.mp3 
ffmpeg -i public/audio/Nameraka_Nihongo_Kaiwa_CD/07_Track_7.mp3 -ss 24.85 -to 26.8 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/24.85_26.8.mp3
ffmpeg -i public/audio/silence.mp3 -ss 24.85 -to 28.75 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/24.85_26.8.mp3 
ffmpeg -i public/audio/Nameraka_Nihongo_Kaiwa_CD/07_Track_7.mp3 -ss 26.8 -to 31.8 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/26.8_31.8.mp3
ffmpeg -i public/audio/silence.mp3 -ss 26.8 -to 36.8 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/26.8_31.8.mp3 
ffmpeg -i public/audio/Nameraka_Nihongo_Kaiwa_CD/07_Track_7.mp3 -ss 31.8 -to 34 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/31.8_34.mp3
ffmpeg -i public/audio/silence.mp3 -ss 31.8 -to 36.2 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/31.8_34.mp3 
ffmpeg -i public/audio/Nameraka_Nihongo_Kaiwa_CD/07_Track_7.mp3 -ss 34 -to 38.6 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/34_38.6.mp3
ffmpeg -i public/audio/silence.mp3 -ss 34 -to 43.2 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/34_38.6.mp3 
ffmpeg -i public/audio/Nameraka_Nihongo_Kaiwa_CD/07_Track_7.mp3 -ss 38.6 -to 42.1 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/38.6_42.1.mp3
ffmpeg -i public/audio/silence.mp3 -ss 38.6 -to 45.6 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/38.6_42.1.mp3 
ffmpeg -i public/audio/Nameraka_Nihongo_Kaiwa_CD/07_Track_7.mp3 -ss 42.1 -to 47 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/42.1_47.mp3
ffmpeg -i public/audio/silence.mp3 -ss 42.1 -to 51.9 -c copy public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/42.1_47.mp3 
ffmpeg -i public/click.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/11_16.3.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/16.3_21.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/21_24.85.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/24.85_26.8.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/26.8_31.8.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/31.8_34.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/34_38.6.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/38.6_42.1.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/42.1_47.mp3  -filter_complex '[0:0][1:0][2:0][3:0][4:0][5:0][6:0][7:0][8:0][9:0]concat=n=10:v=0:a=1[out]' -map '[out]' public/audio/Nameraka_Nihongo_Kaiwa_CD/final/A_07_Track_7.mp3
ffmpeg -i public/click.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/11_16.3.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/16.3_21.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/21_24.85.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/24.85_26.8.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/26.8_31.8.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/31.8_34.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/34_38.6.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/practice/38.6_42.1.mp3 -i public/audio/Nameraka_Nihongo_Kaiwa_CD/silent/42.1_47.mp3  -filter_complex '[0:0][1:0][2:0][3:0][4:0][5:0][6:0][7:0][8:0][9:0]concat=n=10:v=0:a=1[out]' -map '[out]' public/audio/Nameraka_Nihongo_Kaiwa_CD/final/B_07_Track_7.mp3

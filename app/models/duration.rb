class Duration < ActiveRecord::Base
  belongs_to :vol_aulm
  before_create :set_name
  def set_name
    self.name = File.split(URI.decode(link))[1]
  end

  def each_durations
    eval(durations).each_slice(2).to_a
  end

  # sox $(ls *.wav | sort -n) out.wav
  def execute(speed = false, repeat = 10)
    folder = "/Users/THAO-NUS/Music/ProcessingMp3/Processing"
    origin_folder = "public/audio/#{self.vol_aulm.name}"
    speed = speed.present? ? "tempo #{speed}" : ''
    each_durations.each_with_index do |arr, index|
      duration = arr[1].to_i - arr[0].to_i
      start = arr[0].to_i
      name = "#{sprintf('%02d',index + 1)}.mp3"
      full_name = "#{folder}/#{name}"
      origin_full_name = Shellwords.shellescape "#{origin_folder}/#{self.name}"
      command = "sox -e ima-adpcm #{origin_full_name} #{full_name} trim #{start} #{duration}  repeat #{repeat} #{speed}"
      system(command)
    end

    outname = Shellwords.shellescape("/Users/THAO-NUS/Music/ProcessingMp3/Results/#{self.name}")
    command = "sox $(ls /Users/THAO-NUS/Music/ProcessingMp3/Processing/*.mp3 | sort -d) #{outname}"
    system(command)
    FileUtils.rm_rf("/Users/THAO-NUS/Music/ProcessingMp3/Processing/.", secure: true)
  end

  def rename_exercise
    self.name = "exercise-#{self.name}"
    save!
  end

  def onetime_repeat
    execute(false, 0)
  end

  def practice_generate
    #init folder
    origin_folder = "public/audio/#{self.vol_aulm.name}"
    file_path = Shellwords.shellescape "#{origin_folder}/#{self.name}"
    silent_path = 'public/audio/silence.mp3'

    practice_folder = "#{origin_folder}/practice"
    silent_folder = "#{origin_folder}/silent"
    bash_folder = "#{origin_folder}/bash"
    final_folder = "#{origin_folder}/final"

    create_folder_if_not_exist(practice_folder)
    create_folder_if_not_exist(silent_folder)
    create_folder_if_not_exist(bash_folder)
    create_folder_if_not_exist(final_folder)

    na = name.split('.')[0]

    File.open("#{bash_folder}/#{na}.sh", 'w+') do |f|
      #Split
      each_durations.each do |duration|
        out = "#{duration.join('_')}.mp3"
        #Split audio
        f.write "ffmpeg -i #{file_path} -ss #{duration[0]} -to #{duration[1]} -c copy #{practice_folder}/#{out}\n"

        #Split silent audio by duration in needed
        delta = duration[1] - duration[0]
        f.write "ffmpeg -i #{silent_path} -ss #{duration[0]} -to #{duration[1] + delta} -c copy #{silent_folder}/#{out} \n"
      end


      click = 'public/click.mp3'
      size = each_durations.size
      #Concat file
      [:even?, :odd?].each do |t|
        option_1 = "-i #{click} "
        option_2 = '[0:0]'
        each_durations.each_with_index do |duration, i|
          out = "#{duration.join('_')}.mp3"
          if i.send(t)
            option_1 += "-i #{practice_folder}/#{out} "
          else
            option_1 += "-i #{silent_folder}/#{out} "
          end
          option_2 += "[#{i+1}:0]"
        end

        if 2.send(t)
          final_name = "#{final_folder}/A_#{name}"
        else
          final_name = "#{final_folder}/B_#{name}"
        end

        f.write "ffmpeg #{option_1} -filter_complex '#{option_2}concat=n=#{size + 1}:v=0:a=1[out]' -map '[out]' #{final_name}\n"
      end

    end

    `chmod +x /Users/THAO-NUS/Dropbox/Job/JapaneseLearning/#{bash_folder}/#{na}.sh`
    `sh /Users/THAO-NUS/Dropbox/Job/JapaneseLearning/#{bash_folder}/#{na}.sh`
    #Remove file
    `rm #{practice_folder}/*.mp3`
    `rm #{silent_folder}/*.mp3`
    create_full_crop_file
  end

  def create_full_crop_file
    origin_folder = "public/audio/#{self.vol_aulm.name}"
    `ffmpeg -i #{origin_folder}/#{name} -ss #{eval(durations)[0]} -to #{eval(durations)[-1]} -c copy #{origin_folder}/final/#{name}`
  end

  private
  def create_folder_if_not_exist(folder_path)
    dirname = File.dirname(folder_path)
    if File.directory?(dirname)
      FileUtils::mkdir_p folder_path
    end
  end
end

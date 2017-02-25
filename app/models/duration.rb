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
end

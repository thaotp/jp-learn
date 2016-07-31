class Setting < ActiveRecord::Base
  scope :max_lesson, -> { where(name: 'LessonSetting') }
end

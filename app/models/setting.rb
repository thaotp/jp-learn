class Setting < ActiveRecord::Base
  scope :max_lesson, -> { where(name: 'LessonSetting') }
  scope :type_lesson, -> { where(name: 'LessonType') }
end

class KanjiDamagesController < ApplicationController
  layout 'simple'
  def index
    @kanjis = KanjiDamage.includes(:kanji_bs).where(level: [-1, 5,4,3]).limit(700).order(:id)
    p @kanjis.size
  end
end

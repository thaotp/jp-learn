class KanjiDamagesController < ApplicationController
  layout 'simple'
  def index
    @kanjis = KanjiDamage.includes(:kanji_bs).all.order(:id)
  end
end

class SlidesController < ApplicationController
  before_action :set_date

  def index
    if @date
      @slides = Slide.bookmarked_on(@date).order(bookmarks_count: :desc)
    else
      @slides = Slide.order(bookmarked_at: :desc).limit(50)
    end
  end

  private

  def set_date
    @date = Date.parse("#{params[:year]}-#{params[:month]}-#{params[:day]}") rescue nil
  end
end

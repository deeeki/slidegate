class SlidesController < ApplicationController
  before_action :set_date

  def index
    if @date
      @slides = Slide.bookmarked_on(@date).order(bookmarks_count: :desc)
    else
      @recent_slides = Slide.order(bookmarked_at: :desc).limit(10)
      @hot_slides = Slide.bookmarked_within(1.week.ago).order(bookmarks_count: :desc).limit(10)
      render :home
    end
  end

  private

  def set_date
    @date = Date.parse("#{params[:year]}-#{params[:month]}-#{params[:day]}") rescue nil
  end
end

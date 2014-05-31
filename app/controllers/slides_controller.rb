class SlidesController < ApplicationController
  def index
    @slides = Slide.order(bookmarked_at: :desc).limit(50)
  end
end

class WelcomeController < ApplicationController
  def index
    flash[:warning] = "this is warning information！"
  end
end

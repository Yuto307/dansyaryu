class PagesController < ApplicationController
  skip_before_action :require_login

  def tos
  end

  def pp
  end
end

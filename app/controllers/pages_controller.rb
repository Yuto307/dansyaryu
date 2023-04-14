class PagesController < ApplicationController
  skip_before_action :require_login, only: %i[tos pp top usage]

  def tos; end

  def pp; end

  def top; end

  def usage; end
end

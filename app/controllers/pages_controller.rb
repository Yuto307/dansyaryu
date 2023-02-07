class PagesController < ApplicationController
    skip_before_action :require_login, only: %i[tos pp top]

  def tos; end

  def pp; end

  def top; end
end
